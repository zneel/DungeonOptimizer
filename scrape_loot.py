#!/usr/bin/env python3
"""
Scrape dungeon loot tables from Icy Veins dungeon guide pages.
Each dungeon page has boss loot tables with Type | Item | Stats columns.

Usage:
    pip install beautifulsoup4 requests
    python scrape_loot.py                          # Fetch all dungeons live
    python scrape_loot.py --from-files DIR         # Parse saved HTML files
    python scrape_loot.py --output Data.lua        # Write to Data.lua
    python scrape_loot.py --json                   # JSON output

The script expects Icy Veins dungeon guide pages. Save them as:
    DIR/<slug>-dungeon-guide.html
Example:
    snapshots/loot/windrunner-spire-dungeon-guide.html
"""

import re
import sys
import json
import time
import argparse
from pathlib import Path

try:
    from bs4 import BeautifulSoup
except ImportError:
    print("ERROR: beautifulsoup4 required. Run: pip install beautifulsoup4")
    sys.exit(1)

try:
    import requests
except ImportError:
    requests = None


# ============================================================================
# DUNGEON DEFINITIONS
# ============================================================================
DUNGEONS = {
    "MAGISTER": {
        "name": "Magisters' Terrace",
        "slug": "magisters-terrace",
    },
    "SEAT": {
        "name": "The Seat of the Triumvirate",
        "slug": "seat-of-the-triumvirate",
    },
    "SKYREACH": {
        "name": "Skyreach",
        "slug": "skyreach",
    },
    "ALGETHAR": {
        "name": "Algeth'ar Academy",
        "slug": "algethar-academy",
    },
    "PIT_OF_SARON": {
        "name": "Pit of Saron",
        "slug": "pit-of-saron",
    },
    "WINDRUNNER": {
        "name": "Windrunner Spire",
        "slug": "windrunner-spire",
    },
    "MAISARA": {
        "name": "Maisara Caverns",
        "slug": "maisara-caverns",
    },
    "NEXUS_XENAS": {
        "name": "Nexus-Point Xenas",
        "slug": "nexus-point-xenas",
    },
}

# Type column text -> WoW inventory slot ID
# Icy Veins format: "[ArmorType] SlotName" or "WeaponType"
TYPE_TO_SLOT = {
    # Armor slots (with optional armor class prefix)
    "head": 1, "helm": 1, "helmet": 1,
    "neck": 2, "necklace": 2, "amulet": 2,
    "shoulder": 3, "shoulders": 3,
    "chest": 5, "robe": 5,
    "waist": 6, "belt": 6,
    "legs": 7, "leggings": 7, "pants": 7,
    "feet": 8, "boots": 8,
    "wrist": 9, "bracers": 9,
    "hands": 10, "gloves": 10,
    "ring": 11, "finger": 11,
    "trinket": 13,
    "back": 15, "cloak": 15, "cape": 15,
    # Weapons -> main hand by default
    "1h sword": 16, "1h mace": 16, "1h axe": 16,
    "dagger": 16, "fist weapon": 16, "fist": 16,
    "warglaive": 16, "wand": 16,
    "2h sword": 16, "2h mace": 16, "2h axe": 16,
    "staff": 16, "polearm": 16,
    "bow": 16, "crossbow": 16, "gun": 16,
    # Off-hand
    "off-hand": 17, "shield": 17, "held in off-hand": 17,
}


def resolve_slot(type_text):
    """Convert Icy Veins 'Type' column to a slot ID."""
    clean = type_text.strip().lower()

    # Remove armor class prefixes: "Cloth Head" -> "head", "Plate Waist" -> "waist"
    armor_classes = ["cloth", "leather", "mail", "plate"]
    for ac in armor_classes:
        if clean.startswith(ac + " "):
            clean = clean[len(ac) + 1:]
            break

    # Direct lookup
    if clean in TYPE_TO_SLOT:
        return TYPE_TO_SLOT[clean]

    # Partial match
    for key, slot in TYPE_TO_SLOT.items():
        if key in clean:
            return slot

    return None


def extract_item_id(element):
    """Extract item ID from a BeautifulSoup element."""
    for tag in [element] + element.find_all(True):
        wh = tag.get("data-wowhead", "")
        m = re.search(r'item=(\d+)', wh)
        if m:
            return int(m.group(1))
        href = tag.get("href", "")
        m = re.search(r'item[=/](\d+)', href)
        if m:
            return int(m.group(1))
    return None


