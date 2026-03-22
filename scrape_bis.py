#!/usr/bin/env python3
"""
Scrape Icy Veins BIS gear lists for all WoW Midnight specs.
Parses the HTML tables and outputs Data.lua-compatible BIS entries.

Usage:
    pip install beautifulsoup4 requests
    python scrape_bis.py                    # Fetch live from Icy Veins
    python scrape_bis.py --from-files DIR   # Parse local HTML files
    python scrape_bis.py --output Data.lua  # Write directly to Data.lua
"""

import re
import os
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
# SPEC DEFINITIONS
# All class/spec combos with their Icy Veins URL slug
# ============================================================================
SPECS = {
    # Death Knight
    "DEATHKNIGHT_BLOOD": "blood-death-knight-pve-tank",
    "DEATHKNIGHT_FROST": "frost-death-knight-pve-dps",
    "DEATHKNIGHT_UNHOLY": "unholy-death-knight-pve-dps",
    # Demon Hunter
    "DEMONHUNTER_HAVOC": "havoc-demon-hunter-pve-dps",
    "DEMONHUNTER_VENGEANCE": "vengeance-demon-hunter-pve-tank",
    "DEMONHUNTER_DEVOURER": "devourer-demon-hunter-pve-dps",
    # Druid
    "DRUID_BALANCE": "balance-druid-pve-dps",
    "DRUID_FERAL": "feral-druid-pve-dps",
    "DRUID_GUARDIAN": "guardian-druid-pve-tank",
    "DRUID_RESTORATION": "restoration-druid-pve-healing",
    # Evoker
    "EVOKER_DEVASTATION": "devastation-evoker-pve-dps",
    "EVOKER_PRESERVATION": "preservation-evoker-pve-healing",
    "EVOKER_AUGMENTATION": "augmentation-evoker-pve-dps",
    # Hunter
    "HUNTER_BEASTMASTERY": "beast-mastery-hunter-pve-dps",
    "HUNTER_MARKSMANSHIP": "marksmanship-hunter-pve-dps",
    "HUNTER_SURVIVAL": "survival-hunter-pve-dps",
    # Mage
    "MAGE_ARCANE": "arcane-mage-pve-dps",
    "MAGE_FIRE": "fire-mage-pve-dps",
    "MAGE_FROST": "frost-mage-pve-dps",
    # Monk
    "MONK_BREWMASTER": "brewmaster-monk-pve-tank",
    "MONK_MISTWEAVER": "mistweaver-monk-pve-healing",
    "MONK_WINDWALKER": "windwalker-monk-pve-dps",
    # Paladin
    "PALADIN_HOLY": "holy-paladin-pve-healing",
    "PALADIN_PROTECTION": "protection-paladin-pve-tank",
    "PALADIN_RETRIBUTION": "retribution-paladin-pve-dps",
    # Priest
    "PRIEST_DISCIPLINE": "discipline-priest-pve-healing",
    "PRIEST_HOLY": "holy-priest-pve-healing",
    "PRIEST_SHADOW": "shadow-priest-pve-dps",
    # Rogue
    "ROGUE_ASSASSINATION": "assassination-rogue-pve-dps",
    "ROGUE_OUTLAW": "outlaw-rogue-pve-dps",
    "ROGUE_SUBTLETY": "subtlety-rogue-pve-dps",
    # Shaman
    "SHAMAN_ELEMENTAL": "elemental-shaman-pve-dps",
    "SHAMAN_ENHANCEMENT": "enhancement-shaman-pve-dps",
    "SHAMAN_RESTORATION": "restoration-shaman-pve-healing",
    # Warlock
    "WARLOCK_AFFLICTION": "affliction-warlock-pve-dps",
    "WARLOCK_DEMONOLOGY": "demonology-warlock-pve-dps",
    "WARLOCK_DESTRUCTION": "destruction-warlock-pve-dps",
    # Warrior
    "WARRIOR_ARMS": "arms-warrior-pve-dps",
    "WARRIOR_FURY": "fury-warrior-pve-dps",
    "WARRIOR_PROTECTION": "protection-warrior-pve-tank",
}

