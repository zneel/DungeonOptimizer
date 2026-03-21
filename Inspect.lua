-- ============================================================================
-- DungeonOptimizer - Inspect.lua
-- Handles scanning group members' equipped gear and specializations
--
-- Two modes:
--   1. LOCAL INSPECT: NotifyInspect (requires 28yd range)
--   2. ADDON SYNC: Each addon user broadcasts their own gear via addon
--      messages. No range requirement — works cross-continent.
-- ============================================================================

local ADDON_NAME, NS = ...

NS.Inspect = {}
local Inspect = NS.Inspect

-- Queue for inspect requests (WoW only allows one at a time)
local inspectQueue = {}
local isInspecting = false
local currentInspectUnit = nil
local inspectTimer = nil
local retryCount = 0
local MAX_RETRIES = 2
local INSPECT_TIMEOUT = 5

-- Stored group data: { ["PlayerName-Realm"] = { spec, gear, class, name, unit, ilvls, source } }
NS.groupData = {}
NS.skippedPlayers = {}

local GEAR_MSG_PREFIX = "DOptGear"

-- ============================================================================
-- REGISTER GEAR SYNC PREFIX (called from Core:OnEnable)
-- ============================================================================
function Inspect:RegisterSync()
    C_ChatInfo.RegisterAddonMessagePrefix(GEAR_MSG_PREFIX)
end

-- ============================================================================
-- Get the player's own spec key
-- ============================================================================
function Inspect:GetPlayerSpecKey()
    local specIndex = GetSpecialization()
    if not specIndex then return nil end
    local specID = GetSpecializationInfo(specIndex)
    return NS.SPEC_MAP[specID]
end

function Inspect:GetPlayerSpecID()
    local specIndex = GetSpecialization()
    if not specIndex then return nil end
    return GetSpecializationInfo(specIndex)
end

-- ============================================================================
-- Get equipped item ID for a given inventory slot
-- ============================================================================
function Inspect:GetEquippedItemID(unit, slotId)
    local itemLink = GetInventoryItemLink(unit, slotId)
    if not itemLink then return nil end
    local itemId = tonumber(itemLink:match("item:(%d+)"))
    return itemId
end

-- ============================================================================
-- Scan a single unit's gear (all relevant slots)
-- ============================================================================
function Inspect:ScanUnitGear(unit)
    local gear = {}
    for slotName, slotId in pairs(NS.SLOT_IDS) do
        local itemId = self:GetEquippedItemID(unit, slotId)
        if itemId then
            gear[slotId] = itemId
        end
    end
    return gear
end

-- ============================================================================
-- Get the unit's spec key via inspect data
-- ============================================================================
function Inspect:GetUnitSpecKey(unit)
    if UnitIsUnit(unit, "player") then
        return self:GetPlayerSpecKey()
    end
    local specID = GetInspectSpecialization(unit)
    if specID and specID > 0 then
        return NS.SPEC_MAP[specID]
    end
    return nil
end

-- ============================================================================
-- Get unit full name (Name-Realm)
-- ============================================================================
function Inspect:GetUnitFullName(unit)
    local name, realm = UnitName(unit)
    if not name then return nil end
    if not realm or realm == "" then
        realm = GetNormalizedRealmName()
    end
    return name .. "-" .. realm
end

-- ============================================================================
-- GEAR BROADCAST: Serialize own gear and send to group
-- No range required — each player reads their own equipment
-- ============================================================================
function Inspect:BroadcastOwnGear()
    if not IsInGroup() then return end

    local specID = self:GetPlayerSpecID()
    local specKey = self:GetPlayerSpecKey()
    local class = select(2, UnitClass("player"))
    local name = UnitName("player")

    if not specKey then return end

    -- Format: specID|class|slot:itemId,slot:itemId,...
    local parts = {}
    for slotName, slotId in pairs(NS.SLOT_IDS) do
        local itemId = self:GetEquippedItemID("player", slotId)
        if itemId then
            table.insert(parts, slotId .. ":" .. itemId)
        end
    end

    local gearStr = table.concat(parts, ",")
    local message = string.format("%s|%s|%s", tostring(specID), class, gearStr)

    local channel = IsInRaid() and "RAID" or "PARTY"
    C_ChatInfo.SendAddonMessage(GEAR_MSG_PREFIX, message, channel)
end

