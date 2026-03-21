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

local ADDON_MSG_PREFIX = "DOptSync"       -- legacy exclusion sync
local ADDON_MSG_PREFIX_KEY = "DOptKey"    -- #21: keystone sync
local ADDON_MSG_PREFIX_COMP = "DOptComp"  -- per-player completion sync

-- Per-player dungeon completions: { ["Name-Realm"] = { MAGISTER=true, ... } }
NS.groupCompletions = {}

-- Returns the BIS table (always Mythic+)
function NS.GetActiveBISTable()
    return NS.BIS_MYTHIC
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
    if IsInGroup() and not IsInRaid() then
        if myName then groupNames[myName] = true end
        for i = 1, GetNumGroupMembers() - 1 do
            local unit = "party" .. i
            if UnitExists(unit) then
                local name = NS.Inspect:GetUnitFullName(unit)
                if name then groupNames[name] = true end
            end
        end
    elseif not IsInGroup() then
        if myName then groupNames[myName] = true end
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

    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX)
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX_KEY)
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_MSG_PREFIX_COMP)
    -- Register gear sync prefix
    NS.Inspect:RegisterSync()

    -- #18: Build dynamic dungeon list from C_ChallengeMode API
    self:BuildDynamicDungeonList()
    -- Auto-detect completed dungeons
    self:AutoDetectCompletedDungeons()
    -- Seed per-player completion data from saved variables
    self:SeedLocalCompletions()
    -- Broadcast completions to group after a short delay
    if IsInGroup() then
        self:ScheduleTimer(function() self:BroadcastCompletions() end, 2)
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
        if NS.keystones then wipe(NS.keystones) end
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
    -- Prune departed members, broadcast completions + keystones to new members
    self:ScheduleTimer(function()
        self:PruneCompletions()
        self:BroadcastCompletions()
        self:BroadcastKeystone()
    end, 2)
end

-- #26: Auto-hide during active M+ run
function DungeonOptimizer:CHALLENGE_MODE_START()
    if NS.UI and NS.UI:IsVisible() then
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
        self.lastRanking = self:CalculateDungeonRanking()
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
        self.lastRanking = self:CalculateDungeonRanking()
        self:BroadcastCompletions()
        if NS.UI then NS.UI:RefreshIfVisible() end
    elseif cmd == "purge" then
        wipe(NS.groupData)
        wipe(NS.skippedPlayers)
        if NS.keystones then wipe(NS.keystones) end
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
    if NS.UI then NS.UI:RefreshIfVisible() end
end

-- ============================================================================
-- BIS COMPARISON ENGINE
-- ============================================================================
function DungeonOptimizer:PlayerNeedsItem(playerData, itemId, slot)
    if not playerData or not playerData.spec then return false end

    local bisTable = NS.GetActiveBISTable()
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

function DungeonOptimizer:CountMissingBIS(playerData)
    if not playerData or not playerData.spec then return 0, 0, 0, 0 end

    local bisTable = NS.GetActiveBISTable()
    local bisList = bisTable[playerData.spec]
    if not bisList then return 0, 0, 0, 0 end

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

        if NS.IsFromDungeon(bisItemId) then
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
            self.lastRanking = self:CalculateDungeonRanking()
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
        self.lastRanking = self:CalculateDungeonRanking()
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
    elseif prefix == "DOptGear" then
        -- Gear sync: another addon user broadcasted their equipment
        if NS.Inspect:OnGearMessage(message, sender) then
            self:Print(string.format("Received gear from |cff00ff00%s|r (via addon sync).", sender or "?"))
            self.lastRanking = self:CalculateDungeonRanking()
            if NS.UI then NS.UI:RefreshIfVisible() end
        end
    end
end
