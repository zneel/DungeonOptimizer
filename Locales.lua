-- ============================================================================
-- DungeonOptimizer - Locales.lua
-- Internationalization: English (default) + French
-- ============================================================================

local ADDON_NAME, NS = ...

NS.L = {}

-- Default language: English
local L = {
    -- Core
    ["ADDON_LOADED"] = "|cff00ff00Dungeon Optimizer|r loaded. Type |cffeda55f/do|r to open.",
    ["SCANNING_GROUP"] = "Scanning group...",
    ["SCAN_COMPLETE"] = "Scan complete: |cff00ff00%d|r member(s) scanned.",
    ["SKIPPED"] = "Skipped:",
    ["EXCLUDED_RESET"] = "Your dungeon completions have been reset.",

    -- Slash commands
    ["HELP_TITLE"] = "|cff00ff00Dungeon Optimizer - Commands:|r",
    ["HELP_OPEN"] = "  |cffeda55f/do|r - Open/Close window",
    ["HELP_SCAN"] = "  |cffeda55f/do scan|r - Scan group members",
    ["HELP_RESET"] = "  |cffeda55f/do reset|r - Reset your dungeon completions",

    -- Minimap tooltip
    ["TOOLTIP_LEFT"] = "|cffeda55fLeft-click|r : Open/Close window",
    ["TOOLTIP_RIGHT"] = "|cffeda55fRight-click|r : Scan group",

    -- UI
    ["WINDOW_TITLE"] = "Dungeon Optimizer - Midnight Season 1",
    ["STATUS_TEXT"] = "Right-click minimap icon to scan | /do help",
    ["SCAN_GROUP"] = "Scan Group",
    ["SCANNED_COUNT"] = "  |cff00ff00%d|r / %d scanned",
    ["BIS_MODE"] = "BIS Mode",
    ["RESET_EXCLUSIONS"] = "Reset My Completions",
    ["GROUP_MEMBERS"] = "Group Members",
    ["EXCLUDE_DUNGEONS"] = "Dungeon Completions (this week)",
    ["COMPLETED_BY"] = "Completed by:",
    ["DUNGEON_RANKING"] = "Dungeon Ranking - %s (best to worst)",
    ["NO_DUNGEONS"] = "|cffff0000No dungeons available. Check exclusions or scan the group.|r",
    ["UPGRADES_FOR_GROUP"] = "|cff00ff00%d upgrade(s)|r for the group",
    ["NO_BIS_UPGRADES"] = "   |cff888888No BIS upgrades available in this dungeon.|r",
    ["BIS_ITEMS_NEEDED"] = "   |cff%s%s|r  -  %d BIS item(s) needed:",
    ["BIS_LIST_HEADER"] = "|cff%s%s|r - BIS List (%s)",
    ["EQUIPPED"] = "(equipped)",
    ["MISSING"] = "(missing)",
    ["NO_BIS_DATA"] = "|cff888888No BIS data for this spec|r",
    ["UNKNOWN_SPEC"] = "Unknown",

    -- Slot names
    ["SLOT_HEAD"] = "Head",
    ["SLOT_NECK"] = "Neck",
    ["SLOT_SHOULDERS"] = "Shoulders",
    ["SLOT_CHEST"] = "Chest",
    ["SLOT_WAIST"] = "Waist",
    ["SLOT_LEGS"] = "Legs",
    ["SLOT_FEET"] = "Feet",
    ["SLOT_WRIST"] = "Wrist",
    ["SLOT_HANDS"] = "Hands",
    ["SLOT_RING1"] = "Ring 1",
    ["SLOT_RING2"] = "Ring 2",
    ["SLOT_TRINKET1"] = "Trinket 1",
    ["SLOT_TRINKET2"] = "Trinket 2",
    ["SLOT_BACK"] = "Back",
    ["SLOT_MAINHAND"] = "Main Hand",
    ["SLOT_OFFHAND"] = "Off Hand",
}

