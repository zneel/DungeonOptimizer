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
    ["SCANNING_SOLO"] = "Scanning your gear...",
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
    ["TOOLTIP_RIGHT_SOLO"] = "|cffeda55fRight-click|r : Scan gear",

    -- UI
    ["WINDOW_TITLE"] = "Dungeon Optimizer - Midnight Season 1",
    ["STATUS_TEXT"] = "Right-click minimap icon to scan | /do help",
    ["SCAN_GROUP"] = "Scan Group",
    ["SCAN_SOLO"] = "Scan",
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

    -- Off-Spec
    ["OFF_SPEC_LABEL"] = "Off-Spec:",
    ["OFF_SPEC_NONE"] = "None",
    ["OFF_SPEC_TAG"] = "[OS]",
    ["OFF_SPEC_RESET"] = "Off-spec reset (now your active spec).",

    -- Upgrades (#43)
    ["UPGRADE_TAG"] = "[UPG]",
    ["UPGRADE_SCORING_LABEL"] = "Upgrades",
    ["TARGET_KEY_LABEL"] = "Target Key",

    -- Tabs
    ["TAB_MPLUS"] = "Mythic+",
    ["TAB_RAID"] = "Raid",
    ["TAB_OVERALL"] = "Overall",
    ["RAID_RANKING"] = "Raid Ranking - %s (best to worst)",
    ["NO_RAIDS"] = "|cffff0000No raid data available. Populate raid loot tables first.|r",
    ["NO_OVERALL"] = "|cffff0000No overall BIS data available.|r",
    ["OVERALL_RANKING"] = "Overall BIS Ranking (best to worst)",

    -- Catalyst
    ["CATALYST_SUGGEST"] = "Catalyst suggestion: convert %s (%s)",

    -- Ready Check
    ["READYCHECK_TITLE"] = "BIS Ready Check",
    ["READYCHECK_ENCHANTS"] = "Enchants",
    ["READYCHECK_GEMS"] = "Gems",
    ["READYCHECK_FLASK"] = "Flask/Phial",
    ["READYCHECK_FOOD"] = "Food",
    ["READYCHECK_RUNE"] = "Augment Rune",
    ["READYCHECK_PASS"] = "|cff00ff00PASS|r",
    ["READYCHECK_FAIL"] = "|cffff4444FAIL|r",
    ["READYCHECK_SCANNING"] = "Running BIS ready check...",
    ["READYCHECK_RANGE"] = "|cff888888(out of range)|r",

    -- V4 Dashboard
    ["DASHBOARD_NO_KEYS"] = "No keystones detected",
    ["DASHBOARD_NO_DATA"] = "No data available. Scan the group to start.",
    ["DASHBOARD_NO_DATA_SOLO"] = "No data available. Click Scan to start.",
    ["DASHBOARD_ALL_COMPLETED"] = "All dungeons completed this week! Reset completions to see rankings.",
    ["ROADMAP_FULLY_GEARED"] = "You're fully BIS geared! Check the M+ tab for dungeon rankings.",
    ["ROADMAP_FULLY_GEARED_GROUP"] = "You're fully BIS geared! Check the M+ tab to help your group get upgrades.",
    ["ROADMAP_NO_BIS"] = "BIS data not available for your spec. Try changing BIS mode.",
    ["ROADMAP_NO_DATA"] = "Scan your group first to generate upgrade actions.",
    ["ROADMAP_NO_DATA_SOLO"] = "Click Scan to analyze your gear and generate upgrade actions.",
    ["DASHBOARD_RIO_STALE"] = "RIO formula may be outdated - using gear scoring only",
    ["DASHBOARD_VAULT_UNCLAIMED"] = "Unclaimed rewards!",
    ["DASHBOARD_VAULT_NEED_MORE"] = "Need more keys",
    ["DASHBOARD_VAULT_COMPLETE"] = "All slots filled!",
    ["DASHBOARD_BACK"] = "Back to Dashboard",

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
    ["SCANNING_SOLO"] = "Scan de votre \195\169quipement...",
    ["SCAN_COMPLETE"] = "Scan termin\195\169 : |cff00ff00%d|r membre(s) analys\195\169(s).",
    ["SKIPPED"] = "Ignor\195\169 :",
    ["EXCLUDED_RESET"] = "Vos compl\195\169tions de donjons ont \195\169t\195\169 r\195\169initialis\195\169es.",

    ["HELP_TITLE"] = "|cff00ff00Dungeon Optimizer - Commandes :|r",
    ["HELP_OPEN"] = "  |cffeda55f/do|r - Ouvrir/Fermer la fen\195\170tre",
    ["HELP_SCAN"] = "  |cffeda55f/do scan|r - Scanner le groupe",
    ["HELP_RESET"] = "  |cffeda55f/do reset|r - R\195\169initialiser vos compl\195\169tions de donjons",

    ["TOOLTIP_LEFT"] = "|cffeda55fClic gauche|r : Ouvrir/Fermer la fen\195\170tre",
    ["TOOLTIP_RIGHT"] = "|cffeda55fClic droit|r : Scanner le groupe",
    ["TOOLTIP_RIGHT_SOLO"] = "|cffeda55fClic droit|r : Scanner l'\195\169quipement",

    ["WINDOW_TITLE"] = "Dungeon Optimizer - Midnight Saison 1",
    ["STATUS_TEXT"] = "Clic droit minimap = scanner | /do help",
    ["SCAN_GROUP"] = "Scanner le groupe",
    ["SCAN_SOLO"] = "Scanner",
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

    ["OFF_SPEC_LABEL"] = "Off-Spec :",
    ["OFF_SPEC_NONE"] = "Aucune",
    ["OFF_SPEC_TAG"] = "[OS]",
    ["OFF_SPEC_RESET"] = "Off-spec r\195\169initialis\195\169e (c'est maintenant votre spec active).",

    -- Upgrades (#43)
    ["UPGRADE_TAG"] = "[UPG]",
    ["UPGRADE_SCORING_LABEL"] = "Upgrades",
    ["TARGET_KEY_LABEL"] = "Cl\195\169 cible",

    ["TAB_MPLUS"] = "Mythic+",
    ["TAB_RAID"] = "Raid",
    ["TAB_OVERALL"] = "Overall",
    ["RAID_RANKING"] = "Classement du raid - %s (du meilleur au pire)",
    ["NO_RAIDS"] = "|cffff0000Aucune donn\195\169e de raid disponible.|r",
    ["NO_OVERALL"] = "|cffff0000Aucune donn\195\169e BIS Overall disponible.|r",
    ["OVERALL_RANKING"] = "Classement Overall BIS (du meilleur au pire)",

    ["CATALYST_SUGGEST"] = "Suggestion catalyst : convertir %s (%s)",

    -- V4 Dashboard
    ["DASHBOARD_NO_KEYS"] = "Aucune cl\195\169 d\195\169tect\195\169e",
    ["DASHBOARD_NO_DATA"] = "Aucune donn\195\169e disponible. Scannez le groupe.",
    ["DASHBOARD_NO_DATA_SOLO"] = "Aucune donn\195\169e disponible. Cliquez sur Scanner.",
    ["DASHBOARD_ALL_COMPLETED"] = "Tous les donjons compl\195\169t\195\169s cette semaine ! R\195\169initialisez pour voir le classement.",
    ["ROADMAP_FULLY_GEARED"] = "Vous \195\170tes full BIS ! V\195\169rifiez l'onglet M+ pour le classement des donjons.",
    ["ROADMAP_FULLY_GEARED_GROUP"] = "Vous \195\170tes full BIS ! V\195\169rifiez l'onglet M+ pour aider votre groupe.",
    ["ROADMAP_NO_BIS"] = "Donn\195\169es BIS non disponibles pour votre sp\195\169c. Essayez un autre mode BIS.",
    ["ROADMAP_NO_DATA"] = "Scannez votre groupe pour g\195\169n\195\169rer des actions d'am\195\169lioration.",
    ["ROADMAP_NO_DATA_SOLO"] = "Cliquez sur Scanner pour analyser votre \195\169quipement.",
    ["DASHBOARD_RIO_STALE"] = "Formule RIO peut-\195\170tre obsol\195\168te - scoring gear uniquement",
    ["DASHBOARD_VAULT_UNCLAIMED"] = "R\195\169compenses non r\195\169clam\195\169es !",
    ["DASHBOARD_VAULT_NEED_MORE"] = "Besoin de plus de cl\195\169s",
    ["DASHBOARD_VAULT_COMPLETE"] = "Tous les slots remplis !",
    ["DASHBOARD_BACK"] = "Retour au tableau de bord",

    ["READYCHECK_TITLE"] = "V\195\169rification BIS",
    ["READYCHECK_ENCHANTS"] = "Enchantements",
    ["READYCHECK_GEMS"] = "Gemmes",
    ["READYCHECK_FLASK"] = "Flasque/Fiole",
    ["READYCHECK_FOOD"] = "Nourriture",
    ["READYCHECK_RUNE"] = "Rune d'augmentation",
    ["READYCHECK_PASS"] = "|cff00ff00OK|r",
    ["READYCHECK_FAIL"] = "|cffff4444MANQUE|r",
    ["READYCHECK_SCANNING"] = "V\195\169rification BIS en cours...",
    ["READYCHECK_RANGE"] = "|cff888888(hors de port\195\169e)|r",

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
