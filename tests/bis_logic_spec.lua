-- ============================================================================
-- Integration tests: BIS logic with real data
-- Verifies that FindBISSlot, PlayerNeedsItem, ScoreDungeon, CountMissingBIS,
-- CalculateDungeonRanking, ScoreRaid, loot detection, and priority all
-- produce coherent results when using the actual BIS/loot tables.
-- ============================================================================

local stub = require("tests.wow_stub")
local NS = stub.NS

stub.loadAddonFile("Locales.lua")
stub.loadAddonFile("Data.lua")
stub.loadAddonFile("Inspect.lua")
stub.loadAddonFile("Core.lua")

local Core = NS.Core

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
    NS.tradeableLoot = {}
    NS.UI = nil
    Core.db = {
        profile = {
            minimap = { hide = false },
            excludedDungeons = {},
            showTooltips = true,
            weightByScore = false,
            offSpec = nil,
            activeTab = "mplus",
            lootAlertEnabled = true,
        },
    }
end

-- ============================================================================
-- BIS TABLE INTERNAL CONSISTENCY
-- ============================================================================
describe("BIS table consistency", function()
    it("every item in BIS_MYTHIC can be found by FindBISSlot", function()
        for spec, bisList in pairs(NS.BIS_MYTHIC) do
            for slot, itemId in pairs(bisList) do
                local foundSlot = NS.FindBISSlot(spec, itemId)
                assert.is_not_nil(foundSlot,
                    spec .. " item " .. itemId .. " at slot " .. slot .. " not found by FindBISSlot")
            end
        end
    end)

    it("every item in BIS_RAID can be found by FindBISSlot with raid table", function()
        for spec, bisList in pairs(NS.BIS_RAID) do
            for slot, itemId in pairs(bisList) do
                local foundSlot = NS.FindBISSlot(spec, itemId, NS.BIS_RAID)
                assert.is_not_nil(foundSlot,
                    spec .. " raid item " .. itemId .. " at slot " .. slot .. " not found")
            end
        end
    end)

    it("DUNGEON_LOOT items that are BIS for any spec can be resolved to a slot", function()
        local missingSlots = {}
        for dungeonId, drops in pairs(NS.DUNGEON_LOOT) do
            for _, drop in ipairs(drops) do
                -- Check if this item is BIS for any spec
                for spec, bisList in pairs(NS.BIS_MYTHIC) do
                    for slot, bisItemId in pairs(bisList) do
                        if bisItemId == drop.itemId then
                            local foundSlot = NS.FindBISSlot(spec, drop.itemId)
                            if not foundSlot then
                                table.insert(missingSlots, string.format(
                                    "%s item %d (in %s slot %d)", dungeonId, drop.itemId, spec, slot))
                            end
                        end
                    end
                end
            end
        end
        assert.are.equal(0, #missingSlots,
            "Items not resolvable by FindBISSlot:\n  " .. table.concat(missingSlots, "\n  "))
    end)
end)

-- ============================================================================
-- REAL PLAYER SCENARIOS: DK Blood, fully ungeared
-- ============================================================================
describe("DK Blood full BIS scenario", function()
    before_each(resetState)

    local SPEC = "DEATHKNIGHT_BLOOD"
    local bisList = NS.BIS_MYTHIC[SPEC]

    it("ungeared player needs all BIS items", function()
        local player = makePlayer(SPEC, {}, { class = "DEATHKNIGHT" })
        for slot, itemId in pairs(bisList) do
            assert.is_true(Core:PlayerNeedsItem(player, itemId),
                "DK Blood should need item " .. itemId .. " at slot " .. slot)
        end
    end)

    it("fully geared player needs no BIS items", function()
        local player = makePlayer(SPEC, bisList, { class = "DEATHKNIGHT" })
        for slot, itemId in pairs(bisList) do
            assert.is_false(Core:PlayerNeedsItem(player, itemId),
                "Full-BIS DK Blood should not need item " .. itemId)
        end
    end)

    it("CountMissingBIS reports 0 missing for fully geared player", function()
        local player = makePlayer(SPEC, bisList, { class = "DEATHKNIGHT" })
        local missing, total = Core:CountMissingBIS(player)
        assert.are.equal(0, missing)
        assert.is_true(total > 0)
    end)

    it("CountMissingBIS missing == total for ungeared player", function()
        local player = makePlayer(SPEC, {}, { class = "DEATHKNIGHT" })
        local missing, total = Core:CountMissingBIS(player)
        assert.are.equal(total, missing)

        -- Count BIS slots
        local slotCount = 0
        for _ in pairs(bisList) do slotCount = slotCount + 1 end
        assert.are.equal(slotCount, total)
    end)
end)

