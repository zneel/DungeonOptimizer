-- ============================================================================
-- Tests for Data.lua: BIS tables, slot constants, helper functions
-- ============================================================================

local stub = require("tests.wow_stub")
local NS = stub.NS

stub.loadAddonFile("Locales.lua")
stub.loadAddonFile("Data.lua")

-- ============================================================================
-- SLOT_IDS
-- ============================================================================
describe("SLOT_IDS", function()
    it("defines all 17 equipment slot IDs", function()
        local expected = {
            HEAD = 1, NECK = 2, SHOULDER = 3, BACK = 15, CHEST = 5,
            WRIST = 9, HANDS = 10, WAIST = 6, LEGS = 7, FEET = 8,
            FINGER1 = 11, FINGER2 = 12, TRINKET1 = 13, TRINKET2 = 14,
            MAINHAND = 16, OFFHAND = 17,
        }
        for name, id in pairs(expected) do
            assert.are.equal(id, NS.SLOT_IDS[name])
        end
    end)

    it("has exactly 16 entries (no shirt slot)", function()
        local count = 0
        for _ in pairs(NS.SLOT_IDS) do count = count + 1 end
        assert.are.equal(16, count)
    end)
end)

-- ============================================================================
-- SLOT_NAMES (metatable-based locale lookup)
-- ============================================================================
describe("SLOT_NAMES", function()
    it("returns locale string for known slots", function()
        -- NS.L should have SLOT_HEAD etc.
        local name = NS.SLOT_NAMES[1]
        assert.is_string(name)
    end)

    it("returns fallback for unknown slot", function()
        local name = NS.SLOT_NAMES[99]
        assert.are.equal("Slot 99", name)
    end)
end)

-- ============================================================================
-- BIS_MYTHIC
-- ============================================================================
describe("BIS_MYTHIC", function()
    it("exists and is a table", function()
        assert.is_table(NS.BIS_MYTHIC)
    end)

    local ALL_SPECS = {
        "DEATHKNIGHT_BLOOD", "DEATHKNIGHT_FROST", "DEATHKNIGHT_UNHOLY",
        "DEMONHUNTER_HAVOC", "DEMONHUNTER_VENGEANCE",
        "DRUID_BALANCE", "DRUID_FERAL", "DRUID_GUARDIAN", "DRUID_RESTORATION",
        "EVOKER_AUGMENTATION", "EVOKER_DEVASTATION", "EVOKER_PRESERVATION",
        "HUNTER_BEASTMASTERY", "HUNTER_MARKSMANSHIP", "HUNTER_SURVIVAL",
        "MAGE_ARCANE", "MAGE_FIRE", "MAGE_FROST",
        "MONK_BREWMASTER", "MONK_MISTWEAVER", "MONK_WINDWALKER",
        "PALADIN_HOLY", "PALADIN_PROTECTION", "PALADIN_RETRIBUTION",
        "PRIEST_DISCIPLINE", "PRIEST_HOLY", "PRIEST_SHADOW",
        "ROGUE_ASSASSINATION", "ROGUE_OUTLAW", "ROGUE_SUBTLETY",
        "SHAMAN_ELEMENTAL", "SHAMAN_ENHANCEMENT", "SHAMAN_RESTORATION",
        "WARLOCK_AFFLICTION", "WARLOCK_DEMONOLOGY", "WARLOCK_DESTRUCTION",
        "WARRIOR_ARMS", "WARRIOR_FURY", "WARRIOR_PROTECTION",
    }

    it("has entries for all standard specs", function()
        for _, spec in ipairs(ALL_SPECS) do
            assert.is_table(NS.BIS_MYTHIC[spec], "Missing BIS_MYTHIC[" .. spec .. "]")
        end
    end)

    it("each spec BIS list uses valid numeric slot IDs as keys", function()
        local validSlots = {}
        for _, id in pairs(NS.SLOT_IDS) do validSlots[id] = true end

        for spec, bisList in pairs(NS.BIS_MYTHIC) do
            for slot, itemId in pairs(bisList) do
                assert.is_number(slot, spec .. " has non-numeric slot key: " .. tostring(slot))
                assert.is_true(validSlots[slot], spec .. " has invalid slot ID: " .. tostring(slot))
                assert.is_number(itemId, spec .. "[" .. slot .. "] has non-numeric item ID")
            end
        end
    end)

    it("every spec has at least a weapon (slot 16)", function()
        for _, spec in ipairs(ALL_SPECS) do
            assert.is_not_nil(NS.BIS_MYTHIC[spec][16],
                spec .. " missing MAINHAND (slot 16)")
        end
    end)

    -- Regression: DRUID_RESTORATION was missing slots 12 and 14
    it("DRUID_RESTORATION has both ring slots (11 and 12)", function()
        local resto = NS.BIS_MYTHIC["DRUID_RESTORATION"]
        assert.is_not_nil(resto[11], "DRUID_RESTORATION missing slot 11")
        assert.is_not_nil(resto[12], "DRUID_RESTORATION missing slot 12")
    end)

    it("DRUID_RESTORATION has both trinket slots (13 and 14)", function()
        local resto = NS.BIS_MYTHIC["DRUID_RESTORATION"]
        assert.is_not_nil(resto[13], "DRUID_RESTORATION missing slot 13")
        assert.is_not_nil(resto[14], "DRUID_RESTORATION missing slot 14")
    end)
end)

