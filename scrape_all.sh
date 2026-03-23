#!/bin/bash
# Scrape all data from Icy Veins and update Data.lua
# Usage: ./scrape_all.sh [--playwright]
#
# Dependencies:
#   pip install beautifulsoup4 requests
#   For --playwright: pip install playwright && playwright install chromium
set -e

EXTRA_ARGS="$@"

echo "=== Scraping BIS lists (40 specs) ==="
python3 scrape_bis.py $EXTRA_ARGS --save-html snapshots/bis --output Data.lua --quiet

echo ""
echo "=== Scraping dungeon loot tables ==="
python3 scrape_loot.py $EXTRA_ARGS --save-html snapshots/loot --output Data.lua

echo ""
echo "=== Scraping raid loot tables ==="
python3 scrape_loot.py --raids $EXTRA_ARGS --save-html snapshots/loot --output Data.lua

echo ""
echo "=== Done! Data.lua updated ==="
