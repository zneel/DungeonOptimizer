-- ============================================================================
-- DungeonOptimizer - Core.lua
-- Main addon logic: Ace3-based addon, scoring engine, dungeon ranking
-- ============================================================================

local ADDON_NAME, NS = ...

-- ============================================================================
-- Ace3 Addon Creation
-- ============================================================================
local DungeonOptimizer = LibStub("AceAddon-3.0"):NewAddon(
    ADDON_NAME,
    "AceConsole-3.0",
    "AceEvent-3.0",
    "AceTimer-3.0"
)
NS.Core = DungeonOptimizer

-- ============================================================================
-- Default saved variables
-- ============================================================================
local defaults = {
    profile = {
        minimap = { hide = false },
        excludedDungeons = {},  -- { ["DUNGEON_ID"] = true }
        bisMode = "mythic",    -- "overall", "mythic", or "raid"
        showTooltips = true,
    },
}

-- BIS mode labels
NS.BIS_MODES = {
    { key = "overall", label = "Overall" },
    { key = "mythic",  label = "Mythique+" },
    { key = "raid",    label = "Raid" },
}

-- Returns the active BIS table based on current mode
function NS.GetActiveBISTable()
    local mode = NS.Core and NS.Core.db and NS.Core.db.profile.bisMode or "mythic"
    if mode == "raid" then
        return NS.BIS_RAID
    elseif mode == "overall" then
        return NS.BIS_OVERALL
    else
        return NS.BIS_MYTHIC
    end
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================
function DungeonOptimizer:OnInitialize()
    -- AceDB for saved variables
    self.db = LibStub("AceDB-3.0"):New("DungeonOptimizerDB", defaults, true)

    -- LibDataBroker launcher
    local LDB = LibStub("LibDataBroker-1.1")
    self.launcher = LDB:NewDataObject(ADDON_NAME, {
        type = "launcher",
        icon = "Interface\\Icons\\inv_misc_map_01",
        text = "Dungeon Optimizer",
        OnClick = function(_, button)
            if button == "LeftButton" then
                NS.UI:Toggle()
            elseif button == "RightButton" then
                self:ScanGroup()
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine("|cff00ff00Dungeon Optimizer|r")
            tooltip:AddLine(" ")
            tooltip:AddLine("|cffeda55fClic gauche|r : Ouvrir/Fermer la fenêtre")
            tooltip:AddLine("|cffeda55fClic droit|r : Scanner le groupe")
        end,
    })

    -- LibDBIcon minimap button
    local icon = LibStub("LibDBIcon-1.0")
    icon:Register(ADDON_NAME, self.launcher, self.db.profile.minimap)

    -- Slash commands
    self:RegisterChatCommand("dopt", "SlashCommand")
    self:RegisterChatCommand("dungeonopt", "SlashCommand")

    self:Print("|cff00ff00Dungeon Optimizer|r chargé. Tapez |cffeda55f/dopt|r pour ouvrir.")
end

function DungeonOptimizer:OnEnable()
    -- Register for inspect events
    self:RegisterEvent("INSPECT_READY")
    self:RegisterEvent("GROUP_ROSTER_UPDATE")
    self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
end

function DungeonOptimizer:OnDisable()
    self:UnregisterAllEvents()
end

-- ============================================================================
-- EVENT HANDLERS
-- ============================================================================
function DungeonOptimizer:INSPECT_READY(event, guid)
    NS.Inspect:OnInspectReady(guid)
end

function DungeonOptimizer:GET_ITEM_INFO_RECEIVED()
    -- When item cache is populated, refresh UI to show real item names
    if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
        if self._itemInfoTimer then
            self:CancelTimer(self._itemInfoTimer)
        end
        -- Debounce: many items arrive rapidly
        self._itemInfoTimer = self:ScheduleTimer(function()
            NS.UI:RefreshUI()
        end, 0.5)
    end
end

function DungeonOptimizer:GROUP_ROSTER_UPDATE()
    -- Auto-refresh if UI is open
    if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
        -- Debounce: cancel any pending timer before scheduling a new one
        if self._rosterTimer then
            self:CancelTimer(self._rosterTimer)
        end
        self._rosterTimer = self:ScheduleTimer("ScanGroup", 1)
    end
end

-- ============================================================================
-- SLASH COMMAND
-- ============================================================================
function DungeonOptimizer:SlashCommand(input)
    local cmd = self:GetArgs(input, 1)
    if cmd == "scan" then
        self:ScanGroup()
    elseif cmd == "reset" then
        wipe(self.db.profile.excludedDungeons)
        self:Print("Donjons exclus réinitialisés.")
        if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
            NS.UI:RefreshUI()
        end
    elseif cmd == "help" then
        self:Print("|cff00ff00Dungeon Optimizer - Commandes :|r")
        self:Print("  |cffeda55f/dopt|r - Ouvrir/Fermer la fenêtre")
        self:Print("  |cffeda55f/dopt scan|r - Scanner le groupe")
        self:Print("  |cffeda55f/dopt reset|r - Réinitialiser les donjons exclus")
    else
        NS.UI:Toggle()
    end
