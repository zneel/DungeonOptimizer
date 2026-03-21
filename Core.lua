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

-- Returns the BIS table (always Mythic+ — this is a dungeon optimizer)
function NS.GetActiveBISTable()
    return NS.BIS_MYTHIC
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
            tooltip:AddLine(NS.L["TOOLTIP_LEFT"])
            tooltip:AddLine(NS.L["TOOLTIP_RIGHT"])
        end,
    })

    -- LibDBIcon minimap button
    local icon = LibStub("LibDBIcon-1.0")
    icon:Register(ADDON_NAME, self.launcher, self.db.profile.minimap)

    -- Slash commands
    self:RegisterChatCommand("do", "SlashCommand")
    self:RegisterChatCommand("dopt", "SlashCommand")
    self:RegisterChatCommand("dungeonopt", "SlashCommand")

    self:Print(NS.L["ADDON_LOADED"])
end

local ADDON_MSG_PREFIX = "DOptSync"

function DungeonOptimizer:OnEnable()
    -- Register for inspect events
    self:RegisterEvent("INSPECT_READY")
    self:RegisterEvent("GROUP_ROSTER_UPDATE")
    self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
    self:RegisterEvent("CHAT_MSG_ADDON")
    -- Register addon message prefix for group sync
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX)

    -- Auto-detect completed dungeons from this week's M+ history
    self:AutoDetectCompletedDungeons()
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
        self:Print(NS.L["EXCLUDED_RESET"])
        self:BroadcastExcluded()
        if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
            NS.UI:RefreshUI()
        end
    elseif cmd == "help" then
        self:Print(NS.L["HELP_TITLE"])
        self:Print(NS.L["HELP_OPEN"])
        self:Print(NS.L["HELP_SCAN"])
        self:Print(NS.L["HELP_RESET"])
    else
        NS.UI:Toggle()
    end
end

-- ============================================================================
-- GROUP SCANNING
-- ============================================================================
function DungeonOptimizer:ScanGroup()
    self:Print(NS.L["SCANNING_GROUP"])
    NS.Inspect:ScanGroup()
end

-- Called by Inspect module when scan is complete
function DungeonOptimizer:OnScanComplete()
    local count = NS.Inspect:GetScannedCount()
    self:Print(string.format(NS.L["SCAN_COMPLETE"], count))

    -- Report skipped players
    if NS.skippedPlayers and #NS.skippedPlayers > 0 then
        for _, msg in ipairs(NS.skippedPlayers) do
            self:Print(string.format("  |cffff8800%s|r %s", NS.L["SKIPPED"], msg))
        end
    end

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

