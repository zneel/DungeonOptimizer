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
    frame:SetTitle(NS.L["WINDOW_TITLE"])
    frame:SetStatusText(NS.L["STATUS_TEXT"])
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
    scanBtn:SetText(NS.L["SCAN_GROUP"])
    scanBtn:SetWidth(140)
    scanBtn:SetCallback("OnClick", function()
        NS.Core:ScanGroup()
    end)
    topGroup:AddChild(scanBtn)

    local countLabel = AceGUI:Create("Label")
    local scanned = NS.Inspect:GetScannedCount()
    local totalGroup = IsInGroup() and GetNumGroupMembers() or 1
    countLabel:SetText(string.format(NS.L["SCANNED_COUNT"], scanned, totalGroup))
    countLabel:SetWidth(120)
    topGroup:AddChild(countLabel)

    local resetBtn = AceGUI:Create("Button")
    resetBtn:SetText(NS.L["RESET_EXCLUSIONS"])
    resetBtn:SetWidth(140)
    resetBtn:SetCallback("OnClick", function()
        wipe(NS.Core.db.profile.excludedDungeons)
        NS.Core.lastRanking = NS.Core:CalculateDungeonRanking()
        self:RefreshUI()
    end)
    topGroup:AddChild(resetBtn)

    -- Sync button (#11)
    local syncBtn = AceGUI:Create("Button")
    syncBtn:SetText("Sync Group")
    syncBtn:SetWidth(120)
    syncBtn:SetCallback("OnClick", function()
        NS.Core:BroadcastExcluded()
        NS.Core:Print("Synced completed dungeons to group.")
    end)
    topGroup:AddChild(syncBtn)

    -- === GROUP SUMMARY ===
    if scanned > 0 then
        local summaryHeading = AceGUI:Create("Heading")
        summaryHeading:SetText(NS.L["GROUP_MEMBERS"])
        summaryHeading:SetFullWidth(true)
        self.mainFrame:AddChild(summaryHeading)

        local summaryGroup = AceGUI:Create("SimpleGroup")
        summaryGroup:SetFullWidth(true)
        summaryGroup:SetLayout("Flow")
        self.mainFrame:AddChild(summaryGroup)

        for playerName, playerData in pairs(NS.groupData) do
            local missing, total, missingDungeon, totalDungeon = NS.Core:CountMissingBIS(playerData)
            local pct = 0
            if total > 0 then
                pct = math.floor(((total - missing) / total) * 100)
            end
            local dungeonPct = 0
            if totalDungeon > 0 then
                dungeonPct = math.floor(((totalDungeon - missingDungeon) / totalDungeon) * 100)
            end
            local classColor = NS.CLASS_COLORS[playerData.class] or "ffffff"
            local specLabel = playerData.spec or NS.L["UNKNOWN_SPEC"]

            -- Use InteractiveLabel for hover tooltip (#6)
            local pLabel = AceGUI:Create("InteractiveLabel")
            pLabel:SetText(string.format(
                "|cff%s%s|r |cff888888(%s)|r : |cff00ff00%d|r/%d BIS (%d%%) - |cff69ccf0%d|r/%d dungeon (%d%%)",
                classColor, playerData.name, specLabel,
                total - missing, total, pct,
                totalDungeon - missingDungeon, totalDungeon, dungeonPct
            ))
            pLabel:SetWidth(500)

            -- Show BIS items on hover
            local capturedData = playerData
            pLabel:SetCallback("OnEnter", function(widget)
                GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                GameTooltip:AddLine(string.format(NS.L["BIS_LIST_HEADER"], classColor, capturedData.name, specLabel))
                GameTooltip:AddLine(" ")

                local bisTable = NS.GetActiveBISTable()
                local bisList = bisTable[capturedData.spec]
                if bisList then
                    for slot, bisItemId in pairs(bisList) do
                        local slotName = NS.SLOT_NAMES[slot] or "?"
                        local equipped = capturedData.gear[slot]
                        local itemName = GetItemInfo(bisItemId) or ("Item #" .. bisItemId)
                        local source = NS.IsFromDungeon(bisItemId) and "" or " |cff888888(crafted/raid)|r"

                        if equipped == bisItemId then
                            GameTooltip:AddDoubleLine(
                                slotName,
                                "|cff00ff00" .. itemName .. " " .. NS.L["EQUIPPED"] .. "|r",
                                0.6, 0.6, 0.6, 0, 1, 0
                            )
                        else
                            GameTooltip:AddDoubleLine(
                                slotName,
                                "|cffff4444" .. itemName .. " " .. NS.L["MISSING"] .. "|r" .. source,
                                0.6, 0.6, 0.6, 1, 0.27, 0.27
                            )
                        end
                    end
                else
                    GameTooltip:AddLine(NS.L["NO_BIS_DATA"])
                end

                GameTooltip:Show()
            end)
            pLabel:SetCallback("OnLeave", function()
                GameTooltip:Hide()
            end)

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
    excludeHeading:SetText(NS.L["EXCLUDE_DUNGEONS"])
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
            -- Auto-sync to group when toggling
            NS.Core:BroadcastExcluded()
        end)
        checkGroup:AddChild(cb)
    end

    -- === DUNGEON RANKING ===
    local rankHeading = AceGUI:Create("Heading")
    rankHeading:SetText(string.format(NS.L["DUNGEON_RANKING"], "Mythic+"))
    rankHeading:SetFullWidth(true)
    self.mainFrame:AddChild(rankHeading)

    local ranking = NS.Core.lastRanking or NS.Core:CalculateDungeonRanking()

    if #ranking == 0 then
        local noData = AceGUI:Create("Label")
        noData:SetText(NS.L["NO_DUNGEONS"])
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

    local upgradeText = string.format(NS.L["UPGRADES_FOR_GROUP"], score)
    local title = string.format("|cff%s#%d|r  %s  -  %s", rankColor, rank, dungeon.name, upgradeText)
    dungeonGroup:SetTitle(title)
    dungeonGroup:SetLayout("Flow")
    parent:AddChild(dungeonGroup)

    if score == 0 then
        local noUpgrade = AceGUI:Create("Label")
        noUpgrade:SetText(NS.L["NO_BIS_UPGRADES"])
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

    -- Show ALL players, items grouped by boss
    for _, playerEntry in ipairs(sortedPlayers) do
        local pInfo = playerEntry.info
        local classColor = NS.CLASS_COLORS[pInfo.class] or "ffffff"

        -- Player line
        local playerLabel = AceGUI:Create("Label")
        local playerText = string.format(
            NS.L["BIS_ITEMS_NEEDED"],
            classColor, pInfo.name, pInfo.count
        )
        playerLabel:SetText(playerText)
        playerLabel:SetFullWidth(true)
        dungeonGroup:AddChild(playerLabel)

        -- Group items by boss (#14)
        local bosses = {}
        local bossOrder = {}
        for _, item in ipairs(pInfo.needed) do
            local boss = item.boss or ""
            if boss == "" then boss = "Other" end
            if not bosses[boss] then
                bosses[boss] = {}
                table.insert(bossOrder, boss)
            end
            table.insert(bosses[boss], item)
        end

        for _, bossName in ipairs(bossOrder) do
            -- Boss sub-header
            if bossName ~= "Other" or #bossOrder > 1 then
                local bossLabel = AceGUI:Create("Label")
                bossLabel:SetText(string.format("      |cffffcc00%s:|r", bossName))
                bossLabel:SetFullWidth(true)
                dungeonGroup:AddChild(bossLabel)
            end

            for _, item in ipairs(bosses[bossName]) do
                local itemLabel = AceGUI:Create("InteractiveLabel")

                local displayName
                local cachedName = GetItemInfo(item.itemId)
                if cachedName then
                    displayName = cachedName
                elseif item.itemName and item.itemName ~= "" then
                    displayName = item.itemName
                else
                    displayName = "Item #" .. item.itemId
                end

                local indent = (bossName ~= "Other" or #bossOrder > 1) and "         " or "      "
                local itemText = string.format(
                    "%s|cffeda55f[%s]|r |cff69ccf0%s|r",
                    indent, item.slotName, displayName
                )
                itemLabel:SetText(itemText)
                itemLabel:SetFullWidth(true)

                -- Show WoW item tooltip on hover at M+ ilvl
                local capturedItemId = item.itemId
                itemLabel:SetCallback("OnEnter", function(widget)
                    GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                    -- Use SetItemByID for reliable tooltip display
                    GameTooltip:SetItemByID(capturedItemId)
                    GameTooltip:Show()
                end)
                itemLabel:SetCallback("OnLeave", function()
                    GameTooltip:Hide()
                end)

                dungeonGroup:AddChild(itemLabel)
            end
        end
    end
end
