-- ============================================================================
-- Tests for Upgrade Roadmap: data tables, scoring, action generation
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

local function resetState()
    stub.resetStubs()
    wipe(NS.groupCompletions)
    wipe(NS.groupData)
    wipe(NS.partyKeystones)
    wipe(NS.groupCatalyst)
    NS.lastRoadmap = nil
    NS.UI = nil
    Core.db = {
        profile = {
            minimap = { hide = false },
            excludedDungeons = {},
            showTooltips = true,
            weightByScore = false,
            upgradeScoring = true,
            targetKeyLevel = 10,
            offSpec = nil,
            activeTab = "mplus",
            activeMode = "mplus",
            gearWeight = 0.6,
            rioWeight = 0.4,
            rioIlvlFactor = 0.15,
        },
    }
end

-- ============================================================================
-- DATA TABLES
-- ============================================================================
describe("Roadmap Data Tables", function()
    it("has CREST_TYPES with all four tiers", function()
        assert.is_not_nil(NS.CREST_TYPES.WEATHERED)
        assert.is_not_nil(NS.CREST_TYPES.CARVED)
        assert.is_not_nil(NS.CREST_TYPES.RUNED)
        assert.is_not_nil(NS.CREST_TYPES.GILDED)
    end)

    it("has CREST_ORDER with 4 entries", function()
        assert.are.equal(4, #NS.CREST_ORDER)
        assert.are.equal("WEATHERED", NS.CREST_ORDER[1])
        assert.are.equal("GILDED", NS.CREST_ORDER[4])
    end)

    it("has UPGRADE_TRACKS with 6 tiers", function()
        assert.are.equal(6, #NS.TRACK_ORDER)
        assert.is_not_nil(NS.UPGRADE_TRACKS.EXPLORER)
        assert.is_not_nil(NS.UPGRADE_TRACKS.MYTH)
    end)

    it("tracks have ascending ilvl ranges", function()
        local prevMax = 0
        for _, name in ipairs(NS.TRACK_ORDER) do
            local track = NS.UPGRADE_TRACKS[name]
            assert.is_true(track.base >= prevMax,
                name .. " base should be >= previous max")
            assert.is_true(track.max > track.base,
                name .. " max should be > base")
            prevMax = track.max
        end
    end)

    it("has CREST_COSTS for all 16 gear slots", function()
        for _, slotId in ipairs(NS.SLOT_DISPLAY_ORDER) do
            assert.is_not_nil(NS.CREST_COSTS[slotId],
                "Missing CREST_COSTS for slot " .. slotId)
        end
    end)

    it("has ACTION_TYPES constants", function()
        assert.are.equal("dungeon", NS.ACTION_TYPES.DUNGEON_DROP)
        assert.are.equal("craft", NS.ACTION_TYPES.CRAFT_ITEM)
        assert.are.equal("upgrade", NS.ACTION_TYPES.UPGRADE_ITEM)
        assert.are.equal("rio", NS.ACTION_TYPES.RIO_PUSH)
    end)

    it("has PAIRED_SLOTS for rings and trinkets", function()
        assert.are.equal(12, NS.PAIRED_SLOTS[11])
        assert.are.equal(11, NS.PAIRED_SLOTS[12])
        assert.are.equal(14, NS.PAIRED_SLOTS[13])
        assert.are.equal(13, NS.PAIRED_SLOTS[14])
    end)

    it("has CRAFTABLE_BIS for warrior specs", function()
        assert.is_not_nil(NS.CRAFTABLE_BIS.WARRIOR_FURY)
        assert.is_true(#NS.CRAFTABLE_BIS.WARRIOR_FURY > 0)
    end)
end)

-- ============================================================================
-- INFER UPGRADE TRACK
-- ============================================================================
describe("InferUpgradeTrack", function()
    before_each(resetState)

    it("identifies Explorer track", function()
        local track, level, max, remaining = Core:InferUpgradeTrack(558)
        assert.are.equal("EXPLORER", track)
        assert.are.equal(1, level)
        assert.are.equal(8, max)
        assert.are.equal(7, remaining)
    end)

    it("identifies Hero track mid-level", function()
        local track, level, max, remaining = Core:InferUpgradeTrack(616)
        assert.are.equal("HERO", track)
        assert.is_true(level > 1)
        assert.are.equal(6, max)
    end)

    it("identifies Myth track at max", function()
        local track, level, max, remaining = Core:InferUpgradeTrack(639)
        assert.are.equal("MYTH", track)
        assert.are.equal(4, level)
        assert.are.equal(0, remaining)
    end)

    it("handles above max ilvl", function()
        local track, level, max, remaining = Core:InferUpgradeTrack(650)
        assert.are.equal("MYTH", track)
        assert.are.equal(0, remaining)
    end)

    it("returns nil for zero ilvl", function()
        local track = Core:InferUpgradeTrack(0)
        assert.is_nil(track)
    end)

    it("returns nil for nil ilvl", function()
        local track = Core:InferUpgradeTrack(nil)
        assert.is_nil(track)
    end)
end)

-- ============================================================================
-- CURRENCY READING
-- ============================================================================
describe("GetCrestBudget", function()
    before_each(resetState)

    it("returns zeros when API unavailable", function()
        _G.C_CurrencyInfo = nil
        local budget = Core:GetCrestBudget()
        assert.are.equal(0, budget.WEATHERED)
        assert.are.equal(0, budget.GILDED)
    end)

    it("reads currency from API", function()
        _G.C_CurrencyInfo = {
            GetCurrencyInfo = function(id)
                if id == NS.CREST_TYPES.GILDED.id then
                    return { quantity = 45 }
                end
                return { quantity = 0 }
            end,
        }
        local budget = Core:GetCrestBudget()
        assert.are.equal(45, budget.GILDED)
        assert.are.equal(0, budget.WEATHERED)
    end)
end)

describe("GetSparkCount", function()
    before_each(resetState)

    it("returns 0 when API unavailable", function()
        _G.C_CurrencyInfo = nil
        assert.are.equal(0, Core:GetSparkCount())
    end)

    it("reads spark currency", function()
        _G.C_CurrencyInfo = {
            GetCurrencyInfo = function(id)
                if id == NS.SPARK_CURRENCY_ID then
                    return { quantity = 2 }
                end
                return { quantity = 0 }
            end,
        }
        assert.are.equal(2, Core:GetSparkCount())
    end)
end)

-- ============================================================================
-- SCORE ACTION
-- ============================================================================
describe("ScoreRoadmapAction", function()
    before_each(resetState)

    it("scores DUNGEON_DROP at 50% of ilvl gain", function()
        local action = { actionType = NS.ACTION_TYPES.DUNGEON_DROP, ilvlGain = 20 }
        local score = Core:ScoreRoadmapAction(action, {})
        assert.are.equal(10, score)
    end)

    it("scores CRAFT_ITEM at 90% of ilvl gain", function()
        local action = { actionType = NS.ACTION_TYPES.CRAFT_ITEM, ilvlGain = 20 }
        local score = Core:ScoreRoadmapAction(action, {})
        assert.is_true(math.abs(score - 18) < 0.01)
    end)

    it("scores UPGRADE_ITEM with affordability factor", function()
        local budget = { GILDED = 200 }
        local action = {
            actionType = NS.ACTION_TYPES.UPGRADE_ITEM,
            ilvlGain = 10,
            crestType = "GILDED",
            crestCost = 60,
        }
        local score = Core:ScoreRoadmapAction(action, budget)
        -- factor = 1.0 - (60/200) = 0.7, score = 10 * 0.7 = 7
        assert.is_true(math.abs(score - 7) < 0.01)
    end)

    it("caps UPGRADE_ITEM factor to 0.2 when no crests", function()
        local budget = { GILDED = 0 }
        local action = {
            actionType = NS.ACTION_TYPES.UPGRADE_ITEM,
            ilvlGain = 10,
            crestType = "GILDED",
            crestCost = 60,
        }
        local score = Core:ScoreRoadmapAction(action, budget)
        assert.is_true(math.abs(score - 2) < 0.01)
    end)

    it("scores RIO_PUSH using rioIlvlFactor", function()
        local action = { actionType = NS.ACTION_TYPES.RIO_PUSH, rioDelta = 40 }
        local score = Core:ScoreRoadmapAction(action, {})
        -- 40 * 0.15 = 6
        assert.is_true(math.abs(score - 6) < 0.01)
    end)
end)

-- ============================================================================
-- COMPUTE UPGRADE ROADMAP
-- ============================================================================
describe("ComputeUpgradeRoadmap", function()
    before_each(function()
        resetState()
        -- Mock player with Warrior Fury spec — mostly geared with BIS items
        -- BIS_MYTHIC WARRIOR_FURY: 16=251117, 17=237847, 15=260312, 1=251098, etc.
        local bisList = NS.BIS_MYTHIC.WARRIOR_FURY
        -- Give the player BIS in ALL slots, with ilvls that have upgrade room
        local gear = {}
        local ilvls = {}
        for slotId, bisItemId in pairs(bisList) do
            gear[slotId] = bisItemId
            ilvls[slotId] = 612  -- Hero track level 2, has 4 upgrades remaining
        end
        -- Make one slot NOT BIS to test dungeon drop action
        gear[1] = 999999
        ilvls[1] = 580

        NS.groupData["Test-TestRealm"] = makePlayer("WARRIOR_FURY", gear, {
            name = "Test",
            ilvls = ilvls,
        })

        -- Mock Inspect to return our player name
        NS.Inspect.GetUnitFullName = function(_, unit)
            if unit == "player" then return "Test-TestRealm" end
            return nil
        end

        -- No dynamic dungeons or C_MythicPlus (simplify)
        NS.DYNAMIC_DUNGEONS = nil
        _G.C_CurrencyInfo = {
            GetCurrencyInfo = function() return { quantity = 0 } end,
        }
    end)

    it("returns a table of actions", function()
        local roadmap = Core:ComputeUpgradeRoadmap()
        assert.is_table(roadmap)
    end)

    it("generates UPGRADE_ITEM for BIS items with upgrades remaining", function()
        local roadmap = Core:ComputeUpgradeRoadmap()
        local found = false
        for _, action in ipairs(roadmap) do
            if action.actionType == NS.ACTION_TYPES.UPGRADE_ITEM then
                found = true
                assert.is_true(action.ilvlGain > 0)
                break
            end
        end
        assert.is_true(found, "Should find at least one UPGRADE_ITEM action")
    end)

    it("generates CRAFT_ITEM when sparks available and slot is non-BIS", function()
        -- Remove BIS from craftable slot 17 so CRAFT_ITEM fires
        NS.groupData["Test-TestRealm"].gear[17] = 999999
        NS.groupData["Test-TestRealm"].ilvls[17] = 580
        _G.C_CurrencyInfo = {
            GetCurrencyInfo = function(id)
                if id == NS.SPARK_CURRENCY_ID then return { quantity = 1 } end
                return { quantity = 100 }
            end,
        }
        local roadmap = Core:ComputeUpgradeRoadmap()
        local found = false
        for _, action in ipairs(roadmap) do
            if action.actionType == NS.ACTION_TYPES.CRAFT_ITEM then
                found = true
            end
        end
        assert.is_true(found, "Should find CRAFT_ITEM when sparks > 0 and slot is non-BIS")
    end)

    it("does not generate CRAFT_ITEM when no sparks", function()
        _G.C_CurrencyInfo = {
            GetCurrencyInfo = function() return { quantity = 0 } end,
        }
        local roadmap = Core:ComputeUpgradeRoadmap()
        for _, action in ipairs(roadmap) do
            assert.are_not.equal(NS.ACTION_TYPES.CRAFT_ITEM, action.actionType)
        end
    end)

    it("returns empty for missing player", function()
        NS.Inspect.GetUnitFullName = function() return nil end
        local roadmap = Core:ComputeUpgradeRoadmap()
        assert.are.equal(0, #roadmap)
    end)

    it("returns at most 10 actions", function()
        -- All slots non-BIS to generate many actions
        local gear = {}
        local ilvls = {}
        for _, slotId in ipairs(NS.SLOT_DISPLAY_ORDER) do
            gear[slotId] = 999999
            ilvls[slotId] = 580
        end
        NS.groupData["Test-TestRealm"] = makePlayer("WARRIOR_FURY", gear, {
            name = "Test", ilvls = ilvls,
        })

        local roadmap = Core:ComputeUpgradeRoadmap()
        assert.is_true(#roadmap <= 10)
    end)

    it("sorts actions by score descending", function()
        local roadmap = Core:ComputeUpgradeRoadmap()
        if #roadmap >= 2 then
            for i = 2, #roadmap do
                assert.is_true(roadmap[i - 1].score >= roadmap[i].score,
                    string.format("Action %d (%.2f) should be >= action %d (%.2f)",
                        i - 1, roadmap[i - 1].score, i, roadmap[i].score))
            end
        end
    end)
end)

-- ============================================================================
-- SLOT DETAILS
-- ============================================================================
describe("GetSlotDetails", function()
    before_each(function()
        resetState()
        NS.groupData["Test-TestRealm"] = makePlayer("WARRIOR_FURY", {
            [16] = 251117,  -- BIS mainhand (BIS_MYTHIC)
            [15] = 999999,  -- not BIS
        }, {
            name = "Test",
            ilvls = { [16] = 620, [15] = 590 },
        })
        NS.Inspect.GetUnitFullName = function(_, unit)
            if unit == "player" then return "Test-TestRealm" end
            return nil
        end
    end)

    it("returns slot details for all BIS slots", function()
        local slots = Core:GetSlotDetails()
        assert.is_true(#slots > 0)
    end)

    it("marks BIS items as hasBIS", function()
        local slots = Core:GetSlotDetails()
        local mainhand = nil
        for _, slot in ipairs(slots) do
            if slot.slotId == 16 then mainhand = slot end
        end
        assert.is_not_nil(mainhand)
        assert.is_true(mainhand.hasBIS)
    end)

    it("marks non-BIS items as not hasBIS", function()
        local slots = Core:GetSlotDetails()
        local back = nil
        for _, slot in ipairs(slots) do
            if slot.slotId == 15 then back = slot end
        end
        assert.is_not_nil(back)
        assert.is_false(back.hasBIS)
    end)

    it("includes track info for items with ilvl", function()
        local slots = Core:GetSlotDetails()
        local mainhand = nil
        for _, slot in ipairs(slots) do
            if slot.slotId == 16 then mainhand = slot end
        end
        assert.is_not_nil(mainhand)
        assert.is_not_nil(mainhand.trackName)
        assert.is_not_nil(mainhand.currentLevel)
    end)
end)
