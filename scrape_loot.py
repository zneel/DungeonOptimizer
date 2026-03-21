#!/usr/bin/env python3
"""
Scrape Wowhead dungeon loot tables for WoW Midnight Season 1 M+ dungeons.
Parses the zone drop pages and outputs DUNGEON_LOOT entries for Data.lua.

Usage:
    pip install beautifulsoup4 requests
    python scrape_loot.py                    # Fetch live from Wowhead
    python scrape_loot.py --from-files DIR   # Parse local HTML files
    python scrape_loot.py --output Data.lua  # Write directly to Data.lua
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
# DUNGEON DEFINITIONS
# Wowhead zone IDs for Midnight Season 1 M+ dungeons
# ============================================================================
DUNGEONS = {
    "MAGISTER": {
        "name": "Magisters' Terrace",
        "zone_id": 15829,
        "url_slug": "magisters-terrace",
    },
    "SEAT": {
        "name": "The Seat of the Triumvirate",
        "zone_id": 8910,
        "url_slug": "the-seat-of-the-triumvirate",
    },
    "SKYREACH": {
        "name": "Skyreach",
        "zone_id": 6988,
        "url_slug": "skyreach",
    },
    "ALGETHAR": {
        "name": "Algeth'ar Academy",
        "zone_id": 14032,
        "url_slug": "algethar-academy",
    },
    "PIT_OF_SARON": {
        "name": "Pit of Saron",
        "zone_id": 4813,
        "url_slug": "pit-of-saron",
    },
    "WINDRUNNER": {
        "name": "Windrunner Spire",
        "zone_id": 15808,
        "url_slug": "windrunner-spire",
    },
    "MAISARA": {
        "name": "Maisara Caverns",
        "zone_id": 16395,
        "url_slug": "maisara-caverns",
    },
    "NEXUS_XENAS": {
        "name": "Nexus-Point Xenas",
        "zone_id": 16573,
        "url_slug": "nexus-point-xenas",
    },
}

# Wowhead slotbak -> WoW inventory slot ID
# Wowhead uses its own slot numbering system
WOWHEAD_SLOT_MAP = {
    1: 1,    # Head
    2: 2,    # Neck
    3: 3,    # Shoulder
    5: 5,    # Chest
    6: 6,    # Waist
    7: 7,    # Legs
    8: 8,    # Feet
    9: 9,    # Wrist
    10: 10,  # Hands
    11: 11,  # Ring (Finger 1)
    12: 13,  # Trinket -> slot 13 (Trinket 1) — we'll handle dupes later
    13: 16,  # One-Hand -> Main Hand
    14: 17,  # Shield -> Off Hand
    15: 15,  # Back/Cloak
    16: 15,  # Back (alternate)
    17: 16,  # Two-Hand -> Main Hand
    20: 5,   # Robe -> Chest
    21: 16,  # Main Hand (weapon)
    22: 17,  # Off Hand
    23: 17,  # Held in Off-Hand
    25: 16,  # Ranged/Thrown -> Main Hand
    26: 16,  # Ranged (gun/bow/crossbow)
    28: 16,  # Relic -> treat as weapon
}

# Equipment slots we care about (skip non-equippable)
VALID_SLOTS = set(WOWHEAD_SLOT_MAP.keys())

# Item quality filter (3 = rare/blue, 4 = epic/purple)
MIN_QUALITY = 3


# ============================================================================
# PARSING
# ============================================================================

def parse_gatherer_data(html):
    """
    Extract item data from WH.Gatherer.addData() JavaScript calls.
    Returns a dict of {item_id: item_data}.
    """
    items = {}

    # Pattern: WH.Gatherer.addData(3, 1, {JSON})
    # Type 3 = items
    pattern = r'WH\.Gatherer\.addData\(\s*3\s*,\s*\d+\s*,\s*(\{.*?\})\s*\)'
    matches = re.findall(pattern, html, re.DOTALL)

    for match in matches:
        try:
            # The JSON uses unquoted keys, need to handle that
            # Convert JS object to valid JSON
            fixed = re.sub(r'(?<=[{,])\s*(\w+)\s*:', r'"\1":', match)
            # Handle single quotes
            fixed = fixed.replace("'", '"')
            # Try parsing
            data = json.loads(fixed)
            for item_id_str, item_data in data.items():
                try:
                    item_id = int(item_id_str)
                    items[item_id] = item_data
                except (ValueError, TypeError):
                    continue
        except json.JSONDecodeError:
            # Fallback: extract individual items with regex
            item_pattern = r'"(\d+)":\s*\{([^}]+)\}'
            for item_match in re.finditer(item_pattern, match):
                item_id = int(item_match.group(1))
                item_body = item_match.group(2)

                item_info = {}
                # Extract name
                name_match = re.search(r'"name_enus"\s*:\s*"([^"]+)"', item_body)
                if name_match:
                    item_info["name_enus"] = name_match.group(1)

                # Extract quality
                quality_match = re.search(r'"quality"\s*:\s*(\d+)', item_body)
                if quality_match:
                    item_info["quality"] = int(quality_match.group(1))

                # Extract jsonequip for slot
                items[item_id] = item_info

    return items


def extract_items_from_listview(html):
    """
    Extract items from Wowhead listview data (alternative parsing method).
    Looks for data arrays in listview initialization.
    """
    items = {}

    # Pattern: new Listview({...data: [{...}, {...}]...})
    # or: data: [{id: 123, ...}]
    pattern = r'"data"\s*:\s*\[(\{.*?\}(?:\s*,\s*\{.*?\})*)\]'
    matches = re.findall(pattern, html, re.DOTALL)

    for match in matches:
        item_pattern = r'\{[^}]*"id"\s*:\s*(\d+)[^}]*\}'
        for item_match in re.finditer(item_pattern, match):
            item_id = int(item_match.group(1))
            item_body = item_match.group(0)

            item_info = {}
            name_match = re.search(r'"name"\s*:\s*"([^"]+)"', item_body)
            if name_match:
                item_info["name_enus"] = name_match.group(1)

            slot_match = re.search(r'"slot"\s*:\s*(\d+)', item_body)
            if slot_match:
                item_info["slotbak"] = int(slot_match.group(1))

            quality_match = re.search(r'"quality"\s*:\s*(\d+)', item_body)
            if quality_match:
                item_info["quality"] = int(quality_match.group(1))

            items[item_id] = item_info

    return items


def extract_slot_from_jsonequip(html, item_id):
    """Try to extract slotbak from jsonequip data for a specific item."""
    # Look for the item's jsonequip block
    pattern = rf'"{item_id}":\s*\{{[^}}]*"jsonequip"\s*:\s*\{{([^}}]+)\}}'
    match = re.search(pattern, html, re.DOTALL)
    if match:
        equip_data = match.group(1)
        slot_match = re.search(r'"slotbak"\s*:\s*(\d+)', equip_data)
        if slot_match:
            return int(slot_match.group(1))
    return None


def parse_wowhead_item_links(html):
    """
    Extract item IDs from wowhead item links in the HTML.
    Fallback method when JS data isn't parseable.
    """
    items = {}
    # Pattern: item=XXXXX in links and data attributes
    pattern = r'(?:href="[^"]*item=|data-wowhead="item=)(\d+)'
    for match in re.finditer(pattern, html):
        item_id = int(match.group(1))
        items[item_id] = {}
    return items


def parse_zone_page(html, zone_id):
    """
    Parse a Wowhead zone page to extract dungeon loot.
    Returns a list of {itemId, slot, itemName} dicts.
    """
    loot = []
    seen_ids = set()

    # Method 1: Parse WH.Gatherer.addData
    gatherer_items = parse_gatherer_data(html)

    # Method 2: Parse listview data
    listview_items = extract_items_from_listview(html)

    # Merge
    all_items = {}
    all_items.update(listview_items)
    all_items.update(gatherer_items)

    if not all_items:
        # Method 3: Extract from item links
        all_items = parse_wowhead_item_links(html)

    for item_id, item_data in all_items.items():
        if item_id in seen_ids:
            continue

        # Get quality
        quality = item_data.get("quality", 0)
        if quality < MIN_QUALITY:
            continue

        # Get slot
        slot_wh = item_data.get("slotbak")
        if not slot_wh:
            # Try extracting from jsonequip
            slot_wh = extract_slot_from_jsonequip(html, item_id)

        if not slot_wh or slot_wh not in WOWHEAD_SLOT_MAP:
            continue

        slot = WOWHEAD_SLOT_MAP[slot_wh]

        # Get name
        name = item_data.get("name_enus", "")
        # Clean HTML entities
        name = name.replace("&#39;", "'").replace("&amp;", "&").replace("&#45;", "-")

        seen_ids.add(item_id)
        loot.append({
            "itemId": item_id,
            "slot": slot,
            "itemName": name if name else None,
        })

    # Sort by slot then item ID for consistency
    loot.sort(key=lambda x: (x["slot"], x["itemId"]))

    return loot


# ============================================================================
# FETCHING
# ============================================================================

def fetch_zone_loot(zone_id, slug):
    """Fetch a zone's loot page from Wowhead."""
    if requests is None:
        print("ERROR: requests library required. Run: pip install requests")
        sys.exit(1)

    url = f"https://www.wowhead.com/zone={zone_id}/{slug}#drops"
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