-- French overrides
local frFR = {
    ["ADDON_LOADED"] = "|cff00ff00Dungeon Optimizer|r charg\195\169. Tapez |cffeda55f/do|r pour ouvrir.",
    ["SCANNING_GROUP"] = "Scan du groupe en cours...",
    ["SCAN_COMPLETE"] = "Scan termin\195\169 : |cff00ff00%d|r membre(s) analys\195\169(s).",
    ["SKIPPED"] = "Ignor\195\169 :",
    ["EXCLUDED_RESET"] = "Vos compl\195\169tions de donjons ont \195\169t\195\169 r\195\169initialis\195\169es.",

    ["HELP_TITLE"] = "|cff00ff00Dungeon Optimizer - Commandes :|r",
    ["HELP_OPEN"] = "  |cffeda55f/do|r - Ouvrir/Fermer la fen\195\170tre",
    ["HELP_SCAN"] = "  |cffeda55f/do scan|r - Scanner le groupe",
    ["HELP_RESET"] = "  |cffeda55f/do reset|r - R\195\169initialiser vos compl\195\169tions de donjons",

    ["TOOLTIP_LEFT"] = "|cffeda55fClic gauche|r : Ouvrir/Fermer la fen\195\170tre",
    ["TOOLTIP_RIGHT"] = "|cffeda55fClic droit|r : Scanner le groupe",

    ["WINDOW_TITLE"] = "Dungeon Optimizer - Midnight Saison 1",
    ["STATUS_TEXT"] = "Clic droit minimap = scanner | /do help",
    ["SCAN_GROUP"] = "Scanner le groupe",
    ["SCANNED_COUNT"] = "  |cff00ff00%d|r / %d scann\195\169s",
    ["BIS_MODE"] = "Mode BIS",
    ["RESET_EXCLUSIONS"] = "R\195\169init. mes compl\195\169tions",
    ["GROUP_MEMBERS"] = "Membres du groupe",
    ["EXCLUDE_DUNGEONS"] = "Compl\195\169tions de donjons (cette semaine)",
    ["COMPLETED_BY"] = "Compl\195\169t\195\169 par :",
    ["DUNGEON_RANKING"] = "Classement des donjons - %s (du meilleur au pire)",
    ["NO_DUNGEONS"] = "|cffff0000Aucun donjon disponible. V\195\169rifiez les exclusions ou scannez le groupe.|r",
    ["UPGRADES_FOR_GROUP"] = "|cff00ff00%d upgrade(s)|r pour le groupe",
    ["NO_BIS_UPGRADES"] = "   |cff888888Aucun upgrade BIS disponible dans ce donjon.|r",
    ["BIS_ITEMS_NEEDED"] = "   |cff%s%s|r  -  %d item(s) BIS manquant(s) :",
    ["BIS_LIST_HEADER"] = "|cff%s%s|r - Liste BIS (%s)",
    ["EQUIPPED"] = "(\195\169quip\195\169)",
    ["MISSING"] = "(manquant)",
    ["NO_BIS_DATA"] = "|cff888888Pas de donn\195\169es BIS pour cette sp\195\169cialisation|r",
    ["UNKNOWN_SPEC"] = "Inconnue",

    ["SLOT_HEAD"] = "T\195\170te",
    ["SLOT_NECK"] = "Cou",
    ["SLOT_SHOULDERS"] = "\195\137paules",
    ["SLOT_CHEST"] = "Torse",
    ["SLOT_WAIST"] = "Taille",
    ["SLOT_LEGS"] = "Jambes",
    ["SLOT_FEET"] = "Pieds",
    ["SLOT_WRIST"] = "Poignets",
    ["SLOT_HANDS"] = "Mains",
    ["SLOT_RING1"] = "Anneau 1",
    ["SLOT_RING2"] = "Anneau 2",
    ["SLOT_TRINKET1"] = "Bijou 1",
    ["SLOT_TRINKET2"] = "Bijou 2",
    ["SLOT_BACK"] = "Dos",
    ["SLOT_MAINHAND"] = "Main droite",
    ["SLOT_OFFHAND"] = "Main gauche",
}

-- Detect locale and set up accessor
local locale = GetLocale()
local activeLocale = L

if locale == "frFR" then
    -- Merge French on top of English defaults
    activeLocale = setmetatable(frFR, { __index = L })
end

-- Public accessor: NS.L("KEY") or NS.L["KEY"]
setmetatable(NS.L, {
    __index = function(_, key)
        return activeLocale[key] or L[key] or key
    end,
    __call = function(_, key)
        return activeLocale[key] or L[key] or key
    end,
})
