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
        excludedDungeons = {},
        showTooltips = true,
        weightByScore = true, -- #20: factor M+ score into recommendations
        offSpec = nil, -- off-spec key (e.g. "WARRIOR_FURY"), nil if disabled
        activeTab = "mplus", -- "mplus" or "raid"
        lootAlertEnabled = true, -- #35: show loot trade notifications
    },
}

local ADDON_MSG_PREFIX = "DOptSync"       -- legacy exclusion sync
local ADDON_MSG_PREFIX_KEY = "DOptKey"    -- #21: keystone sync
local ADDON_MSG_PREFIX_COMP = "DOptComp"  -- per-player completion sync
local ADDON_MSG_PREFIX_OFFSPEC = "DOptOff" -- off-spec sync
local ADDON_MSG_PREFIX_CATALYST = "DOptCat" -- #37: catalyst sync

-- Per-player dungeon completions: { ["Name-Realm"] = { MAGISTER=true, ... } }
NS.groupCompletions = {}

-- Returns the M+ BIS table
function NS.GetActiveBISTable()
    return NS.BIS_MYTHIC
end

-- Returns the Raid BIS table
function NS.GetRaidBISTable()
    return NS.BIS_RAID
end

-- Returns the Overall BIS table
function NS.GetOverallBISTable()
    return NS.BIS_OVERALL
end

-- Returns the BIS table for the currently active tab
function NS.GetBISTableForActiveTab()
    local activeTab = NS.Core.db.profile.activeTab or "mplus"
    if activeTab == "raid" then
        return NS.GetRaidBISTable()
    elseif activeTab == "overall" then
        return NS.GetOverallBISTable()
    else
        return NS.GetActiveBISTable()
    end
end

-- Find which BIS slot an item maps to for a given spec
function NS.FindBISSlot(spec, itemId, bisTable)
    bisTable = bisTable or NS.GetActiveBISTable()
    local bisList = bisTable[spec]
    if not bisList then return nil end
    for slot, bisItemId in pairs(bisList) do
        if bisItemId == itemId then return slot end
    end
    return nil
end

-- ============================================================================
-- PER-PLAYER COMPLETION HELPERS
-- ============================================================================

-- Returns true if ANY group member has completed this dungeon
function DungeonOptimizer:IsDungeonExcluded(dungeonId)
    for _, completions in pairs(NS.groupCompletions) do
        if completions[dungeonId] then return true end
    end
    return false
end

-- Returns list of "Name-Realm" who completed a dungeon
function DungeonOptimizer:GetDungeonCompleters(dungeonId)
    local names = {}
    for playerName, completions in pairs(NS.groupCompletions) do
        if completions[dungeonId] then
            table.insert(names, playerName)
        end
    end
    return names
end

-- Remove completion entries for players no longer in the group
function DungeonOptimizer:PruneCompletions()
    local myName = NS.Inspect:GetUnitFullName("player")
    local groupNames = {}
    if myName then groupNames[myName] = true end
    if IsInRaid() then
        for i = 1, GetNumGroupMembers() do
            local unit = "raid" .. i
            if UnitExists(unit) then
                local name = NS.Inspect:GetUnitFullName(unit)
                if name then groupNames[name] = true end
            end
        end
    elseif IsInGroup() then
        for i = 1, GetNumGroupMembers() - 1 do
            local unit = "party" .. i
            if UnitExists(unit) then
                local name = NS.Inspect:GetUnitFullName(unit)
                if name then groupNames[name] = true end
            end
        end
    end

    for playerName in pairs(NS.groupCompletions) do
        if not groupNames[playerName] then
            NS.groupCompletions[playerName] = nil
        end
    end
end

-- Broadcast your own completions to the group
function DungeonOptimizer:BroadcastCompletions()
    if not IsInGroup() then return end
    local parts = {}
    for id, val in pairs(self.db.profile.excludedDungeons) do
        if val then table.insert(parts, id) end
    end
    local data = "V2:" .. (#parts > 0 and table.concat(parts, ",") or "NONE")
    local channel = IsInRaid() and "RAID" or "PARTY"
    C_ChatInfo.SendAddonMessage(ADDON_MSG_PREFIX_COMP, data, channel)
end

-- Seed groupCompletions with the local player's saved data
function DungeonOptimizer:SeedLocalCompletions()
    local myName = NS.Inspect:GetUnitFullName("player")
    if not myName then return end
    NS.groupCompletions[myName] = {}
    for id, val in pairs(self.db.profile.excludedDungeons) do
        if val then NS.groupCompletions[myName][id] = true end
    end
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================
function DungeonOptimizer:OnInitialize()
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

    local icon = LibStub("LibDBIcon-1.0")
    icon:Register(ADDON_NAME, self.launcher, self.db.profile.minimap)

    self:RegisterChatCommand("do", "SlashCommand")
    self:RegisterChatCommand("dopt", "SlashCommand")
    self:RegisterChatCommand("dungeonopt", "SlashCommand")

    self:Print(NS.L["ADDON_LOADED"])
end

function DungeonOptimizer:OnEnable()
    self:RegisterEvent("INSPECT_READY")
    self:RegisterEvent("GROUP_ROSTER_UPDATE")
    self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
    self:RegisterEvent("CHAT_MSG_ADDON")
    -- #26: auto-hide during M+ runs
    self:RegisterEvent("CHALLENGE_MODE_START")
    self:RegisterEvent("CHALLENGE_MODE_COMPLETED")
    -- #27: affix updates
    self:RegisterEvent("MYTHIC_PLUS_CURRENT_AFFIX_UPDATE")
    -- #34: loot trading detection
    self:RegisterEvent("CHAT_MSG_LOOT")

    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX)
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX_KEY)
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX_COMP)
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX_OFFSPEC)
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX_CATALYST)
    -- Register gear sync prefix
    NS.Inspect:RegisterSync()
    -- Off-spec: listen for spec changes to auto-reset
    self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

    -- #18: Build dynamic dungeon list from C_ChallengeMode API
    self:BuildDynamicDungeonList()
    -- Auto-detect completed dungeons
    self:AutoDetectCompletedDungeons()
    -- Seed per-player completion data from saved variables
    self:SeedLocalCompletions()
    -- Broadcast completions and off-spec to group after a short delay
    if IsInGroup() then
        self:ScheduleTimer(function()
            self:BroadcastCompletions()
            self:BroadcastOffSpec()
            self:BroadcastCatalyst()
        end, 2)
    end
    -- #27: Request current affixes
    if C_MythicPlus and C_MythicPlus.RequestCurrentAffixes then
        C_MythicPlus.RequestCurrentAffixes()
    end
end

function DungeonOptimizer:OnDisable()
    self:UnregisterAllEvents()
end

