#!/bin/bash
# ============================================================================
# DungeonOptimizer - Library Installer
# Downloads all dependencies from CurseForge SVN repos (same as .pkgmeta)
# Requires: svn (brew install svn)
# ============================================================================

set -e

LIBS_DIR="Libs"
mkdir -p "$LIBS_DIR"

echo "=== Dungeon Optimizer - Installation des librairies ==="
echo ""

# Check for svn
if ! command -v svn &> /dev/null; then
    echo "ERROR: svn is required. Install it with: brew install svn"
    exit 1
fi

checkout() {
    local name="$1"
    local url="$2"
    local dest="$LIBS_DIR/$name"

    if [ -d "$dest" ] && [ "$(ls -A "$dest" 2>/dev/null)" ]; then
        echo "  [UPDATE] $name"
        svn update "$dest" --quiet
    else
        echo "  [INSTALL] $name"
        rm -rf "$dest"
        svn checkout "$url" "$dest" --quiet
    fi
}

echo "[1/10] LibStub..."
checkout "LibStub" "https://repos.curseforge.com/wow/libstub/trunk"

echo "[2/10] CallbackHandler-1.0..."
checkout "CallbackHandler-1.0" "https://repos.curseforge.com/wow/callbackhandler/trunk/CallbackHandler-1.0"

echo "[3/10] AceAddon-3.0..."
checkout "AceAddon-3.0" "https://repos.curseforge.com/wow/ace3/trunk/AceAddon-3.0"

echo "[4/10] AceConsole-3.0..."
checkout "AceConsole-3.0" "https://repos.curseforge.com/wow/ace3/trunk/AceConsole-3.0"

echo "[5/10] AceDB-3.0..."
checkout "AceDB-3.0" "https://repos.curseforge.com/wow/ace3/trunk/AceDB-3.0"

echo "[6/10] AceEvent-3.0..."
checkout "AceEvent-3.0" "https://repos.curseforge.com/wow/ace3/trunk/AceEvent-3.0"

echo "[7/10] AceTimer-3.0..."
checkout "AceTimer-3.0" "https://repos.curseforge.com/wow/ace3/trunk/AceTimer-3.0"

echo "[8/10] AceGUI-3.0..."
checkout "AceGUI-3.0" "https://repos.curseforge.com/wow/ace3/trunk/AceGUI-3.0"

echo "[9/10] LibDataBroker-1.1..."
checkout "LibDataBroker-1.1" "https://repos.curseforge.com/wow/libdatabroker-1-1/trunk"

echo "[10/10] LibDBIcon-1.0..."
checkout "LibDBIcon-1.0" "https://repos.curseforge.com/wow/libdbicon-1-0/trunk/LibDBIcon-1.0"

echo ""
echo "=== Toutes les librairies sont installées ! ==="
echo ""
echo "Structure:"
find "$LIBS_DIR" -maxdepth 2 -name "*.lua" -o -name "*.xml" | head -30
echo ""
echo "L'addon est prêt. Copie le dossier DungeonOptimizer/ dans :"
echo "  World of Warcraft/_retail_/Interface/AddOns/"