# Icy Veins slot name -> our slot ID
# Single-item slots only.  Plural rows ("rings", "trinkets", "weapons") are
# handled separately in parse_table_element via PLURAL_SLOT_MAP.
SLOT_MAP = {
    # Weapons — single slot
    "2h weapon": 16,
    "weapon": 16,
    "main hand": 16,
    "main-hand": 16,
    "main hand weapon": 16,
    "mainhand": 16,
    "mainhand weapon": 16,
    "mainhand 1h weapon": 16,
    "1h weapon": 16,  # NOTE: second occurrence becomes OH — see parse_table_element
    "one-handed weapon": 16,
    "weapon main-hand": 16,
    "weapon (2h)": 16,
    "weapon (staff)": 16,
    "weapon (two-hand)": 16,
    "weapon (main-hand/off-hand)": 16,
    "two-handed weapon": 16,
    "off hand": 17,
    "off-hand": 17,
    "offhand": 17,
    "offhand weapon": 17,
    "off hand weapon": 17,
    "off-hand weapon": 17,
    "offhand 1h weapon": 17,
    "weapon off-hand": 17,
    "shield": 17,
    "held in off-hand": 17,
    # Armor
    "helm": 1,
    "head": 1,
    "helmet": 1,
    "neck": 2,
    "necklace": 2,
    "shoulder": 3,
    "shoulders": 3,
    "cloak": 15,
    "back": 15,
    "cape": 15,
    "chest": 5,
    "robe": 5,
    "bracers": 9,
    "wrist": 9,
    "wrists": 9,
    "gloves": 10,
    "hands": 10,
    "belt": 6,
    "waist": 6,
    "legs": 7,
    "pants": 7,
    "boots": 8,
    "feet": 8,
    # Jewelry
    "ring #1": 11,
    "ring #2": 12,
    "ring 1": 11,
    "ring 2": 12,
    "ring": 11,
    "trinket #1": 13,
    "trinket #2": 14,
    "trinket 1": 13,
    "trinket 2": 14,
    "trinket": 13,
}

# Plural rows — a single table row that contains multiple items for a pair of
# slots.  The scraper will extract the first two item IDs and assign them to
# the two slot IDs in order.
PLURAL_SLOT_MAP = {
    "rings": (11, 12),
    "trinkets": (13, 14),
    "top trinkets": (13, 14),
    "defensive trinkets": (13, 14),
    "weapons": (16, 17),
    "weapons (dual wield)": (16, 17),
}

# Known hero-spec prefixes that Icy Veins glues to slot names (e.g.
# "SentinelWeapon" → "weapon", "Pack LeaderMain Hand" → "main hand").
HERO_PREFIXES = ["sentinel", "pack leader", "dark ranger"]

# ============================================================================
# HTML PARSING
# ============================================================================

def extract_item_id(cell_html):
    """Extract the first item ID from a table cell's data-wowhead attribute."""
    match = re.search(r'data-wowhead="item=(\d+)', cell_html)
    if match:
        return int(match.group(1))
    # Fallback: href-based
    match = re.search(r'wowhead\.com/item=(\d+)', cell_html)
    if match:
        return int(match.group(1))
    return None


def extract_item_name(cell):
    """Extract item name from a BeautifulSoup cell."""
    # Look for the first span/a with class q3 or q4 (item quality colors)
    for tag in cell.find_all(["span", "a"], class_=re.compile(r"q[0-9]")):
        text = tag.get_text(strip=True)
        if text and len(text) > 2:
            return text
    return None


def extract_source(cell) -> str:
    """Extract the source (dungeon/boss/crafted) from the source column."""
    text = cell.get_text(separator=" ", strip=True)
    # Clean up common patterns
    text = re.sub(r"\s+", " ", text)
    return text


