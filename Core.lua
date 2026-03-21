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
    },
}

local ADDON_MSG_PREFIX = "DOptSync"
local ADDON_MSG_PREFIX_KEY = "DOptKey" -- #21: keystone sync

-- Returns the BIS table (always Mythic+)
function NS.GetActiveBISTable()
    return NS.BIS_MYTHIC
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

    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX)
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX_KEY)
    -- Register gear sync prefix
    NS.Inspect:RegisterSync()

    -- #18: Build dynamic dungeon list from C_ChallengeMode API
    self:BuildDynamicDungeonList()
    -- Auto-detect completed dungeons
    self:AutoDetectCompletedDungeons()
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
    if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
        if self._itemInfoTimer then
            self:CancelTimer(self._itemInfoTimer)
        end
        self._itemInfoTimer = self:ScheduleTimer(function()
            NS.UI:RefreshUI()
        end, 0.5)
    end
end

function DungeonOptimizer:GROUP_ROSTER_UPDATE()
    if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
        if self._rosterTimer then
            self:CancelTimer(self._rosterTimer)
        end
        self._rosterTimer = self:ScheduleTimer("ScanGroup", 1)
    end
    -- #21: broadcast our keystone to new group members
    self:ScheduleTimer(function() self:BroadcastKeystone() end, 2)
end

-- #26: Auto-hide during active M+ run
function DungeonOptimizer:CHALLENGE_MODE_START()
    if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
        NS.UI._wasShownBeforeRun = true
        NS.UI.mainFrame:Hide()
        self:Print("UI hidden for M+ run. Will restore after completion.")
    end
end

function DungeonOptimizer:CHALLENGE_MODE_COMPLETED()
    -- Auto-exclude the completed dungeon
    if C_ChallengeMode and C_ChallengeMode.GetActiveChallengeMapID then
        local mapID = C_ChallengeMode.GetActiveChallengeMapID()
        local dungeonKey = NS.CHALLENGE_MODE_MAP[mapID]
        if dungeonKey then
            self.db.profile.excludedDungeons[dungeonKey] = true
            self:BroadcastExcluded()
            self:Print(string.format("Auto-excluded |cff00ff00%s|r (just completed).", dungeonKey))
        end
    end
    -- Restore UI if it was hidden
    if NS.UI and NS.UI._wasShownBeforeRun then
        NS.UI._wasShownBeforeRun = nil
        self.lastRanking = self:CalculateDungeonRanking()
        NS.UI:Show()
    end
end

-- #27: Affix update
function DungeonOptimizer:MYTHIC_PLUS_CURRENT_AFFIX_UPDATE()
    NS.currentAffixes = nil -- clear cache, will be rebuilt on next UI refresh
    if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
        NS.UI:RefreshUI()
    end
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
        if rewardIlvl and rewardIlvl >= currentIlvl then
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
        self:Print(NS.L["EXCLUDED_RESET"])
        self:BroadcastExcluded()
        if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
            NS.UI:RefreshUI()
        end
    elseif cmd == "history" then
        -- #22: show season history
        NS.UI:ShowHistoryTab()
    elseif cmd == "help" then
        self:Print(NS.L["HELP_TITLE"])
        self:Print(NS.L["HELP_OPEN"])
        self:Print(NS.L["HELP_SCAN"])
        self:Print(NS.L["HELP_RESET"])
        self:Print("  |cffeda55f/do history|r - Show season run history")
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

    self.lastRanking = self:CalculateDungeonRanking()
    if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
        NS.UI:RefreshUI()
    end
end

-- ============================================================================
-- BIS COMPARISON ENGINE
-- ============================================================================
function DungeonOptimizer:PlayerNeedsItem(playerData, itemId, slot)
    if not playerData or not playerData.spec then return false end

    local bisTable = NS.GetActiveBISTable()
    local bisList = bisTable[playerData.spec]
    if not bisList then return false end

    local slotsToCheck = { slot }
    if slot == 11 then slotsToCheck = { 11, 12 }
    elseif slot == 12 then slotsToCheck = { 11, 12 }
    elseif slot == 13 then slotsToCheck = { 13, 14 }
    elseif slot == 14 then slotsToCheck = { 13, 14 }
    end

    for _, checkSlot in ipairs(slotsToCheck) do
        local bisItemId = bisList[checkSlot]
        if bisItemId and bisItemId == itemId then
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

