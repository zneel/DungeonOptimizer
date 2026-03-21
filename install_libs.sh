#!/bin/bash
# ============================================================================
# DungeonOptimizer - Library Installer
# Downloads all dependencies from GitHub (no SVN needed)
# ============================================================================

set -e

LIBS_DIR="Libs"
mkdir -p "$LIBS_DIR"

echo "=== Dungeon Optimizer - Installation des librairies ==="
echo ""

# Ace3 - all modules from one repo (includes LibStub and CallbackHandler)
ACE3_MODULES="AceAddon-3.0 AceConsole-3.0 AceDB-3.0 AceEvent-3.0 AceTimer-3.0 AceGUI-3.0 CallbackHandler-1.0 LibStub"
ACE3_URL="https://github.com/WoWUIDev/Ace3/archive/refs/heads/master.tar.gz"

echo "[1/3] Ace3 ($(echo $ACE3_MODULES | wc -w | tr -d ' ') modules)..."
TMP=$(mktemp -d)
curl -sL "$ACE3_URL" -o "$TMP/ace3.tar.gz"
tar -xzf "$TMP/ace3.tar.gz" -C "$TMP"
for mod in $ACE3_MODULES; do
    rm -rf "$LIBS_DIR/$mod"
    cp -r "$TMP/Ace3-master/$mod" "$LIBS_DIR/$mod"
    echo "  - $mod"
done
rm -rf "$TMP"

echo "[2/3] LibDataBroker-1.1..."
mkdir -p "$LIBS_DIR/LibDataBroker-1.1"
curl -sL "https://raw.githubusercontent.com/tekkub/libdatabroker-1-1/master/LibDataBroker-1.1.lua" \
    -o "$LIBS_DIR/LibDataBroker-1.1/LibDataBroker-1.1.lua"

echo "[3/3] LibDBIcon-1.0..."
mkdir -p "$LIBS_DIR/LibDBIcon-1.0"
curl -sL "https://raw.githubusercontent.com/wowace-clone/LibDBIcon-1.0/master/LibDBIcon-1.0/LibDBIcon-1.0.lua" \
    -o "$LIBS_DIR/LibDBIcon-1.0/LibDBIcon-1.0.lua"
curl -sL "https://raw.githubusercontent.com/wowace-clone/LibDBIcon-1.0/master/LibDBIcon-1.0/lib.xml" \
    -o "$LIBS_DIR/LibDBIcon-1.0/lib.xml"

echo ""
echo "=== Done ==="
find "$LIBS_DIR" -maxdepth 2 -name "*.lua" | wc -l | xargs -I{} echo "{} Lua files installed"