-- ============================================================================
-- BIS_RAID
-- ============================================================================
describe("BIS_RAID", function()
    it("exists and is a table", function()
        assert.is_table(NS.BIS_RAID)
    end)

    -- Regression: a second NS.BIS_RAID = {} was overwriting real data
    it("is not empty (not overwritten by double definition)", function()
        local hasData = false
        for _, bisList in pairs(NS.BIS_RAID) do
            if next(bisList) then hasData = true; break end
        end
        assert.is_true(hasData, "BIS_RAID has no data")
    end)

    it("PALADIN_PROTECTION has raid BIS items", function()
        local prot = NS.BIS_RAID["PALADIN_PROTECTION"]
        assert.is_table(prot)
        assert.is_true(next(prot) ~= nil)
    end)

    it("SHAMAN_ELEMENTAL has raid BIS items", function()
        local ele = NS.BIS_RAID["SHAMAN_ELEMENTAL"]
        assert.is_table(ele)
        assert.is_true(next(ele) ~= nil)
    end)

    it("WARRIOR_FURY has raid BIS items", function()
        local fury = NS.BIS_RAID["WARRIOR_FURY"]
        assert.is_table(fury)
        assert.is_true(next(fury) ~= nil)
    end)

    it("uses valid numeric slot IDs", function()
        local validSlots = {}
        for _, id in pairs(NS.SLOT_IDS) do validSlots[id] = true end
        for spec, bisList in pairs(NS.BIS_RAID) do
            for slot, itemId in pairs(bisList) do
                assert.is_number(slot, spec .. " raid BIS has non-numeric slot")
                assert.is_true(validSlots[slot], spec .. " raid BIS has invalid slot " .. tostring(slot))
            end
        end
    end)
end)

-- ============================================================================
-- DUNGEON_LOOT
-- ============================================================================
describe("DUNGEON_LOOT", function()
    it("exists and is a table", function()
        assert.is_table(NS.DUNGEON_LOOT)
    end)

    it("has at least one dungeon", function()
        assert.is_true(next(NS.DUNGEON_LOOT) ~= nil)
    end)

    it("each dungeon has drops with required fields", function()
        for dungeonId, drops in pairs(NS.DUNGEON_LOOT) do
            assert.is_table(drops)
            for i, drop in ipairs(drops) do
                assert.is_number(drop.itemId, dungeonId .. " drop #" .. i .. " missing itemId")
            end
        end
    end)
end)

-- ============================================================================
-- RAID_LOOT
-- ============================================================================
describe("RAID_LOOT", function()
    it("exists and is a table", function()
        assert.is_table(NS.RAID_LOOT)
    end)
end)