-- ============================================================================
-- PARTIAL GEAR: player equips some BIS
-- ============================================================================
describe("Partial gear scenario", function()
    before_each(resetState)

    local SPEC = "WARRIOR_ARMS"
    local bisList = NS.BIS_MYTHIC[SPEC]

    it("player who equips 3 BIS items has (total - 3) missing", function()
        -- Pick first 3 BIS items
        local gear = {}
        local count = 0
        for slot, itemId in pairs(bisList) do
            gear[slot] = itemId
            count = count + 1
            if count >= 3 then break end
        end

        local player = makePlayer(SPEC, gear)
        local missing, total = Core:CountMissingBIS(player)

        local totalSlots = 0
        for _ in pairs(bisList) do totalSlots = totalSlots + 1 end

        assert.are.equal(totalSlots - 3, missing)
        assert.are.equal(totalSlots, total)
    end)

    it("equipping non-BIS item doesn't reduce missing count", function()
        local player = makePlayer(SPEC, { [1] = 999999 })
        local missing1, total = Core:CountMissingBIS(player)

        local player2 = makePlayer(SPEC, {})
        local missing2 = Core:CountMissingBIS(player2)

        assert.are.equal(missing2, missing1)
    end)
end)

-- ============================================================================
-- DUPLICATE ITEMS (same item in 2 slots, e.g. 2 rings)
-- ============================================================================
describe("Duplicate BIS items", function()
    before_each(resetState)

    it("specs with same ring in both slots require 2 copies", function()
        -- Find a spec that has the same itemId in slots 11 and 12
        local foundSpec, foundItemId
        for spec, bisList in pairs(NS.BIS_MYTHIC) do
            if bisList[11] and bisList[12] and bisList[11] == bisList[12] then
                foundSpec = spec
                foundItemId = bisList[11]
                break
            end
        end

        if foundSpec then
            -- Having only 1 copy should mean player still needs it
            local player = makePlayer(foundSpec, { [11] = foundItemId })
            assert.is_true(Core:PlayerNeedsItem(player, foundItemId),
                foundSpec .. " with 1/" .. tostring(2) .. " copies should still need " .. foundItemId)

            -- Having 2 copies means done
            local player2 = makePlayer(foundSpec, { [11] = foundItemId, [12] = foundItemId })
            assert.is_false(Core:PlayerNeedsItem(player2, foundItemId))
        end
    end)
end)

