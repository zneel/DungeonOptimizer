-- ============================================================================
-- DungeonOptimizer - UI.lua
-- Main UI with AceGUI: all panels and features
-- ============================================================================

local ADDON_NAME, NS = ...
local AceGUI = LibStub("AceGUI-3.0")

NS.UI = {}
local UI = NS.UI

UI.mainFrame = nil
UI._wasShownBeforeRun = nil

function UI:Toggle()
    if self.mainFrame and self.mainFrame:IsShown() then
        self.mainFrame:Hide()
    else
        self:Show()
    end
end

function UI:Show()
    if not self.mainFrame then
        self:CreateMainFrame()
    end
    self.mainFrame:Show()
    self:RefreshUI()

    if NS.Inspect:GetScannedCount() == 0 then
        NS.Core:ScanGroup()
    end
    -- #21: broadcast keystone on open
    NS.Core:BroadcastKeystone()
end

function UI:CreateMainFrame()
    local frame = AceGUI:Create("Frame")
    frame:SetTitle(NS.L["WINDOW_TITLE"])
    frame:SetStatusText(NS.L["STATUS_TEXT"])
    frame:SetLayout("Flow")
    frame:SetWidth(800)
    frame:SetHeight(700)
    frame:SetCallback("OnClose", function(widget) widget:Hide() end)
    self.mainFrame = frame
end

-- ============================================================================
-- #22: SEASON HISTORY TAB
-- ============================================================================
function UI:ShowHistoryTab()
    if not self.mainFrame then self:CreateMainFrame() end
    self.mainFrame:Show()
    self.mainFrame:ReleaseChildren()

    local heading = AceGUI:Create("Heading")
    heading:SetText("Season Run History")
    heading:SetFullWidth(true)
    self.mainFrame:AddChild(heading)

    local history = NS.Core:GetSeasonHistory()
    if not next(history) then
        local lbl = AceGUI:Create("Label")
        lbl:SetText("|cff888888No M+ runs found this season.|r")
        lbl:SetFullWidth(true)
        self.mainFrame:AddChild(lbl)

        local backBtn = AceGUI:Create("Button")
        backBtn:SetText("Back to Main")
        backBtn:SetWidth(150)
        backBtn:SetCallback("OnClick", function() self:RefreshUI() end)
        self.mainFrame:AddChild(backBtn)
        return
    end

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    self.mainFrame:AddChild(scroll)

    -- Sort by runs descending
    local sorted = {}
    for mapID, data in pairs(history) do
        local name = ""
        if C_ChallengeMode and C_ChallengeMode.GetMapUIInfo then
            name = C_ChallengeMode.GetMapUIInfo(mapID) or ("Map " .. mapID)
        end
        table.insert(sorted, { mapID = mapID, name = name, runs = data.runs, bestLevel = data.bestLevel, bestScore = data.bestScore })
    end
    table.sort(sorted, function(a, b) return a.bestScore > b.bestScore end)

    for _, entry in ipairs(sorted) do
        local lbl = AceGUI:Create("Label")
        lbl:SetText(string.format(
            "  |cff00ff00%s|r  -  %d runs  -  Best: +%d  (Score: %d)",
            entry.name, entry.runs, entry.bestLevel, entry.bestScore
        ))
        lbl:SetFullWidth(true)
        scroll:AddChild(lbl)
    end

    local backBtn = AceGUI:Create("Button")
    backBtn:SetText("Back to Main")
    backBtn:SetWidth(150)
    backBtn:SetCallback("OnClick", function() self:RefreshUI() end)
    self.mainFrame:AddChild(backBtn)
end