end

-- ============================================================================
-- GROUP SCANNING
-- ============================================================================
function DungeonOptimizer:ScanGroup()
    self:Print("Scan du groupe en cours...")
    NS.Inspect:ScanGroup()
end

-- Called by Inspect module when scan is complete
function DungeonOptimizer:OnScanComplete()
    local count = NS.Inspect:GetScannedCount()
    self:Print(string.format("Scan terminé : |cff00ff00%d|r membre(s) analysé(s).", count))

    -- Calculate and refresh UI
    self.lastRanking = self:CalculateDungeonRanking()
    if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
        NS.UI:RefreshUI()
    end
end

-- ============================================================================
-- BIS COMPARISON ENGINE
-- ============================================================================

-- Check if a player needs a specific item (it's in their BIS list and not equipped)
function DungeonOptimizer:PlayerNeedsItem(playerData, itemId, slot)
    if not playerData or not playerData.spec then return false end

    local bisTable = NS.GetActiveBISTable()
    local bisList = bisTable[playerData.spec]
    if not bisList then return false end

    -- Check if this item is BIS for any matching slot
    -- For rings/trinkets, check both slots
    local slotsToCheck = { slot }
    if slot == 11 then slotsToCheck = { 11, 12 }
    elseif slot == 12 then slotsToCheck = { 11, 12 }
    elseif slot == 13 then slotsToCheck = { 13, 14 }
    elseif slot == 14 then slotsToCheck = { 13, 14 }
    end

    for _, checkSlot in ipairs(slotsToCheck) do
        local bisItemId = bisList[checkSlot]
        if bisItemId and bisItemId == itemId then
            -- Check if player already has it equipped in any valid slot
            local alreadyEquipped = false
            for _, eqSlot in ipairs(slotsToCheck) do
                if playerData.gear[eqSlot] == itemId then
                    alreadyEquipped = true
                    break
                end
            end
            if not alreadyEquipped then
                return true
            end
        end
    end

    return false
end

-- Count how many BIS items a player is missing overall
function DungeonOptimizer:CountMissingBIS(playerData)
    if not playerData or not playerData.spec then return 0, 0 end

    local bisTable = NS.GetActiveBISTable()
    local bisList = bisTable[playerData.spec]
    if not bisList then return 0, 0 end

    local total = 0
    local missing = 0

    for slot, bisItemId in pairs(bisList) do
        total = total + 1
        if playerData.gear[slot] ~= bisItemId then
            missing = missing + 1
        end
    end

    return missing, total
end

-- ============================================================================
-- DUNGEON SCORING & RANKING
-- ============================================================================

-- Score a single dungeon for the whole group
-- Returns: total score, and details per player
function DungeonOptimizer:ScoreDungeon(dungeonId)
    local lootTable = NS.DUNGEON_LOOT[dungeonId]
    if not lootTable then return 0, {} end

    local totalScore = 0
    local playerDetails = {} -- { ["Name-Realm"] = { needed = { {item, slot, boss}, ... } } }

    for playerName, playerData in pairs(NS.groupData) do
        local needed = {}

        for _, drop in ipairs(lootTable) do
            if self:PlayerNeedsItem(playerData, drop.itemId, drop.slot) then
                table.insert(needed, {
                    itemId = drop.itemId,
                    slot = drop.slot,
                    itemName = drop.itemName or ("Item " .. drop.itemId),
                    slotName = NS.SLOT_NAMES[drop.slot] or "?",
                })
            end
        end

        if #needed > 0 then
            playerDetails[playerName] = {
                needed = needed,
                count = #needed,
                class = playerData.class,
                name = playerData.name,
            }
            totalScore = totalScore + #needed
        end
    end

    return totalScore, playerDetails
end

-- Calculate ranking for all non-excluded dungeons
function DungeonOptimizer:CalculateDungeonRanking()
    local ranking = {}

    for _, dungeon in ipairs(NS.DUNGEONS) do
        if not self.db.profile.excludedDungeons[dungeon.id] then
            local score, details = self:ScoreDungeon(dungeon.id)
            table.insert(ranking, {
                dungeon = dungeon,
                score = score,
                details = details,
            })
        end
    end

    -- Sort by score descending (most upgrades first)
    table.sort(ranking, function(a, b) return a.score > b.score end)

    return ranking
end

-- ============================================================================
-- UTILITY: Get class color
-- ============================================================================
NS.CLASS_COLORS = {
    WARRIOR     = "c79c6e",
    PALADIN     = "f58cba",
    HUNTER      = "abd473",
    ROGUE       = "fff569",
    PRIEST      = "ffffff",
    DEATHKNIGHT = "c41e3a",
    SHAMAN      = "0070de",
    MAGE        = "69ccf0",
    WARLOCK     = "9482c9",
    MONK        = "00ff96",
    DRUID       = "ff7d0a",
    DEMONHUNTER = "a330c9",
    EVOKER      = "33937f",
}

function NS.ColorByClass(text, class)
    local color = NS.CLASS_COLORS[class] or "ffffff"
    return string.format("|cff%s%s|r", color, text)
end