def parse_slot_name(raw):
    """Convert Icy Veins slot text to our slot ID.

    Returns:
        int           — a single slot ID, OR
        tuple(int,int) — a pair of slot IDs for plural rows, OR
        None          — if the slot name is unrecognised.
    """
    clean = raw.strip().lower()
    # Remove bold markers and extra whitespace
    clean = re.sub(r"[*#]", "", clean).strip()
    # Remove leading "bis ->" prefix
    clean = re.sub(r"^bis\s*->\s*", "", clean)

    # Skip tier-list headers, alternatives, and malformed slot names
    if re.match(r"^[a-f] tier$|^s tier$", clean):
        return "SKIP"
    if re.search(r"\balt\b|\balternative\b|\(alt|trinket #?\d\s*\(", clean):
        return "SKIP"
    if "/td>" in clean:
        return "SKIP"

    # Direct match (single-slot)
    result = SLOT_MAP.get(clean)
    if result is not None:
        return result

    # Plural match (multi-item row)
    result = PLURAL_SLOT_MAP.get(clean)
    if result is not None:
        return result

    # Strip hero-spec prefixes (e.g. "sentinelweapon" → "weapon",
    # "pack leadermain hand" → "main hand")
    for prefix in HERO_PREFIXES:
        if clean.startswith(prefix):
            stripped = clean[len(prefix):].strip()
            result = SLOT_MAP.get(stripped)
            if result is not None:
                return result

    # Strip em-dash prefixed hero-spec labels (e.g. "bracers —pack leader" → "bracers")
    if "\u2014" in clean:
        base = clean.split("\u2014")[0].strip()
        result = SLOT_MAP.get(base)
        if result is not None:
            return result

    return None


def _extract_all_item_ids(cell_html):
    """Extract ALL item IDs from a table cell (for plural rows)."""
    return [int(m) for m in re.findall(r'item=(\d+)', cell_html)]


def _extract_all_item_names(cell):
    """Extract ALL item names from a table cell (for plural rows)."""
    names = []
    for tag in cell.find_all(["span", "a"], class_=re.compile(r"q[0-9]")):
        text = tag.get_text(strip=True)
        if text and len(text) > 2:
            names.append(text)
    return names


def parse_table_element(table_el, warn_unknown_slots=True) -> dict:
    """Parse a single HTML table element into a dict of slot_id -> item info."""
    items = {}
    for row in table_el.find_all("tr"):
        cells = row.find_all("td")
        if len(cells) < 2:
            continue

        slot_text = cells[0].get_text(strip=True)
        slot_result = parse_slot_name(slot_text)
        if slot_result is None:
            for strong in cells[0].find_all("strong"):
                slot_text = strong.get_text(strip=True)
                slot_result = parse_slot_name(slot_text)
                if slot_result is not None:
                    break
        if slot_result == "SKIP":
            continue
        if slot_result is None:
            if warn_unknown_slots:
                print(f"  WARNING: Unknown slot '{slot_text}'", file=sys.stderr)
            continue

        cell_html = str(cells[1])
        source = extract_source(cells[2]) if len(cells) > 2 else ""

        # Plural row: tuple of slot IDs — extract first two items
        if isinstance(slot_result, tuple):
            all_ids = _extract_all_item_ids(cell_html)
            all_names = _extract_all_item_names(cells[1])
            for i, slot_id in enumerate(slot_result):
                if i < len(all_ids) and slot_id not in items:
                    items[slot_id] = {
                        "itemId": all_ids[i],
                        "itemName": all_names[i] if i < len(all_names) else None,
                        "source": source,
                    }
        else:
            # Single-slot row
            item_id = extract_item_id(cell_html)
            if not item_id:
                continue

            item_name = extract_item_name(cells[1])

            if slot_result not in items:
                items[slot_result] = {
                    "itemId": item_id,
                    "itemName": item_name,
                    "source": source,
                }
            elif slot_result == 16 and 17 not in items:
                # Duplicate mainhand row (e.g. two "1H Weapon" rows for
                # dual-wield specs) — promote the second one to offhand.
                items[17] = {
                    "itemId": item_id,
                    "itemName": item_name,
                    "source": source,
                }
    return items


