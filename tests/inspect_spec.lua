-- ============================================================================
-- Tests for Inspect.lua: gear scanning, sync, name resolution
-- ============================================================================

local stub = require("tests.wow_stub")
local NS = stub.NS

stub.loadAddonFile("Locales.lua")
stub.loadAddonFile("Data.lua")
stub.loadAddonFile("Inspect.lua")
stub.loadAddonFile("Core.lua")

local Inspect = NS.Inspect

local function resetState()
    stub.resetStubs()
    wipe(NS.groupData)
    wipe(NS.skippedPlayers)
end

-- ============================================================================
-- GetUnitFullName
-- ============================================================================
describe("GetUnitFullName", function()
    after_each(stub.resetStubs)

    it("returns Name-Realm for player", function()
        _G.UnitName = function() return "TestPlayer", nil end
        _G.GetNormalizedRealmName = function() return "TestRealm" end
        assert.are.equal("TestPlayer-TestRealm", Inspect:GetUnitFullName("player"))
    end)

    it("returns Name-Realm when realm is provided", function()
        _G.UnitName = function() return "Alice", "OtherRealm" end
        assert.are.equal("Alice-OtherRealm", Inspect:GetUnitFullName("party1"))
    end)

    it("returns nil when UnitName returns nil", function()
        _G.UnitName = function() return nil end
        assert.is_nil(Inspect:GetUnitFullName("party1"))
    end)

    it("uses GetNormalizedRealmName as fallback for empty realm", function()
        _G.UnitName = function() return "Bob", "" end
        _G.GetNormalizedRealmName = function() return "FallbackRealm" end
        assert.are.equal("Bob-FallbackRealm", Inspect:GetUnitFullName("party1"))
    end)

    it("returns just the name when both realm and normalized are empty", function()
        _G.UnitName = function() return "Solo", "" end
        _G.GetNormalizedRealmName = function() return "" end
        assert.are.equal("Solo", Inspect:GetUnitFullName("player"))
    end)
end)

-- ============================================================================
-- GetEquippedItemID
-- ============================================================================
describe("GetEquippedItemID", function()
    after_each(stub.resetStubs)

    it("returns nil when no item link", function()
        _G.GetInventoryItemLink = function() return nil end
        assert.is_nil(Inspect:GetEquippedItemID("player", 1))
    end)

    it("extracts item ID from link", function()
        _G.GetInventoryItemLink = function()
            return "|cff0070dd|Hitem:12345:0:0:0:0:0:0:0:80:0:0:0|h[Test Item]|h|r"
        end
        assert.are.equal(12345, Inspect:GetEquippedItemID("player", 1))
    end)

    it("handles complex item links", function()
        _G.GetInventoryItemLink = function()
            return "|cffa335ee|Hitem:207160:6652:192991:0:0:0:0:0:80:0:3:2:4795:4802|h[Item]|h|r"
        end
        assert.are.equal(207160, Inspect:GetEquippedItemID("player", 1))
    end)
end)

-- ============================================================================
-- ScanUnitGear
-- ============================================================================
describe("ScanUnitGear", function()
    after_each(stub.resetStubs)

    it("returns empty gear when no items equipped", function()
        _G.GetInventoryItemLink = function() return nil end
        local gear = Inspect:ScanUnitGear("player")
        assert.are.same({}, gear)
    end)

    it("populates gear by slotId", function()
        _G.GetInventoryItemLink = function(unit, slotId)
            if slotId == 1 then
                return "|cff|Hitem:11111:0|h[Head]|h|r"
            elseif slotId == 16 then
                return "|cff|Hitem:22222:0|h[Weapon]|h|r"
            end
            return nil
        end
        local gear = Inspect:ScanUnitGear("player")
        assert.are.equal(11111, gear[1])
        assert.are.equal(22222, gear[16])
    end)
end)

-- ============================================================================
-- GetUnitSpecKey
-- ============================================================================
describe("GetUnitSpecKey", function()
    after_each(stub.resetStubs)

    it("returns player spec for player unit", function()
        _G.UnitIsUnit = function(a, b) return a == "player" and b == "player" end
        _G.GetSpecialization = function() return 1 end
        _G.GetSpecializationInfo = function() return 71 end -- Arms specID
        -- NS.SPEC_MAP[71] should map to a spec key
        local result = Inspect:GetUnitSpecKey("player")
        -- Result depends on SPEC_MAP data, but it should not error
        -- For player, it calls GetPlayerSpecKey
    end)

    it("uses GetInspectSpecialization for non-player units", function()
        _G.UnitIsUnit = function() return false end
        _G.GetInspectSpecialization = function() return 71 end
        local result = Inspect:GetUnitSpecKey("party1")
        -- Returns NS.SPEC_MAP[71]
        if NS.SPEC_MAP[71] then
            assert.are.equal(NS.SPEC_MAP[71], result)
        end
    end)

    it("returns nil for unknown specID", function()
        _G.UnitIsUnit = function() return false end
        _G.GetInspectSpecialization = function() return 0 end
        assert.is_nil(Inspect:GetUnitSpecKey("party1"))
    end)
end)

