-- ============================================================================
-- DungeonOptimizer - UI.lua
-- Main UI with AceGUI: dungeon ranking, checkboxes, player details
-- ============================================================================

local ADDON_NAME, NS = ...
local AceGUI = LibStub("AceGUI-3.0")

NS.UI = {}
local UI = NS.UI

UI.mainFrame = nil

-- ============================================================================
-- TOGGLE MAIN WINDOW
-- ============================================================================
function UI:Toggle()
    if self.mainFrame and self.mainFrame:IsShown() then
        self.mainFrame:Hide()
    else
        self:Show()
    end
end

-- ============================================================================
-- SHOW MAIN WINDOW
-- ============================================================================
function UI:Show()
    if not self.mainFrame then
        self:CreateMainFrame()
    end
    self.mainFrame:Show()
    self:RefreshUI()

    -- Auto-scan if no data
    if NS.Inspect:GetScannedCount() == 0 then
        NS.Core:ScanGroup()
    end
end

-- ============================================================================
-- CREATE MAIN FRAME
-- ============================================================================
function UI:CreateMainFrame()
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Dungeon Optimizer - Midnight Season 1")
    frame:SetStatusText("Right-click minimap icon to scan | /do help")
    frame:SetLayout("Flow")
    frame:SetWidth(780)
    frame:SetHeight(650)
    frame:SetCallback("OnClose", function(widget) widget:Hide() end)

    self.mainFrame = frame
end

-- ============================================================================
-- REFRESH UI
-- ============================================================================
function UI:RefreshUI()
    if not self.mainFrame then return end

    -- Clear existing content
    self.mainFrame:ReleaseChildren()

    -- === TOP BAR: Scan button + member count + BIS mode selector ===
    local topGroup = AceGUI:Create("SimpleGroup")
    topGroup:SetFullWidth(true)
    topGroup:SetLayout("Flow")
    self.mainFrame:AddChild(topGroup)

    local scanBtn = AceGUI:Create("Button")
    scanBtn:SetText("Scan Group")
    scanBtn:SetWidth(140)
    scanBtn:SetCallback("OnClick", function()
        NS.Core:ScanGroup()
    end)
    topGroup:AddChild(scanBtn)

    local countLabel = AceGUI:Create("Label")
    local scanned = NS.Inspect:GetScannedCount()
    local totalGroup = IsInGroup() and GetNumGroupMembers() or 1
    countLabel:SetText(string.format("  |cff00ff00%d|r / %d scanned", scanned, totalGroup))
    countLabel:SetWidth(120)
    topGroup:AddChild(countLabel)

    -- BIS Mode dropdown
    local modeDropdown = AceGUI:Create("Dropdown")
    modeDropdown:SetLabel("BIS Mode")
    modeDropdown:SetWidth(160)
    local modeList = {}
    for _, m in ipairs(NS.BIS_MODES) do
        modeList[m.key] = m.label
    end
    modeDropdown:SetList(modeList, { "overall", "mythic", "raid" })
    modeDropdown:SetValue(NS.Core.db.profile.bisMode or "mythic")
    modeDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        NS.Core.db.profile.bisMode = value
        NS.Core.lastRanking = NS.Core:CalculateDungeonRanking()
        self:RefreshUI()
    end)
    topGroup:AddChild(modeDropdown)

    local resetBtn = AceGUI:Create("Button")
    resetBtn:SetText("Reset Exclusions")
    resetBtn:SetWidth(140)
    resetBtn:SetCallback("OnClick", function()
        wipe(NS.Core.db.profile.excludedDungeons)
        NS.Core.lastRanking = NS.Core:CalculateDungeonRanking()
        self:RefreshUI()
    end)
    topGroup:AddChild(resetBtn)

    -- === GROUP SUMMARY ===
    if scanned > 0 then
        local summaryHeading = AceGUI:Create("Heading")
        summaryHeading:SetText("Group Members")
        summaryHeading:SetFullWidth(true)
        self.mainFrame:AddChild(summaryHeading)

        local summaryGroup = AceGUI:Create("SimpleGroup")
        summaryGroup:SetFullWidth(true)
        summaryGroup:SetLayout("Flow")
        self.mainFrame:AddChild(summaryGroup)

        for playerName, playerData in pairs(NS.groupData) do
            local missing, total = NS.Core:CountMissingBIS(playerData)
            local pct = 0
            if total > 0 then
                pct = math.floor(((total - missing) / total) * 100)
            end
            local classColor = NS.CLASS_COLORS[playerData.class] or "ffffff"
            local specLabel = playerData.spec or "Unknown"

            local pLabel = AceGUI:Create("Label")
            pLabel:SetText(string.format(
                "|cff%s%s|r |cff888888(%s)|r : |cff00ff00%d|r/%d BIS (%d%%)",
                classColor, playerData.name, specLabel, total - missing, total, pct
            ))
            pLabel:SetWidth(370)
            summaryGroup:AddChild(pLabel)
        end

        -- Show skipped players warning
        if NS.skippedPlayers and #NS.skippedPlayers > 0 then
            local warnLabel = AceGUI:Create("Label")
            local warnText = "|cffff8800Skipped:|r "
            for i, msg in ipairs(NS.skippedPlayers) do
                if i > 1 then warnText = warnText .. ", " end
                warnText = warnText .. msg
            end
            warnLabel:SetText(warnText)
            warnLabel:SetFullWidth(true)
            summaryGroup:AddChild(warnLabel)
        end
    end

    -- === DUNGEON EXCLUSION CHECKBOXES ===
    local excludeHeading = AceGUI:Create("Heading")
    excludeHeading:SetText("Exclude Dungeons (already completed)")
    excludeHeading:SetFullWidth(true)
    self.mainFrame:AddChild(excludeHeading)

    local checkGroup = AceGUI:Create("SimpleGroup")
    checkGroup:SetFullWidth(true)
    checkGroup:SetLayout("Flow")
    self.mainFrame:AddChild(checkGroup)

    for _, dungeon in ipairs(NS.DUNGEONS) do
        local cb = AceGUI:Create("CheckBox")
        cb:SetLabel(dungeon.name)
        cb:SetValue(NS.Core.db.profile.excludedDungeons[dungeon.id] or false)
        cb:SetWidth(200)
        cb:SetCallback("OnValueChanged", function(widget, event, value)
            NS.Core.db.profile.excludedDungeons[dungeon.id] = value or nil
            NS.Core.lastRanking = NS.Core:CalculateDungeonRanking()
            self:RefreshUI()
        end)
        checkGroup:AddChild(cb)
    end

    -- === DUNGEON RANKING ===
    local modeLabel = modeList[NS.Core.db.profile.bisMode] or "Mythic+"
    local rankHeading = AceGUI:Create("Heading")
    rankHeading:SetText(string.format("Dungeon Ranking - %s (best to worst)", modeLabel))
    rankHeading:SetFullWidth(true)
    self.mainFrame:AddChild(rankHeading)

    local ranking = NS.Core.lastRanking or NS.Core:CalculateDungeonRanking()

    if #ranking == 0 then
        local noData = AceGUI:Create("Label")
        noData:SetText("|cffff0000No dungeons available. Check exclusions or scan the group.|r")
        noData:SetFullWidth(true)
        self.mainFrame:AddChild(noData)
        return
    end

    -- Scroll frame for results
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    self.mainFrame:AddChild(scroll)

    for rank, entry in ipairs(ranking) do
        self:CreateDungeonEntry(scroll, rank, entry)
    end
