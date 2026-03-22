#!/usr/bin/env python3
"""
Scrape dungeon and raid loot tables from Icy Veins guide pages.
Each page has boss loot tables with Type | Item | Stats columns.

Usage:
    pip install beautifulsoup4 requests
    python scrape_loot.py                          # Fetch all dungeons live
    python scrape_loot.py --raids                  # Fetch raid loot tables
    python scrape_loot.py --from-files DIR         # Parse saved HTML files
    python scrape_loot.py --output Data.lua        # Write to Data.lua
    python scrape_loot.py --json                   # JSON output

The script expects Icy Veins guide pages. Save them as:
    DIR/<slug>-dungeon-guide.html  (dungeons)
    DIR/<slug>-loot.html           (raids)
Example:
    snapshots/loot/windrunner-spire-dungeon-guide.html
    snapshots/loot/liberation-of-undermine-loot.html
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

# ============================================================================
# RAID DEFINITIONS
# ============================================================================
RAIDS = {
    "LIBERATION_OF_UNDERMINE": {
        "name": "Liberation of Undermine",
        "slug": "liberation-of-undermine",
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
                "itemName": item_name,
                "boss": boss_name,
            })

    items.sort(key=lambda x: (x["boss"], x["itemId"]))
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


def fetch_raid_page(slug):
    """Fetch a raid loot page from Icy Veins."""
    if requests is None:
        print("ERROR: requests required. Run: pip install requests", file=sys.stderr)
        sys.exit(1)

    url = f"https://www.icy-veins.com/wow/{slug}-loot"
    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
        "Accept": "text/html,application/xhtml+xml",
    }
    print(f"  Fetching {url}...", file=sys.stderr)
    resp = requests.get(url, headers=headers, timeout=30)
    resp.raise_for_status()
    return resp.text


def find_html_file(directory, slug, content_type="dungeon"):
    """Try various filename patterns to find the saved HTML."""
    if content_type == "raid":
        patterns = [
            f"{slug}-loot.html",
            f"{slug}-raid-loot.html",
            f"{slug}.html",
        ]
    else:
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

def format_loot_table(table_name, definitions, all_loot):
    """Format a loot table (dungeon or raid) as Lua."""
    lines = [f"NS.{table_name} = {{"]

    for key in sorted(all_loot.keys()):
        items = all_loot[key]
        name = definitions[key]["name"]

        lines.append(f"    -- {name} ({len(items)} items)")
        lines.append(f"    {key} = {{")

        for item in items:
            name_str = json.dumps(item["itemName"]) if item["itemName"] else "nil"
            boss_str = json.dumps(item.get("boss", "")) if item.get("boss") else "nil"
            lines.append(
                f'        {{ itemId = {item["itemId"]}, '
                f'itemName = {name_str}, boss = {boss_str} }},'
            )

        lines.append("    },")

    lines.append("}")
    return "\n".join(lines)


def format_dungeon_loot(all_loot):
    """Format DUNGEON_LOOT table as Lua."""
    return format_loot_table("DUNGEON_LOOT", DUNGEONS, all_loot)


def format_raid_loot(all_loot):
    """Format RAID_LOOT table as Lua."""
    return format_loot_table("RAID_LOOT", RAIDS, all_loot)


# ============================================================================
# MAIN
# ============================================================================

def scrape_content(definitions, content_type, args):
    """Scrape loot tables for dungeons or raids.

    Returns dict of key -> list of items.
    """
    all_loot = {}
    key_filter = set(args.keys) if args.keys else None

    for key, info in sorted(definitions.items()):
        if key_filter and key not in key_filter:
            continue

        print(f"[{len(all_loot)+1}/{len(definitions)}] {info['name']}...", file=sys.stderr)

        html = None

        # Try loading from file
        if args.from_files:
            path = find_html_file(args.from_files, info["slug"], content_type)
            if path:
                html = path.read_text(encoding="utf-8")
                print(f"  Loaded from {path}", file=sys.stderr)
            else:
                print(f"  WARNING: No file found for {info['slug']}", file=sys.stderr)

        # Fetch live
        if html is None:
            try:
                if content_type == "raid":
                    html = fetch_raid_page(info["slug"])
                    save_suffix = f"{info['slug']}-loot.html"
                else:
                    html = fetch_dungeon_page(info["slug"])
                    save_suffix = f"{info['slug']}-dungeon-guide.html"
                if args.save_html:
                    save_dir = Path(args.save_html)
                    save_dir.mkdir(parents=True, exist_ok=True)
                    (save_dir / save_suffix).write_text(html, encoding="utf-8")
                time.sleep(args.delay)
            except Exception as e:
                print(f"  ERROR: {e}", file=sys.stderr)
                continue

        # Parse (same parser works for both dungeon and raid pages)
        items = parse_dungeon_page(html)
        if items:
            print(f"  Found {len(items)} items", file=sys.stderr)
            all_loot[key] = items
        else:
            print(f"  WARNING: No loot found!", file=sys.stderr)

    label = "raids" if content_type == "raid" else "dungeons"
    total = sum(len(v) for v in all_loot.values())
    print(f"\nProcessed {len(all_loot)} {label}, {total} total items.", file=sys.stderr)
    for key in sorted(all_loot.keys()):
        print(f"  {definitions[key]['name']}: {len(all_loot[key])} items", file=sys.stderr)

    return all_loot


def write_output(output, table_name, args):
    """Write Lua or JSON output to file or stdout."""
    if args.output:
        out_path = Path(args.output)
        if out_path.exists() and out_path.name == "Data.lua":
            existing = out_path.read_text(encoding="utf-8")
            pattern = rf'NS\.{table_name}\s*=\s*\{{.*?\n\}}'
            new_section = re.search(pattern, output, re.DOTALL)
            if new_section and re.search(pattern, existing, re.DOTALL):
                existing = re.sub(pattern, new_section.group(0), existing, flags=re.DOTALL)
                out_path.write_text(existing, encoding="utf-8")
                print(f"\nReplaced {table_name} in {out_path}", file=sys.stderr)
            else:
                # Append if section doesn't exist yet
                existing = existing.rstrip() + "\n\n" + output + "\n"
                out_path.write_text(existing, encoding="utf-8")
                print(f"\nAppended {table_name} to {out_path}", file=sys.stderr)
        else:
            out_path.write_text(output, encoding="utf-8")
            print(f"\nWritten to {out_path}", file=sys.stderr)
    else:
        print(output)


def main():
    parser = argparse.ArgumentParser(description="Scrape Icy Veins loot tables")
    parser.add_argument("--from-files", type=str,
                        help="Directory with saved HTML files")
    parser.add_argument("--output", type=str, help="Output file (default: stdout)")
    parser.add_argument("--save-html", type=str, help="Save fetched HTML here")
    parser.add_argument("--keys", type=str, nargs="+",
                        help="Only process these keys (dungeon or raid)")
    parser.add_argument("--dungeons", type=str, nargs="+",
                        help="Only process these dungeon keys (alias for --keys)")
    parser.add_argument("--raids", action="store_true",
                        help="Scrape raid loot tables instead of dungeons")
    parser.add_argument("--delay", type=float, default=2.0,
                        help="Delay between requests (seconds)")
    parser.add_argument("--json", action="store_true", help="JSON output")

    args = parser.parse_args()

    # Backward compat: --dungeons is an alias for --keys
    if args.dungeons and not args.keys:
        args.keys = args.dungeons

    if args.raids:
        definitions = RAIDS
        content_type = "raid"
        table_name = "RAID_LOOT"
    else:
        definitions = DUNGEONS
        content_type = "dungeon"
        table_name = "DUNGEON_LOOT"

    all_loot = scrape_content(definitions, content_type, args)

    # Output
    if args.json:
        output = json.dumps(all_loot, indent=2)
    else:
        if args.raids:
            output = format_raid_loot(all_loot)
        else:
            output = format_dungeon_loot(all_loot)

    write_output(output, table_name, args)


if __name__ == "__main__":
    main()