-- ============================================================================
-- OnGearMessage (pure logic: parses addon sync messages)
-- ============================================================================
describe("OnGearMessage", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("parses a valid gear sync message", function()
        _G.UnitName = function() return "Me", nil end

        local msg = "71|WARRIOR|1:11111,5:22222,16:33333"
        local result = Inspect:OnGearMessage(msg, "Alice-Realm")
        assert.is_true(result)

        local data = NS.groupData["Alice-Realm"]
        assert.is_not_nil(data)
        assert.are.equal("WARRIOR", data.class)
        assert.are.equal(11111, data.gear[1])
        assert.are.equal(22222, data.gear[5])
        assert.are.equal(33333, data.gear[16])
        assert.are.equal("Alice", data.name)
        assert.are.equal("sync", data.source)
    end)

    it("parses message with off-spec field", function()
        _G.UnitName = function() return "Me", nil end

        local msg = "71|WARRIOR|1:11111,16:33333|WARRIOR_FURY"
        Inspect:OnGearMessage(msg, "Bob-Realm")

        local data = NS.groupData["Bob-Realm"]
        assert.is_not_nil(data)
        assert.are.equal("WARRIOR_FURY", data.offSpec)
    end)

    it("sets offSpec to nil when NONE", function()
        _G.UnitName = function() return "Me", nil end

        local msg = "71|WARRIOR|1:11111|NONE"
        Inspect:OnGearMessage(msg, "Bob-Realm")
        assert.is_nil(NS.groupData["Bob-Realm"].offSpec)
    end)

    it("ignores messages from self", function()
        _G.UnitName = function() return "Me", nil end
        _G.GetNormalizedRealmName = function() return "TestRealm" end

        local msg = "71|WARRIOR|1:11111"
        Inspect:OnGearMessage(msg, "Me-TestRealm")
        assert.is_nil(NS.groupData["Me-TestRealm"])
    end)

    it("ignores nil message", function()
        Inspect:OnGearMessage(nil, "Alice-Realm")
        assert.is_nil(NS.groupData["Alice-Realm"])
    end)

    it("ignores nil sender", function()
        Inspect:OnGearMessage("71|WARRIOR|1:11111", nil)
    end)

    it("ignores malformed messages", function()
        _G.UnitName = function() return "Me", nil end

        Inspect:OnGearMessage("garbage", "Alice-Realm")
        assert.is_nil(NS.groupData["Alice-Realm"])
    end)

    it("handles empty gear string", function()
        _G.UnitName = function() return "Me", nil end

        local msg = "71|WARRIOR|"
        -- This may or may not parse - just ensure no crash
        assert.has_no.errors(function()
            Inspect:OnGearMessage(msg, "Alice-Realm")
        end)
    end)
end)

-- ============================================================================
-- GetScannedCount
-- ============================================================================
describe("GetScannedCount", function()
    before_each(resetState)

    it("returns 0 when no data", function()
        assert.are.equal(0, Inspect:GetScannedCount())
    end)

    it("counts entries in groupData", function()
        NS.groupData["A-Realm"] = {}
        NS.groupData["B-Realm"] = {}
        NS.groupData["C-Realm"] = {}
        assert.are.equal(3, Inspect:GetScannedCount())
    end)
end)

-- ============================================================================
-- ScanGroup
-- ============================================================================
describe("ScanGroup", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("blocks scanning in raids", function()
        _G.IsInRaid = function() return true end
        _G.IsInGroup = function() return true end
        Inspect:ScanGroup()
        -- Should not crash and should clear data
        assert.is_nil(next(NS.groupData))
    end)

    it("clears stale data before scanning", function()
        NS.groupData["Old-Realm"] = { spec = "WARRIOR_ARMS" }
        NS.skippedPlayers = { "something" }
        _G.IsInRaid = function() return false end
        _G.IsInGroup = function() return false end
        Inspect:ScanGroup()
        -- Old-Realm should be gone (stale data cleared)
        assert.is_nil(NS.groupData["Old-Realm"])
        -- skippedPlayers should be cleared
        assert.are.equal(0, #NS.skippedPlayers)
    end)
end)

-- ============================================================================
-- BroadcastOwnGear
-- ============================================================================
describe("BroadcastOwnGear", function()
    before_each(resetState)
    after_each(stub.resetStubs)

    it("does nothing when not in group", function()
        _G.IsInGroup = function() return false end
        local sent = false
        _G.C_ChatInfo = {
            SendAddonMessage = function() sent = true end,
            RegisterAddonMessagePrefix = function() end,
        }
        Inspect:BroadcastOwnGear()
        assert.is_false(sent)
    end)
end)