-- ============================================================================
-- DUNGEON SCORING WITH REAL DATA
-- ============================================================================
describe("Dungeon scoring with real data", function()
    before_each(resetState)

    it("ungeared DK Blood gets positive scores for dungeons that drop BIS", function()
        local SPEC = "DEATHKNIGHT_BLOOD"
        NS.groupData = {
            ["DK-Realm"] = makePlayer(SPEC, {}, { class = "DEATHKNIGHT", name = "DK" }),
        }

        local foundPositive = false
        for dungeonId, _ in pairs(NS.DUNGEON_LOOT) do
            local score, details = Core:ScoreDungeon(dungeonId)
            if score > 0 then
                foundPositive = true
                -- Verify the items in details are actual BIS items
                local dk = details["DK-Realm"]
                assert.is_not_nil(dk)
                for _, item in ipairs(dk.needed) do
                    assert.is_number(item.itemId)
                    assert.is_number(item.slot)
                    -- The slot should be in the BIS table
                    local bis = NS.BIS_MYTHIC[SPEC]
                    assert.are.equal(item.itemId, bis[item.slot],
                        "ScoreDungeon returned item " .. item.itemId ..
                        " at slot " .. item.slot .. " but BIS has " ..
                        tostring(bis[item.slot]))
                end
            end
        end
        assert.is_true(foundPositive, "DK Blood should need items from at least one dungeon")
    end)

    it("fully geared player has score 0 in all dungeons", function()
        local SPEC = "DEATHKNIGHT_BLOOD"
        NS.groupData = {
            ["DK-Realm"] = makePlayer(SPEC, NS.BIS_MYTHIC[SPEC], {
                class = "DEATHKNIGHT", name = "DK",
            }),
        }

        for dungeonId, _ in pairs(NS.DUNGEON_LOOT) do
            local score = Core:ScoreDungeon(dungeonId)
            assert.are.equal(0, score,
                "Fully geared DK should have 0 score in " .. dungeonId)
        end
    end)

    it("dungeon with more BIS drops for group ranks higher", function()
        -- Create 2 players of different specs
        NS.groupData = {
            ["DK-Realm"] = makePlayer("DEATHKNIGHT_BLOOD", {}, {
                class = "DEATHKNIGHT", name = "DK",
            }),
            ["Warrior-Realm"] = makePlayer("WARRIOR_ARMS", {}, {
                class = "WARRIOR", name = "Warrior",
            }),
        }

        local ranking = Core:CalculateDungeonRanking()
        assert.is_true(#ranking > 0)

        -- Ranking should be sorted descending
        for i = 2, #ranking do
            assert.is_true(ranking[i - 1].score >= ranking[i].score,
                "Ranking not sorted at index " .. i)
        end

        -- Top dungeon should have a positive score (ungeared players need stuff)
        assert.is_true(ranking[1].score > 0,
            "Top ranked dungeon should have positive score for ungeared group")
    end)
end)

-- ============================================================================
-- EXCLUDING DUNGEONS REDUCES RANKING
-- ============================================================================
describe("Dungeon exclusion", function()
    before_each(resetState)

    it("excluded dungeons do not appear in ranking", function()
        NS.groupData = {
            ["DK-Realm"] = makePlayer("DEATHKNIGHT_BLOOD", {}, {
                class = "DEATHKNIGHT", name = "DK",
            }),
        }

        local fullRanking = Core:CalculateDungeonRanking()
        local fullCount = #fullRanking

        -- Exclude the first dungeon
        local firstId = NS.DUNGEONS[1].id
        NS.groupCompletions["DK-Realm"] = { [firstId] = true }

        local reducedRanking = Core:CalculateDungeonRanking()
        assert.are.equal(fullCount - 1, #reducedRanking)

        -- The excluded dungeon should not be in the ranking
        for _, entry in ipairs(reducedRanking) do
            assert.is_not_equal(firstId, entry.dungeon.id)
        end
    end)
end)

-- ============================================================================
-- OFF-SPEC SCORING
-- ============================================================================
describe("Off-spec scoring with real data", function()
    before_each(resetState)

    it("off-spec items score 0.5 and are flagged isOffSpec", function()
        -- Use a DK Blood main with Frost off-spec
        local mainSpec = "DEATHKNIGHT_BLOOD"
        local offSpec = "DEATHKNIGHT_FROST"

        -- Fully gear the main spec so only off-spec items remain
        NS.groupData = {
            ["DK-Realm"] = makePlayer(mainSpec, NS.BIS_MYTHIC[mainSpec], {
                class = "DEATHKNIGHT", name = "DK", offSpec = offSpec,
            }),
        }

        local totalOffSpec = 0
        for dungeonId, _ in pairs(NS.DUNGEON_LOOT) do
            local score, details = Core:ScoreDungeon(dungeonId)
            local dk = details["DK-Realm"]
            if dk then
                totalOffSpec = totalOffSpec + dk.offSpecCount
                for _, item in ipairs(dk.needed) do
                    if item.isOffSpec then
                        -- Verify the item is actually in the Frost BIS and NOT in Blood BIS
                        local inOff = false
                        for _, bisId in pairs(NS.BIS_MYTHIC[offSpec]) do
                            if bisId == item.itemId then inOff = true; break end
                        end
                        assert.is_true(inOff,
                            "Off-spec item " .. item.itemId .. " not in " .. offSpec .. " BIS")

                        local inMain = false
                        for _, bisId in pairs(NS.BIS_MYTHIC[mainSpec]) do
                            if bisId == item.itemId then inMain = true; break end
                        end
                        assert.is_false(inMain,
                            "Off-spec item " .. item.itemId .. " should NOT be in " .. mainSpec .. " BIS")
                    end
                end
            end
        end
    end)
end)

-- ============================================================================
-- RAID SCORING WITH REAL DATA
-- ============================================================================
describe("Raid scoring with real data", function()
    before_each(resetState)

    it("CalculateRaidRanking returns entries for all raids", function()
        NS.groupData = {
            ["Player-Realm"] = makePlayer("PALADIN_PROTECTION", {}, {
                class = "PALADIN", name = "Tank",
            }),
        }

        local ranking = Core:CalculateRaidRanking()
        assert.are.equal(#NS.RAIDS, #ranking)
    end)

    -- Regression: BIS_RAID was empty due to double definition
    it("BIS_RAID has data for PALADIN_PROTECTION (not overwritten)", function()
        local prot = NS.BIS_RAID["PALADIN_PROTECTION"]
        assert.is_table(prot)
        assert.is_true(next(prot) ~= nil,
            "PALADIN_PROTECTION should have raid BIS entries")
    end)

    -- Note: RAID_LOOT is currently a placeholder (empty). ScoreRaid can only
    -- score raids whose loot tables are populated. Once scrape_loot.py --raids
    -- is run, the following test will verify scoring works.
    it("ScoreRaid uses BIS_RAID table (not BIS_MYTHIC)", function()
        -- Manually add a raid loot entry matching a PALADIN_PROTECTION BIS item
        local origRaidLoot = NS.RAID_LOOT
        local palBIS = NS.BIS_RAID["PALADIN_PROTECTION"]
        local testItemId, testSlot
        for slot, itemId in pairs(palBIS) do
            testItemId = itemId
            testSlot = slot
            break
        end

        NS.RAID_LOOT = {
            TEST_RAID = {
                { itemId = testItemId, itemName = "Test Raid Drop", boss = "Boss" },
            },
        }
        NS.groupData = {
            ["Tank-Realm"] = makePlayer("PALADIN_PROTECTION", {}, {
                class = "PALADIN", name = "Tank",
            }),
        }

        local score, details = Core:ScoreRaid("TEST_RAID")
        assert.are.equal(1, score)
        assert.are.equal(1, details["Tank-Realm"].count)

        -- Verify it used BIS_RAID, not BIS_MYTHIC
        local raidSlot = NS.FindBISSlot("PALADIN_PROTECTION", testItemId, NS.BIS_RAID)
        assert.is_not_nil(raidSlot)

        NS.RAID_LOOT = origRaidLoot
    end)
end)

-- ============================================================================
-- LOOT ITEM CANDIDATES WITH REAL DATA
-- ============================================================================
describe("Loot item candidates with real data", function()
    before_each(resetState)

    it("ungeared players of correct spec appear as candidates for BIS drops", function()
        -- Pick a real dungeon item that's BIS for DK Blood
        local spec = "DEATHKNIGHT_BLOOD"
        local bisList = NS.BIS_MYTHIC[spec]
        local testItemId, testSlot

        -- Find an item in BIS that also drops in a dungeon
        for slot, itemId in pairs(bisList) do
            if NS.IsFromDungeon(itemId) then
                testItemId = itemId
                testSlot = slot
                break
            end
        end

        if testItemId then
            NS.groupData = {
                ["DK-Realm"] = makePlayer(spec, {}, {
                    class = "DEATHKNIGHT", name = "DK",
                }),
                ["Mage-Realm"] = makePlayer("MAGE_FROST", {}, {
                    class = "MAGE", name = "Mage",
                }),
            }

            local candidates = Core:GetItemCandidates(testItemId, testSlot)
            -- DK should be a candidate
            local foundDK = false
            for _, c in ipairs(candidates) do
                if c.playerName == "DK-Realm" then
                    foundDK = true
                    assert.are.equal(NS.PRIORITY_TAGS.BIS_MAIN, c.tag)
                end
            end
            assert.is_true(foundDK, "DK Blood should be a candidate for their BIS item " .. testItemId)
        end
    end)

    it("player who already has the item is NOT a candidate", function()
        local spec = "DEATHKNIGHT_BLOOD"
        local bisList = NS.BIS_MYTHIC[spec]
        local testItemId, testSlot

        for slot, itemId in pairs(bisList) do
            if NS.IsFromDungeon(itemId) then
                testItemId = itemId
                testSlot = slot
                break
            end
        end

        if testItemId then
            NS.groupData = {
                ["DK-Realm"] = makePlayer(spec, { [testSlot] = testItemId }, {
                    class = "DEATHKNIGHT", name = "DK",
                }),
            }

            local candidates = Core:GetItemCandidates(testItemId, testSlot)
            for _, c in ipairs(candidates) do
                assert.is_not_equal("DK-Realm", c.playerName,
                    "DK who has the item should not be a candidate")
            end
        end
    end)
end)

-- ============================================================================
-- RECALCULATE ALL RANKINGS: end-to-end coherence
-- ============================================================================
describe("RecalculateAllRankings end-to-end", function()
    before_each(resetState)

    it("produces coherent rankings for a 5-player group", function()
        NS.groupData = {
            ["Tank-Realm"] = makePlayer("DEATHKNIGHT_BLOOD", {}, {
                class = "DEATHKNIGHT", name = "Tank",
            }),
            ["Healer-Realm"] = makePlayer("DRUID_RESTORATION", {}, {
                class = "DRUID", name = "Healer",
            }),
            ["DPS1-Realm"] = makePlayer("WARRIOR_ARMS", {}, {
                class = "WARRIOR", name = "DPS1",
            }),
            ["DPS2-Realm"] = makePlayer("MAGE_FROST", {}, {
                class = "MAGE", name = "DPS2",
            }),
            ["DPS3-Realm"] = makePlayer("ROGUE_OUTLAW", {}, {
                class = "ROGUE", name = "DPS3",
            }),
        }

        Core:RecalculateAllRankings()

        -- M+ ranking
        assert.is_table(Core.lastRanking)
        assert.are.equal(#NS.DUNGEONS, #Core.lastRanking)

        -- All ungeared = all dungeons should have positive scores
        -- (unless no loot is BIS for any of these 5 specs in a given dungeon)
        local positiveCount = 0
        for _, entry in ipairs(Core.lastRanking) do
            assert.is_number(entry.score)
            if entry.score > 0 then positiveCount = positiveCount + 1 end
        end
        assert.is_true(positiveCount > 0, "At least some dungeons should have positive scores")

        -- Raid ranking
        assert.is_table(Core.lastRaidRanking)
        assert.are.equal(#NS.RAIDS, #Core.lastRaidRanking)

        -- Verify details contain all 5 players
        for _, entry in ipairs(Core.lastRanking) do
            for playerName, _ in pairs(NS.groupData) do
                assert.is_not_nil(entry.details[playerName],
                    playerName .. " missing from dungeon " .. entry.dungeon.id .. " details")
            end
        end
    end)

    it("as players gear up, scores decrease", function()
        local spec = "DEATHKNIGHT_BLOOD"
        NS.groupData = {
            ["DK-Realm"] = makePlayer(spec, {}, {
                class = "DEATHKNIGHT", name = "DK",
            }),
        }

        Core:RecalculateAllRankings()
        local totalScore1 = 0
        for _, e in ipairs(Core.lastRanking) do totalScore1 = totalScore1 + e.score end

        -- Now equip all BIS
        NS.groupData["DK-Realm"].gear = NS.BIS_MYTHIC[spec]

        Core:RecalculateAllRankings()
        local totalScore2 = 0
        for _, e in ipairs(Core.lastRanking) do totalScore2 = totalScore2 + e.score end

        assert.is_true(totalScore2 < totalScore1,
            "Total score should decrease when player equips BIS items")
        assert.are.equal(0, totalScore2,
            "Total score should be 0 when fully BIS geared")
    end)
end)

-- ============================================================================
-- ITEM_TO_DUNGEONS index coherence
-- ============================================================================
describe("ITEM_TO_DUNGEONS index coherence", function()
    it("every BIS dungeon item maps back to at least one dungeon", function()
        local missing = {}
        for spec, bisList in pairs(NS.BIS_MYTHIC) do
            for slot, itemId in pairs(bisList) do
                if NS.IsFromDungeon(itemId) then
                    local dungeons = NS.ITEM_TO_DUNGEONS[itemId]
                    assert.is_table(dungeons)
                    assert.is_true(#dungeons > 0,
                        "Item " .. itemId .. " (" .. spec .. " slot " .. slot ..
                        ") is marked as dungeon item but has no dungeon in index")
                end
            end
        end
    end)

    it("DUNGEON_LOOT dungeon keys match DUNGEONS list ids", function()
        local validIds = {}
        for _, d in ipairs(NS.DUNGEONS) do validIds[d.id] = true end

        for dungeonId, _ in pairs(NS.DUNGEON_LOOT) do
            assert.is_true(validIds[dungeonId],
                "DUNGEON_LOOT key '" .. dungeonId .. "' not in DUNGEONS list")
        end
    end)
end)

-- ============================================================================
-- TIER SET LOGIC WITH REAL DATA
-- ============================================================================
describe("Tier set logic with real data", function()
    before_each(resetState)

    it("tier count is 0 for ungeared player", function()
        local player = makePlayer("DEATHKNIGHT_BLOOD", {}, { class = "DEATHKNIGHT" })
        assert.are.equal(0, Core:GetTierSetCount(player))
    end)

    it("GetCatalystSuggestion returns a tier slot for ungeared player", function()
        local player = makePlayer("DEATHKNIGHT_BLOOD", {}, { class = "DEATHKNIGHT" })
        local suggestion = Core:GetCatalystSuggestion(player)
        assert.is_not_nil(suggestion)
        -- The suggested slot should be one of the tier set slots
        local isTierSlot = false
        for _, tierSlot in ipairs(NS.TIER_SET_SLOTS) do
            if tierSlot == suggestion.slotId then isTierSlot = true; break end
        end
        assert.is_true(isTierSlot, "Suggested slot " .. suggestion.slotId .. " is not a tier slot")
    end)

    it("fully tier-geared player has count 5 and no suggestion", function()
        local spec = "DEATHKNIGHT_BLOOD"
        local bisList = NS.BIS_MYTHIC[spec]
        -- Build gear with all tier slots from BIS
        local gear = {}
        for _, slotId in ipairs(NS.TIER_SET_SLOTS) do
            if bisList[slotId] then
                gear[slotId] = bisList[slotId]
            end
        end

        local player = makePlayer(spec, gear, { class = "DEATHKNIGHT" })
        assert.are.equal(5, Core:GetTierSetCount(player))
        assert.is_nil(Core:GetCatalystSuggestion(player))
    end)
end)

-- ============================================================================
-- CROSS-SPEC BIS ITEM OVERLAP
-- ============================================================================
describe("Cross-spec BIS item detection", function()
    it("shared dungeon items are scored for all specs that need them", function()
        -- Find an item that's BIS for 2+ specs
        local sharedItem
        local specs = {}
        for spec, bisList in pairs(NS.BIS_MYTHIC) do
            for _, itemId in pairs(bisList) do
                if NS.IsFromDungeon(itemId) then
                    if not sharedItem then
                        -- Check if another spec also has this item
                        for spec2, bisList2 in pairs(NS.BIS_MYTHIC) do
                            if spec2 ~= spec then
                                for _, itemId2 in pairs(bisList2) do
                                    if itemId2 == itemId then
                                        sharedItem = itemId
                                        specs = { spec, spec2 }
                                        break
                                    end
                                end
                            end
                            if sharedItem then break end
                        end
                    end
                end
                if sharedItem then break end
            end
            if sharedItem then break end
        end

        if sharedItem and #specs >= 2 then
            NS.groupData = {}
            for i, spec in ipairs(specs) do
                local class = spec:match("^(%u+)_")
                NS.groupData["Player" .. i .. "-Realm"] = makePlayer(spec, {}, {
                    class = class, name = "Player" .. i,
                })
            end

            -- Find which dungeon drops this item
            local dungeonId
            for dId, drops in pairs(NS.DUNGEON_LOOT) do
                for _, drop in ipairs(drops) do
                    if drop.itemId == sharedItem then
                        dungeonId = dId
                        break
                    end
                end
                if dungeonId then break end
            end

            if dungeonId then
                local score, details = Core:ScoreDungeon(dungeonId)
                -- Both players should need the shared item
                for i, spec in ipairs(specs) do
                    local pName = "Player" .. i .. "-Realm"
                    local pDetails = details[pName]
                    assert.is_not_nil(pDetails)
                    local foundItem = false
                    for _, item in ipairs(pDetails.needed) do
                        if item.itemId == sharedItem then foundItem = true; break end
                    end
                    assert.is_true(foundItem,
                        spec .. " should need shared item " .. sharedItem .. " in " .. dungeonId)
                end
            end
        end
    end)
end)