-- ============================================================================
-- GEAR RECEIVE: Parse incoming gear broadcast from another addon user
-- ============================================================================
function Inspect:OnGearMessage(message, sender)
    if not message or not sender then return end

    -- Don't process our own messages
    local myName = UnitName("player")
    if sender:find(myName) then return end

    local specIDStr, class, gearStr = message:match("^(%d+)|(%u+)|(.+)$")
    if not specIDStr or not class or not gearStr then return end

    local specID = tonumber(specIDStr)
    local specKey = NS.SPEC_MAP[specID]

    -- Parse gear
    local gear = {}
    for entry in gearStr:gmatch("[^,]+") do
        local slotId, itemId = entry:match("^(%d+):(%d+)$")
        if slotId and itemId then
            gear[tonumber(slotId)] = tonumber(itemId)
        end
    end

    -- Extract display name from sender (Name-Realm or just Name)
    local displayName = sender:match("^([^-]+)") or sender

    -- Store/update group data (merge with existing if we have inspect data)
    NS.groupData[sender] = {
        spec = specKey,
        gear = gear,
        class = class,
        name = displayName,
        unit = nil, -- no unit token for remote synced players
        source = "sync", -- distinguish from local inspect
        ilvls = {}, -- will be empty for synced players (can't read remote ilvls)
    }

    return true
end

-- ============================================================================
-- Process inspect result for current unit (local inspect)
-- ============================================================================
function Inspect:OnInspectReady(guid)
    if not currentInspectUnit then return end

    local unitGUID = UnitGUID(currentInspectUnit)
    if unitGUID ~= guid then return end

    local fullName = self:GetUnitFullName(currentInspectUnit)
    if not fullName then
        self:ProcessNextInspect()
        return
    end

    local specKey = self:GetUnitSpecKey(currentInspectUnit)
    local gear = self:ScanUnitGear(currentInspectUnit)

    NS.groupData[fullName] = {
        spec = specKey,
        gear = gear,
        unit = currentInspectUnit,
        class = select(2, UnitClass(currentInspectUnit)),
        name = UnitName(currentInspectUnit),
        source = "inspect",
    }

    ClearInspectPlayer()
    isInspecting = false
    currentInspectUnit = nil
    retryCount = 0

    self:ProcessNextInspect()
end

-- ============================================================================
-- Process next unit in the inspect queue
-- ============================================================================
function Inspect:ProcessNextInspect()
    if #inspectQueue == 0 then
        isInspecting = false
        -- After inspect queue is done, broadcast our own gear for remote users
        self:BroadcastOwnGear()
        if NS.Core and NS.Core.OnScanComplete then
            NS.Core:OnScanComplete()
        end
        return
    end

    local unit = table.remove(inspectQueue, 1)

    if not UnitExists(unit) or not UnitIsConnected(unit) then
        local name = UnitName(unit) or unit
        table.insert(NS.skippedPlayers, name .. " (not available - will try sync)")
        self:ProcessNextInspect()
        return
    end

    -- Player doesn't need inspect API
    if UnitIsUnit(unit, "player") then
        local fullName = self:GetUnitFullName(unit)
        if fullName then
            NS.groupData[fullName] = {
                spec = self:GetPlayerSpecKey(),
                gear = self:ScanUnitGear(unit),
                unit = unit,
                class = select(2, UnitClass(unit)),
                name = UnitName(unit),
                source = "local",
            }
        end
        self:ProcessNextInspect()
        return
    end

    -- Check range for inspect
    if not CheckInteractDistance(unit, 2) then
        local name = UnitName(unit) or unit
        -- Don't mark as skipped — they might sync via addon messages
        local fullName = self:GetUnitFullName(unit)
        if not NS.groupData[fullName] then
            table.insert(NS.skippedPlayers, name .. " (out of range - waiting for sync)")
        end
        self:ProcessNextInspect()
        return
    end

    currentInspectUnit = unit
    isInspecting = true
    retryCount = 0
    NotifyInspect(unit)
    self:StartInspectTimeout()
end

-- ============================================================================
-- Inspect timeout with retry logic
-- ============================================================================
function Inspect:StartInspectTimeout()
    if inspectTimer then
        inspectTimer:Cancel()
    end
    inspectTimer = C_Timer.NewTimer(INSPECT_TIMEOUT, function()
        if isInspecting and currentInspectUnit then
            retryCount = retryCount + 1
            if retryCount <= MAX_RETRIES and UnitExists(currentInspectUnit) and CheckInteractDistance(currentInspectUnit, 2) then
                ClearInspectPlayer()
                NotifyInspect(currentInspectUnit)
                Inspect:StartInspectTimeout()
            else
                local name = UnitName(currentInspectUnit) or currentInspectUnit
                table.insert(NS.skippedPlayers, name .. " (timed out - waiting for sync)")
                ClearInspectPlayer()
                isInspecting = false
                currentInspectUnit = nil
                retryCount = 0
                Inspect:ProcessNextInspect()
            end
        end
    end)
end

-- ============================================================================
-- Start scanning the entire group
-- ============================================================================
function Inspect:ScanGroup()
    -- Don't wipe groupData — keep synced players' data
    -- Only clear inspect-specific state
    wipe(inspectQueue)
    wipe(NS.skippedPlayers)
    isInspecting = false
    currentInspectUnit = nil
    retryCount = 0

    -- Mark existing synced data as stale but don't delete
    -- (will be refreshed by inspect or new sync message)

    local numMembers
    local prefix

    if IsInRaid() then
        numMembers = GetNumGroupMembers()
        prefix = "raid"
    elseif IsInGroup() then
        numMembers = GetNumGroupMembers()
        prefix = "party"
    else
        numMembers = 0
        prefix = nil
    end

    -- Always add the player first
    table.insert(inspectQueue, "player")

    if prefix then
        local maxIndex = numMembers
        if prefix == "party" then
            maxIndex = numMembers - 1
        end
        for i = 1, maxIndex do
            local unit = prefix .. i
            if UnitExists(unit) and not UnitIsUnit(unit, "player") then
                table.insert(inspectQueue, unit)
            end
        end
    end

    self:ProcessNextInspect()
end

-- ============================================================================
-- Get number of group members scanned (from any source)
-- ============================================================================
function Inspect:GetScannedCount()
    local count = 0
    for _ in pairs(NS.groupData) do
        count = count + 1
    end
    return count
end