def format_dungeon_loot(all_loot):
    """Format DUNGEON_LOOT table as Lua."""
    lines = ["NS.DUNGEON_LOOT = {"]

    for dungeon_key in sorted(all_loot.keys()):
        items = all_loot[dungeon_key]
        dungeon_name = DUNGEONS[dungeon_key]["name"]

        lines.append(f"    -- {dungeon_name}")
        lines.append(f"    {dungeon_key} = {{")

        for item in items:
            name_str = f'"{item["itemName"]}"' if item["itemName"] else "nil"
            lines.append(
                f'        {{ itemId = {item["itemId"]}, slot = {item["slot"]}, '
                f'itemName = {name_str} }},'
            )

        lines.append("    },")

    lines.append("}")
    return "\n".join(lines)


# ============================================================================
# MAIN
# ============================================================================

def main():
    parser = argparse.ArgumentParser(description="Scrape Wowhead dungeon loot tables")
    parser.add_argument("--from-files", type=str, help="Directory with saved HTML files (dungeon-slug.html)")
    parser.add_argument("--output", type=str, help="Output file (default: stdout)")
    parser.add_argument("--save-html", type=str, help="Save fetched HTML to this directory")
    parser.add_argument("--dungeons", type=str, nargs="+", help="Only process these dungeon keys")
    parser.add_argument("--delay", type=float, default=2.0, help="Delay between requests (seconds)")
    parser.add_argument("--json", action="store_true", help="Output as JSON instead of Lua")
    args = parser.parse_args()

    all_loot = {}
    dungeon_filter = set(args.dungeons) if args.dungeons else None

    for key, info in sorted(DUNGEONS.items()):
        if dungeon_filter and key not in dungeon_filter:
            continue

        print(f"[{len(all_loot)+1}/{len(DUNGEONS)}] {info['name']}...", file=sys.stderr)

        html = None

        # Try loading from file
        if args.from_files:
            file_path = Path(args.from_files) / f"{info['url_slug']}.html"
            if file_path.exists():
                html = file_path.read_text(encoding="utf-8")
                print(f"  Loaded from {file_path}", file=sys.stderr)
            else:
                file_path2 = Path(args.from_files) / f"{key}.html"
                if file_path2.exists():
                    html = file_path2.read_text(encoding="utf-8")
                    print(f"  Loaded from {file_path2}", file=sys.stderr)
                else:
                    print(f"  WARNING: No file found, will fetch live", file=sys.stderr)

        # Fetch live
        if html is None:
            try:
                html = fetch_zone_loot(info["zone_id"], info["url_slug"])
                if args.save_html:
                    save_dir = Path(args.save_html)
                    save_dir.mkdir(parents=True, exist_ok=True)
                    (save_dir / f"{info['url_slug']}.html").write_text(html, encoding="utf-8")
                time.sleep(args.delay)
            except Exception as e:
                print(f"  ERROR: {e}", file=sys.stderr)
                continue

        # Parse
        loot = parse_zone_page(html, info["zone_id"])
        if loot:
            print(f"  Found {len(loot)} equippable items", file=sys.stderr)
            all_loot[key] = loot
        else:
            print(f"  WARNING: No loot found!", file=sys.stderr)

    print(f"\nProcessed {len(all_loot)} dungeons, "
          f"{sum(len(v) for v in all_loot.values())} total items.", file=sys.stderr)

    # Output
    if args.json:
        output = json.dumps(all_loot, indent=2, default=str)
    else:
        output = format_dungeon_loot(all_loot)

    if args.output:
        out_path = Path(args.output)
        if out_path.exists() and out_path.name == "Data.lua":
            existing = out_path.read_text(encoding="utf-8")
            # Replace DUNGEON_LOOT section
            pattern = r'NS\.DUNGEON_LOOT\s*=\s*\{.*?\n\}'
            new_match = re.search(r'NS\.DUNGEON_LOOT\s*=\s*\{.*?\n\}', output, re.DOTALL)
            if new_match and re.search(pattern, existing, re.DOTALL):
                existing = re.sub(pattern, new_match.group(0), existing, flags=re.DOTALL)
                out_path.write_text(existing, encoding="utf-8")
                print(f"  Replaced DUNGEON_LOOT in {out_path}", file=sys.stderr)
            else:
                print(f"  WARNING: Could not find DUNGEON_LOOT section to replace", file=sys.stderr)
                out_path.write_text(output, encoding="utf-8")
        else:
            out_path.write_text(output, encoding="utf-8")
        print(f"Written to {out_path}", file=sys.stderr)
    else:
        print(output)


if __name__ == "__main__":
    main()