def extract_item_name(element):
    """Extract item name from element."""
    for tag in element.find_all(["a", "span"], class_=re.compile(r"q[0-9]")):
        text = tag.get_text(strip=True)
        if text and len(text) > 2:
            return text
    # Fallback: plain text
    text = element.get_text(strip=True)
    return text if text else None


def parse_dungeon_page(html):
    """
    Parse an Icy Veins dungeon guide page.
    Returns list of {itemId, slot, itemName, boss}.
    Boss names are extracted from h3/h4 headings above each loot table.
    """
    soup = BeautifulSoup(html, "html.parser")
    items = []
    seen_ids = set()

    # Build a mapping: table element -> boss name
    # by finding h3/h4 headings that precede loot tables
    table_boss_map = {}
    for h in soup.find_all(["h3", "h4"]):
        boss_name = h.get_text(strip=True)
        # Skip non-boss headings
        if any(skip in boss_name.lower() for skip in
               ["overview", "talent", "route", "strategy", "abilities",
                "tips", "mythic", "trash", "achievement", "loot"]):
            continue
        # Find the next table after this heading
        el = h
        for _ in range(15):
            el = el.find_next()
            if el is None:
                break
            if el.name in ["h2", "h3", "h4"]:
                break
            if el.name == "table":
                rows = el.find_all("tr")
                if len(rows) > 1:
                    table_boss_map[id(el)] = boss_name
                break

    for table in soup.find_all("table"):
        rows = table.find_all("tr")
        if len(rows) < 2:
            continue

        # Check if this is a loot table
        header_cells = rows[0].find_all(["th", "td"])
        headers = [c.get_text(strip=True).lower() for c in header_cells]

        is_loot = (
            len(headers) >= 2 and
            ("type" in headers or "slot" in headers) and
            ("item" in headers or "name" in headers)
        )

        if not is_loot and len(rows) > 1:
            first_data = rows[1].find_all("td")
            if len(first_data) >= 2:
                first_type = first_data[0].get_text(strip=True).lower()
                if resolve_slot(first_type) is not None:
                    is_loot = True

        if not is_loot:
            continue

        boss_name = table_boss_map.get(id(table), "Unknown")

        for row in rows[1:]:
            cells = row.find_all("td")
            if len(cells) < 2:
                continue

            type_text = cells[0].get_text(strip=True)
            slot_id = resolve_slot(type_text)
            if slot_id is None:
                continue

            item_id = extract_item_id(cells[1])
            if not item_id:
                for cell in cells:
                    item_id = extract_item_id(cell)
                    if item_id:
                        break
            if not item_id:
                continue

            item_name = extract_item_name(cells[1])

            if item_id in seen_ids:
                continue
            seen_ids.add(item_id)

            items.append({
                "itemId": item_id,
                "slot": slot_id,
                "itemName": item_name,
                "boss": boss_name,
            })

    items.sort(key=lambda x: (x["boss"], x["slot"], x["itemId"]))
    return items


# ============================================================================
# FETCHING
# ============================================================================

def fetch_dungeon_page(slug):
    """Fetch a dungeon guide page from Icy Veins."""
    if requests is None:
        print("ERROR: requests required. Run: pip install requests", file=sys.stderr)
        sys.exit(1)

    url = f"https://www.icy-veins.com/wow/{slug}-dungeon-guide"
    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
        "Accept": "text/html,application/xhtml+xml",
    }
    print(f"  Fetching {url}...", file=sys.stderr)
    resp = requests.get(url, headers=headers, timeout=30)
    resp.raise_for_status()
    return resp.text


def find_html_file(directory, slug):
    """Try various filename patterns to find the saved HTML."""
    patterns = [
        f"{slug}-dungeon-guide.html",
        f"{slug}.html",
        f"{slug}-dungeon-guide-location-boss-strategies-and-trash.html",
    ]
    d = Path(directory)
    for p in patterns:
        path = d / p
        if path.exists():
            return path
    # Glob fallback
    matches = list(d.glob(f"*{slug}*"))
    if matches:
        return matches[0]
    return None


# ============================================================================
# LUA OUTPUT
# ============================================================================

