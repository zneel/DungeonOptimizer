-- ============================================================================
-- Tests for Core.lua: BIS engine, scoring, ranking, completions, loot, ready check
-- ============================================================================

local stub = require("tests.wow_stub")
local NS = stub.NS

-- Load addon files in dependency order
stub.loadAddonFile("Locales.lua")
stub.loadAddonFile("Data.lua")
stub.loadAddonFile("Inspect.lua")
stub.loadAddonFile("Core.lua")

local Core = NS.Core

-- ============================================================================
-- Helper: build a mock player data record
-- ============================================================================
local function makePlayer(spec, gear, opts)
    opts = opts or {}
    return {
        spec = spec,
        gear = gear or {},
        class = opts.class or "WARRIOR",
        name = opts.name or "Test",
        unit = opts.unit or "player",
        ilvls = opts.ilvls or {},
        offSpec = opts.offSpec or nil,
    }
end

-- Reset state between tests
local function resetState()
    stub.resetStubs()
    wipe(NS.groupCompletions)
    wipe(NS.groupData)
    wipe(NS.partyKeystones)
    wipe(NS.groupCatalyst)
    NS.UI = nil
    Core.db = {
        profile = {
            minimap = { hide = false },
            excludedDungeons = {},
            showTooltips = true,
            weightByScore = false,
            upgradeScoring = false,
            targetKeyLevel = 10,
            offSpec = nil,
            activeTab = "mplus",
        },
    }
end

-- ============================================================================
-- GetActiveBISTable / GetRaidBISTable
-- ============================================================================
describe("GetActiveBISTable", function()
    it("returns NS.BIS_MYTHIC", function()
        assert.are.equal(NS.BIS_MYTHIC, NS.GetActiveBISTable())
    end)
end)

describe("GetRaidBISTable", function()
    it("returns NS.BIS_RAID", function()
        assert.are.equal(NS.BIS_RAID, NS.GetRaidBISTable())
    end)
end)

-- ============================================================================
-- FindBISSlot
-- ============================================================================
describe("FindBISSlot", function()
    local bisTable

    before_each(function()
        bisTable = {
            WARRIOR_ARMS = { [1] = 100, [5] = 200, [16] = 300 },
            MAGE_FROST = { [1] = 400, [11] = 500, [12] = 500 },
        }
    end)

    it("returns the slot when item is in BIS list", function()
        assert.are.equal(1, NS.FindBISSlot("WARRIOR_ARMS", 100, bisTable))
        assert.are.equal(5, NS.FindBISSlot("WARRIOR_ARMS", 200, bisTable))
        assert.are.equal(16, NS.FindBISSlot("WARRIOR_ARMS", 300, bisTable))
    end)

    it("returns nil when item is not in BIS list", function()
        assert.is_nil(NS.FindBISSlot("WARRIOR_ARMS", 999, bisTable))
    end)

    it("returns nil for unknown spec", function()
        assert.is_nil(NS.FindBISSlot("UNKNOWN_SPEC", 100, bisTable))
    end)

    it("returns nil for nil spec", function()
        assert.is_nil(NS.FindBISSlot(nil, 100, bisTable))
    end)

    it("returns a slot for duplicate items", function()
        local slot = NS.FindBISSlot("MAGE_FROST", 500, bisTable)
        assert.is_not_nil(slot)
        assert.is_true(slot == 11 or slot == 12)
    end)

    it("defaults to NS.BIS_MYTHIC when no bisTable provided", function()
        local spec = "WARRIOR_ARMS"
        local bisList = NS.BIS_MYTHIC[spec]
        if bisList then
            for slot, itemId in pairs(bisList) do
                assert.are.equal(slot, NS.FindBISSlot(spec, itemId))
                break
            end
        end
    end)
end)

-- ============================================================================
-- IsDungeonExcluded
-- ============================================================================
describe("IsDungeonExcluded", function()
    before_each(resetState)

    it("returns false when no completions", function()
        assert.is_false(Core:IsDungeonExcluded("MAGISTER"))
    end)

    it("returns true when any player completed the dungeon", function()
        NS.groupCompletions["Alice-Realm"] = { MAGISTER = true }
        assert.is_true(Core:IsDungeonExcluded("MAGISTER"))
    end)

    it("returns true when multiple players completed", function()
        NS.groupCompletions["Alice-Realm"] = { MAGISTER = true }
        NS.groupCompletions["Bob-Realm"] = { MAGISTER = true }
        assert.is_true(Core:IsDungeonExcluded("MAGISTER"))
    end)

    it("returns false for a different dungeon", function()
        NS.groupCompletions["Alice-Realm"] = { MAGISTER = true }
        assert.is_false(Core:IsDungeonExcluded("MAISARA"))
    end)
end)

