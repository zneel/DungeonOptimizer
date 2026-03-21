-- ============================================================================
-- DungeonOptimizer - Inspect.lua
-- Handles scanning group members' equipped gear and specializations
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
local INSPECT_TIMEOUT = 5 -- seconds per inspect attempt

-- Stored group data: { ["PlayerName-Realm"] = { spec = "KEY", gear = {[slot]=itemId} } }
NS.groupData = {}

-- Skipped players tracking (for user feedback)
NS.skippedPlayers = {}

-- ============================================================================
-- Get the player's own spec key
-- ============================================================================
function Inspect:GetPlayerSpecKey()
    local specIndex = GetSpecialization()
    if not specIndex then return nil end
    local specID = GetSpecializationInfo(specIndex)
    return NS.SPEC_MAP[specID]
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
-- Process inspect result for current unit
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
        -- Notify core that scan is complete
        if NS.Core and NS.Core.OnScanComplete then
            NS.Core:OnScanComplete()
        end
        return
    end

    local unit = table.remove(inspectQueue, 1)

    -- Skip if unit no longer exists or is disconnected
    if not UnitExists(unit) or not UnitIsConnected(unit) then
        local name = UnitName(unit) or unit
        table.insert(NS.skippedPlayers, name .. " (not available)")
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
            }
        end
        self:ProcessNextInspect()
        return
    end

    -- Check range for inspect (index 2 = inspect range ~28 yards)
    if not CheckInteractDistance(unit, 2) then
        local name = UnitName(unit) or unit
        table.insert(NS.skippedPlayers, name .. " (out of range)")
        self:ProcessNextInspect()
        return
    end

    currentInspectUnit = unit
    isInspecting = true
    retryCount = 0
    NotifyInspect(unit)

    -- Safety timeout with retry
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
                -- Retry the inspect
                ClearInspectPlayer()
                NotifyInspect(currentInspectUnit)
                Inspect:StartInspectTimeout()
            else
                -- Give up on this unit
                local name = UnitName(currentInspectUnit) or currentInspectUnit
                table.insert(NS.skippedPlayers, name .. " (inspect timed out)")
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
    -- Clear previous data
    wipe(NS.groupData)
    wipe(inspectQueue)
    wipe(NS.skippedPlayers)
    isInspecting = false
    currentInspectUnit = nil
    retryCount = 0

    local numMembers
    local prefix

    if IsInRaid() then
        numMembers = GetNumGroupMembers()
        prefix = "raid"
    elseif IsInGroup() then
        numMembers = GetNumGroupMembers()
        prefix = "party"
    else
        -- Solo: just scan the player
        numMembers = 0
        prefix = nil
    end

    -- Always add the player first
    table.insert(inspectQueue, "player")

    if prefix then
        local maxIndex = numMembers
        -- In a party, tokens are party1..party4 (player is separate)
        -- In a raid, tokens are raid1..raidN (player is included)
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

    -- Start processing queue
    self:ProcessNextInspect()
end

-- ============================================================================
-- Get number of group members scanned
-- ============================================================================
function Inspect:GetScannedCount()
    local count = 0
    for _ in pairs(NS.groupData) do
        count = count + 1
    end
    return count
end