def format_dungeon_loot(all_loot):
    """Format DUNGEON_LOOT table as Lua."""
    lines = ["NS.DUNGEON_LOOT = {"]

    for key in sorted(all_loot.keys()):
        items = all_loot[key]
        name = DUNGEONS[key]["name"]

        lines.append(f"    -- {name} ({len(items)} items)")
        lines.append(f"    {key} = {{")

        for item in items:
            name_str = json.dumps(item["itemName"]) if item["itemName"] else "nil"
            boss_str = json.dumps(item.get("boss", "")) if item.get("boss") else "nil"
            lines.append(
                f'        {{ itemId = {item["itemId"]}, slot = {item["slot"]}, '
                f'itemName = {name_str}, boss = {boss_str} }},'
            )

        lines.append("    },")

    lines.append("}")
    return "\n".join(lines)


# ============================================================================
# MAIN
# ============================================================================

def main():
    parser = argparse.ArgumentParser(description="Scrape Icy Veins dungeon loot tables")
    parser.add_argument("--from-files", type=str,
                        help="Directory with saved HTML files")
    parser.add_argument("--output", type=str, help="Output file (default: stdout)")
    parser.add_argument("--save-html", type=str, help="Save fetched HTML here")
    parser.add_argument("--dungeons", type=str, nargs="+",
                        help="Only process these dungeon keys")
    parser.add_argument("--delay", type=float, default=2.0,
                        help="Delay between requests (seconds)")
    parser.add_argument("--json", action="store_true", help="JSON output")

    # Also support the Wowhead loot-table.html format
    parser.add_argument("--wowhead", type=str,
                        help="Parse Wowhead M+ rewards HTML (loot-table.html)")
    args = parser.parse_args()

    # Wowhead mode: use the existing loot-table.html parser
    if args.wowhead:
        from scrape_loot_wowhead import parse_loot_page_wowhead
        # (This is handled by a separate import if needed)
        pass

    all_loot = {}
    dungeon_filter = set(args.dungeons) if args.dungeons else None

    for key, info in sorted(DUNGEONS.items()):
        if dungeon_filter and key not in dungeon_filter:
            continue

        print(f"[{len(all_loot)+1}/{len(DUNGEONS)}] {info['name']}...", file=sys.stderr)

        html = None

        # Try loading from file
        if args.from_files:
            path = find_html_file(args.from_files, info["slug"])
            if path:
                html = path.read_text(encoding="utf-8")
                print(f"  Loaded from {path}", file=sys.stderr)
            else:
                print(f"  WARNING: No file found for {info['slug']}", file=sys.stderr)

        # Fetch live
        if html is None:
            try:
                html = fetch_dungeon_page(info["slug"])
                if args.save_html:
                    save_dir = Path(args.save_html)
                    save_dir.mkdir(parents=True, exist_ok=True)
                    (save_dir / f"{info['slug']}-dungeon-guide.html").write_text(
                        html, encoding="utf-8")
                time.sleep(args.delay)
            except Exception as e:
                print(f"  ERROR: {e}", file=sys.stderr)
                continue

        # Parse
        items = parse_dungeon_page(html)
        if items:
            print(f"  Found {len(items)} items", file=sys.stderr)
            all_loot[key] = items
        else:
            print(f"  WARNING: No loot found!", file=sys.stderr)

    total = sum(len(v) for v in all_loot.values())
    print(f"\nProcessed {len(all_loot)} dungeons, {total} total items.", file=sys.stderr)
    for key in sorted(all_loot.keys()):
        print(f"  {DUNGEONS[key]['name']}: {len(all_loot[key])} items", file=sys.stderr)

    # Output
    if args.json:
        output = json.dumps(all_loot, indent=2)
    else:
        output = format_dungeon_loot(all_loot)

    if args.output:
        out_path = Path(args.output)
        if out_path.exists() and out_path.name == "Data.lua":
            existing = out_path.read_text(encoding="utf-8")
            pattern = r'NS\.DUNGEON_LOOT\s*=\s*\{.*?\n\}'
            new_section = re.search(r'NS\.DUNGEON_LOOT\s*=\s*\{.*?\n\}', output, re.DOTALL)
            if new_section and re.search(pattern, existing, re.DOTALL):
                existing = re.sub(pattern, new_section.group(0), existing, flags=re.DOTALL)
                out_path.write_text(existing, encoding="utf-8")
                print(f"\nReplaced DUNGEON_LOOT in {out_path}", file=sys.stderr)
            else:
                print(f"\nWARNING: Could not find DUNGEON_LOOT to replace",
                      file=sys.stderr)
        else:
            out_path.write_text(output, encoding="utf-8")
            print(f"\nWritten to {out_path}", file=sys.stderr)
    else:
        print(output)


if __name__ == "__main__":
    main()