-- ============================================================================
-- MAIN REFRESH
-- ============================================================================
function UI:RefreshUI()
    if not self.mainFrame then return end
    self.mainFrame:ReleaseChildren()

    -- === TOP BAR ===
    local topGroup = AceGUI:Create("SimpleGroup")
    topGroup:SetFullWidth(true)
    topGroup:SetLayout("Flow")
    self.mainFrame:AddChild(topGroup)

    local scanBtn = AceGUI:Create("Button")
    scanBtn:SetText(NS.L["SCAN_GROUP"])
    scanBtn:SetWidth(120)
    scanBtn:SetCallback("OnClick", function() NS.Core:ScanGroup() end)
    topGroup:AddChild(scanBtn)

    local scanned = NS.Inspect:GetScannedCount()
    local totalGroup = IsInGroup() and GetNumGroupMembers() or 1
    local countLabel = AceGUI:Create("Label")
    countLabel:SetText(string.format(NS.L["SCANNED_COUNT"], scanned, totalGroup))
    countLabel:SetWidth(100)
    topGroup:AddChild(countLabel)

    local resetBtn = AceGUI:Create("Button")
    resetBtn:SetText(NS.L["RESET_EXCLUSIONS"])
    resetBtn:SetWidth(130)
    resetBtn:SetCallback("OnClick", function()
        wipe(NS.Core.db.profile.excludedDungeons)
        NS.Core.lastRanking = NS.Core:CalculateDungeonRanking()
        self:RefreshUI()
        NS.Core:BroadcastExcluded()
    end)
    topGroup:AddChild(resetBtn)

    local syncBtn = AceGUI:Create("Button")
    syncBtn:SetText("Sync")
    syncBtn:SetWidth(80)
    syncBtn:SetCallback("OnClick", function()
        NS.Core:BroadcastExcluded()
        NS.Core:BroadcastKeystone()
        NS.Core:Print("Synced to group.")
    end)
    topGroup:AddChild(syncBtn)

    -- #22: History button
    local histBtn = AceGUI:Create("Button")
    histBtn:SetText("History")
    histBtn:SetWidth(80)
    histBtn:SetCallback("OnClick", function() self:ShowHistoryTab() end)
    topGroup:AddChild(histBtn)

    -- #20: Score weight toggle
    local scoreToggle = AceGUI:Create("CheckBox")
    scoreToggle:SetLabel("M+ Score")
    scoreToggle:SetValue(NS.Core.db.profile.weightByScore)
    scoreToggle:SetWidth(110)
    scoreToggle:SetCallback("OnValueChanged", function(_, _, val)
        NS.Core.db.profile.weightByScore = val
        NS.Core.lastRanking = NS.Core:CalculateDungeonRanking()
        self:RefreshUI()
    end)
    topGroup:AddChild(scoreToggle)

    -- === #27: CURRENT AFFIXES ===
    local affixes = NS.Core:GetCurrentAffixes()
    if affixes and #affixes > 0 then
        local affixGroup = AceGUI:Create("SimpleGroup")
        affixGroup:SetFullWidth(true)
        affixGroup:SetLayout("Flow")
        self.mainFrame:AddChild(affixGroup)

        local affixText = "|cffffcc00Affixes:|r "
        for i, affix in ipairs(affixes) do
            if i > 1 then affixText = affixText .. "  " end
            affixText = affixText .. "|cff69ccf0" .. affix.name .. "|r"
        end
        local affixLabel = AceGUI:Create("Label")
        affixLabel:SetText(affixText)
        affixLabel:SetFullWidth(true)
        affixGroup:AddChild(affixLabel)
    end

    -- === #23: GREAT VAULT PROGRESS ===
    local vault = NS.Core:GetVaultProgress()
    if vault.totalRuns > 0 or (vault.slots and #vault.slots > 0) then
        local vaultGroup = AceGUI:Create("SimpleGroup")
        vaultGroup:SetFullWidth(true)
        vaultGroup:SetLayout("Flow")
        self.mainFrame:AddChild(vaultGroup)

        local vaultText = "|cffffcc00Vault:|r "
        for i, slot in ipairs(vault.slots) do
            local color = slot.progress >= slot.threshold and "00ff00" or "ff8800"
            vaultText = vaultText .. string.format(
                " Slot %d: |cff%s%d/%d|r", i, color, slot.progress, slot.threshold
            )
            if slot.level and slot.level > 0 then
                vaultText = vaultText .. string.format(" (+%d)", slot.level)
            end
        end
        if vault.hasRewards then
            vaultText = vaultText .. "  |cff00ff00[Rewards available!]|r"
        end

        local vaultLabel = AceGUI:Create("Label")
        vaultLabel:SetText(vaultText)
        vaultLabel:SetFullWidth(true)
        vaultGroup:AddChild(vaultLabel)
    end

    -- === #21: PARTY KEYSTONES ===
    local myKey = NS.Core:GetOwnKeystone()
    local hasAnyKey = myKey ~= nil or next(NS.partyKeystones) ~= nil
    if hasAnyKey then
        local keyHeading = AceGUI:Create("Heading")
        keyHeading:SetText("Party Keystones")
        keyHeading:SetFullWidth(true)
        self.mainFrame:AddChild(keyHeading)

        local keyGroup = AceGUI:Create("SimpleGroup")
        keyGroup:SetFullWidth(true)
        keyGroup:SetLayout("Flow")
        self.mainFrame:AddChild(keyGroup)

        if myKey then
            local myName = UnitName("player")
            local myClass = select(2, UnitClass("player"))
            local myColor = NS.CLASS_COLORS[myClass] or "ffffff"
            local keyLabel = AceGUI:Create("Label")
            keyLabel:SetText(string.format(
                "  |cff%s%s|r: |cff00ff00%s +%d|r",
                myColor, myName, myKey.dungeonName, myKey.level
            ))
            keyLabel:SetWidth(350)
            keyGroup:AddChild(keyLabel)
        end

        for sender, keyData in pairs(NS.partyKeystones) do
            local keyLabel = AceGUI:Create("Label")
            keyLabel:SetText(string.format(
                "  |cffaaaaaa%s|r: |cff69ccf0%s +%d|r",
                sender, keyData.dungeonName, keyData.level
            ))
            keyLabel:SetWidth(350)
            keyGroup:AddChild(keyLabel)
        end
    end

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
            local pct = total > 0 and math.floor(((total - missing) / total) * 100) or 0
            local dungeonPct = totalDungeon > 0 and math.floor(((totalDungeon - missingDungeon) / totalDungeon) * 100) or 0
            local classColor = NS.CLASS_COLORS[playerData.class] or "ffffff"
            local specLabel = playerData.spec or NS.L["UNKNOWN_SPEC"]

            local sourceTag = ""
            if playerData.source == "sync" then
                sourceTag = " |cff888888[synced]|r"
            end

            local pLabel = AceGUI:Create("InteractiveLabel")
            pLabel:SetText(string.format(
                "|cff%s%s|r |cff888888(%s)|r : |cff00ff00%d|r/%d BIS (%d%%)%s",
                classColor, playerData.name, specLabel,
                totalDungeon - missingDungeon, totalDungeon, dungeonPct,
                sourceTag
            ))
            pLabel:SetWidth(450)

            -- #19: Show BIS items with ilvl on hover
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
                        local equippedIlvl = capturedData.ilvls and capturedData.ilvls[slot]

                        if equipped == bisItemId then
                            local ilvlStr = equippedIlvl and (" ilvl " .. equippedIlvl) or ""
                            GameTooltip:AddDoubleLine(
                                slotName,
                                "|cff00ff00" .. itemName .. ilvlStr .. " " .. NS.L["EQUIPPED"] .. "|r",
                                0.6, 0.6, 0.6, 0, 1, 0
                            )
                        else
                            -- #19: show ilvl gap
                            local ilvlStr = equippedIlvl and (" (equipped: " .. equippedIlvl .. ")") or ""
                            GameTooltip:AddDoubleLine(
                                slotName,
                                "|cffff4444" .. itemName .. " " .. NS.L["MISSING"] .. "|r" .. ilvlStr,
                                0.6, 0.6, 0.6, 1, 0.27, 0.27
                            )
                        end
                    end
                else
                    GameTooltip:AddLine(NS.L["NO_BIS_DATA"])
                end
                GameTooltip:Show()
            end)
            pLabel:SetCallback("OnLeave", function() GameTooltip:Hide() end)
            summaryGroup:AddChild(pLabel)
        end

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
-- DUNGEON ENTRY IN RANKING
-- ============================================================================
function UI:CreateDungeonEntry(parent, rank, entry)
    local dungeon = entry.dungeon
    local score = entry.score
    local details = entry.details

    local rankColor
    if rank == 1 then rankColor = "00ff00"
    elseif rank == 2 then rankColor = "ffff00"
    elseif rank == 3 then rankColor = "ff8800"
    else rankColor = "ff4444" end

    local dungeonGroup = AceGUI:Create("InlineGroup")
    dungeonGroup:SetFullWidth(true)

    -- #20: show rating bonus if present
    local upgradeText = string.format(NS.L["UPGRADES_FOR_GROUP"], entry.bisScore or score)
    local bonusText = ""
    if entry.ratingBonus and entry.ratingBonus > 0 then
        bonusText = string.format(" |cff69ccf0+%d rating|r", entry.ratingBonus)
    end
    local title = string.format("|cff%s#%d|r  %s  -  %s%s", rankColor, rank, dungeon.name, upgradeText, bonusText)
    dungeonGroup:SetTitle(title)
    dungeonGroup:SetLayout("Flow")
    parent:AddChild(dungeonGroup)

    if (entry.bisScore or score) == 0 and (entry.ratingBonus or 0) == 0 then
        local noUpgrade = AceGUI:Create("Label")
        noUpgrade:SetText(NS.L["NO_BIS_UPGRADES"])
        noUpgrade:SetFullWidth(true)
        dungeonGroup:AddChild(noUpgrade)
        return
    end

    if not details or not next(details) then return end

    local sortedPlayers = {}
    for playerName, playerInfo in pairs(details) do
        table.insert(sortedPlayers, { name = playerName, info = playerInfo })
    end
    table.sort(sortedPlayers, function(a, b) return a.info.count > b.info.count end)

    for _, playerEntry in ipairs(sortedPlayers) do
        local pInfo = playerEntry.info
        local classColor = NS.CLASS_COLORS[pInfo.class] or "ffffff"

        local playerLabel = AceGUI:Create("Label")
        if pInfo.count == 0 then
            -- Player doesn't need anything from this dungeon
            playerLabel:SetText(string.format(
                "   |cff%s%s|r  -  |cff555555no upgrades needed|r",
                classColor, pInfo.name
            ))
            playerLabel:SetFullWidth(true)
            dungeonGroup:AddChild(playerLabel)
            -- Skip item listing for this player
        else
            playerLabel:SetText(string.format(
                NS.L["BIS_ITEMS_NEEDED"], classColor, pInfo.name, pInfo.count
            ))
            playerLabel:SetFullWidth(true)
            dungeonGroup:AddChild(playerLabel)
        end

        if pInfo.count == 0 then
            -- Already handled above, skip to next player
        else
        -- Group items by boss
        local bosses, bossOrder = {}, {}
        for _, item in ipairs(pInfo.needed) do
            local boss = (item.boss and item.boss ~= "") and item.boss or "Other"
            if not bosses[boss] then
                bosses[boss] = {}
                table.insert(bossOrder, boss)
            end
            table.insert(bosses[boss], item)
        end

        for _, bossName in ipairs(bossOrder) do
            if bossName ~= "Other" or #bossOrder > 1 then
                local bossLabel = AceGUI:Create("Label")
                bossLabel:SetText(string.format("      |cffffcc00%s:|r", bossName))
                bossLabel:SetFullWidth(true)
                dungeonGroup:AddChild(bossLabel)
            end

            for _, item in ipairs(bosses[bossName]) do
                local itemLabel = AceGUI:Create("InteractiveLabel")

                local displayName = GetItemInfo(item.itemId)
                    or (item.itemName ~= "" and item.itemName)
                    or ("Item #" .. item.itemId)

                -- #25: Show min key level for upgrade
                local minKeyStr = ""
                local playerData = NS.groupData[playerEntry.name]
                if playerData and playerData.ilvls then
                    local equippedIlvl = playerData.ilvls[item.slot]
                    if equippedIlvl then
                        local minKey = NS.Core:GetMinKeyForUpgrade(equippedIlvl)
                        if minKey then
                            minKeyStr = string.format(" |cffaaaaaa(need +%d)|r", minKey)
                        end
                    end
                end

                local indent = (bossName ~= "Other" or #bossOrder > 1) and "         " or "      "
                itemLabel:SetText(string.format(
                    "%s|cffeda55f[%s]|r |cff69ccf0%s|r%s",
                    indent, item.slotName, displayName, minKeyStr
                ))
                itemLabel:SetFullWidth(true)

                local capturedItemId = item.itemId
                itemLabel:SetCallback("OnEnter", function(widget)
                    GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                    GameTooltip:SetItemByID(capturedItemId)
                    GameTooltip:Show()
                end)
                itemLabel:SetCallback("OnLeave", function() GameTooltip:Hide() end)

                dungeonGroup:AddChild(itemLabel)
            end
        end
        end -- close else (pInfo.count > 0)
    end
end

-- ============================================================================
-- #24: ONE-CLICK LFG LISTING
-- ============================================================================
function UI:CreateLFGListing(dungeonKey)
    if not C_LFGList then
        NS.Core:Print("|cffff0000LFG API not available.|r")
        return
    end
    if C_LFGList.GetActiveEntryInfo and C_LFGList.GetActiveEntryInfo() then
        NS.Core:Print("|cffff8800Already listed in Group Finder.|r")
        return
    end
    -- This requires a hardware event (button click) to work
    NS.Core:Print("Use the Group Finder to list for " .. (dungeonKey or "a dungeon") .. ".")
end