end

-- ============================================================================
-- CREATE A SINGLE DUNGEON ENTRY IN THE RANKING
-- ============================================================================
function UI:CreateDungeonEntry(parent, rank, entry)
    local dungeon = entry.dungeon
    local score = entry.score
    local details = entry.details

    -- Color based on rank
    local rankColor
    if rank == 1 then
        rankColor = "00ff00" -- green = best
    elseif rank == 2 then
        rankColor = "ffff00" -- yellow
    elseif rank == 3 then
        rankColor = "ff8800" -- orange
    else
        rankColor = "ff4444" -- red-ish
    end

    -- Dungeon header
    local dungeonGroup = AceGUI:Create("InlineGroup")
    dungeonGroup:SetFullWidth(true)

    local title = string.format(
        "|cff%s#%d|r  %s  -  |cff00ff00%d upgrade(s)|r for the group",
        rankColor, rank, dungeon.name, score
    )
    dungeonGroup:SetTitle(title)
    dungeonGroup:SetLayout("Flow")
    parent:AddChild(dungeonGroup)

    if score == 0 then
        local noUpgrade = AceGUI:Create("Label")
        noUpgrade:SetText("   |cff888888No BIS upgrades available in this dungeon.|r")
        noUpgrade:SetFullWidth(true)
        dungeonGroup:AddChild(noUpgrade)
        return
    end

    -- Sort players by number of items needed (descending)
    local sortedPlayers = {}
    for playerName, playerInfo in pairs(details) do
        table.insert(sortedPlayers, { name = playerName, info = playerInfo })
    end
    table.sort(sortedPlayers, function(a, b) return a.info.count > b.info.count end)

    -- Show ALL players (no limit)
    for _, playerEntry in ipairs(sortedPlayers) do
        local pInfo = playerEntry.info
        local classColor = NS.CLASS_COLORS[pInfo.class] or "ffffff"

        -- Player line
        local playerLabel = AceGUI:Create("Label")
        local playerText = string.format(
            "   |cff%s%s|r  -  %d BIS item(s) needed:",
            classColor, pInfo.name, pInfo.count
        )
        playerLabel:SetText(playerText)
        playerLabel:SetFullWidth(true)
        dungeonGroup:AddChild(playerLabel)

        -- Item details
        for _, item in ipairs(pInfo.needed) do
            local itemLabel = AceGUI:Create("Label")

            -- Try to load item info from cache (GetItemInfo triggers async query on first call)
            local displayName
            local cachedName = GetItemInfo(item.itemId)
            if cachedName then
                displayName = cachedName
            elseif item.itemName and item.itemName ~= "" then
                displayName = item.itemName
            else
                displayName = "Item #" .. item.itemId
            end

            local itemText = string.format(
                "      |cffeda55f[%s]|r |cff69ccf0%s|r",
                item.slotName, displayName
            )
            itemLabel:SetText(itemText)
            itemLabel:SetFullWidth(true)
            dungeonGroup:AddChild(itemLabel)
        end
    end
end