function DungeonOptimizer:CountMissingBIS(playerData)
    if not playerData or not playerData.spec then return 0, 0, 0, 0 end

    local bisTable = NS.GetActiveBISTable()
    local bisList = bisTable[playerData.spec]
    if not bisList then return 0, 0, 0, 0 end

    local total, missing, totalDungeon, missingDungeon = 0, 0, 0, 0

    for slot, bisItemId in pairs(bisList) do
        local isPaired = (slot == 12 or slot == 14)
        local pairSlot = isPaired and (slot - 1) or nil

        if isPaired and bisList[pairSlot] == bisItemId then
            -- skip duplicate
        else
            total = total + 1
            local isMissing = (playerData.gear[slot] ~= bisItemId)
            if isMissing then missing = missing + 1 end

            if NS.IsFromDungeon(bisItemId) then
                totalDungeon = totalDungeon + 1
                if isMissing then missingDungeon = missingDungeon + 1 end
            end
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

        -- Always include every group member (even with 0 needs)
        playerDetails[playerName] = {
            needed = needed,
            count = #needed,
            class = playerData.class,
            name = playerData.name,
        }
        totalScore = totalScore + #needed
    end

    return totalScore, playerDetails
end

function DungeonOptimizer:CalculateDungeonRanking()
    local ranking = {}

    for _, dungeon in ipairs(NS.DUNGEONS) do
        if not self.db.profile.excludedDungeons[dungeon.id] then
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
-- DUNGEON COMPLETION SYNC
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

function DungeonOptimizer:SerializeExcluded()
    local parts = {}
    for id, val in pairs(self.db.profile.excludedDungeons) do
        if val then table.insert(parts, id) end
    end
    return table.concat(parts, ",")
end

function DungeonOptimizer:ApplyExcludedState(data)
    local newState = {}
    if data ~= "RESET" then
        for rawId in data:gmatch("[^,]+") do
            local id = rawId:match("^%s*(.-)%s*$")
            for _, dungeon in ipairs(NS.DUNGEONS) do
                if dungeon.id == id then newState[id] = true end
            end
        end
    end

    local changed = false
    for _, dungeon in ipairs(NS.DUNGEONS) do
        if (self.db.profile.excludedDungeons[dungeon.id] or false) ~= (newState[dungeon.id] or false) then
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

function DungeonOptimizer:BroadcastExcluded()
    if not IsInGroup() then return end
    local data = self:SerializeExcluded()
    if data == "" then data = "RESET" end
    local channel = IsInRaid() and "RAID" or "PARTY"
    C_ChatInfo.SendAddonMessage(ADDON_MSG_PREFIX, data, channel)
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
        local myName = UnitName("player")
        if sender and sender:find(myName) then return end
        if self:ApplyExcludedState(message) then
            self:Print(string.format("Synced exclusions from |cff00ff00%s|r.", sender or "group"))
            self.lastRanking = self:CalculateDungeonRanking()
            if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
                NS.UI:RefreshUI()
            end
        end
    elseif prefix == ADDON_MSG_PREFIX_KEY then
        local mapID, level, dungeonName = message:match("^(%d+):(%d+):(.*)$")
        if mapID and level and sender then
            NS.partyKeystones[sender] = {
                mapID = tonumber(mapID),
                level = tonumber(level),
                dungeonName = dungeonName or "",
            }
            if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
                NS.UI:RefreshUI()
            end
        end
    elseif prefix == "DOptGear" then
        -- Gear sync: another addon user broadcasted their equipment
        if NS.Inspect:OnGearMessage(message, sender) then
            self:Print(string.format("Received gear from |cff00ff00%s|r (via addon sync).", sender or "?"))
            -- Recalculate rankings with new data
            self.lastRanking = self:CalculateDungeonRanking()
            if NS.UI and NS.UI.mainFrame and NS.UI.mainFrame:IsShown() then
                NS.UI:RefreshUI()
            end
        end
    end
end