def parse_page(html: str, quiet: bool = False) -> dict:
    """
    Parse a full Icy Veins BIS page.
    Returns: { "overall": {slot: item}, "mythic": {...}, "raid": {...} }
    """
    soup = BeautifulSoup(html, "html.parser")
    result = {}

    # Find section headers to identify which table is which
    headings = soup.find_all(["h2", "h3"])
    table_sections = []

    for h in headings:
        text = h.get_text(strip=True).lower()
        if "mythic" in text and ("bis" in text or "gear" in text):
            table_sections.append(("mythic", h))
        elif "raid" in text and ("bis" in text or "gear" in text):
            table_sections.append(("raid", h))
        elif "overall" in text and "bis" in text:
            table_sections.append(("overall", h))
        elif "bis list for" in text and "mythic" not in text and "raid" not in text:
            table_sections.append(("overall", h))

    # Map each section to its following table
    all_tables = soup.find_all("table")

    for section_name, heading in table_sections:
        next_el = heading.parent
        while next_el:
            next_el = next_el.find_next_sibling()
            if not next_el:
                next_el = heading.parent.find_next_sibling()
                break
            if next_el.name == "table":
                break
            table_in = next_el.find("table") if next_el else None
            if table_in:
                next_el = table_in
                break

        if next_el and next_el.name == "table":
            result[section_name] = parse_table_element(next_el, warn_unknown_slots=not quiet)

    # Fallback: if we didn't find section headers, use table order
    if not result and len(all_tables) >= 1:
        labels = ["overall", "mythic", "raid"]
        for i, table_el in enumerate(all_tables[:3]):
            if i < len(labels):
                result[labels[i]] = parse_table_element(table_el, warn_unknown_slots=not quiet)

    return result


# ============================================================================
# FETCHING
# ============================================================================

def fetch_page(spec_slug: str) -> str:
    """Fetch a BIS page from Icy Veins."""
    if requests is None:
        print("ERROR: requests library required for live fetching. Run: pip install requests")
        sys.exit(1)

    url = f"https://www.icy-veins.com/wow/{spec_slug}-gear-best-in-slot"
    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
        "Accept": "text/html,application/xhtml+xml",
    }
    print(f"  Fetching {url}...", file=sys.stderr)
    resp = requests.get(url, headers=headers, timeout=30)
    resp.raise_for_status()
    return resp.text


# ============================================================================
# LUA OUTPUT
# ============================================================================

SLOT_NAMES = {
    1: "Head", 2: "Neck", 3: "Shoulders", 5: "Chest",
    6: "Waist", 7: "Legs", 8: "Feet", 9: "Wrist",
    10: "Hands", 11: "Ring 1", 12: "Ring 2",
    13: "Trinket 1", 14: "Trinket 2", 15: "Back",
    16: "Main Hand", 17: "Off Hand",
}

# Slot output order for consistency
SLOT_ORDER = [16, 17, 1, 2, 3, 15, 5, 9, 10, 6, 7, 8, 11, 12, 13, 14]


def format_bis_table(table_name: str, all_specs: dict) -> str:
    """Format a single BIS table (overall/mythic/raid) as Lua."""
    lines = [f"NS.{table_name} = {{"]

    for spec_key in sorted(all_specs.keys()):
        items = all_specs[spec_key]
        if not items:
            continue

        lines.append(f"    {spec_key} = {{")
        for slot in SLOT_ORDER:
            if slot in items:
                item = items[slot]
                name = item.get("itemName", "")
                source = item.get("source", "")
                comment = ""
                if name:
                    comment += name
                if source:
                    comment += f" ({source})" if comment else source
                comment_str = f" -- {comment}" if comment else ""
                lines.append(f"        [{slot}] = {item['itemId']},{comment_str}")
        lines.append("    },")

    lines.append("}")
    return "\n".join(lines)


def generate_lua(all_data: dict) -> str:
    """Generate the full BIS section for Data.lua."""
    from datetime import datetime

    header = f"""-- ============================================================================
-- BIS LISTS - AUTO-GENERATED from Icy Veins on {datetime.now().strftime('%Y-%m-%d')}
-- Re-generate with: python scrape_bis.py --output Data.lua
-- ============================================================================
"""

    sections = []

    # Mythic+  (with backfill from overall/raid for missing slots)
    mythic = {}
    for spec, data in all_data.items():
        primary = dict(data.get("mythic", data.get("overall", {})))
        # Backfill missing slots from other tables (overall > raid)
        for fallback_key in ["overall", "raid"]:
            fallback = data.get(fallback_key, {})
            for slot_id, item in fallback.items():
                if slot_id not in primary:
                    primary[slot_id] = item
        mythic[spec] = primary
    sections.append(format_bis_table("BIS_MYTHIC", mythic))

    # Raid BIS (with backfill from overall/mythic for missing slots)
    raid = {}
    for spec, data in all_data.items():
        primary = dict(data.get("raid", data.get("overall", {})))
        # Backfill missing slots from other tables (overall > mythic)
        for fallback_key in ["overall", "mythic"]:
            fallback = data.get(fallback_key, {})
            for slot_id, item in fallback.items():
                if slot_id not in primary:
                    primary[slot_id] = item
        raid[spec] = primary
    sections.append(format_bis_table("BIS_RAID", raid))

    return header + "\n\n".join(sections)