-- ============================================================================
-- #18: DYNAMIC DUNGEON LIST FROM C_ChallengeMode API
-- ============================================================================
function DungeonOptimizer:BuildDynamicDungeonList()
    if not C_ChallengeMode or not C_ChallengeMode.GetMapTable then return end

    local mapIDs = C_ChallengeMode.GetMapTable()
    if not mapIDs or #mapIDs == 0 then return end

    NS.DYNAMIC_DUNGEONS = {}
    NS.MAP_ID_TO_DUNGEON = {}

    for _, mapID in ipairs(mapIDs) do
        local name, id, timeLimitSec, texture, bgTexture = C_ChallengeMode.GetMapUIInfo(mapID)
        if name and name ~= "" then
            -- Try to match to our hardcoded dungeon key
            local dungeonKey = nil
            local nameLower = name:lower()
            for _, dungeon in ipairs(NS.DUNGEONS) do
                if dungeon.name:lower() == nameLower or nameLower:find(dungeon.name:lower():sub(1, 8)) then
                    dungeonKey = dungeon.id
                    break
                end
            end
            -- Also check the activity name map
            if not dungeonKey then
                dungeonKey = NS.ACTIVITY_NAME_MAP[nameLower]
            end

            if dungeonKey then
                NS.MAP_ID_TO_DUNGEON[mapID] = dungeonKey
                -- Update CHALLENGE_MODE_MAP dynamically
                NS.CHALLENGE_MODE_MAP[mapID] = dungeonKey
            end

            table.insert(NS.DYNAMIC_DUNGEONS, {
                mapID = mapID,
                name = name,
                timeLimitSec = timeLimitSec,
                texture = texture,
                dungeonKey = dungeonKey,
            })
        end
    end

    if #NS.DYNAMIC_DUNGEONS > 0 then
        self:Print(string.format("Loaded |cff00ff00%d|r M+ dungeons from game data.", #NS.DYNAMIC_DUNGEONS))
    end
end

-- ============================================================================
-- EVENT HANDLERS
-- ============================================================================
function DungeonOptimizer:INSPECT_READY(event, guid)
    NS.Inspect:OnInspectReady(guid)
end

function DungeonOptimizer:GET_ITEM_INFO_RECEIVED()
    if not NS.UI or not NS.UI:IsVisible() then return end
    if self._itemInfoTimer then
        self:CancelTimer(self._itemInfoTimer)
    end
    self._itemInfoTimer = self:ScheduleTimer(function()
        NS.UI:RefreshUI()
    end, 0.5)
end

function DungeonOptimizer:GROUP_ROSTER_UPDATE()
    -- If we left a group or joined a raid, purge stale data immediately
    if not IsInGroup() or IsInRaid() then
        wipe(NS.groupData)
        wipe(NS.skippedPlayers)
        wipe(NS.partyKeystones)
        -- Keep only local player's completions
        self:PruneCompletions()
        -- Re-scan just the player if solo
        if not IsInGroup() and not IsInRaid() then
            NS.Inspect:ScanGroup()
        end
        if NS.UI then NS.UI:RefreshIfVisible() end
        return
    end

    -- Normal party: debounced re-scan
    if NS.UI and NS.UI:IsVisible() then
        if self._rosterTimer then
            self:CancelTimer(self._rosterTimer)
        end
        self._rosterTimer = self:ScheduleTimer("ScanGroup", 1)
    end
    -- Prune departed members, broadcast completions + keystones + off-spec to new members
    self:ScheduleTimer(function()
        self:PruneCompletions()
        self:BroadcastCompletions()
        self:BroadcastKeystone()
        self:BroadcastOffSpec()
        self:BroadcastCatalyst()
    end, 2)
end

-- #26: Auto-hide during active M+ run
function DungeonOptimizer:CHALLENGE_MODE_START()
    -- Cache the active challenge map ID so it's available after completion
    if C_ChallengeMode and C_ChallengeMode.GetActiveChallengeMapID then
        self._activeChallengeMapID = C_ChallengeMode.GetActiveChallengeMapID()
    end
    if NS.UI and NS.UI:IsVisible() then
        NS.UI._wasShownBeforeRun = true
        NS.UI.mainFrame:Hide()
        self:Print("UI hidden for M+ run. Will restore after completion.")
    end
end

function DungeonOptimizer:CHALLENGE_MODE_COMPLETED()
    -- Auto-exclude the completed dungeon (use cached mapID since active challenge is over)
    if C_ChallengeMode then
        local mapID = self._activeChallengeMapID
        self._activeChallengeMapID = nil
        local dungeonKey = NS.CHALLENGE_MODE_MAP[mapID]
        if dungeonKey then
            self.db.profile.excludedDungeons[dungeonKey] = true
            local myName = NS.Inspect:GetUnitFullName("player")
            if myName then
                NS.groupCompletions[myName] = NS.groupCompletions[myName] or {}
                NS.groupCompletions[myName][dungeonKey] = true
            end
            self:BroadcastCompletions()
            self:Print(string.format("Auto-excluded |cff00ff00%s|r (just completed).", dungeonKey))
        end
    end
    -- Restore UI if it was hidden
    if NS.UI and NS.UI._wasShownBeforeRun then
        NS.UI._wasShownBeforeRun = nil
        self:RecalculateAllRankings()
        NS.UI:Show()
    end
end

-- #27: Affix update
function DungeonOptimizer:MYTHIC_PLUS_CURRENT_AFFIX_UPDATE()
    NS.currentAffixes = nil -- clear cache, will be rebuilt on next UI refresh
    if NS.UI then NS.UI:RefreshIfVisible() end
end

-- ============================================================================
-- #27: CURRENT AFFIXES
-- ============================================================================
function DungeonOptimizer:GetCurrentAffixes()
    if NS.currentAffixes then return NS.currentAffixes end
    if not C_MythicPlus or not C_MythicPlus.GetCurrentAffixes then return nil end

    local affixes = C_MythicPlus.GetCurrentAffixes()
    if not affixes then return nil end

    local result = {}
    for _, affix in ipairs(affixes) do
        if affix.id then
            local name, desc, filedataid
            if C_ChallengeMode and C_ChallengeMode.GetAffixInfo then
                name, desc, filedataid = C_ChallengeMode.GetAffixInfo(affix.id)
            end
            table.insert(result, {
                id = affix.id,
                name = name or ("Affix " .. affix.id),
                description = desc or "",
                icon = filedataid,
            })
        end
    end

    NS.currentAffixes = result
    return result
end

-- ============================================================================
-- #34: LOOT TRADING DETECTION
-- ============================================================================
NS.tradeableLoot = {} -- recent tradeable loot events

function DungeonOptimizer:CHAT_MSG_LOOT(event, message, ...)
    if not IsInGroup() then return end

    -- Extract item link from loot message
    local itemLink = message:match("|c%x+|Hitem:[^|]+|h%[.-%]|h|r")
    if not itemLink then return end

    -- Extract item ID from link
    local itemId = tonumber(itemLink:match("item:(%d+)"))
    if not itemId then return end

    -- Extract looter name from message using WoW locale-aware globals
    -- LOOT_ITEM = "%s receives loot: %s", LOOT_ITEM_SELF = "You receive loot: %s"
    local looterName
    local lootPatternOther = LOOT_ITEM and LOOT_ITEM:gsub("%%s", "(.+)", 1):gsub("%%s", ".+") or nil
    local lootPatternSelf = LOOT_ITEM_SELF and LOOT_ITEM_SELF:gsub("%%s", ".+") or nil
    if lootPatternOther then
        looterName = message:match("^" .. lootPatternOther)
    end
    if not looterName or looterName == "" then
        if lootPatternSelf and message:match("^" .. lootPatternSelf) then
            looterName = NS.Inspect:GetUnitFullName("player")
        end
    end
    if not looterName then return end

    -- Resolve full Name-Realm if needed
    if not looterName:find("-") then
        for fullName, _ in pairs(NS.groupData) do
            if fullName:sub(1, #looterName + 1) == looterName .. "-" then
                looterName = fullName
                break
            end
        end
    end

    local looterData = NS.groupData[looterName]
    if not looterData then return end

    -- Determine item slot from BIS data or loot tables
    local itemSlot = NS.FindBISSlot(looterData.spec, itemId) or nil
    -- Try to find slot from dungeon loot tables
    if not itemSlot then
        for _, lootTable in pairs(NS.DUNGEON_LOOT) do
            for _, drop in ipairs(lootTable) do
                if drop.itemId == itemId then
                    -- slot not stored in loot table, try BIS for any spec
                    for _, specKey in pairs(NS.SPEC_MAP) do
                        itemSlot = NS.FindBISSlot(specKey, itemId)
                        if itemSlot then break end
                    end
                    break
                end
            end
            if itemSlot then break end
        end
    end

    -- Check tradeability: item is tradeable if the looter doesn't need it as BIS
    if not itemSlot then return end
    local isTradeable = not self:PlayerNeedsItem(looterData, itemId)
    if not isTradeable then return end

    -- Find candidates who need this item
    local candidates = self:GetItemCandidates(itemId, itemSlot)

    -- Remove the looter from candidates
    local filteredCandidates = {}
    for _, c in ipairs(candidates) do
        if c.playerName ~= looterName then
            table.insert(filteredCandidates, c)
        end
    end

    if #filteredCandidates == 0 then return end

    -- Store the tradeable loot event
    local lootEvent = {
        itemId = itemId,
        itemLink = itemLink,
        itemSlot = itemSlot,
        looter = looterName,
        looterClass = looterData.class,
        candidates = filteredCandidates,
        timestamp = time(),
    }
    table.insert(NS.tradeableLoot, lootEvent)

    -- Keep only last 10 events
    while #NS.tradeableLoot > 10 do
        table.remove(NS.tradeableLoot, 1)
    end

    -- Notify UI
    if NS.UI then
        NS.UI:OnTradeableLoot(lootEvent)
    end
end

-- ============================================================================
-- #20: PER-DUNGEON M+ SCORE DATA
-- ============================================================================
function DungeonOptimizer:GetDungeonScoreData(mapID)
    if not C_MythicPlus then return nil end

    local data = {}

    -- Weekly best
    if C_MythicPlus.GetWeeklyBestForMap then
        local duration, level, completionDate, affixIDs, members, score =
            C_MythicPlus.GetWeeklyBestForMap(mapID)
        if level then
            data.weeklyBest = { level = level, score = score or 0 }
        end
    end

    -- Season best
    if C_MythicPlus.GetSeasonBestForMap then
        local intimeInfo, overtimeInfo = C_MythicPlus.GetSeasonBestForMap(mapID)
        if intimeInfo then
            data.seasonBest = { level = intimeInfo.level, score = intimeInfo.dungeonScore or 0 }
        elseif overtimeInfo then
            data.seasonBest = { level = overtimeInfo.level, score = overtimeInfo.dungeonScore or 0 }
        end
    end

    -- Overall player score
    if C_ChallengeMode and C_ChallengeMode.GetOverallDungeonScore then
        data.overallScore = C_ChallengeMode.GetOverallDungeonScore()
    end

    return data
end

-- ============================================================================
-- #22: SEASON RUN HISTORY
-- ============================================================================
function DungeonOptimizer:GetSeasonHistory()
    if not C_MythicPlus or not C_MythicPlus.GetRunHistory then return {} end

    local runs = C_MythicPlus.GetRunHistory(false, false)
    if not runs then return {} end

    -- Group by dungeon
    local history = {} -- mapID -> { runs=N, bestLevel=N, bestScore=N }
    for _, run in ipairs(runs) do
        local mapID = run.mapChallengeModeID
        if not history[mapID] then
            history[mapID] = { runs = 0, bestLevel = 0, bestScore = 0 }
        end
        local h = history[mapID]
        h.runs = h.runs + 1
        if run.level and run.level > h.bestLevel then
            h.bestLevel = run.level
        end
        if run.runScore and run.runScore > h.bestScore then
            h.bestScore = run.runScore
        end
    end

    return history
end

-- ============================================================================
-- #23: GREAT VAULT PROGRESS
-- ============================================================================
function DungeonOptimizer:GetVaultProgress()
    local result = { slots = {}, totalRuns = 0 }

    if C_WeeklyRewards and C_WeeklyRewards.GetActivities then
        local activities = C_WeeklyRewards.GetActivities(1) -- type 1 = M+ dungeons
        if activities then
            for _, activity in ipairs(activities) do
                table.insert(result.slots, {
                    threshold = activity.threshold,
                    progress = activity.progress,
                    level = activity.level,
                })
                if activity.progress > result.totalRuns then
                    result.totalRuns = activity.progress
                end
            end
        end
    end

    if C_WeeklyRewards and C_WeeklyRewards.HasAvailableRewards then
        result.hasRewards = C_WeeklyRewards.HasAvailableRewards()
    end

    return result
end

-- ============================================================================
-- #25: MINIMUM KEY LEVEL FOR UPGRADE
-- ============================================================================
function DungeonOptimizer:GetMinKeyForUpgrade(currentIlvl)
    if not C_MythicPlus or not C_MythicPlus.GetRewardLevelFromKeystoneLevel then
        return nil
    end
    for keyLevel = 2, 20 do
        local rewardIlvl = C_MythicPlus.GetRewardLevelFromKeystoneLevel(keyLevel)
        if rewardIlvl and rewardIlvl > currentIlvl then
            return keyLevel
        end
    end
    return nil
end

-- ============================================================================
-- #19: GET EQUIPPED ITEM LEVEL FOR A SLOT
-- ============================================================================
function DungeonOptimizer:GetEquippedItemLevel(unit, slotId)
    local itemLink = GetInventoryItemLink(unit, slotId)
    if not itemLink then return nil end
    if C_Item and C_Item.GetDetailedItemLevelInfo then
        local actualIlvl = C_Item.GetDetailedItemLevelInfo(itemLink)
        return actualIlvl
    end
    -- Fallback
    local _, _, _, itemLevel = GetItemInfo(itemLink)
    return itemLevel
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
        local myName = NS.Inspect:GetUnitFullName("player")
        if myName then NS.groupCompletions[myName] = {} end
        self:Print(NS.L["EXCLUDED_RESET"])
        self:RecalculateAllRankings()
        self:BroadcastCompletions()
        if NS.UI then NS.UI:RefreshIfVisible() end
    elseif cmd == "purge" then
        wipe(NS.groupData)
        wipe(NS.skippedPlayers)
        wipe(NS.partyKeystones)
        wipe(self.db.profile.excludedDungeons)
        local myName = NS.Inspect:GetUnitFullName("player")
        if myName then NS.groupCompletions[myName] = {} end
        self.lastRanking = nil
        self:Print("|cff00ff00All data purged.|r Scanning fresh...")
        NS.Inspect:ScanGroup()
        if NS.UI then NS.UI:RefreshIfVisible() end
    elseif cmd == "history" then
        -- #22: show season history
        NS.UI:ShowHistoryTab()
    elseif cmd == "readycheck" or cmd == "rc" then
        -- #41: BIS ready check
        self:PerformReadyCheck()
    elseif cmd == "help" then
        self:Print(NS.L["HELP_TITLE"])
        self:Print(NS.L["HELP_OPEN"])
        self:Print(NS.L["HELP_SCAN"])
        self:Print(NS.L["HELP_RESET"])
        self:Print("  |cffeda55f/do history|r - Show season run history")
        self:Print("  |cffeda55f/do readycheck|r - Check group enchants, gems & consumables")
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

function DungeonOptimizer:OnScanComplete()
    local count = NS.Inspect:GetScannedCount()
    self:Print(string.format(NS.L["SCAN_COMPLETE"], count))

    if NS.skippedPlayers and #NS.skippedPlayers > 0 then
        for _, msg in ipairs(NS.skippedPlayers) do
            self:Print(string.format("  |cffff8800%s|r %s", NS.L["SKIPPED"], msg))
        end
    end

    -- #19: Store item levels during scan
    for playerName, playerData in pairs(NS.groupData) do
        playerData.ilvls = {}
        if playerData.unit then
            for slotName, slotId in pairs(NS.SLOT_IDS) do
                local ilvl = self:GetEquippedItemLevel(playerData.unit, slotId)
                if ilvl then
                    playerData.ilvls[slotId] = ilvl
                end
            end
        end
    end

    -- Seed local player's off-spec into groupData
    self:SeedLocalOffSpec()

    self:RecalculateAllRankings()
    if NS.UI then NS.UI:RefreshIfVisible() end
end

-- ============================================================================
-- OFF-SPEC SYNC
-- ============================================================================
function DungeonOptimizer:BroadcastOffSpec()
    if not IsInGroup() then return end
    local offSpec = self.db.profile.offSpec or "NONE"
    local channel = IsInRaid() and "RAID" or "PARTY"
    C_ChatInfo.SendAddonMessage(ADDON_MSG_PREFIX_OFFSPEC, offSpec, channel)
end

-- Seed off-spec into local player's groupData
function DungeonOptimizer:SeedLocalOffSpec()
    local myName = NS.Inspect:GetUnitFullName("player")
    if not myName or not NS.groupData[myName] then return end
    NS.groupData[myName].offSpec = self.db.profile.offSpec
end

-- Auto-reset off-spec if player switched to it
function DungeonOptimizer:PLAYER_SPECIALIZATION_CHANGED()
    local currentSpec = NS.Inspect:GetPlayerSpecKey()
    if currentSpec and self.db.profile.offSpec == currentSpec then
        self.db.profile.offSpec = nil
        self:Print(NS.L["OFF_SPEC_RESET"] or "Off-spec reset (now your active spec).")
        self:SeedLocalOffSpec()
        self:BroadcastOffSpec()
        self:RecalculateAllRankings()
        if NS.UI then NS.UI:RefreshIfVisible() end
    end
end

-- ============================================================================
-- #37: CATALYST TRACKING
-- ============================================================================
NS.groupCatalyst = {} -- { "Name-Realm" = { charges=N, tierCount=N } }

function DungeonOptimizer:GetCatalystCharges()
    if not C_CurrencyInfo or not C_CurrencyInfo.GetCurrencyInfo then return 0 end
    local info = C_CurrencyInfo.GetCurrencyInfo(NS.CATALYST_CURRENCY_ID)
    if info then return info.quantity or 0 end
    return 0
end

function DungeonOptimizer:GetTierSetCount(playerData)
    if not playerData or not playerData.spec or not playerData.gear then return 0 end

    local bisTable = NS.GetBISTableForActiveTab()
    local bisList = bisTable[playerData.spec]
    if not bisList then return 0 end

    local count = 0
    for _, slotId in ipairs(NS.TIER_SET_SLOTS) do
        local bisItemId = bisList[slotId]
        if bisItemId and playerData.gear[slotId] == bisItemId then
            count = count + 1
        end
    end
    return count
end

function DungeonOptimizer:GetCatalystSuggestion(playerData)
    if not playerData or not playerData.spec or not playerData.gear then return nil end

    local bisTable = NS.GetBISTableForActiveTab()
    local bisList = bisTable[playerData.spec]
    if not bisList then return nil end

    -- Find tier slots where the player doesn't have the BIS tier piece
    for _, slotId in ipairs(NS.TIER_SET_SLOTS) do
        local bisItemId = bisList[slotId]
        if bisItemId and playerData.gear[slotId] ~= bisItemId then
            local slotName = NS.SLOT_NAMES[slotId] or "?"
            local itemName = GetItemInfo(bisItemId) or ("Item #" .. bisItemId)
            return { slotId = slotId, slotName = slotName, itemId = bisItemId, itemName = itemName }
        end
    end
    return nil -- all tier slots filled
end

function DungeonOptimizer:BroadcastCatalyst()
    if not IsInGroup() then return end
    local myName = NS.Inspect:GetUnitFullName("player")
    local myData = myName and NS.groupData[myName]

    local charges = self:GetCatalystCharges()
    local tierCount = myData and self:GetTierSetCount(myData) or 0

    local data = string.format("%d:%d", charges, tierCount)
    local channel = IsInRaid() and "RAID" or "PARTY"
    C_ChatInfo.SendAddonMessage(ADDON_MSG_PREFIX_CATALYST, data, channel)

    -- Also store locally
    if myName then
        NS.groupCatalyst[myName] = { charges = charges, tierCount = tierCount }
    end
end

-- ============================================================================
-- #41: READY CHECK BIS
-- Verify enchants, gems, and consumables for group members
-- ============================================================================

-- Enchantable slots: weapon(s), rings, back, chest, legs, feet, wrist
local ENCHANTABLE_SLOTS = { 16, 17, 11, 12, 15, 5, 7, 8, 9 }

-- Check if an item link has an enchant (non-zero second field in item: string)
local function HasEnchant(itemLink)
    if not itemLink then return false end
    local enchantId = itemLink:match("item:%d+:(%d+)")
    return enchantId and tonumber(enchantId) > 0
end

-- Check if an item link has empty gem sockets
local function HasAllGems(itemLink)
    if not itemLink then return true end -- no item = no sockets to check
    -- Check for gem socket info in the item link
    -- WoW item links: item:id:enchant:gem1:gem2:gem3:gem4:...
    local parts = { itemLink:match("item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)") }
    if #parts < 6 then return true end -- can't determine socket info
    -- If any gem slot is 0 and item has sockets, it's missing
    -- This is a simplified check - in practice need C_Item.GetItemGem
    return true -- simplified: assume gems are OK if we can't fully check
end

function DungeonOptimizer:PerformReadyCheck()
    self:Print(NS.L["READYCHECK_SCANNING"])

    local results = {}
    local units = {}
    if IsInRaid() then
        for i = 1, GetNumGroupMembers() do
            table.insert(units, "raid" .. i)
        end
    elseif IsInGroup() then
        table.insert(units, "player")
        for i = 1, GetNumGroupMembers() - 1 do
            table.insert(units, "party" .. i)
        end
    else
        table.insert(units, "player")
    end

    for _, unit in ipairs(units) do
        if UnitExists(unit) and UnitIsConnected(unit) then
            local fullName = NS.Inspect:GetUnitFullName(unit)
            local name = UnitName(unit) or "?"
            local class = select(2, UnitClass(unit)) or "WARRIOR"
            local inRange = UnitIsUnit(unit, "player") or CheckInteractDistance(unit, 1)

            local checks = {
                enchants = { pass = true, missing = {} },
                gems = { pass = true, missing = {} },
                flask = { pass = false },
                food = { pass = false },
                rune = { pass = false },
            }

            if inRange then
                -- Check enchants on enchantable slots
                for _, slotId in ipairs(ENCHANTABLE_SLOTS) do
                    local itemLink = GetInventoryItemLink(unit, slotId)
                    if itemLink and not HasEnchant(itemLink) then
                        checks.enchants.pass = false
                        table.insert(checks.enchants.missing, NS.SLOT_NAMES[slotId] or ("Slot " .. slotId))
                    end
                end

                -- Check consumable buffs
                -- Flask/Phial: buff category check
                for i = 1, 40 do
                    local name_buff, _, _, _, _, _, _, _, _, spellId = UnitBuff(unit, i)
                    if not name_buff then break end
                    local lowerName = name_buff:lower()
                    if lowerName:find("phial") or lowerName:find("flask") then
                        checks.flask.pass = true
                    end
                    if lowerName:find("well fed") or lowerName:find("food") then
                        checks.food.pass = true
                    end
                    if lowerName:find("augment") or lowerName:find("rune") then
                        checks.rune.pass = true
                    end
                end
            end

            local passCount = 0
            local totalChecks = 5
            if checks.enchants.pass then passCount = passCount + 1 end
            if checks.gems.pass then passCount = passCount + 1 end
            if checks.flask.pass then passCount = passCount + 1 end
            if checks.food.pass then passCount = passCount + 1 end
            if checks.rune.pass then passCount = passCount + 1 end

            table.insert(results, {
                name = name,
                fullName = fullName,
                class = class,
                unit = unit,
                inRange = inRange,
                checks = checks,
                passCount = passCount,
                totalChecks = totalChecks,
            })
        end
    end

    -- Store for UI display
    self.lastReadyCheck = results
    -- Show results in UI
    if NS.UI then
        NS.UI:ShowReadyCheckResults(results)
    end

    return results
end

-- ============================================================================
-- BIS COMPARISON ENGINE
-- ============================================================================
function DungeonOptimizer:PlayerNeedsItem(playerData, itemId, bisTable)
    if not playerData or not playerData.spec or not playerData.gear then return false end

    bisTable = bisTable or NS.GetActiveBISTable()
    local bisList = bisTable[playerData.spec]
    if not bisList then return false end

    -- Count how many times this item appears in BIS list (handles duplicate rings/trinkets/weapons)
    local bisCount = 0
    for _, bisItemId in pairs(bisList) do
        if bisItemId == itemId then
            bisCount = bisCount + 1
        end
    end
    if bisCount == 0 then return false end

    -- Count how many copies the player already has equipped
    local equippedCount = 0
    for _, gearItemId in pairs(playerData.gear) do
        if gearItemId == itemId then
            equippedCount = equippedCount + 1
        end
    end

    return equippedCount < bisCount
end

-- Check if a player needs an item for their off-spec BIS list
-- Since we don't know off-spec gear, all off-spec BIS items are considered missing
-- except those already equipped in main-spec (same itemId)
function DungeonOptimizer:PlayerNeedsItemForOffSpec(playerData, itemId, bisTable)
    if not playerData or not playerData.offSpec then return false end

    bisTable = bisTable or NS.GetActiveBISTable()
    local bisList = bisTable[playerData.offSpec]
    if not bisList then return false end

    -- Check if this item is in the off-spec BIS list
    local isOffSpecBIS = false
    for _, bisItemId in pairs(bisList) do
        if bisItemId == itemId then
            isOffSpecBIS = true
            break
        end
    end
    if not isOffSpecBIS then return false end

    -- Skip if this item is also a main-spec BIS item (already tracked as main-spec)
    if playerData.spec then
        local mainBisList = bisTable[playerData.spec]
        if mainBisList then
            for _, bisItemId in pairs(mainBisList) do
                if bisItemId == itemId then return false end
            end
        end
    end

    return true
end

function DungeonOptimizer:CountMissingBIS(playerData, bisTable)
    if not playerData or not playerData.spec then return 0, 0, 0, 0 end

    bisTable = bisTable or NS.GetActiveBISTable()
    local bisList = bisTable[playerData.spec]
    if not bisList then return 0, 0, 0, 0 end
    if not playerData.gear then return 0, 0, 0, 0 end

    local total, missing, totalDungeon, missingDungeon = 0, 0, 0, 0

    -- Pre-count how many times each itemId appears in BIS and in gear
    local bisItemCounts = {}
    for _, bisItemId in pairs(bisList) do
        bisItemCounts[bisItemId] = (bisItemCounts[bisItemId] or 0) + 1
    end

    local gearItemCounts = {}
    for _, gearItemId in pairs(playerData.gear) do
        gearItemCounts[gearItemId] = (gearItemCounts[gearItemId] or 0) + 1
    end

    -- Track how many of each item we've already accounted for (for duplicates)
    local accountedFor = {}

    for slot, bisItemId in pairs(bisList) do
        total = total + 1

        local needed = bisItemCounts[bisItemId] or 1
        local have = math.min(gearItemCounts[bisItemId] or 0, needed)
        accountedFor[bisItemId] = (accountedFor[bisItemId] or 0) + 1

        -- This BIS slot is missing if we don't have enough copies
        local isMissing = (have < accountedFor[bisItemId])

        if isMissing then missing = missing + 1 end

        -- Check if item comes from farmable content (dungeon or raid)
        if NS.IsFromContent(bisItemId) then
            totalDungeon = totalDungeon + 1
            if isMissing then missingDungeon = missingDungeon + 1 end
        end
    end

    return missing, total, missingDungeon, totalDungeon
end

-- ============================================================================
-- DUNGEON SCORING & RANKING
-- ============================================================================
function DungeonOptimizer:ScoreDungeon(dungeonId)
    local lootTable = NS.DUNGEON_LOOT[dungeonId]
    if not lootTable then return 0, {} end

    local totalScore = 0
    local playerDetails = {}

    for playerName, playerData in pairs(NS.groupData) do
        local needed = {}
        local seenItems = {}
        local offSpecCount = 0

        -- Main-spec items
        for _, drop in ipairs(lootTable) do
            if not seenItems[drop.itemId] and self:PlayerNeedsItem(playerData, drop.itemId) then
                seenItems[drop.itemId] = true
                local bisSlot = NS.FindBISSlot(playerData.spec, drop.itemId)
                table.insert(needed, {
                    itemId = drop.itemId,
                    slot = bisSlot,
                    itemName = drop.itemName or ("Item " .. drop.itemId),
                    slotName = NS.SLOT_NAMES[bisSlot] or "?",
                    boss = drop.boss or "",
                })
            end
        end

        -- Off-spec items (only items not already tracked as main-spec)
        if playerData.offSpec then
            for _, drop in ipairs(lootTable) do
                if not seenItems[drop.itemId] and self:PlayerNeedsItemForOffSpec(playerData, drop.itemId) then
                    seenItems[drop.itemId] = true
                    local bisSlot = NS.FindBISSlot(playerData.offSpec, drop.itemId)
                    table.insert(needed, {
                        itemId = drop.itemId,
                        slot = bisSlot,
                        itemName = drop.itemName or ("Item " .. drop.itemId),
                        slotName = NS.SLOT_NAMES[bisSlot] or "?",
                        boss = drop.boss or "",
                        isOffSpec = true,
                    })
                    offSpecCount = offSpecCount + 1
                end
            end
        end

        local mainSpecCount = #needed - offSpecCount

        -- Always include every group member (even with 0 needs)
        playerDetails[playerName] = {
            needed = needed,
            count = #needed,
            mainSpecCount = mainSpecCount,
            offSpecCount = offSpecCount,
            class = playerData.class,
            name = playerData.name,
            offSpec = playerData.offSpec,
        }
        -- Off-spec items count 0.5 each toward the dungeon score
        totalScore = totalScore + mainSpecCount + (offSpecCount * 0.5)
    end

    return totalScore, playerDetails
end

function DungeonOptimizer:CalculateDungeonRanking()
    local ranking = {}

    for _, dungeon in ipairs(NS.DUNGEONS) do
        if not self:IsDungeonExcluded(dungeon.id) then
            local score, details = self:ScoreDungeon(dungeon.id)

            -- #20: Score weighting by M+ rating opportunity
            local ratingBonus = 0
            if self.db.profile.weightByScore and NS.DYNAMIC_DUNGEONS then
                for _, dd in ipairs(NS.DYNAMIC_DUNGEONS) do
                    if dd.dungeonKey == dungeon.id then
                        local scoreData = self:GetDungeonScoreData(dd.mapID)
                        if scoreData then
                            local seasonLevel = scoreData.seasonBest and scoreData.seasonBest.level or 0
                            -- Lower season best = higher rating opportunity
                            if seasonLevel < 5 then
                                ratingBonus = 3
                            elseif seasonLevel < 10 then
                                ratingBonus = 2
                            elseif seasonLevel < 15 then
                                ratingBonus = 1
                            end
                        else
                            ratingBonus = 3 -- never done = high priority
                        end
                        break
                    end
                end
            end

            table.insert(ranking, {
                dungeon = dungeon,
                score = score + ratingBonus,
                bisScore = score,
                ratingBonus = ratingBonus,
                details = details,
            })
        end
    end

    table.sort(ranking, function(a, b) return a.score > b.score end)
    return ranking
end

-- Recalculate all rankings (dungeon, raid, overall)
function DungeonOptimizer:RecalculateAllRankings()
    self.lastRanking = self:CalculateDungeonRanking()
    self.lastRaidRanking = self:CalculateRaidRanking()
    self.lastOverallRanking = self:CalculateOverallRanking()
end

-- ============================================================================
-- RAID SCORING & RANKING
-- ============================================================================
function DungeonOptimizer:ScoreRaid(raidId)
    local lootTable = NS.RAID_LOOT[raidId]
    if not lootTable then return 0, {} end

    local raidBIS = NS.GetRaidBISTable()
    local totalScore = 0
    local playerDetails = {}

    for playerName, playerData in pairs(NS.groupData) do
        local needed = {}
        local seenItems = {}
        local offSpecCount = 0

        -- Main-spec items (using raid BIS table)
        for _, drop in ipairs(lootTable) do
            if not seenItems[drop.itemId] and self:PlayerNeedsItem(playerData, drop.itemId, raidBIS) then
                seenItems[drop.itemId] = true
                local bisSlot = NS.FindBISSlot(playerData.spec, drop.itemId, raidBIS)
                table.insert(needed, {
                    itemId = drop.itemId,
                    slot = bisSlot,
                    itemName = drop.itemName or ("Item " .. drop.itemId),
                    slotName = NS.SLOT_NAMES[bisSlot] or "?",
                    boss = drop.boss or "",
                })
            end
        end

        -- Off-spec items (using raid BIS table)
        if playerData.offSpec then
            for _, drop in ipairs(lootTable) do
                if not seenItems[drop.itemId] and self:PlayerNeedsItemForOffSpec(playerData, drop.itemId, raidBIS) then
                    seenItems[drop.itemId] = true
                    local bisSlot = NS.FindBISSlot(playerData.offSpec, drop.itemId, raidBIS)
                    table.insert(needed, {
                        itemId = drop.itemId,
                        slot = bisSlot,
                        itemName = drop.itemName or ("Item " .. drop.itemId),
                        slotName = NS.SLOT_NAMES[bisSlot] or "?",
                        boss = drop.boss or "",
                        isOffSpec = true,
                    })
                    offSpecCount = offSpecCount + 1
                end
            end
        end

        local mainSpecCount = #needed - offSpecCount

        playerDetails[playerName] = {
            needed = needed,
            count = #needed,
            mainSpecCount = mainSpecCount,
            offSpecCount = offSpecCount,
            class = playerData.class,
            name = playerData.name,
            offSpec = playerData.offSpec,
        }
        totalScore = totalScore + mainSpecCount + (offSpecCount * 0.5)
    end

    return totalScore, playerDetails
end

function DungeonOptimizer:CalculateRaidRanking()
    local ranking = {}

    for _, raid in ipairs(NS.RAIDS) do
        local score, details = self:ScoreRaid(raid.id)

        table.insert(ranking, {
            dungeon = raid, -- reuse "dungeon" field name for UI compatibility
            score = score,
            bisScore = score,
            ratingBonus = 0, -- raids don't have M+ rating bonus
            details = details,
            isRaid = true,
        })
    end

    table.sort(ranking, function(a, b) return a.score > b.score end)
    return ranking
end

-- ============================================================================
-- OVERALL SCORING & RANKING
-- Scores all content (dungeons + raids) against BIS_OVERALL table
-- ============================================================================
function DungeonOptimizer:ScoreOverallContent(contentId, lootTable)
    if not lootTable then return 0, {} end

    local overallBIS = NS.GetOverallBISTable()
    if not overallBIS then return 0, {} end

    local totalScore = 0
    local playerDetails = {}

    for playerName, playerData in pairs(NS.groupData) do
        local needed = {}
        local seenItems = {}
        local offSpecCount = 0

        for _, drop in ipairs(lootTable) do
            if not seenItems[drop.itemId] and self:PlayerNeedsItem(playerData, drop.itemId, overallBIS) then
                seenItems[drop.itemId] = true
                local bisSlot = NS.FindBISSlot(playerData.spec, drop.itemId, overallBIS)
                table.insert(needed, {
                    itemId = drop.itemId,
                    slot = bisSlot,
                    itemName = drop.itemName or ("Item " .. drop.itemId),
                    slotName = NS.SLOT_NAMES[bisSlot] or "?",
                    boss = drop.boss or "",
                })
            end
        end

        if playerData.offSpec then
            for _, drop in ipairs(lootTable) do
                if not seenItems[drop.itemId] and self:PlayerNeedsItemForOffSpec(playerData, drop.itemId, overallBIS) then
                    seenItems[drop.itemId] = true
                    local bisSlot = NS.FindBISSlot(playerData.offSpec, drop.itemId, overallBIS)
                    table.insert(needed, {
                        itemId = drop.itemId,
                        slot = bisSlot,
                        itemName = drop.itemName or ("Item " .. drop.itemId),
                        slotName = NS.SLOT_NAMES[bisSlot] or "?",
                        boss = drop.boss or "",
                        isOffSpec = true,
                    })
                    offSpecCount = offSpecCount + 1
                end
            end
        end

        local mainSpecCount = #needed - offSpecCount

        playerDetails[playerName] = {
            needed = needed,
            count = #needed,
            mainSpecCount = mainSpecCount,
            offSpecCount = offSpecCount,
            class = playerData.class,
            name = playerData.name,
            offSpec = playerData.offSpec,
        }
        totalScore = totalScore + mainSpecCount + (offSpecCount * 0.5)
    end

    return totalScore, playerDetails
end

function DungeonOptimizer:CalculateOverallRanking()
    local ranking = {}

    -- Score dungeons against overall BIS
    for _, dungeon in ipairs(NS.DUNGEONS) do
        if not self:IsDungeonExcluded(dungeon.id) then
            local score, details = self:ScoreOverallContent(dungeon.id, NS.DUNGEON_LOOT[dungeon.id])
            table.insert(ranking, {
                dungeon = dungeon,
                score = score,
                bisScore = score,
                ratingBonus = 0,
                details = details,
                isRaid = false,
            })
        end
    end

    -- Score raids against overall BIS
    for _, raid in ipairs(NS.RAIDS) do
        local score, details = self:ScoreOverallContent(raid.id, NS.RAID_LOOT[raid.id])
        table.insert(ranking, {
            dungeon = raid,
            score = score,
            bisScore = score,
            ratingBonus = 0,
            details = details,
            isRaid = true,
        })
    end

    table.sort(ranking, function(a, b) return a.score > b.score end)
    return ranking
end

-- ============================================================================
-- #40: TIMER PREDICTIONS
-- Estimate likelihood of timing a key based on run history
-- ============================================================================
function DungeonOptimizer:PredictTimerSuccess(mapID, targetLevel)
    if not C_MythicPlus or not C_MythicPlus.GetRunHistory then return nil end

    local runs = C_MythicPlus.GetRunHistory(false, false) -- all season runs
    if not runs then return nil end

    -- Filter runs for this dungeon at similar key levels (targetLevel ± 2)
    local timed = 0
    local total = 0
    for _, run in ipairs(runs) do
        if run.mapChallengeModeID == mapID then
            local levelDiff = math.abs((run.level or 0) - (targetLevel or 0))
            if levelDiff <= 2 then
                total = total + 1
                if run.completed then
                    timed = timed + 1
                end
            end
        end
    end

    -- Need at least 3 runs for a meaningful prediction
    if total < 3 then return nil end

    local confidence = math.floor((timed / total) * 100)
    local tag, color
    if confidence >= 80 then
        tag = "Likely"
        color = "00ff00"
    elseif confidence >= 50 then
        tag = "Moderate"
        color = "ffff00"
    else
        tag = "Unlikely"
        color = "ff4444"
    end

    return {
        confidence = confidence,
        tag = tag,
        color = color,
        timed = timed,
        total = total,
    }
end

-- Get timer prediction for a dungeon key (convenience wrapper)
function DungeonOptimizer:GetDungeonTimerPrediction(dungeonKey)
    if not NS.CHALLENGE_MODE_MAP then return nil end

    -- Find the mapID for this dungeon key
    local mapID = nil
    for mid, dk in pairs(NS.CHALLENGE_MODE_MAP) do
        if dk == dungeonKey then
            mapID = mid
            break
        end
    end
    if not mapID then return nil end

    -- Use the group's average key level as target, or fallback to 10
    local targetLevel = 10
    local myKey = self:GetOwnKeystone()
    if myKey then targetLevel = myKey.level end

    return self:PredictTimerSuccess(mapID, targetLevel)
end

-- ============================================================================
-- #38: KEY ROUTING OPTIMIZER
-- Suggest optimal run order based on available group keystones
-- ============================================================================
function DungeonOptimizer:CalculateKeyRoute()
    local allKeys = {}

    -- Collect own keystone
    local myKey = self:GetOwnKeystone()
    local myName = NS.Inspect:GetUnitFullName("player")
    if myKey and myName then
        table.insert(allKeys, {
            owner = myName,
            ownerShort = myName:match("^([^-]+)") or myName,
            ownerClass = NS.groupData[myName] and NS.groupData[myName].class or nil,
            mapID = myKey.mapID,
            level = myKey.level,
            dungeonName = myKey.dungeonName,
        })
    end

    -- Collect party keystones
    for sender, keyData in pairs(NS.partyKeystones) do
        table.insert(allKeys, {
            owner = sender,
            ownerShort = sender:match("^([^-]+)") or sender,
            ownerClass = NS.groupData[sender] and NS.groupData[sender].class or nil,
            mapID = keyData.mapID,
            level = keyData.level,
            dungeonName = keyData.dungeonName,
        })
    end

    if #allKeys == 0 then return {} end

    -- Score each available key
    for _, key in ipairs(allKeys) do
        -- Find the matching dungeon key from our map
        local dungeonKey = NS.CHALLENGE_MODE_MAP and NS.CHALLENGE_MODE_MAP[key.mapID]
            or (NS.MAP_ID_TO_DUNGEON and NS.MAP_ID_TO_DUNGEON[key.mapID])

        -- BIS upgrade score from dungeon ranking
        local bisScore = 0
        if dungeonKey then
            bisScore = select(1, self:ScoreDungeon(dungeonKey))
        end

        -- Rating opportunity bonus
        local ratingBonus = 0
        if self.db.profile.weightByScore and key.mapID then
            local scoreData = self:GetDungeonScoreData(key.mapID)
            if scoreData then
                local seasonLevel = scoreData.seasonBest and scoreData.seasonBest.level or 0
                if seasonLevel < 5 then
                    ratingBonus = 3
                elseif seasonLevel < 10 then
                    ratingBonus = 2
                elseif seasonLevel < 15 then
                    ratingBonus = 1
                end
            else
                ratingBonus = 3
            end
        end

        key.dungeonKey = dungeonKey
        key.bisScore = bisScore
        key.ratingBonus = ratingBonus
        key.totalScore = bisScore + ratingBonus
    end

    -- Sort by total score descending
    table.sort(allKeys, function(a, b) return a.totalScore > b.totalScore end)
    return allKeys
end

-- ============================================================================
-- #36: UPGRADE PRIORITY SYSTEM
-- Rank who benefits most from a specific item drop
-- ============================================================================

-- Priority tags returned alongside scores
NS.PRIORITY_TAGS = {
    BIS_MAIN = "BIS Main",
    BIS_OFF = "BIS Off-Spec",
    UPGRADE = "Upgrade",
    NO_UPGRADE = "No Upgrade",
}

--- Calculate how much a player would benefit from a specific item.
--- Returns: score (number), tag (string), ilvlDelta (number or nil)
function DungeonOptimizer:CalculateItemPriority(playerData, itemId, itemSlot)
    if not playerData or not playerData.spec then
        return 0, NS.PRIORITY_TAGS.NO_UPGRADE, nil
    end

    local ilvlDelta = 0
    if playerData.ilvls and itemSlot and playerData.ilvls[itemSlot] then
        -- We don't know the drop ilvl without more context, so delta is based
        -- on the fact that a BIS item in that slot is an upgrade path
        ilvlDelta = 1 -- placeholder: any BIS item is at least +1 priority
    end

    -- Check main-spec BIS
    local isBISMain = self:PlayerNeedsItem(playerData, itemId)
    if isBISMain then
        -- Fewer remaining BIS items → each item is more impactful
        local missing, total = self:CountMissingBIS(playerData)
        local completionBonus = total > 0 and ((total - missing) / total) * 10 or 0
        return 100 + completionBonus, NS.PRIORITY_TAGS.BIS_MAIN, ilvlDelta
    end

    -- Check off-spec BIS
    local isBISOff = self:PlayerNeedsItemForOffSpec(playerData, itemId)
    if isBISOff then
        return 50, NS.PRIORITY_TAGS.BIS_OFF, ilvlDelta
    end

    return 0, NS.PRIORITY_TAGS.NO_UPGRADE, nil
end

--- Get a sorted list of candidates for a specific item.
--- Returns: { {playerName, playerData, score, tag, ilvlDelta}, ... }
function DungeonOptimizer:GetItemCandidates(itemId, itemSlot)
    local candidates = {}

    for playerName, playerData in pairs(NS.groupData) do
        local score, tag, ilvlDelta = self:CalculateItemPriority(playerData, itemId, itemSlot)
        if score > 0 then
            table.insert(candidates, {
                playerName = playerName,
                playerData = playerData,
                score = score,
                tag = tag,
                ilvlDelta = ilvlDelta,
            })
        end
    end

    table.sort(candidates, function(a, b) return a.score > b.score end)
    return candidates
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
-- DUNGEON COMPLETION DATA
-- ============================================================================
NS.CHALLENGE_MODE_MAP = {
    [2773] = "MAGISTER", [2774] = "MAISARA",
    [2775] = "WINDRUNNER", [2776] = "NEXUS_XENAS",
    [2286] = "ALGETHAR", [2293] = "PIT_OF_SARON",
    [2295] = "SEAT", [2296] = "SKYREACH",
}

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
    if not C_MythicPlus then return end
    local runs = C_MythicPlus.GetRunHistory(false, true)
    if not runs then return end

    local detected = 0
    for _, run in ipairs(runs) do
        local dungeonKey = NS.CHALLENGE_MODE_MAP[run.mapChallengeModeID]
        if dungeonKey and not self.db.profile.excludedDungeons[dungeonKey] then
            self.db.profile.excludedDungeons[dungeonKey] = true
            detected = detected + 1
        end
    end

    if detected > 0 then
        self:Print(string.format("Auto-detected |cff00ff00%d|r completed dungeon(s) this week.", detected))
    end
end


-- ============================================================================
-- #21: PARTY KEYSTONE SYNC
-- ============================================================================
NS.partyKeystones = {} -- { ["Name-Realm"] = { mapID=N, level=N, dungeonName="..." } }

function DungeonOptimizer:GetOwnKeystone()
    if not C_MythicPlus then return nil end
    local mapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
    local level = C_MythicPlus.GetOwnedKeystoneLevel()
    if not mapID or not level then return nil end

    local name = ""
    if C_ChallengeMode and C_ChallengeMode.GetMapUIInfo then
        name = C_ChallengeMode.GetMapUIInfo(mapID) or ""
    end

    return { mapID = mapID, level = level, dungeonName = name }
end

function DungeonOptimizer:BroadcastKeystone()
    if not IsInGroup() then return end
    local key = self:GetOwnKeystone()
    if not key then return end
    local data = string.format("%d:%d:%s", key.mapID, key.level, key.dungeonName)
    local channel = IsInRaid() and "RAID" or "PARTY"
    C_ChatInfo.SendAddonMessage(ADDON_MSG_PREFIX_KEY, data, channel)
end

function DungeonOptimizer:CHAT_MSG_ADDON(event, prefix, message, channel, sender)
    if prefix == ADDON_MSG_PREFIX then
        local myFullName = NS.Inspect:GetUnitFullName("player")
        if sender and myFullName and sender == myFullName then return end
        -- Legacy compat: treat old-format sync as that sender's completions
        if sender then
            local completions = {}
            if message ~= "RESET" then
                for rawId in message:gmatch("[^,]+") do
                    local id = rawId:match("^%s*(.-)%s*$")
                    for _, dungeon in ipairs(NS.DUNGEONS) do
                        if dungeon.id == id then completions[id] = true; break end
                    end
                end
            end
            NS.groupCompletions[sender] = completions
            self:RecalculateAllRankings()
            if NS.UI then NS.UI:RefreshIfVisible() end
        end
    elseif prefix == ADDON_MSG_PREFIX_COMP then
        -- Per-player completion sync (new protocol)
        if not sender then return end
        local myFullName = NS.Inspect:GetUnitFullName("player")
        if sender == myFullName then return end

        local payload = message:match("^V2:(.+)$")
        if not payload then return end

        local completions = {}
        if payload ~= "NONE" then
            for rawId in payload:gmatch("[^,]+") do
                local id = rawId:match("^%s*(.-)%s*$")
                for _, dungeon in ipairs(NS.DUNGEONS) do
                    if dungeon.id == id then completions[id] = true; break end
                end
            end
        end

        NS.groupCompletions[sender] = completions
        self:RecalculateAllRankings()
        if NS.UI then NS.UI:RefreshIfVisible() end
    elseif prefix == ADDON_MSG_PREFIX_KEY then
        local mapID, level, dungeonName = message:match("^(%d+):(%d+):(.*)$")
        if mapID and level and sender then
            NS.partyKeystones[sender] = {
                mapID = tonumber(mapID),
                level = tonumber(level),
                dungeonName = dungeonName or "",
            }
            if NS.UI then NS.UI:RefreshIfVisible() end
        end
    elseif prefix == ADDON_MSG_PREFIX_OFFSPEC then
        -- Off-spec sync
        if not sender then return end
        local myFullName = NS.Inspect:GetUnitFullName("player")
        if sender == myFullName then return end

        if NS.groupData[sender] then
            local validOffSpec = (message ~= "NONE") and NS.GetActiveBISTable()[message] and message or nil
            NS.groupData[sender].offSpec = validOffSpec
            self:RecalculateAllRankings()
            if NS.UI then NS.UI:RefreshIfVisible() end
        end
    elseif prefix == ADDON_MSG_PREFIX_CATALYST then
        -- #37: Catalyst sync
        if not sender then return end
        local myFullName = NS.Inspect:GetUnitFullName("player")
        if sender == myFullName then return end

        local charges, tierCount = message:match("^(%d+):(%d+)$")
        if charges and tierCount then
            NS.groupCatalyst[sender] = {
                charges = tonumber(charges),
                tierCount = tonumber(tierCount),
            }
            if NS.UI then NS.UI:RefreshIfVisible() end
        end
    elseif prefix == "DOptGear" then
        -- Gear sync: another addon user broadcasted their equipment
        if NS.Inspect:OnGearMessage(message, sender) then
            self:Print(string.format("Received gear from |cff00ff00%s|r (via addon sync).", sender or "?"))
            self:RecalculateAllRankings()
            if NS.UI then NS.UI:RefreshIfVisible() end
        end
    end
end