-- ============================================================================
-- DUNGEONS
-- ============================================================================
describe("DUNGEONS", function()
    it("exists and each dungeon has id and name", function()
        assert.is_table(NS.DUNGEONS)
        for i, dungeon in ipairs(NS.DUNGEONS) do
            assert.is_string(dungeon.id, "DUNGEONS[" .. i .. "] missing id")
            assert.is_string(dungeon.name, "DUNGEONS[" .. i .. "] missing name")
        end
    end)

    it("has at least one dungeon", function()
        assert.is_true(#NS.DUNGEONS > 0)
    end)
end)

-- ============================================================================
-- RAIDS
-- ============================================================================
describe("RAIDS", function()
    it("exists and each raid has id and name", function()
        assert.is_table(NS.RAIDS)
        for i, raid in ipairs(NS.RAIDS) do
            assert.is_string(raid.id, "RAIDS[" .. i .. "] missing id")
            assert.is_string(raid.name, "RAIDS[" .. i .. "] missing name")
        end
    end)
end)

-- ============================================================================
-- TIER_SET_SLOTS
-- ============================================================================
describe("TIER_SET_SLOTS", function()
    it("has exactly 5 tier set slots", function()
        assert.are.equal(5, #NS.TIER_SET_SLOTS)
    end)

    it("contains head, shoulders, chest, hands, legs", function()
        local expected = { [1] = true, [3] = true, [5] = true, [10] = true, [7] = true }
        for _, slotId in ipairs(NS.TIER_SET_SLOTS) do
            assert.is_true(expected[slotId], "Unexpected tier slot: " .. slotId)
        end
    end)
end)

-- ============================================================================
-- SPEC_MAP
-- ============================================================================
describe("SPEC_MAP", function()
    it("exists and maps specIDs to spec keys", function()
        assert.is_table(NS.SPEC_MAP)
        for specID, specKey in pairs(NS.SPEC_MAP) do
            assert.is_number(specID)
            assert.is_string(specKey)
            assert.is_truthy(specKey:match("^%u+_%u+$"), specKey .. " doesn't match expected pattern")
        end
    end)
end)

-- ============================================================================
-- GetSpecShortName
-- ============================================================================
describe("GetSpecShortName", function()
    it("extracts and title-cases the suffix", function()
        assert.are.equal("Fury", NS.GetSpecShortName("WARRIOR_FURY"))
        assert.are.equal("Beastmastery", NS.GetSpecShortName("HUNTER_BEASTMASTERY"))
        assert.are.equal("Blood", NS.GetSpecShortName("DEATHKNIGHT_BLOOD"))
    end)

    it("returns the key as-is if no underscore", function()
        assert.are.equal("UNKNOWN", NS.GetSpecShortName("UNKNOWN"))
    end)

    it("returns nil for nil input", function()
        assert.is_nil(NS.GetSpecShortName(nil))
    end)
end)

-- ============================================================================
-- ITEM_TO_DUNGEONS / ITEM_TO_RAIDS indexes
-- ============================================================================
describe("ITEM_TO_DUNGEONS", function()
    it("is built from DUNGEON_LOOT", function()
        assert.is_table(NS.ITEM_TO_DUNGEONS)
        -- Every loot item should have an entry
        for dungeonKey, drops in pairs(NS.DUNGEON_LOOT) do
            for _, drop in ipairs(drops) do
                assert.is_table(NS.ITEM_TO_DUNGEONS[drop.itemId],
                    "Item " .. drop.itemId .. " from " .. dungeonKey .. " not in index")
            end
        end
    end)

    it("maps items to their source dungeons", function()
        -- Pick first item from first dungeon
        for dungeonKey, drops in pairs(NS.DUNGEON_LOOT) do
            if #drops > 0 then
                local dungeons = NS.ITEM_TO_DUNGEONS[drops[1].itemId]
                assert.is_table(dungeons)
                local found = false
                for _, dk in ipairs(dungeons) do
                    if dk == dungeonKey then found = true; break end
                end
                assert.is_true(found, "Item not mapped back to its dungeon")
                break
            end
        end
    end)
end)

-- ============================================================================
-- IsFromDungeon / IsFromRaid / IsFromContent
-- ============================================================================
describe("IsFromDungeon", function()
    it("returns true for a dungeon item", function()
        for _, drops in pairs(NS.DUNGEON_LOOT) do
            if #drops > 0 then
                assert.is_true(NS.IsFromDungeon(drops[1].itemId))
                break
            end
        end
    end)

    it("returns false for a bogus item ID", function()
        assert.is_false(NS.IsFromDungeon(999999999))
    end)
end)

describe("IsFromRaid", function()
    it("returns false for a bogus item ID", function()
        assert.is_false(NS.IsFromRaid(999999999))
    end)
end)

describe("IsFromContent", function()
    it("returns true for dungeon items", function()
        for _, drops in pairs(NS.DUNGEON_LOOT) do
            if #drops > 0 then
                assert.is_true(NS.IsFromContent(drops[1].itemId))
                break
            end
        end
    end)

    it("returns false for a bogus item ID", function()
        assert.is_false(NS.IsFromContent(999999999))
    end)
end)

-- ============================================================================
-- CLASS_SPECS
-- ============================================================================
describe("CLASS_SPECS", function()
    it("exists and has entries for all classes", function()
        assert.is_table(NS.CLASS_SPECS)
        local classes = {
            "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST",
            "DEATHKNIGHT", "SHAMAN", "MAGE", "WARLOCK", "MONK",
            "DRUID", "DEMONHUNTER", "EVOKER",
        }
        for _, class in ipairs(classes) do
            assert.is_table(NS.CLASS_SPECS[class], "Missing CLASS_SPECS[" .. class .. "]")
            assert.is_true(#NS.CLASS_SPECS[class] > 0, class .. " has no specs")
        end
    end)
end)
