-- ============================================================================
-- WoW API stubs for unit testing DungeonOptimizer outside the game client
-- ============================================================================

-- Simulate the addon namespace (WoW injects (addonName, NS) via varargs)
local NS = {}
_G._test_NS = NS

-- Stub LibStub and AceAddon so Core.lua can load
local aceAddon = {}
aceAddon.__index = aceAddon

function aceAddon:NewAddon(name, ...)
    local addon = setmetatable({}, { __index = aceAddon })
    addon.name = name
    addon.db = {
        profile = {
            minimap = { hide = false },
            excludedDungeons = {},
            showTooltips = true,
            weightByScore = true,
            offSpec = nil,
            activeTab = "mplus",

        },
    }
    return addon
end

function aceAddon:RegisterChatCommand() end
function aceAddon:RegisterEvent() end
function aceAddon:UnregisterEvent() end
function aceAddon:ScheduleTimer(...) return 1 end
function aceAddon:CancelTimer() end
function aceAddon:Print(...) end
function aceAddon:GetArgs(input, n, startPos)
    -- Minimal AceConsole:GetArgs stub
    local arg = input and input:match("^(%S+)") or ""
    return arg
end

local libDBIcon = { Register = function() end }
local libLDB = { NewDataObject = function(_, _, obj) return obj end }

_G.LibStub = function(name)
    if name == "AceAddon-3.0" then return aceAddon end
    if name == "AceDB-3.0" then
        return {
            New = function(_, dbName, defs, defaultProfile)
                return {
                    profile = defs and defs.profile or {},
                }
            end,
        }
    end
    if name == "LibDataBroker-1.1" then return libLDB end
    if name == "LibDBIcon-1.0" then return libDBIcon end
    return {}
end

-- WoW global API stubs (all overridable per-test)
_G.IsInGroup = function() return false end
_G.IsInRaid = function() return false end
_G.GetNumGroupMembers = function() return 1 end
_G.UnitExists = function() return true end
_G.UnitIsConnected = function() return true end
_G.UnitName = function(unit) return unit, nil end
_G.UnitClass = function() return "Warrior", "WARRIOR" end
_G.UnitGUID = function() return "Player-1234-ABCDEF" end
_G.UnitIsUnit = function(a, b) return a == b end
_G.UnitBuff = function() return nil end
_G.GetInventoryItemLink = function() return nil end
_G.GetItemInfo = function(id) return "Item " .. tostring(id) end
_G.GetItemIconByID = function() return nil end
_G.CheckInteractDistance = function() return true end
_G.C_ChatInfo = { SendAddonMessage = function() end, RegisterAddonMessagePrefix = function() end }
_G.C_MythicPlus = nil
_G.C_ChallengeMode = nil
_G.C_CurrencyInfo = nil
_G.C_WeeklyRewards = nil
_G.C_Item = nil
_G.C_LFGList = nil
_G.GetLocale = function() return "enUS" end
_G.GetNormalizedRealmName = function() return "TestRealm" end
_G.GetSpecialization = function() return nil end
_G.GetSpecializationInfo = function() return nil end
_G.NotifyInspect = function() end
_G.ClearInspectPlayer = function() end
_G.GetInspectSpecialization = function() return 0 end
_G.CanInspect = function() return false end
_G.time = os.time

_G.select = select
_G.pairs = pairs
_G.ipairs = ipairs
_G.type = type
_G.tostring = tostring
_G.tonumber = tonumber
_G.math = math
_G.string = string
_G.table = table
_G.setmetatable = setmetatable
_G.getmetatable = getmetatable
_G.next = next
_G.unpack = unpack or table.unpack
_G.wipe = function(t) for k in pairs(t) do t[k] = nil end return t end

-- Locale globals (used by loot detection)
_G.LOOT_ITEM = "%s receives loot: %s"
_G.LOOT_ITEM_SELF = "You receive loot: %s"

-- ============================================================================
-- Module loader: loads a .lua file with the WoW addon varargs injected
-- ============================================================================
local function loadAddonFile(filepath)
    local fn, err = loadfile(filepath)
    if not fn then error("Failed to load " .. filepath .. ": " .. err) end
    fn("DungeonOptimizer", NS)
end

-- ============================================================================
-- Helper: reset all WoW stubs to defaults (call in after_each)
-- ============================================================================
local function resetStubs()
    _G.IsInGroup = function() return false end
    _G.IsInRaid = function() return false end
    _G.GetNumGroupMembers = function() return 1 end
    _G.UnitExists = function() return true end
    _G.UnitIsConnected = function() return true end
    _G.UnitName = function(unit) return unit, nil end
    _G.UnitClass = function() return "Warrior", "WARRIOR" end
    _G.UnitGUID = function() return "Player-1234-ABCDEF" end
    _G.UnitIsUnit = function(a, b) return a == b end
    _G.UnitBuff = function() return nil end
    _G.GetInventoryItemLink = function() return nil end
    _G.CheckInteractDistance = function() return true end
    _G.C_MythicPlus = nil
    _G.C_ChallengeMode = nil
    _G.C_CurrencyInfo = nil
    _G.C_WeeklyRewards = nil
end

return {
    NS = NS,
    loadAddonFile = loadAddonFile,
    aceAddon = aceAddon,
    resetStubs = resetStubs,
}