-- ============================================================================
-- GetDungeonCompleters
-- ============================================================================
describe("GetDungeonCompleters", function()
    before_each(resetState)

    it("returns empty list when no completions", function()
        assert.are.same({}, Core:GetDungeonCompleters("MAGISTER"))
    end)

    it("returns names of all completers", function()
        NS.groupCompletions["Alice-Realm"] = { MAGISTER = true }
        NS.groupCompletions["Bob-Realm"] = { MAGISTER = true }
        NS.groupCompletions["Charlie-Realm"] = { MAISARA = true }
        local completers = Core:GetDungeonCompleters("MAGISTER")
        assert.are.equal(2, #completers)
    end)

    it("does not include non-completers", function()
        NS.groupCompletions["Alice-Realm"] = { MAISARA = true }
        local completers = Core:GetDungeonCompleters("MAGISTER")
        assert.are.equal(0, #completers)
    end)
end)

-- ============================================================================
-- PruneCompletions
-- ============================================================================
describe("PruneCompletions", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("keeps local player's completions when solo", function()
        _G.IsInGroup = function() return false end
        _G.IsInRaid = function() return false end
        _G.UnitName = function() return "TestPlayer", nil end
        NS.groupCompletions["TestPlayer-TestRealm"] = { MAGISTER = true }
        Core:PruneCompletions()
        assert.is_not_nil(NS.groupCompletions["TestPlayer-TestRealm"])
    end)

    it("removes departed members in party", function()
        _G.IsInGroup = function() return true end
        _G.IsInRaid = function() return false end
        _G.GetNumGroupMembers = function() return 1 end
        _G.UnitName = function() return "TestPlayer", nil end
        NS.groupCompletions["TestPlayer-TestRealm"] = { MAGISTER = true }
        NS.groupCompletions["GonePlayer-Realm"] = { MAISARA = true }
        Core:PruneCompletions()
        assert.is_not_nil(NS.groupCompletions["TestPlayer-TestRealm"])
        assert.is_nil(NS.groupCompletions["GonePlayer-Realm"])
    end)

    -- Regression: PruneCompletions had no raid branch, wiped everything in raid
    it("handles raid groups by iterating raid units", function()
        _G.IsInGroup = function() return true end
        _G.IsInRaid = function() return true end
        _G.GetNumGroupMembers = function() return 2 end
        local raidNames = { "Alice", "Bob" }
        _G.UnitExists = function(unit) return unit:match("^raid%d+$") ~= nil end
        _G.UnitName = function(unit)
            local i = tonumber(unit:match("raid(%d+)"))
            if i and raidNames[i] then return raidNames[i], nil end
            return "TestPlayer", nil
        end

        NS.groupCompletions["TestPlayer-TestRealm"] = { MAGISTER = true }
        NS.groupCompletions["Alice-TestRealm"] = { MAISARA = true }
        NS.groupCompletions["Gone-TestRealm"] = { NEXUS_XENAS = true }

        Core:PruneCompletions()
        assert.is_not_nil(NS.groupCompletions["TestPlayer-TestRealm"])
        assert.is_not_nil(NS.groupCompletions["Alice-TestRealm"])
        assert.is_nil(NS.groupCompletions["Gone-TestRealm"])
    end)
end)

-- ============================================================================
-- SeedLocalCompletions
-- ============================================================================
describe("SeedLocalCompletions", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("copies excludedDungeons to groupCompletions for local player", function()
        _G.UnitName = function() return "Me", nil end
        Core.db.profile.excludedDungeons = { MAGISTER = true, MAISARA = true }
        Core:SeedLocalCompletions()
        local myCompletions = NS.groupCompletions["Me-TestRealm"]
        assert.is_not_nil(myCompletions)
        assert.is_true(myCompletions.MAGISTER)
        assert.is_true(myCompletions.MAISARA)
    end)

    it("does nothing if player name is nil", function()
        _G.UnitName = function() return nil end
        Core:SeedLocalCompletions()
        assert.is_true(next(NS.groupCompletions) == nil)
    end)
end)

-- ============================================================================
-- BroadcastCompletions
-- ============================================================================
describe("BroadcastCompletions", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("does not send when not in a group", function()
        _G.IsInGroup = function() return false end
        local sent = false
        _G.C_ChatInfo = {
            SendAddonMessage = function() sent = true end,
            RegisterAddonMessagePrefix = function() end,
        }
        Core:BroadcastCompletions()
        assert.is_false(sent)
    end)

    it("sends when in a group", function()
        _G.IsInGroup = function() return true end
        _G.IsInRaid = function() return false end
        local sentMsg
        _G.C_ChatInfo = {
            SendAddonMessage = function(prefix, msg, channel) sentMsg = msg end,
            RegisterAddonMessagePrefix = function() end,
        }
        Core.db.profile.excludedDungeons = { MAGISTER = true }
        Core:BroadcastCompletions()
        assert.is_not_nil(sentMsg)
        assert.is_truthy(sentMsg:find("V2:"))
    end)
end)

-- ============================================================================
-- PlayerNeedsItem
-- ============================================================================
describe("PlayerNeedsItem", function()
    local bisTable

    before_each(function()
        bisTable = {
            WARRIOR_ARMS = { [1] = 100, [5] = 200, [11] = 300, [12] = 300 },
        }
    end)

    it("returns true when player doesn't have the BIS item", function()
        local player = makePlayer("WARRIOR_ARMS", { [1] = 999, [5] = 999 })
        assert.is_true(Core:PlayerNeedsItem(player, 100, bisTable))
    end)

    it("returns false when player has the BIS item equipped", function()
        local player = makePlayer("WARRIOR_ARMS", { [1] = 100, [5] = 200 })
        assert.is_false(Core:PlayerNeedsItem(player, 100, bisTable))
    end)

    it("handles duplicate BIS items (needs 2, has 1)", function()
        local player = makePlayer("WARRIOR_ARMS", { [11] = 300, [12] = 999 })
        assert.is_true(Core:PlayerNeedsItem(player, 300, bisTable))
    end)

    it("returns false when both copies of duplicate item equipped", function()
        local player = makePlayer("WARRIOR_ARMS", { [11] = 300, [12] = 300 })
        assert.is_false(Core:PlayerNeedsItem(player, 300, bisTable))
    end)

    it("returns false when item is not in BIS at all", function()
        local player = makePlayer("WARRIOR_ARMS", {})
        assert.is_false(Core:PlayerNeedsItem(player, 999, bisTable))
    end)

    it("returns false for nil playerData", function()
        assert.is_false(Core:PlayerNeedsItem(nil, 100, bisTable))
    end)

    it("returns false for player with no spec", function()
        assert.is_false(Core:PlayerNeedsItem({ gear = {} }, 100, bisTable))
    end)

    it("returns false for player with no gear table", function()
        assert.is_false(Core:PlayerNeedsItem({ spec = "WARRIOR_ARMS" }, 100, bisTable))
    end)

    it("defaults to NS.BIS_MYTHIC when no bisTable provided", function()
        local spec = "WARRIOR_ARMS"
        local bisList = NS.BIS_MYTHIC[spec]
        local player = makePlayer(spec, {})
        if bisList then
            for _, itemId in pairs(bisList) do
                assert.is_true(Core:PlayerNeedsItem(player, itemId))
                break
            end
        end
    end)
end)

-- ============================================================================
-- PlayerNeedsItemForOffSpec
-- ============================================================================
describe("PlayerNeedsItemForOffSpec", function()
    local bisTable

    before_each(function()
        bisTable = {
            WARRIOR_ARMS = { [1] = 100, [16] = 300 },
            WARRIOR_FURY = { [1] = 100, [16] = 400 },
        }
    end)

    it("returns true for off-spec-only BIS item", function()
        local player = makePlayer("WARRIOR_ARMS", { [16] = 300 }, { offSpec = "WARRIOR_FURY" })
        assert.is_true(Core:PlayerNeedsItemForOffSpec(player, 400, bisTable))
    end)

    it("returns false for item shared between main and off spec", function()
        local player = makePlayer("WARRIOR_ARMS", {}, { offSpec = "WARRIOR_FURY" })
        assert.is_false(Core:PlayerNeedsItemForOffSpec(player, 100, bisTable))
    end)

    it("returns false when player has no offSpec", function()
        local player = makePlayer("WARRIOR_ARMS", {})
        assert.is_false(Core:PlayerNeedsItemForOffSpec(player, 400, bisTable))
    end)

    it("returns false for item not in off-spec BIS", function()
        local player = makePlayer("WARRIOR_ARMS", {}, { offSpec = "WARRIOR_FURY" })
        assert.is_false(Core:PlayerNeedsItemForOffSpec(player, 999, bisTable))
    end)

    it("returns false for nil playerData", function()
        assert.is_false(Core:PlayerNeedsItemForOffSpec(nil, 400, bisTable))
    end)

    it("returns false when off-spec is unknown", function()
        local player = makePlayer("WARRIOR_ARMS", {}, { offSpec = "UNKNOWN_SPEC" })
        assert.is_false(Core:PlayerNeedsItemForOffSpec(player, 400, bisTable))
    end)

    it("still checks off-spec BIS even when player has no main spec", function()
        -- No main spec means the "skip shared items" check is bypassed
        local player = { offSpec = "WARRIOR_FURY", gear = {} }
        -- Item 400 is in WARRIOR_FURY BIS and NOT in any main spec (no spec set)
        -- So it should return true (off-spec need, no main-spec to filter against)
        assert.is_true(Core:PlayerNeedsItemForOffSpec(player, 400, bisTable))
    end)
end)

-- ============================================================================
-- CountMissingBIS
-- ============================================================================
describe("CountMissingBIS", function()
    local bisTable, origItemToDungeons, origItemToRaids

    before_each(function()
        bisTable = {
            WARRIOR_ARMS = { [1] = 100, [5] = 200, [16] = 300 },
        }
        origItemToDungeons = NS.ITEM_TO_DUNGEONS
        origItemToRaids = NS.ITEM_TO_RAIDS
        NS.ITEM_TO_DUNGEONS = { [100] = { "MAGISTER" }, [200] = { "NEXUS_XENAS" } }
        NS.ITEM_TO_RAIDS = {}
    end)

    after_each(function()
        NS.ITEM_TO_DUNGEONS = origItemToDungeons
        NS.ITEM_TO_RAIDS = origItemToRaids
    end)

    it("reports all items missing when gear is empty", function()
        local player = makePlayer("WARRIOR_ARMS", {})
        local missing, total = Core:CountMissingBIS(player, bisTable)
        assert.are.equal(3, total)
        assert.are.equal(3, missing)
    end)

    it("reports zero missing when all BIS equipped", function()
        local player = makePlayer("WARRIOR_ARMS", { [1] = 100, [5] = 200, [16] = 300 })
        local missing, total = Core:CountMissingBIS(player, bisTable)
        assert.are.equal(3, total)
        assert.are.equal(0, missing)
    end)

    it("counts dungeon items separately", function()
        local player = makePlayer("WARRIOR_ARMS", { [16] = 300 })
        local missing, total, missingDungeon, totalDungeon = Core:CountMissingBIS(player, bisTable)
        assert.are.equal(2, missing)
        assert.are.equal(2, missingDungeon)
        assert.are.equal(2, totalDungeon)
    end)

    it("handles nil playerData", function()
        local m, t, md, td = Core:CountMissingBIS(nil, bisTable)
        assert.are.equal(0, m)
        assert.are.equal(0, t)
        assert.are.equal(0, md)
        assert.are.equal(0, td)
    end)

    it("handles player with no spec", function()
        local m, t = Core:CountMissingBIS({ gear = {} }, bisTable)
        assert.are.equal(0, m)
        assert.are.equal(0, t)
    end)

    it("handles player with no gear", function()
        local m, t = Core:CountMissingBIS({ spec = "WARRIOR_ARMS" }, bisTable)
        assert.are.equal(0, m)
        assert.are.equal(0, t)
    end)

    it("handles duplicate items correctly (2 rings same itemId)", function()
        bisTable.WARRIOR_ARMS[11] = 500
        bisTable.WARRIOR_ARMS[12] = 500
        local player = makePlayer("WARRIOR_ARMS", { [11] = 500, [12] = 999 })
        local missing, total = Core:CountMissingBIS(player, bisTable)
        assert.are.equal(5, total) -- 3 original + 2 rings
        assert.are.equal(4, missing) -- items 100, 200, 300, and 1 copy of 500
    end)

    it("reports zero missing for duplicates when both copies equipped", function()
        bisTable.WARRIOR_ARMS[11] = 500
        bisTable.WARRIOR_ARMS[12] = 500
        local player = makePlayer("WARRIOR_ARMS", {
            [1] = 100, [5] = 200, [16] = 300, [11] = 500, [12] = 500,
        })
        local missing, total = Core:CountMissingBIS(player, bisTable)
        assert.are.equal(5, total)
        assert.are.equal(0, missing)
    end)
end)

-- ============================================================================
-- ScoreDungeon
-- ============================================================================
describe("ScoreDungeon", function()
    local origLoot, origGroupData, origBIS

    before_each(function()
        resetState()
        origLoot = NS.DUNGEON_LOOT
        origGroupData = NS.groupData
        origBIS = NS.BIS_MYTHIC
        NS.DUNGEON_LOOT = {
            TEST_DUNGEON = {
                { itemId = 100, itemName = "Sword", boss = "Boss A" },
                { itemId = 200, itemName = "Shield", boss = "Boss B" },
                { itemId = 300, itemName = "Ring", boss = "Boss A" },
            },
        }
    end)

    after_each(function()
        NS.DUNGEON_LOOT = origLoot
        NS.groupData = origGroupData
        NS.BIS_MYTHIC = origBIS
    end)

    it("returns 0 for unknown dungeon", function()
        local score, details = Core:ScoreDungeon("NONEXISTENT")
        assert.are.equal(0, score)
        assert.are.same({}, details)
    end)

    it("returns 0 when no group members", function()
        NS.groupData = {}
        local score, details = Core:ScoreDungeon("TEST_DUNGEON")
        assert.are.equal(0, score)
    end)

    it("scores based on BIS items needed", function()
        NS.BIS_MYTHIC = {
            WARRIOR_ARMS = { [16] = 100, [17] = 200 },
            MAGE_FROST = { [11] = 300 },
        }
        NS.groupData = {
            ["Warrior-Realm"] = makePlayer("WARRIOR_ARMS", {}, { name = "Warrior" }),
            ["Mage-Realm"] = makePlayer("MAGE_FROST", {}, { name = "Mage", class = "MAGE" }),
        }

        local score, details = Core:ScoreDungeon("TEST_DUNGEON")
        assert.are.equal(3, score)
        assert.are.equal(2, details["Warrior-Realm"].count)
        assert.are.equal(1, details["Mage-Realm"].count)
    end)

    it("scores off-spec items at 0.5 each", function()
        NS.BIS_MYTHIC = {
            WARRIOR_ARMS = { [16] = 100 },
            WARRIOR_FURY = { [16] = 200 },
        }
        NS.groupData = {
            ["Tank-Realm"] = makePlayer("WARRIOR_ARMS", {}, {
                name = "Tank", offSpec = "WARRIOR_FURY",
            }),
        }

        local score, details = Core:ScoreDungeon("TEST_DUNGEON")
        assert.are.equal(1.5, score)
        assert.are.equal(1, details["Tank-Realm"].mainSpecCount)
        assert.are.equal(1, details["Tank-Realm"].offSpecCount)
    end)

    it("does not double-count items needed for both main and off spec", function()
        NS.BIS_MYTHIC = {
            WARRIOR_ARMS = { [16] = 100 },
            WARRIOR_FURY = { [16] = 100 },
        }
        NS.groupData = {
            ["Player-Realm"] = makePlayer("WARRIOR_ARMS", {}, {
                name = "Player", offSpec = "WARRIOR_FURY",
            }),
        }

        local score, details = Core:ScoreDungeon("TEST_DUNGEON")
        assert.are.equal(1, score)
        assert.are.equal(0, details["Player-Realm"].offSpecCount)
    end)

    it("does not count items already equipped", function()
        NS.BIS_MYTHIC = {
            WARRIOR_ARMS = { [16] = 100, [17] = 200 },
        }
        NS.groupData = {
            ["Player-Realm"] = makePlayer("WARRIOR_ARMS", { [16] = 100 }, { name = "Player" }),
        }
        local score, details = Core:ScoreDungeon("TEST_DUNGEON")
        assert.are.equal(1, score) -- only 200 needed
    end)

    it("includes every group member in details even with 0 needs", function()
        NS.BIS_MYTHIC = { WARRIOR_ARMS = {} }
        NS.groupData = {
            ["Player-Realm"] = makePlayer("WARRIOR_ARMS", {}, { name = "Player" }),
        }
        local _, details = Core:ScoreDungeon("TEST_DUNGEON")
        assert.is_not_nil(details["Player-Realm"])
        assert.are.equal(0, details["Player-Realm"].count)
    end)
end)

-- ============================================================================
-- CalculateDungeonRanking
-- ============================================================================
describe("CalculateDungeonRanking", function()
    before_each(resetState)

    it("returns a ranking for each non-excluded dungeon", function()
        local ranking = Core:CalculateDungeonRanking()
        assert.is_table(ranking)
        assert.are.equal(#NS.DUNGEONS, #ranking)
    end)

    it("excludes completed dungeons", function()
        NS.groupCompletions["Me-Realm"] = { [NS.DUNGEONS[1].id] = true }
        local ranking = Core:CalculateDungeonRanking()
        assert.are.equal(#NS.DUNGEONS - 1, #ranking)
    end)

    it("sorts by score descending", function()
        local ranking = Core:CalculateDungeonRanking()
        for i = 2, #ranking do
            assert.is_true(ranking[i - 1].score >= ranking[i].score)
        end
    end)

    it("each entry has expected fields", function()
        local ranking = Core:CalculateDungeonRanking()
        if #ranking > 0 then
            local entry = ranking[1]
            assert.is_table(entry.dungeon)
            assert.is_number(entry.score)
            assert.is_number(entry.bisScore)
            assert.is_number(entry.ratingBonus)
            assert.is_table(entry.details)
        end
    end)
end)

-- ============================================================================
-- RecalculateAllRankings (regression: was infinitely recursive)
-- ============================================================================
describe("RecalculateAllRankings", function()
    before_each(resetState)

    it("does not infinitely recurse", function()
        assert.has_no.errors(function()
            Core:RecalculateAllRankings()
        end)
    end)

    it("populates both lastRanking and lastRaidRanking", function()
        Core:RecalculateAllRankings()
        assert.is_table(Core.lastRanking)
        assert.is_table(Core.lastRaidRanking)
    end)

    it("lastRanking has correct number of entries", function()
        Core:RecalculateAllRankings()
        assert.are.equal(#NS.DUNGEONS, #Core.lastRanking)
    end)
end)

-- ============================================================================
-- ScoreRaid
-- ============================================================================
describe("ScoreRaid", function()
    local origRaidLoot, origBISRaid

    before_each(function()
        resetState()
        origRaidLoot = NS.RAID_LOOT
        origBISRaid = NS.BIS_RAID
        NS.RAID_LOOT = {
            TEST_RAID = {
                { itemId = 1000, itemName = "Raid Sword", boss = "Big Boss" },
                { itemId = 1001, itemName = "Raid Shield", boss = "Other Boss" },
            },
        }
        NS.BIS_RAID = {
            WARRIOR_ARMS = { [16] = 1000 },
            WARRIOR_FURY = { [16] = 1001 },
        }
    end)

    after_each(function()
        NS.RAID_LOOT = origRaidLoot
        NS.BIS_RAID = origBISRaid
    end)

    it("returns 0 for unknown raid", function()
        local score, details = Core:ScoreRaid("NONEXISTENT")
        assert.are.equal(0, score)
    end)

    it("scores using raid BIS table (not M+ BIS)", function()
        NS.groupData = {
            ["Player-Realm"] = makePlayer("WARRIOR_ARMS", {}, { name = "Player" }),
        }
        local score, details = Core:ScoreRaid("TEST_RAID")
        assert.are.equal(1, score)
        assert.are.equal(1, details["Player-Realm"].count)
    end)

    it("handles off-spec in raid scoring", function()
        NS.groupData = {
            ["Player-Realm"] = makePlayer("WARRIOR_ARMS", {}, {
                name = "Player", offSpec = "WARRIOR_FURY",
            }),
        }
        local score, details = Core:ScoreRaid("TEST_RAID")
        -- 1 main-spec (1000) + 1 off-spec (1001) at 0.5 = 1.5
        assert.are.equal(1.5, score)
        assert.are.equal(1, details["Player-Realm"].mainSpecCount)
        assert.are.equal(1, details["Player-Realm"].offSpecCount)
    end)
end)

-- ============================================================================
-- CalculateRaidRanking
-- ============================================================================
describe("CalculateRaidRanking", function()
    before_each(resetState)

    it("returns a ranking entry for each raid", function()
        local ranking = Core:CalculateRaidRanking()
        assert.is_table(ranking)
        assert.are.equal(#NS.RAIDS, #ranking)
    end)

    it("sorts by score descending", function()
        local ranking = Core:CalculateRaidRanking()
        for i = 2, #ranking do
            assert.is_true(ranking[i - 1].score >= ranking[i].score)
        end
    end)

    it("marks entries as isRaid", function()
        local ranking = Core:CalculateRaidRanking()
        for _, entry in ipairs(ranking) do
            assert.is_true(entry.isRaid)
        end
    end)

    it("has ratingBonus = 0 for raid entries", function()
        local ranking = Core:CalculateRaidRanking()
        for _, entry in ipairs(ranking) do
            assert.are.equal(0, entry.ratingBonus)
        end
    end)
end)

-- ============================================================================
-- GetTierSetCount
-- ============================================================================
describe("GetTierSetCount", function()
    local origBIS

    before_each(function()
        origBIS = NS.BIS_MYTHIC
        NS.BIS_MYTHIC = {
            WARRIOR_ARMS = {
                [1] = 1001, [3] = 1002, [5] = 1003, [10] = 1004, [7] = 1005,
                [16] = 2000,
            },
        }
    end)

    after_each(function()
        NS.BIS_MYTHIC = origBIS
    end)

    it("returns 0 when no tier pieces equipped", function()
        local player = makePlayer("WARRIOR_ARMS", { [16] = 2000 })
        assert.are.equal(0, Core:GetTierSetCount(player))
    end)

    it("counts equipped tier pieces", function()
        local player = makePlayer("WARRIOR_ARMS", {
            [1] = 1001, [3] = 1002, [5] = 9999, [10] = 1004, [7] = 1005,
        })
        assert.are.equal(4, Core:GetTierSetCount(player))
    end)

    it("returns 5 when full tier set equipped", function()
        local player = makePlayer("WARRIOR_ARMS", {
            [1] = 1001, [3] = 1002, [5] = 1003, [10] = 1004, [7] = 1005,
        })
        assert.are.equal(5, Core:GetTierSetCount(player))
    end)

    it("returns 0 for nil playerData", function()
        assert.are.equal(0, Core:GetTierSetCount(nil))
    end)

    it("returns 0 for player with no spec", function()
        assert.are.equal(0, Core:GetTierSetCount({ gear = {} }))
    end)

    it("returns 0 for player with no gear", function()
        assert.are.equal(0, Core:GetTierSetCount({ spec = "WARRIOR_ARMS" }))
    end)

    it("returns 0 when spec has no BIS list", function()
        assert.are.equal(0, Core:GetTierSetCount(makePlayer("UNKNOWN", {})))
    end)
end)

-- ============================================================================
-- GetCatalystSuggestion
-- ============================================================================
describe("GetCatalystSuggestion", function()
    local origBIS

    before_each(function()
        origBIS = NS.BIS_MYTHIC
        NS.BIS_MYTHIC = {
            WARRIOR_ARMS = {
                [1] = 1001, [3] = 1002, [5] = 1003, [10] = 1004, [7] = 1005,
            },
        }
    end)

    after_each(function()
        NS.BIS_MYTHIC = origBIS
    end)

    it("returns nil when full tier set equipped", function()
        local player = makePlayer("WARRIOR_ARMS", {
            [1] = 1001, [3] = 1002, [5] = 1003, [10] = 1004, [7] = 1005,
        })
        assert.is_nil(Core:GetCatalystSuggestion(player))
    end)

    it("suggests a missing tier slot", function()
        local player = makePlayer("WARRIOR_ARMS", {
            [1] = 1001, [3] = 9999, [5] = 1003, [10] = 1004, [7] = 1005,
        })
        local suggestion = Core:GetCatalystSuggestion(player)
        assert.is_not_nil(suggestion)
        assert.is_number(suggestion.slotId)
        assert.is_number(suggestion.itemId)
        assert.is_string(suggestion.slotName)
    end)

    it("returns nil for nil playerData", function()
        assert.is_nil(Core:GetCatalystSuggestion(nil))
    end)

    it("returns nil for player with no spec", function()
        assert.is_nil(Core:GetCatalystSuggestion({ gear = {} }))
    end)

    it("returns nil for player with no gear", function()
        assert.is_nil(Core:GetCatalystSuggestion({ spec = "WARRIOR_ARMS" }))
    end)
end)

-- ============================================================================
-- GetCatalystCharges
-- ============================================================================
describe("GetCatalystCharges", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns 0 when C_CurrencyInfo is nil", function()
        _G.C_CurrencyInfo = nil
        assert.are.equal(0, Core:GetCatalystCharges())
    end)

    it("returns 0 when GetCurrencyInfo is nil", function()
        _G.C_CurrencyInfo = {}
        assert.are.equal(0, Core:GetCatalystCharges())
    end)

    it("returns quantity from currency info", function()
        _G.C_CurrencyInfo = {
            GetCurrencyInfo = function(currencyId)
                return { quantity = 3 }
            end,
        }
        assert.are.equal(3, Core:GetCatalystCharges())
    end)

    it("returns 0 when currency info has no quantity", function()
        _G.C_CurrencyInfo = {
            GetCurrencyInfo = function() return {} end,
        }
        assert.are.equal(0, Core:GetCatalystCharges())
    end)
end)

-- ============================================================================
-- BroadcastCatalyst
-- ============================================================================
describe("BroadcastCatalyst", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("does nothing when not in group", function()
        _G.IsInGroup = function() return false end
        local sent = false
        _G.C_ChatInfo = {
            SendAddonMessage = function() sent = true end,
            RegisterAddonMessagePrefix = function() end,
        }
        Core:BroadcastCatalyst()
        assert.is_false(sent)
    end)

    it("stores locally after broadcast", function()
        _G.IsInGroup = function() return true end
        _G.IsInRaid = function() return false end
        _G.UnitName = function() return "Me", nil end
        _G.C_CurrencyInfo = nil
        Core:BroadcastCatalyst()
        assert.is_not_nil(NS.groupCatalyst["Me-TestRealm"])
    end)
end)

-- ============================================================================
-- CalculateItemPriority
-- ============================================================================
describe("CalculateItemPriority", function()
    local bisTable, origBIS

    before_each(function()
        resetState()
        origBIS = NS.BIS_MYTHIC
        NS.BIS_MYTHIC = {
            WARRIOR_ARMS = { [1] = 100, [16] = 300 },
            WARRIOR_FURY = { [16] = 400 },
        }
    end)

    after_each(function()
        NS.BIS_MYTHIC = origBIS
    end)

    it("returns BIS_MAIN for main-spec BIS item", function()
        local player = makePlayer("WARRIOR_ARMS", {})
        local score, tag = Core:CalculateItemPriority(player, 100, 1)
        assert.is_true(score >= 100)
        assert.are.equal(NS.PRIORITY_TAGS.BIS_MAIN, tag)
    end)

    it("returns BIS_OFF for off-spec BIS item", function()
        local player = makePlayer("WARRIOR_ARMS", {}, { offSpec = "WARRIOR_FURY" })
        local score, tag = Core:CalculateItemPriority(player, 400, 16)
        assert.are.equal(50, score)
        assert.are.equal(NS.PRIORITY_TAGS.BIS_OFF, tag)
    end)

    it("returns NO_UPGRADE for non-BIS item", function()
        local player = makePlayer("WARRIOR_ARMS", {})
        local score, tag = Core:CalculateItemPriority(player, 999, 1)
        assert.are.equal(0, score)
        assert.are.equal(NS.PRIORITY_TAGS.NO_UPGRADE, tag)
    end)

    it("returns NO_UPGRADE for nil playerData", function()
        local score, tag = Core:CalculateItemPriority(nil, 100, 1)
        assert.are.equal(0, score)
        assert.are.equal(NS.PRIORITY_TAGS.NO_UPGRADE, tag)
    end)

    it("higher completion gives higher score (completion bonus)", function()
        -- Player with 1/2 BIS gets higher bonus than 0/2
        local p1 = makePlayer("WARRIOR_ARMS", { [1] = 100 }) -- 1 of 2 equipped
        local p2 = makePlayer("WARRIOR_ARMS", {})              -- 0 of 2 equipped
        local s1 = Core:CalculateItemPriority(p1, 300, 16) -- needs 300
        local s2 = Core:CalculateItemPriority(p2, 300, 16) -- needs 300
        assert.is_true(s1 > s2) -- p1 is closer to completion
    end)

    it("returns ilvlDelta when ilvl data available", function()
        local player = makePlayer("WARRIOR_ARMS", {}, { ilvls = { [1] = 600 } })
        local _, _, ilvlDelta = Core:CalculateItemPriority(player, 100, 1)
        assert.is_not_nil(ilvlDelta)
        assert.are.equal(1, ilvlDelta)
    end)
end)

-- ============================================================================
-- GetItemCandidates
-- ============================================================================
describe("GetItemCandidates", function()
    local origBIS

    before_each(function()
        resetState()
        origBIS = NS.BIS_MYTHIC
        NS.BIS_MYTHIC = {
            WARRIOR_ARMS = { [16] = 100 },
            MAGE_FROST = { [16] = 100 },
            ROGUE_OUTLAW = {},
        }
        NS.groupData = {
            ["Warrior-Realm"] = makePlayer("WARRIOR_ARMS", {}, { name = "Warrior" }),
            ["Mage-Realm"] = makePlayer("MAGE_FROST", {}, { name = "Mage", class = "MAGE" }),
            ["Rogue-Realm"] = makePlayer("ROGUE_OUTLAW", {}, { name = "Rogue", class = "ROGUE" }),
        }
    end)

    after_each(function()
        NS.BIS_MYTHIC = origBIS
    end)

    it("returns candidates who need the item", function()
        local candidates = Core:GetItemCandidates(100, 16)
        assert.are.equal(2, #candidates) -- warrior + mage
    end)

    it("excludes players who don't need the item", function()
        local candidates = Core:GetItemCandidates(100, 16)
        for _, c in ipairs(candidates) do
            assert.is_not_equal("Rogue-Realm", c.playerName)
        end
    end)

    it("returns sorted by score descending", function()
        local candidates = Core:GetItemCandidates(100, 16)
        for i = 2, #candidates do
            assert.is_true(candidates[i - 1].score >= candidates[i].score)
        end
    end)

    it("returns empty list for non-BIS item", function()
        local candidates = Core:GetItemCandidates(999, 1)
        assert.are.equal(0, #candidates)
    end)

    it("each candidate has expected fields", function()
        local candidates = Core:GetItemCandidates(100, 16)
        for _, c in ipairs(candidates) do
            assert.is_string(c.playerName)
            assert.is_table(c.playerData)
            assert.is_number(c.score)
            assert.is_string(c.tag)
        end
    end)
end)

-- ============================================================================
-- ColorByClass
-- ============================================================================
describe("ColorByClass", function()
    it("wraps text with class color code", function()
        local result = NS.ColorByClass("TestPlayer", "WARRIOR")
        assert.are.equal("|cffc79c6eTestPlayer|r", result)
    end)

    it("wraps text with white for unknown class", function()
        local result = NS.ColorByClass("TestPlayer", "UNKNOWN")
        assert.are.equal("|cffffffffTestPlayer|r", result)
    end)

    it("works with nil class", function()
        local result = NS.ColorByClass("TestPlayer", nil)
        assert.are.equal("|cffffffffTestPlayer|r", result)
    end)
end)

-- ============================================================================
-- PerformReadyCheck (unit list logic)
-- ============================================================================
describe("PerformReadyCheck", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("includes player once when solo", function()
        _G.IsInGroup = function() return false end
        _G.IsInRaid = function() return false end
        _G.GetNumGroupMembers = function() return 1 end
        _G.UnitName = function() return "Solo", nil end

        local results = Core:PerformReadyCheck()
        assert.are.equal(1, #results)
    end)

    -- Regression: player was duplicated in raid
    it("does not duplicate player in raid", function()
        _G.IsInGroup = function() return true end
        _G.IsInRaid = function() return true end
        _G.GetNumGroupMembers = function() return 3 end
        _G.UnitExists = function(u) return u:match("^raid") ~= nil end
        _G.UnitIsConnected = function() return true end
        local raidNames = { raid1 = "Alice", raid2 = "Bob", raid3 = "Charlie" }
        _G.UnitName = function(u) return raidNames[u] or u, nil end

        local results = Core:PerformReadyCheck()
        assert.are.equal(3, #results)
    end)

    it("handles party group correctly", function()
        _G.IsInGroup = function() return true end
        _G.IsInRaid = function() return false end
        _G.GetNumGroupMembers = function() return 3 end
        _G.UnitExists = function() return true end
        _G.UnitIsConnected = function() return true end
        _G.UnitName = function(u)
            local names = { player = "Me", party1 = "Alice", party2 = "Bob" }
            return names[u] or u, nil
        end

        local results = Core:PerformReadyCheck()
        assert.are.equal(3, #results) -- player + party1 + party2
    end)

    it("skips disconnected units", function()
        _G.IsInGroup = function() return false end
        _G.UnitIsConnected = function() return false end
        _G.UnitName = function() return "Me", nil end

        local results = Core:PerformReadyCheck()
        assert.are.equal(0, #results)
    end)

    it("each result has expected fields", function()
        _G.IsInGroup = function() return false end
        _G.UnitIsConnected = function() return true end
        _G.UnitName = function() return "Me", nil end

        local results = Core:PerformReadyCheck()
        if #results > 0 then
            local r = results[1]
            assert.is_string(r.name)
            assert.is_string(r.class)
            assert.is_table(r.checks)
            assert.is_number(r.passCount)
            assert.are.equal(5, r.totalChecks)
        end
    end)

    it("stores results in Core.lastReadyCheck", function()
        _G.IsInGroup = function() return false end
        _G.UnitIsConnected = function() return true end
        _G.UnitName = function() return "Me", nil end

        Core:PerformReadyCheck()
        assert.is_table(Core.lastReadyCheck)
    end)
end)

-- ============================================================================
-- GetDungeonScoreData
-- ============================================================================
describe("GetDungeonScoreData", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns nil when C_MythicPlus is nil", function()
        _G.C_MythicPlus = nil
        assert.is_nil(Core:GetDungeonScoreData(2773))
    end)

    it("returns data when API is available", function()
        _G.C_MythicPlus = {
            GetWeeklyBestForMap = function() return 1200, 15, nil, nil, nil, 200 end,
            GetSeasonBestForMap = function()
                return { level = 20 }, nil
            end,
        }
        local data = Core:GetDungeonScoreData(2773)
        assert.is_table(data)
        assert.is_table(data.weeklyBest)
        assert.are.equal(15, data.weeklyBest.level)
    end)
end)

-- ============================================================================
-- GetSeasonHistory
-- ============================================================================
describe("GetSeasonHistory", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns empty when C_MythicPlus is nil", function()
        _G.C_MythicPlus = nil
        assert.are.same({}, Core:GetSeasonHistory())
    end)

    it("groups runs by mapID", function()
        _G.C_MythicPlus = {
            GetRunHistory = function()
                return {
                    { mapChallengeModeID = 2773, level = 15, runScore = 200 },
                    { mapChallengeModeID = 2773, level = 18, runScore = 300 },
                    { mapChallengeModeID = 2774, level = 10, runScore = 100 },
                }
            end,
        }
        local history = Core:GetSeasonHistory()
        assert.are.equal(2, history[2773].runs)
        assert.are.equal(18, history[2773].bestLevel)
        assert.are.equal(300, history[2773].bestScore)
        assert.are.equal(1, history[2774].runs)
    end)
end)

-- ============================================================================
-- GetVaultProgress
-- ============================================================================
describe("GetVaultProgress", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns empty slots when C_WeeklyRewards is nil", function()
        _G.C_WeeklyRewards = nil
        local result = Core:GetVaultProgress()
        assert.are.same({}, result.slots)
        assert.are.equal(0, result.totalRuns)
    end)

    it("parses vault activities", function()
        _G.C_WeeklyRewards = {
            GetActivities = function()
                return {
                    { threshold = 1, progress = 3, level = 15 },
                    { threshold = 4, progress = 5, level = 12 },
                }
            end,
            HasAvailableRewards = function() return true end,
        }
        local result = Core:GetVaultProgress()
        assert.are.equal(2, #result.slots)
        assert.are.equal(5, result.totalRuns)
        assert.is_true(result.hasRewards)
    end)
end)

-- ============================================================================
-- GetMinKeyForUpgrade
-- ============================================================================
describe("GetMinKeyForUpgrade", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns nil when C_MythicPlus is nil", function()
        _G.C_MythicPlus = nil
        assert.is_nil(Core:GetMinKeyForUpgrade(600))
    end)

    it("finds the first key level that gives an upgrade", function()
        _G.C_MythicPlus = {
            GetRewardLevelFromKeystoneLevel = function(keyLevel)
                return 610 + keyLevel * 3
            end,
        }
        local minKey = Core:GetMinKeyForUpgrade(625)
        assert.is_number(minKey)
    end)

    it("returns nil when no key level provides an upgrade", function()
        _G.C_MythicPlus = {
            GetRewardLevelFromKeystoneLevel = function() return 500 end,
        }
        assert.is_nil(Core:GetMinKeyForUpgrade(600))
    end)
end)

-- ============================================================================
-- GetEquippedItemLevel
-- ============================================================================
describe("GetEquippedItemLevel", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns nil when no item in slot", function()
        _G.GetInventoryItemLink = function() return nil end
        assert.is_nil(Core:GetEquippedItemLevel("player", 1))
    end)

    it("uses C_Item.GetDetailedItemLevelInfo when available", function()
        _G.GetInventoryItemLink = function() return "|cff0070dd|Hitem:12345::::::::|h[Test]|h|r" end
        _G.C_Item = {
            GetDetailedItemLevelInfo = function() return 625 end,
        }
        assert.are.equal(625, Core:GetEquippedItemLevel("player", 1))
        _G.C_Item = nil
    end)

    it("falls back to GetItemInfo when C_Item unavailable", function()
        _G.GetInventoryItemLink = function() return "|cff0070dd|Hitem:12345::::::::|h[Test]|h|r" end
        _G.GetItemInfo = function() return "Test", nil, nil, 600 end
        _G.C_Item = nil
        assert.are.equal(600, Core:GetEquippedItemLevel("player", 1))
    end)
end)

-- ============================================================================
-- PredictTimerSuccess
-- ============================================================================
describe("PredictTimerSuccess", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns nil when C_MythicPlus is nil", function()
        _G.C_MythicPlus = nil
        assert.is_nil(Core:PredictTimerSuccess(2773, 15))
    end)

    it("returns nil with fewer than 3 runs", function()
        _G.C_MythicPlus = {
            GetRunHistory = function()
                return {
                    { mapChallengeModeID = 2773, level = 15, completed = true },
                    { mapChallengeModeID = 2773, level = 14, completed = true },
                }
            end,
        }
        assert.is_nil(Core:PredictTimerSuccess(2773, 15))
    end)

    it("returns Likely for >= 80% timed", function()
        _G.C_MythicPlus = {
            GetRunHistory = function()
                return {
                    { mapChallengeModeID = 2773, level = 15, completed = true },
                    { mapChallengeModeID = 2773, level = 14, completed = true },
                    { mapChallengeModeID = 2773, level = 16, completed = true },
                    { mapChallengeModeID = 2773, level = 15, completed = true },
                    { mapChallengeModeID = 2773, level = 15, completed = false },
                }
            end,
        }
        local result = Core:PredictTimerSuccess(2773, 15)
        assert.is_not_nil(result)
        assert.are.equal("Likely", result.tag)
        assert.are.equal(80, result.confidence)
    end)

    it("returns Moderate for 50-79% timed", function()
        _G.C_MythicPlus = {
            GetRunHistory = function()
                return {
                    { mapChallengeModeID = 2773, level = 15, completed = true },
                    { mapChallengeModeID = 2773, level = 14, completed = false },
                    { mapChallengeModeID = 2773, level = 16, completed = true },
                    { mapChallengeModeID = 2773, level = 15, completed = false },
                }
            end,
        }
        local result = Core:PredictTimerSuccess(2773, 15)
        assert.is_not_nil(result)
        assert.are.equal("Moderate", result.tag)
    end)

    it("returns Unlikely for < 50% timed", function()
        _G.C_MythicPlus = {
            GetRunHistory = function()
                return {
                    { mapChallengeModeID = 2773, level = 15, completed = false },
                    { mapChallengeModeID = 2773, level = 14, completed = false },
                    { mapChallengeModeID = 2773, level = 16, completed = true },
                }
            end,
        }
        local result = Core:PredictTimerSuccess(2773, 15)
        assert.is_not_nil(result)
        assert.are.equal("Unlikely", result.tag)
    end)

    it("only considers runs within +-2 key levels", function()
        _G.C_MythicPlus = {
            GetRunHistory = function()
                return {
                    { mapChallengeModeID = 2773, level = 15, completed = true },
                    { mapChallengeModeID = 2773, level = 14, completed = true },
                    { mapChallengeModeID = 2773, level = 13, completed = true },
                    { mapChallengeModeID = 2773, level = 5, completed = false }, -- out of range
                    { mapChallengeModeID = 2773, level = 25, completed = false }, -- out of range
                }
            end,
        }
        local result = Core:PredictTimerSuccess(2773, 15)
        assert.is_not_nil(result)
        assert.are.equal(3, result.total) -- only 3 in range
        assert.are.equal(3, result.timed)
    end)
end)

-- ============================================================================
-- GetDungeonTimerPrediction
-- ============================================================================
describe("GetDungeonTimerPrediction", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns nil when CHALLENGE_MODE_MAP is nil", function()
        NS.CHALLENGE_MODE_MAP = nil
        assert.is_nil(Core:GetDungeonTimerPrediction("MAGISTER"))
        NS.CHALLENGE_MODE_MAP = { [2773] = "MAGISTER" }
    end)

    it("returns nil for unknown dungeon key", function()
        assert.is_nil(Core:GetDungeonTimerPrediction("UNKNOWN_DUNGEON"))
    end)

    it("returns nil when C_MythicPlus is nil", function()
        _G.C_MythicPlus = nil
        assert.is_nil(Core:GetDungeonTimerPrediction("MAGISTER"))
    end)
end)

-- ============================================================================
-- CalculateKeyRoute
-- ============================================================================
describe("CalculateKeyRoute", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns empty when no keystones available", function()
        _G.C_MythicPlus = nil
        local route = Core:CalculateKeyRoute()
        assert.are.same({}, route)
    end)

    it("includes own keystone", function()
        _G.C_MythicPlus = {
            GetOwnedKeystoneChallengeMapID = function() return 2773 end,
            GetOwnedKeystoneLevel = function() return 15 end,
        }
        _G.C_ChallengeMode = {
            GetMapUIInfo = function() return "Magisters' Terrace" end,
        }
        _G.UnitName = function() return "Me", nil end

        local route = Core:CalculateKeyRoute()
        assert.are.equal(1, #route)
        assert.are.equal("Me-TestRealm", route[1].owner)
        assert.are.equal(15, route[1].level)
    end)

    it("includes party keystones", function()
        _G.C_MythicPlus = nil
        _G.UnitName = function() return "Me", nil end
        NS.partyKeystones["Alice-Realm"] = { mapID = 2774, level = 12, dungeonName = "Maisara" }

        local route = Core:CalculateKeyRoute()
        assert.are.equal(1, #route)
        assert.are.equal("Alice-Realm", route[1].owner)
    end)

    it("sorts keys by total score descending", function()
        _G.C_MythicPlus = nil
        _G.UnitName = function() return "Me", nil end
        NS.partyKeystones["A-Realm"] = { mapID = 2773, level = 15, dungeonName = "Magister" }
        NS.partyKeystones["B-Realm"] = { mapID = 2774, level = 10, dungeonName = "Maisara" }

        local route = Core:CalculateKeyRoute()
        for i = 2, #route do
            assert.is_true(route[i - 1].totalScore >= route[i].totalScore)
        end
    end)
end)

-- ============================================================================
-- GetOwnKeystone
-- ============================================================================
describe("GetOwnKeystone", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns nil when C_MythicPlus is nil", function()
        _G.C_MythicPlus = nil
        assert.is_nil(Core:GetOwnKeystone())
    end)

    it("returns nil when no keystone owned", function()
        _G.C_MythicPlus = {
            GetOwnedKeystoneChallengeMapID = function() return nil end,
            GetOwnedKeystoneLevel = function() return nil end,
        }
        assert.is_nil(Core:GetOwnKeystone())
    end)

    it("returns keystone data when owned", function()
        _G.C_MythicPlus = {
            GetOwnedKeystoneChallengeMapID = function() return 2773 end,
            GetOwnedKeystoneLevel = function() return 15 end,
        }
        _G.C_ChallengeMode = {
            GetMapUIInfo = function() return "Magisters' Terrace" end,
        }
        local key = Core:GetOwnKeystone()
        assert.is_not_nil(key)
        assert.are.equal(2773, key.mapID)
        assert.are.equal(15, key.level)
        assert.are.equal("Magisters' Terrace", key.dungeonName)
    end)
end)

-- ============================================================================
-- BroadcastKeystone
-- ============================================================================
describe("BroadcastKeystone", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("does nothing when not in group", function()
        _G.IsInGroup = function() return false end
        local sent = false
        _G.C_ChatInfo = {
            SendAddonMessage = function() sent = true end,
            RegisterAddonMessagePrefix = function() end,
        }
        Core:BroadcastKeystone()
        assert.is_false(sent)
    end)

    it("does nothing when no keystone owned", function()
        _G.IsInGroup = function() return true end
        _G.C_MythicPlus = nil
        local sent = false
        _G.C_ChatInfo = {
            SendAddonMessage = function() sent = true end,
            RegisterAddonMessagePrefix = function() end,
        }
        Core:BroadcastKeystone()
        assert.is_false(sent)
    end)
end)

-- ============================================================================
-- BroadcastOffSpec
-- ============================================================================
describe("BroadcastOffSpec", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("does nothing when not in group", function()
        _G.IsInGroup = function() return false end
        local sent = false
        _G.C_ChatInfo = {
            SendAddonMessage = function() sent = true end,
            RegisterAddonMessagePrefix = function() end,
        }
        Core:BroadcastOffSpec()
        assert.is_false(sent)
    end)
end)

-- ============================================================================
-- SeedLocalOffSpec
-- ============================================================================
describe("SeedLocalOffSpec", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("sets offSpec on local player's groupData", function()
        _G.UnitName = function() return "Me", nil end
        NS.groupData["Me-TestRealm"] = makePlayer("WARRIOR_ARMS", {})
        Core.db.profile.offSpec = "WARRIOR_FURY"
        Core:SeedLocalOffSpec()
        assert.are.equal("WARRIOR_FURY", NS.groupData["Me-TestRealm"].offSpec)
    end)

    it("sets nil when no offSpec configured", function()
        _G.UnitName = function() return "Me", nil end
        NS.groupData["Me-TestRealm"] = makePlayer("WARRIOR_ARMS", {})
        Core.db.profile.offSpec = nil
        Core:SeedLocalOffSpec()
        assert.is_nil(NS.groupData["Me-TestRealm"].offSpec)
    end)
end)

-- ============================================================================
-- CHAT_MSG_ADDON handler (off-spec validation regression)
-- ============================================================================
describe("CHAT_MSG_ADDON", function()
    before_each(function()
        resetState()
        _G.UnitName = function() return "Me", nil end
    end)
    after_each(stub.resetStubs)

    it("stores validated off-spec from addon message", function()
        local origBIS = NS.BIS_MYTHIC
        NS.BIS_MYTHIC = { WARRIOR_FURY = { [16] = 100 } }
        NS.groupData["Alice-Realm"] = makePlayer("WARRIOR_ARMS", {})

        Core:CHAT_MSG_ADDON("CHAT_MSG_ADDON", "DOptOff", "WARRIOR_FURY", "PARTY", "Alice-Realm")
        assert.are.equal("WARRIOR_FURY", NS.groupData["Alice-Realm"].offSpec)
        NS.BIS_MYTHIC = origBIS
    end)

    -- Regression: unvalidated offSpec could be any arbitrary string
    it("rejects invalid off-spec keys", function()
        NS.groupData["Alice-Realm"] = makePlayer("WARRIOR_ARMS", {})
        Core:CHAT_MSG_ADDON("CHAT_MSG_ADDON", "DOptOff", "INJECTED_GARBAGE", "PARTY", "Alice-Realm")
        assert.is_nil(NS.groupData["Alice-Realm"].offSpec)
    end)

    it("clears off-spec when NONE received", function()
        NS.groupData["Alice-Realm"] = makePlayer("WARRIOR_ARMS", {}, { offSpec = "WARRIOR_FURY" })
        Core:CHAT_MSG_ADDON("CHAT_MSG_ADDON", "DOptOff", "NONE", "PARTY", "Alice-Realm")
        assert.is_nil(NS.groupData["Alice-Realm"].offSpec)
    end)

    it("ignores messages from self", function()
        NS.groupData["Me-TestRealm"] = makePlayer("WARRIOR_ARMS", {})
        Core:CHAT_MSG_ADDON("CHAT_MSG_ADDON", "DOptOff", "WARRIOR_FURY", "PARTY", "Me-TestRealm")
        assert.is_nil(NS.groupData["Me-TestRealm"].offSpec)
    end)

    it("handles completion sync (V2 protocol)", function()
        Core:CHAT_MSG_ADDON("CHAT_MSG_ADDON", "DOptComp", "V2:MAGISTER,MAISARA", "PARTY", "Alice-Realm")
        assert.is_not_nil(NS.groupCompletions["Alice-Realm"])
        assert.is_true(NS.groupCompletions["Alice-Realm"]["MAGISTER"] or false)
    end)

    it("handles completion sync NONE", function()
        Core:CHAT_MSG_ADDON("CHAT_MSG_ADDON", "DOptComp", "V2:NONE", "PARTY", "Alice-Realm")
        assert.is_not_nil(NS.groupCompletions["Alice-Realm"])
        -- Should be empty
        assert.is_nil(next(NS.groupCompletions["Alice-Realm"]))
    end)

    it("handles keystone sync", function()
        Core:CHAT_MSG_ADDON("CHAT_MSG_ADDON", "DOptKey", "2773:15:Magisters' Terrace", "PARTY", "Alice-Realm")
        assert.is_not_nil(NS.partyKeystones["Alice-Realm"])
        assert.are.equal(2773, NS.partyKeystones["Alice-Realm"].mapID)
        assert.are.equal(15, NS.partyKeystones["Alice-Realm"].level)
    end)

    it("handles catalyst sync", function()
        Core:CHAT_MSG_ADDON("CHAT_MSG_ADDON", "DOptCat", "3:4", "PARTY", "Alice-Realm")
        assert.is_not_nil(NS.groupCatalyst["Alice-Realm"])
        assert.are.equal(3, NS.groupCatalyst["Alice-Realm"].charges)
        assert.are.equal(4, NS.groupCatalyst["Alice-Realm"].tierCount)
    end)
end)

-- ============================================================================
-- CHALLENGE_MODE_START / CHALLENGE_MODE_COMPLETED
-- ============================================================================
describe("Challenge mode events", function()
    before_each(function()
        resetState()
        _G.UnitName = function() return "Me", nil end
    end)
    after_each(stub.resetStubs)

    -- Regression: CHALLENGE_MODE_COMPLETED called GetActiveChallengeMapID which returns nil after completion
    it("caches mapID at start and uses it on completion", function()
        _G.C_ChallengeMode = {
            GetActiveChallengeMapID = function() return 2773 end,
        }
        Core:CHALLENGE_MODE_START()
        assert.are.equal(2773, Core._activeChallengeMapID)

        -- On completion, the active challenge is over
        _G.C_ChallengeMode = {
            GetActiveChallengeMapID = function() return nil end,
        }
        Core:CHALLENGE_MODE_COMPLETED()
        assert.is_nil(Core._activeChallengeMapID)
        assert.is_true(Core.db.profile.excludedDungeons["MAGISTER"] or false)
    end)

    it("clears cached mapID after completion", function()
        _G.C_ChallengeMode = {
            GetActiveChallengeMapID = function() return 2773 end,
        }
        Core:CHALLENGE_MODE_START()
        Core:CHALLENGE_MODE_COMPLETED()
        assert.is_nil(Core._activeChallengeMapID)
    end)
end)

-- ============================================================================
-- GROUP_ROSTER_UPDATE
-- ============================================================================
describe("GROUP_ROSTER_UPDATE", function()
    before_each(function()
        resetState()
        _G.UnitName = function() return "Me", nil end
    end)
    after_each(stub.resetStubs)

    -- Regression: was wiping NS.keystones instead of NS.partyKeystones
    it("clears partyKeystones when leaving group", function()
        NS.partyKeystones["Alice-Realm"] = { mapID = 2773, level = 15 }
        _G.IsInGroup = function() return false end
        _G.IsInRaid = function() return false end
        Core:GROUP_ROSTER_UPDATE()
        assert.is_nil(next(NS.partyKeystones))
    end)

    it("clears stale groupData when leaving group", function()
        NS.groupData["Alice-Realm"] = makePlayer("WARRIOR_ARMS", {})
        _G.IsInGroup = function() return false end
        _G.IsInRaid = function() return false end
        Core:GROUP_ROSTER_UPDATE()
        -- Alice should be gone (she was stale data from a previous group)
        assert.is_nil(NS.groupData["Alice-Realm"])
    end)
end)

-- ============================================================================
-- AutoDetectCompletedDungeons
-- ============================================================================
describe("AutoDetectCompletedDungeons", function()
    before_each(function()
        resetState()
        _G.UnitName = function() return "Me", nil end
    end)
    after_each(stub.resetStubs)

    it("does nothing when C_MythicPlus is nil", function()
        _G.C_MythicPlus = nil
        Core:AutoDetectCompletedDungeons()
        assert.is_nil(next(Core.db.profile.excludedDungeons))
    end)

    it("detects completed dungeons from run history", function()
        -- Ensure CHALLENGE_MODE_MAP is populated
        NS.CHALLENGE_MODE_MAP = NS.CHALLENGE_MODE_MAP or {}
        NS.CHALLENGE_MODE_MAP[2773] = "MAGISTER"
        NS.CHALLENGE_MODE_MAP[2774] = "MAISARA"

        _G.C_MythicPlus = {
            GetRunHistory = function()
                return {
                    { mapChallengeModeID = 2773 },
                    { mapChallengeModeID = 2774 },
                }
            end,
        }
        Core:AutoDetectCompletedDungeons()
        assert.is_true(Core.db.profile.excludedDungeons["MAGISTER"])
        assert.is_true(Core.db.profile.excludedDungeons["MAISARA"])
    end)
end)

-- ============================================================================
-- GetCurrentAffixes
-- ============================================================================
describe("GetCurrentAffixes", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("returns nil when C_MythicPlus is nil", function()
        _G.C_MythicPlus = nil
        NS.currentAffixes = nil
        assert.is_nil(Core:GetCurrentAffixes())
    end)

    it("caches affix results", function()
        _G.C_MythicPlus = {
            GetCurrentAffixes = function()
                return {
                    { id = 9, name = "Tyrannical" },
                    { id = 10, name = "Fortified" },
                }
            end,
        }
        local affixes1 = Core:GetCurrentAffixes()
        local affixes2 = Core:GetCurrentAffixes()
        assert.are.equal(affixes1, affixes2) -- same cached table
    end)
end)

-- ============================================================================
-- #43: PlayerNeedsItemUpgrade
-- ============================================================================
describe("PlayerNeedsItemUpgrade", function()
    local origBIS

    before_each(function()
        resetState()
        origBIS = NS.BIS_MYTHIC
        Core.db.profile.upgradeScoring = true
        _G.C_MythicPlus = {
            GetRewardLevelFromKeystoneLevel = function(keyLevel)
                -- Simple linear model: key 2 = 616, key 10 = 640, key 15 = 655
                return 610 + keyLevel * 3
            end,
        }
    end)

    after_each(function()
        NS.BIS_MYTHIC = origBIS
        stub.resetStubs()
    end)

    it("returns upgrade when equipped ilvl is lower than reward", function()
        NS.BIS_MYTHIC = { WARRIOR_ARMS = { [16] = 100 } }
        local player = makePlayer("WARRIOR_ARMS", { [16] = 100 }, {
            name = "Player", ilvls = { [16] = 620 },
        })
        -- Key 10 rewards 640, equipped 620 => delta 20
        local isUpgrade, score, curIlvl, targetIlvl, slot =
            Core:PlayerNeedsItemUpgrade(player, 100, 10)
        assert.is_true(isUpgrade)
        assert.is_true(score > 0)
        assert.are.equal(620, curIlvl)
        assert.are.equal(640, targetIlvl)
        assert.are.equal(16, slot)
    end)

    it("returns false when equipped ilvl >= reward", function()
        NS.BIS_MYTHIC = { WARRIOR_ARMS = { [16] = 100 } }
        local player = makePlayer("WARRIOR_ARMS", { [16] = 100 }, {
            name = "Player", ilvls = { [16] = 650 },
        })
        -- Key 10 rewards 640, equipped 650 => no upgrade
        local isUpgrade = Core:PlayerNeedsItemUpgrade(player, 100, 10)
        assert.is_false(isUpgrade)
    end)

    it("returns false when upgradeScoring is disabled", function()
        Core.db.profile.upgradeScoring = false
        NS.BIS_MYTHIC = { WARRIOR_ARMS = { [16] = 100 } }
        local player = makePlayer("WARRIOR_ARMS", { [16] = 100 }, {
            name = "Player", ilvls = { [16] = 600 },
        })
        local isUpgrade = Core:PlayerNeedsItemUpgrade(player, 100, 10)
        assert.is_false(isUpgrade)
    end)

    it("returns false when ilvl data is missing", function()
        NS.BIS_MYTHIC = { WARRIOR_ARMS = { [16] = 100 } }
        local player = makePlayer("WARRIOR_ARMS", { [16] = 100 }, { name = "Player" })
        local isUpgrade = Core:PlayerNeedsItemUpgrade(player, 100, 10)
        assert.is_false(isUpgrade)
    end)

    it("returns false when item is not in BIS list", function()
        NS.BIS_MYTHIC = { WARRIOR_ARMS = { [16] = 100 } }
        local player = makePlayer("WARRIOR_ARMS", { [16] = 100 }, {
            name = "Player", ilvls = { [16] = 600 },
        })
        local isUpgrade = Core:PlayerNeedsItemUpgrade(player, 999, 10)
        assert.is_false(isUpgrade)
    end)

    it("picks the slot with the largest delta for duplicate items", function()
        NS.BIS_MYTHIC = { MAGE_FROST = { [11] = 500, [12] = 500 } }
        local player = makePlayer("MAGE_FROST", { [11] = 500, [12] = 500 }, {
            name = "Player", class = "MAGE",
            ilvls = { [11] = 635, [12] = 610 },
        })
        -- Key 10 rewards 640; slot 11 delta = 5, slot 12 delta = 30
        local isUpgrade, score, curIlvl, targetIlvl, slot =
            Core:PlayerNeedsItemUpgrade(player, 500, 10)
        assert.is_true(isUpgrade)
        assert.are.equal(12, slot) -- picks the larger delta
        assert.are.equal(610, curIlvl)
    end)

    it("caps score at BASE_WEIGHT for very large deltas", function()
        NS.BIS_MYTHIC = { WARRIOR_ARMS = { [16] = 100 } }
        local player = makePlayer("WARRIOR_ARMS", { [16] = 100 }, {
            name = "Player", ilvls = { [16] = 500 },
        })
        -- Key 15 rewards 655, equipped 500 => delta 155 >> 26
        local _, score = Core:PlayerNeedsItemUpgrade(player, 100, 15)
        assert.are.equal(0.6, score) -- capped at max
    end)
end)

-- ============================================================================
-- #43: ScoreContent with upgrade scoring
-- ============================================================================
describe("ScoreContent with upgrades", function()
    local origLoot, origBIS

    before_each(function()
        resetState()
        origLoot = NS.DUNGEON_LOOT
        origBIS = NS.BIS_MYTHIC
        Core.db.profile.upgradeScoring = true
        _G.C_MythicPlus = {
            GetRewardLevelFromKeystoneLevel = function(keyLevel)
                return 610 + keyLevel * 3
            end,
            GetOwnedKeystoneChallengeMapID = function() return nil end,
            GetOwnedKeystoneLevel = function() return nil end,
        }
        NS.DUNGEON_LOOT = {
            TEST_DUNGEON = {
                { itemId = 100, itemName = "Sword", boss = "Boss A" },
                { itemId = 200, itemName = "Shield", boss = "Boss B" },
            },
        }
    end)

    after_each(function()
        NS.DUNGEON_LOOT = origLoot
        NS.BIS_MYTHIC = origBIS
        stub.resetStubs()
    end)

    it("includes upgrade items in score as fractional value", function()
        NS.BIS_MYTHIC = { WARRIOR_ARMS = { [16] = 100, [17] = 200 } }
        -- Player has item 100 at low ilvl, missing item 200
        NS.groupData = {
            ["Player-Realm"] = makePlayer("WARRIOR_ARMS", { [16] = 100 }, {
                name = "Player", ilvls = { [16] = 620 },
            }),
        }
        local score, details = Core:ScoreContent(
            NS.DUNGEON_LOOT.TEST_DUNGEON, NS.BIS_MYTHIC,
            { targetKeyLevel = 10 }
        )
        -- 1.0 for missing item 200, plus fractional for upgrade on item 100
        assert.is_true(score > 1.0)
        assert.is_true(score < 2.0)
        local pd = details["Player-Realm"]
        assert.are.equal(1, pd.mainSpecCount)
        assert.are.equal(1, pd.upgradeCount)
    end)

    it("missing items score higher than upgradeable items", function()
        NS.BIS_MYTHIC = { WARRIOR_ARMS = { [16] = 100 } }
        -- Player A: missing item entirely
        -- Player B: has item but at low ilvl
        NS.groupData = {
            ["Missing-Realm"] = makePlayer("WARRIOR_ARMS", {}, { name = "Missing" }),
            ["Upgrade-Realm"] = makePlayer("WARRIOR_ARMS", { [16] = 100 }, {
                name = "Upgrade", ilvls = { [16] = 600 },
            }),
        }
        local _, details = Core:ScoreContent(
            NS.DUNGEON_LOOT.TEST_DUNGEON, NS.BIS_MYTHIC,
            { targetKeyLevel = 10 }
        )
        -- Missing should contribute more than upgrade
        local missingScore = details["Missing-Realm"].mainSpecCount
        local upgradeScore = 0
        for _, item in ipairs(details["Upgrade-Realm"].needed) do
            if item.isUpgrade then upgradeScore = upgradeScore + item.upgradeScore end
        end
        assert.is_true(missingScore > upgradeScore)
    end)

    it("does not include upgrades when scoring is disabled", function()
        Core.db.profile.upgradeScoring = false
        NS.BIS_MYTHIC = { WARRIOR_ARMS = { [16] = 100 } }
        NS.groupData = {
            ["Player-Realm"] = makePlayer("WARRIOR_ARMS", { [16] = 100 }, {
                name = "Player", ilvls = { [16] = 600 },
            }),
        }
        local score, details = Core:ScoreContent(
            NS.DUNGEON_LOOT.TEST_DUNGEON, NS.BIS_MYTHIC,
            { targetKeyLevel = 10 }
        )
        assert.are.equal(0, score)
        assert.are.equal(0, details["Player-Realm"].upgradeCount)
    end)
end)

-- ============================================================================
-- #43: GetTargetKeyLevel
-- ============================================================================
describe("GetTargetKeyLevel", function()
    before_each(function()
        resetState()
        NS.CHALLENGE_MODE_MAP = { [2773] = "MAGISTER", [2774] = "MAISARA" }
        _G.C_MythicPlus = {
            GetOwnedKeystoneChallengeMapID = function() return nil end,
            GetOwnedKeystoneLevel = function() return nil end,
        }
    end)
    after_each(stub.resetStubs)

    it("returns saved setting as fallback", function()
        Core.db.profile.targetKeyLevel = 12
        assert.are.equal(12, Core:GetTargetKeyLevel("MAGISTER"))
    end)

    it("returns party keystone level when available", function()
        NS.partyKeystones = {
            ["Friend-Realm"] = { mapID = 2773, level = 15 },
        }
        assert.are.equal(15, Core:GetTargetKeyLevel("MAGISTER"))
    end)

    it("returns fallback when party key is for different dungeon", function()
        Core.db.profile.targetKeyLevel = 8
        NS.partyKeystones = {
            ["Friend-Realm"] = { mapID = 2774, level = 15 },
        }
        assert.are.equal(8, Core:GetTargetKeyLevel("MAGISTER"))
    end)

    it("returns own keystone level for matching dungeon", function()
        _G.C_MythicPlus = {
            GetOwnedKeystoneChallengeMapID = function() return 2773 end,
            GetOwnedKeystoneLevel = function() return 11 end,
        }
        _G.C_ChallengeMode = {
            GetMapUIInfo = function() return "Magisters' Terrace" end,
        }
        assert.are.equal(11, Core:GetTargetKeyLevel("MAGISTER"))
    end)
end)

-- ============================================================================
-- #43: GetRewardIlvlForKey
-- ============================================================================
describe("GetRewardIlvlForKey", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("prefers GetRewardLevelForDifficultyLevel end-of-run ilvl", function()
        _G.C_MythicPlus = {
            GetRewardLevelForDifficultyLevel = function(key)
                return 650 + key * 3, 610 + key * 3  -- weekly, endOfRun
            end,
            GetRewardLevelFromKeystoneLevel = function(key) return 999 end, -- should not be used
        }
        assert.are.equal(640, Core:GetRewardIlvlForKey(10)) -- endOfRun value
    end)

    it("falls back to GetRewardLevelFromKeystoneLevel", function()
        _G.C_MythicPlus = {
            GetRewardLevelFromKeystoneLevel = function(key) return 610 + key * 3 end,
        }
        assert.are.equal(640, Core:GetRewardIlvlForKey(10))
    end)

    it("returns nil when API unavailable", function()
        _G.C_MythicPlus = nil
        assert.is_nil(Core:GetRewardIlvlForKey(10))
    end)
end)