# ============================================================================
# MAIN
# ============================================================================

def main():
    parser = argparse.ArgumentParser(description="Scrape Icy Veins BIS lists")
    parser.add_argument("--from-files", type=str, help="Directory with saved HTML files (spec-slug.html)")
    parser.add_argument("--output", type=str, help="Output file (default: stdout)")
    parser.add_argument("--save-html", type=str, help="Save fetched HTML to this directory")
    parser.add_argument("--specs", type=str, nargs="+", help="Only process these spec keys")
    parser.add_argument("--delay", type=float, default=2.0, help="Delay between requests (seconds)")
    parser.add_argument("--json", action="store_true", help="Output as JSON instead of Lua")
    parser.add_argument("--quiet", action="store_true", help="Suppress warnings about unknown slot names")
    args = parser.parse_args()

    all_data = {}
    spec_filter = set(args.specs) if args.specs else None

    for spec_key, slug in sorted(SPECS.items()):
        if spec_filter and spec_key not in spec_filter:
            continue

        print(f"[{len(all_data)+1}/{len(SPECS)}] {spec_key}...", file=sys.stderr)

        html = None

        # Try loading from file
        if args.from_files:
            file_path = Path(args.from_files) / f"{slug}.html"
            if file_path.exists():
                html = file_path.read_text(encoding="utf-8")
                print(f"  Loaded from {file_path}", file=sys.stderr)
            else:
                # Try with spec_key as filename
                file_path2 = Path(args.from_files) / f"{spec_key}.html"
                if file_path2.exists():
                    html = file_path2.read_text(encoding="utf-8")
                    print(f"  Loaded from {file_path2}", file=sys.stderr)
                else:
                    print(f"  WARNING: No file found at {file_path}", file=sys.stderr)
                    continue

        # Fetch live
        if html is None:
            try:
                html = fetch_page(slug)
                if args.save_html:
                    save_dir = Path(args.save_html)
                    save_dir.mkdir(parents=True, exist_ok=True)
                    (save_dir / f"{slug}.html").write_text(html, encoding="utf-8")
                time.sleep(args.delay)
            except Exception as e:
                print(f"  ERROR: {e}", file=sys.stderr)
                continue

        # Parse
        data = parse_page(html, quiet=args.quiet)
        if data:
            for mode, items in data.items():
                print(f"  {mode}: {len(items)} items", file=sys.stderr)
            all_data[spec_key] = data
        else:
            print(f"  WARNING: No BIS tables found!", file=sys.stderr)

    print(f"\nProcessed {len(all_data)} specs.", file=sys.stderr)

    # Output
    if args.json:
        output = json.dumps(all_data, indent=2, default=str)
    else:
        output = generate_lua(all_data)

    if args.output:
        # If outputting to Data.lua, replace only the BIS sections
        out_path = Path(args.output)
        if out_path.exists() and out_path.name == "Data.lua":
            existing = out_path.read_text(encoding="utf-8")

            # Replace BIS_MYTHIC and BIS_RAID sections
            for table_name in ["BIS_MYTHIC", "BIS_RAID"]:
                pattern = rf"NS\.{table_name}\s*=\s*\{{.*?\n\}}"
                if args.json:
                    continue
                # Find the new section
                new_match = re.search(rf"NS\.{table_name}\s*=\s*\{{.*?\n\}}", output, re.DOTALL)
                if not new_match:
                    continue
                if re.search(pattern, existing, re.DOTALL):
                    existing = re.sub(pattern, new_match.group(0), existing, flags=re.DOTALL)
                    print(f"  Replaced {table_name} in {out_path}", file=sys.stderr)
                else:
                    # Append new section if it doesn't exist yet
                    existing = existing.rstrip() + "\n\n" + new_match.group(0) + "\n"
                    print(f"  Appended {table_name} to {out_path}", file=sys.stderr)

            out_path.write_text(existing, encoding="utf-8")
        else:
            out_path.write_text(output, encoding="utf-8")
        print(f"Written to {out_path}", file=sys.stderr)
    else:
        print(output)


if __name__ == "__main__":
    main()