-- Count how many BIS items a player is missing
-- Returns: missing, total, missingFromDungeons, totalFromDungeons
function DungeonOptimizer:CountMissingBIS(playerData)
    if not playerData or not playerData.spec then return 0, 0, 0, 0 end

    local bisTable = NS.GetActiveBISTable()
    local bisList = bisTable[playerData.spec]
    if not bisList then return 0, 0, 0, 0 end

    local total = 0
    local missing = 0
    local totalDungeon = 0
    local missingDungeon = 0

    for slot, bisItemId in pairs(bisList) do
        -- For paired slots (rings 11/12, trinkets 13/14), only count unique items
        local isPaired = (slot == 12 or slot == 14)
        local pairSlot = isPaired and (slot - 1) or nil

        if isPaired and bisList[pairSlot] == bisItemId then
            -- Same item in both paired slots, already counted via slot 11/13
        else
            total = total + 1
            local isMissing = (playerData.gear[slot] ~= bisItemId)
            if isMissing then
                missing = missing + 1
            end

            -- Track dungeon-droppable items separately
            if NS.IsFromDungeon(bisItemId) then
                totalDungeon = totalDungeon + 1
                if isMissing then
                    missingDungeon = missingDungeon + 1
                end
            end
        end
    end

    return missing, total, missingDungeon, totalDungeon
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
        local seenItems = {} -- Deduplicate: same itemId should only appear once per player

        for _, drop in ipairs(lootTable) do
            if not seenItems[drop.itemId] and self:PlayerNeedsItem(playerData, drop.itemId, drop.slot) then
                seenItems[drop.itemId] = true
                table.insert(needed, {
                    itemId = drop.itemId,
                    slot = drop.slot,
                    itemName = drop.itemName or ("Item " .. drop.itemId),
                    slotName = NS.SLOT_NAMES[drop.slot] or "?",
                    boss = drop.boss or "",
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

-- ============================================================================
-- DUNGEON COMPLETION SYNC (#11)
-- Auto-detect completed dungeons + sync between group members
-- ============================================================================

-- Map WoW dungeon mapChallengeModeID -> our dungeon key
-- These IDs may need updating for Midnight
NS.CHALLENGE_MODE_MAP = {
    -- New Midnight dungeons (IDs are approximate — verify in-game)
    [2773] = "MAGISTER",
    [2774] = "MAISARA",
    [2775] = "WINDRUNNER",
    [2776] = "NEXUS_XENAS",
    -- Legacy dungeons
    [2286] = "ALGETHAR",
    [2293] = "PIT_OF_SARON",
    [2295] = "SEAT",
    [2296] = "SKYREACH",
}

-- Also map by dungeon activity name (more reliable)
NS.ACTIVITY_NAME_MAP = {
    ["magisters' terrace"]    = "MAGISTER",
    ["maisara caverns"]       = "MAISARA",
    ["windrunner spire"]      = "WINDRUNNER",
    ["nexus-point xenas"]     = "NEXUS_XENAS",
    ["algeth'ar academy"]     = "ALGETHAR",
    ["pit of saron"]          = "PIT_OF_SARON",
    ["seat of the triumvirate"] = "SEAT",
    ["the seat of the triumvirate"] = "SEAT",
    ["skyreach"]              = "SKYREACH",
}

function DungeonOptimizer:AutoDetectCompletedDungeons()
    -- Try to detect this week's completed M+ from C_MythicPlus
    if not C_MythicPlus then return end

    local runs = C_MythicPlus.GetRunHistory(false, true) -- thisWeek=true
    if not runs then return end

    local detected = 0
    for _, run in ipairs(runs) do
        local mapID = run.mapChallengeModeID
        local dungeonKey = NS.CHALLENGE_MODE_MAP[mapID]
        if dungeonKey and not self.db.profile.excludedDungeons[dungeonKey] then
            self.db.profile.excludedDungeons[dungeonKey] = true
            detected = detected + 1
        end
    end

    if detected > 0 then
        self:Print(string.format("Auto-detected |cff00ff00%d|r completed dungeon(s) this week.", detected))
    end
end

-- Serialize excluded dungeons for sync
function DungeonOptimizer:SerializeExcluded()
    local parts = {}
    for id, val in pairs(self.db.profile.excludedDungeons) do
        if val then
            table.insert(parts, id)
        end
    end
    return table.concat(parts, ",")
end

-- Apply a full exclusion state from a sync message (replaces local state)
function DungeonOptimizer:ApplyExcludedState(data)
    local newState = {}
    if data ~= "RESET" then
        for rawId in data:gmatch("[^,]+") do
            local id = rawId:match("^%s*(.-)%s*$")
            -- Validate it's a known dungeon
            for _, dungeon in ipairs(NS.DUNGEONS) do
                if dungeon.id == id then
                    newState[id] = true
                end
            end
        end
    end

    -- Check if anything changed
    local changed = false
    for _, dungeon in ipairs(NS.DUNGEONS) do
        local id = dungeon.id
        if (self.db.profile.excludedDungeons[id] or false) ~= (newState[id] or false) then
            changed = true
            break
        end
    end

    if changed then
        wipe(self.db.profile.excludedDungeons)
        for id, val in pairs(newState) do
            self.db.profile.excludedDungeons[id] = val
        end
    end

    return changed
end

-- Send our full exclusion state to the group
function DungeonOptimizer:BroadcastExcluded()
    if not IsInGroup() then return end
    local data = self:SerializeExcluded()
    -- Send "RESET" if nothing is excluded, so others clear their state too
    if data == "" then data = "RESET" end
    local channel = IsInRaid() and "RAID" or "PARTY"
    C_ChatInfo.SendAddonMessage(ADDON_MSG_PREFIX, data, channel)
end

-- Handle incoming sync messages
function DungeonOptimizer:CHAT_MSG_ADDON(event, prefix, message, channel, sender)
    if prefix ~= ADDON_MSG_PREFIX then return end
    -- Don't process our own messages
    local myName = UnitName("player")
    if sender and sender:find(myName) then return end

    if self:ApplyExcludedState(message) then
        self:Print(string.format("Synced exclusions from |cff00ff00%s|r.", sender or "group"))
        self.lastRanking = self:CalculateDungeonRanking()
        if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
            NS.UI:RefreshUI()
        end
    end
end
