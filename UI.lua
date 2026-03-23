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

function UI:IsVisible()
    return self.mainFrame and self.mainFrame:IsShown()
end

function UI:RefreshIfVisible()
    if self:IsVisible() then
        self:RefreshUI()
    end
end

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
    -- Broadcast off-spec on open
    NS.Core:BroadcastOffSpec()
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
    resetBtn:SetWidth(150)
    resetBtn:SetCallback("OnClick", function()
        wipe(NS.Core.db.profile.excludedDungeons)
        local myName = NS.Inspect:GetUnitFullName("player")
        if myName then NS.groupCompletions[myName] = {} end
        NS.Core:RecalculateAllRankings()
        self:RefreshUI()
        NS.Core:BroadcastCompletions()
    end)
    topGroup:AddChild(resetBtn)

    local syncBtn = AceGUI:Create("Button")
    syncBtn:SetText("Sync")
    syncBtn:SetWidth(80)
    syncBtn:SetCallback("OnClick", function()
        NS.Core:BroadcastCompletions()
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
        NS.Core:RecalculateAllRankings()
        self:RefreshUI()
    end)
    topGroup:AddChild(scoreToggle)

    -- Off-Spec dropdown
    local playerClass = select(2, UnitClass("player"))
    local classSpecs = NS.CLASS_SPECS[playerClass]
    local currentSpec = NS.Inspect:GetPlayerSpecKey()
    if classSpecs and #classSpecs > 1 then
        local offSpecDropdown = AceGUI:Create("Dropdown")
        offSpecDropdown:SetLabel(NS.L["OFF_SPEC_LABEL"] or "Off-Spec:")
        offSpecDropdown:SetWidth(150)

        local specList = { ["NONE"] = NS.L["OFF_SPEC_NONE"] or "None" }
        local order = { "NONE" }
        for _, specInfo in ipairs(classSpecs) do
            if specInfo.key ~= currentSpec then
                specList[specInfo.key] = NS.GetSpecShortName(specInfo.key)
                table.insert(order, specInfo.key)
            end
        end
        offSpecDropdown:SetList(specList, order)
        offSpecDropdown:SetValue(NS.Core.db.profile.offSpec or "NONE")
        offSpecDropdown:SetCallback("OnValueChanged", function(_, _, val)
            NS.Core.db.profile.offSpec = (val ~= "NONE") and val or nil
            NS.Core:SeedLocalOffSpec()
            NS.Core:BroadcastOffSpec()
            NS.Core:RecalculateAllRankings()
            self:RefreshUI()
        end)
        topGroup:AddChild(offSpecDropdown)
    end

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
    if vault.slots and #vault.slots > 0 then
        local vaultHeading = AceGUI:Create("Heading")
        vaultHeading:SetText("Great Vault")
        vaultHeading:SetFullWidth(true)
        self.mainFrame:AddChild(vaultHeading)

        if vault.hasRewards then
            local rewardLabel = AceGUI:Create("Label")
            rewardLabel:SetText("|cff00ff00Unclaimed rewards available!|r")
            rewardLabel:SetFullWidth(true)
            self.mainFrame:AddChild(rewardLabel)
        end

        local slotNames = { "1 dungeon", "4 dungeons", "8 dungeons" }
        for i, slot in ipairs(vault.slots) do
            local slotGroup = AceGUI:Create("SimpleGroup")
            slotGroup:SetFullWidth(true)
            slotGroup:SetLayout("Flow")
            self.mainFrame:AddChild(slotGroup)

            local unlocked = slot.progress >= slot.threshold
            local statusIcon = unlocked and "|cff00ff00[+]|r" or "|cffff8800[-]|r"
            local progressColor = unlocked and "00ff00" or "ff8800"
            local progressText = string.format("|cff%s%d/%d|r", progressColor, slot.progress, slot.threshold)

            local keyInfo = ""
            if slot.level and slot.level > 0 then
                keyInfo = string.format("  |cff69ccf0(+%d key)|r", slot.level)
            end

            local label = AceGUI:Create("Label")
            label:SetText(string.format("  %s  Slot %d (%s): %s%s",
                statusIcon, i, slotNames[i] or "?", progressText, keyInfo))
            label:SetFullWidth(true)
            slotGroup:AddChild(label)
        end
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
        -- #38: Key Route suggestion
        local keyRoute = NS.Core:CalculateKeyRoute()
        if #keyRoute > 1 then
            local routeLabel = AceGUI:Create("Label")
            local routeText = "  |cffffcc00Suggested order:|r "
            for i, key in ipairs(keyRoute) do
                if i > 1 then routeText = routeText .. " > " end
                local color = key.ownerClass and NS.CLASS_COLORS[key.ownerClass] or "aaaaaa"
                routeText = routeText .. string.format(
                    "|cff%s%s|r's %s +%d",
                    color, key.ownerShort, key.dungeonName, key.level
                )
                if key.bisScore > 0 then
                    routeText = routeText .. string.format(" |cff00ff00(%d BIS)|r", key.bisScore)
                end
            end
            routeLabel:SetText(routeText)
            routeLabel:SetFullWidth(true)
            keyGroup:AddChild(routeLabel)
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

            local offSpecTag = ""
            if playerData.offSpec then
                local osName = NS.GetSpecShortName(playerData.offSpec)
                offSpecTag = string.format(" |cffcc88ff+%s|r", osName or playerData.offSpec)
            end

            -- #37: Catalyst/tier info
            local tierTag = ""
            local catalystData = NS.groupCatalyst[playerName]
            if catalystData then
                tierTag = string.format(" |cffeda55f[%d/5 tier, %d charge(s)]|r",
                    catalystData.tierCount, catalystData.charges)
            else
                local tierCount = NS.Core:GetTierSetCount(playerData)
                if tierCount > 0 then
                    tierTag = string.format(" |cffeda55f[%d/5 tier]|r", tierCount)
                end
            end

            local pLabel = AceGUI:Create("InteractiveLabel")
            pLabel:SetText(string.format(
                "|cff%s%s|r |cff888888(%s%s)|r : |cff00ff00%d|r/%d BIS (%d%%)%s%s",
                classColor, playerData.name, specLabel, offSpecTag,
                totalDungeon - missingDungeon, totalDungeon, dungeonPct,
                tierTag, sourceTag
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
                    -- Pre-count BIS and gear item occurrences for duplicate handling
                    local bisItemCounts = {}
                    for _, bid in pairs(bisList) do
                        bisItemCounts[bid] = (bisItemCounts[bid] or 0) + 1
                    end
                    local gearItemCounts = {}
                    for _, gid in pairs(capturedData.gear) do
                        gearItemCounts[gid] = (gearItemCounts[gid] or 0) + 1
                    end
                    local accountedFor = {}

                    for _, slot in ipairs(NS.SLOT_DISPLAY_ORDER) do
                        local bisItemId = bisList[slot]
                        if bisItemId then
                            local slotName = NS.SLOT_NAMES[slot] or "?"
                            local itemName = GetItemInfo(bisItemId) or ("Item #" .. bisItemId)

                            -- Check equipped: item found anywhere in gear, respecting duplicate counts
                            accountedFor[bisItemId] = (accountedFor[bisItemId] or 0) + 1
                            local needed = bisItemCounts[bisItemId] or 1
                            local have = math.min(gearItemCounts[bisItemId] or 0, needed)
                            local isEquipped = (have >= accountedFor[bisItemId])

                            local equippedIlvl = capturedData.ilvls and capturedData.ilvls[slot]

                            if isEquipped then
                                local ilvlStr = equippedIlvl and (" ilvl " .. equippedIlvl) or ""
                                GameTooltip:AddDoubleLine(
                                    slotName,
                                    "|cff00ff00" .. itemName .. ilvlStr .. " " .. NS.L["EQUIPPED"] .. "|r",
                                    0.6, 0.6, 0.6, 0, 1, 0
                                )
                            else
                                local ilvlStr = equippedIlvl and (" (equipped: " .. equippedIlvl .. ")") or ""
                                GameTooltip:AddDoubleLine(
                                    slotName,
                                    "|cffff4444" .. itemName .. " " .. NS.L["MISSING"] .. "|r" .. ilvlStr,
                                    0.6, 0.6, 0.6, 1, 0.27, 0.27
                                )
                            end
                        end
                    end
                else
                    GameTooltip:AddLine(NS.L["NO_BIS_DATA"])
                end

                -- Off-spec BIS section
                if capturedData.offSpec then
                    local offBisList = bisTable[capturedData.offSpec]
                    if offBisList then
                        local osName = NS.GetSpecShortName(capturedData.offSpec)
                        GameTooltip:AddLine(" ")
                        GameTooltip:AddLine(string.format("|cffcc88ffOff-Spec (%s)|r", osName or capturedData.offSpec))

                        for _, slot in ipairs(NS.SLOT_DISPLAY_ORDER) do
                            local bisItemId = offBisList[slot]
                            if bisItemId then
                                local slotName = NS.SLOT_NAMES[slot] or "?"
                                local itemName = GetItemInfo(bisItemId) or ("Item #" .. bisItemId)
                                GameTooltip:AddDoubleLine(
                                    slotName,
                                    "|cffcc88ff" .. itemName .. "|r",
                                    0.6, 0.6, 0.6, 0.8, 0.53, 1.0
                                )
                            end
                        end
                    end
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

    -- === #35: LOOT ALERTS ===
    self:RenderLootAlerts(self.mainFrame)

    -- === TAB GROUP (M+ / Raid) ===
    local tabGroup = AceGUI:Create("TabGroup")
    tabGroup:SetFullWidth(true)
    tabGroup:SetFullHeight(true)
    tabGroup:SetLayout("Flow")
    tabGroup:SetTabs({
        { text = NS.L["TAB_MPLUS"], value = "mplus" },
        { text = NS.L["TAB_RAID"], value = "raid" },
        { text = NS.L["TAB_OVERALL"], value = "overall" },
    })

    tabGroup:SetCallback("OnGroupSelected", function(container, event, group)
        container:ReleaseChildren()
        NS.Core.db.profile.activeTab = group
        if group == "mplus" then
            self:RenderMPlusContent(container)
        elseif group == "raid" then
            self:RenderRaidContent(container)
        elseif group == "overall" then
            self:RenderOverallContent(container)
        end
    end)

    self.mainFrame:AddChild(tabGroup)
    tabGroup:SelectTab(NS.Core.db.profile.activeTab or "mplus")
end

-- ============================================================================
-- M+ TAB CONTENT
-- ============================================================================
function UI:RenderMPlusContent(parent)
    -- === DUNGEON COMPLETIONS ===
    local excludeHeading = AceGUI:Create("Heading")
    excludeHeading:SetText(NS.L["EXCLUDE_DUNGEONS"])
    excludeHeading:SetFullWidth(true)
    parent:AddChild(excludeHeading)

    local checkGroup = AceGUI:Create("SimpleGroup")
    checkGroup:SetFullWidth(true)
    checkGroup:SetLayout("Flow")
    parent:AddChild(checkGroup)

    for _, dungeon in ipairs(NS.DUNGEONS) do
        local cb = AceGUI:Create("CheckBox")

        -- Build label with completer names
        local completers = NS.Core:GetDungeonCompleters(dungeon.id)
        local label = dungeon.name
        if #completers > 0 then
            local shortNames = {}
            for _, fullName in ipairs(completers) do
                table.insert(shortNames, fullName:match("^([^-]+)") or fullName)
            end
            label = label .. " |cff888888(" .. table.concat(shortNames, ", ") .. ")|r"
        end
        cb:SetLabel(label)

        -- Checkbox reflects YOUR completion state
        cb:SetValue(NS.Core.db.profile.excludedDungeons[dungeon.id] or false)
        cb:SetWidth(280)

        cb:SetCallback("OnValueChanged", function(widget, event, value)
            NS.Core.db.profile.excludedDungeons[dungeon.id] = value or nil
            local myName = NS.Inspect:GetUnitFullName("player")
            if myName then
                NS.groupCompletions[myName] = NS.groupCompletions[myName] or {}
                NS.groupCompletions[myName][dungeon.id] = value or nil
            end
            NS.Core:RecalculateAllRankings()
            self:RefreshUI()
            NS.Core:BroadcastCompletions()
        end)

        -- Tooltip showing full Name-Realm of completers
        local capturedDungeon = dungeon
        cb:SetCallback("OnEnter", function(widget)
            local tips = NS.Core:GetDungeonCompleters(capturedDungeon.id)
            if #tips > 0 then
                GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
                GameTooltip:AddLine(capturedDungeon.name .. " - " .. NS.L["COMPLETED_BY"])
                for _, name in ipairs(tips) do
                    GameTooltip:AddLine("  " .. name, 0.5, 1.0, 0.5)
                end
                GameTooltip:Show()
            end
        end)
        cb:SetCallback("OnLeave", function() GameTooltip:Hide() end)

        checkGroup:AddChild(cb)
    end

    -- === DUNGEON RANKING ===
    local rankHeading = AceGUI:Create("Heading")
    rankHeading:SetText(string.format(NS.L["DUNGEON_RANKING"], "Mythic+"))
    rankHeading:SetFullWidth(true)
    parent:AddChild(rankHeading)

    local ranking = NS.Core.lastRanking or NS.Core:CalculateDungeonRanking()

    if #ranking == 0 then
        local noData = AceGUI:Create("Label")
        noData:SetText(NS.L["NO_DUNGEONS"])
        noData:SetFullWidth(true)
        parent:AddChild(noData)
        return
    end

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    parent:AddChild(scroll)

    for rank, entry in ipairs(ranking) do
        self:CreateDungeonEntry(scroll, rank, entry)
    end
end

-- ============================================================================
-- RAID TAB CONTENT
-- ============================================================================
function UI:RenderRaidContent(parent)
    local rankHeading = AceGUI:Create("Heading")
    rankHeading:SetText(string.format(NS.L["RAID_RANKING"] or NS.L["DUNGEON_RANKING"], "Raid"))
    rankHeading:SetFullWidth(true)
    parent:AddChild(rankHeading)

    local ranking = NS.Core.lastRaidRanking or NS.Core:CalculateRaidRanking()

    if #ranking == 0 or (ranking[1] and ranking[1].score == 0 and not next(NS.RAID_LOOT)) then
        local noData = AceGUI:Create("Label")
        noData:SetText(NS.L["NO_RAIDS"])
        noData:SetFullWidth(true)
        parent:AddChild(noData)
        return
    end

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    parent:AddChild(scroll)

    for rank, entry in ipairs(ranking) do
        self:CreateDungeonEntry(scroll, rank, entry)
    end
end

-- ============================================================================
-- OVERALL TAB CONTENT
-- ============================================================================
function UI:RenderOverallContent(parent)
    local rankHeading = AceGUI:Create("Heading")
    rankHeading:SetText(NS.L["OVERALL_RANKING"] or "Overall BIS Ranking")
    rankHeading:SetFullWidth(true)
    parent:AddChild(rankHeading)

    local ranking = NS.Core.lastOverallRanking or NS.Core:CalculateOverallRanking()

    if not NS.BIS_OVERALL or not next(NS.BIS_OVERALL) then
        local noData = AceGUI:Create("Label")
        noData:SetText(NS.L["NO_OVERALL"])
        noData:SetFullWidth(true)
        parent:AddChild(noData)
        return
    end

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    parent:AddChild(scroll)

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
    -- #40: Timer prediction
    local timerText = ""
    if not entry.isRaid then
        local prediction = NS.Core:GetDungeonTimerPrediction(dungeon.id)
        if prediction then
            timerText = string.format(" |cff%s[%d%% %s]|r", prediction.color, prediction.confidence, prediction.tag)
        end
    end

    local title = string.format("|cff%s#%d|r  %s  -  %s%s%s", rankColor, rank, dungeon.name, upgradeText, bonusText, timerText)
    dungeonGroup:SetTitle(title)
    dungeonGroup:SetLayout("Flow")
    parent:AddChild(dungeonGroup)

    -- #39: Affix strategy tip
    if not entry.isRaid then
        local affixes = NS.Core:GetCurrentAffixes()
        if affixes then
            for _, affix in ipairs(affixes) do
                local tipData = NS.AFFIX_TIPS[affix.id]
                if tipData then
                    local tip = (tipData.dungeons and tipData.dungeons[dungeon.id]) or tipData.general
                    if tip then
                        local tipLabel = AceGUI:Create("Label")
                        tipLabel:SetText(string.format("   |cffaaaaaa%s: %s|r", affix.name, tip))
                        tipLabel:SetFullWidth(true)
                        dungeonGroup:AddChild(tipLabel)
                    end
                end
            end
        end
    end

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
            playerLabel:SetText(string.format(
                "   |cff%s%s|r  -  |cff555555no upgrades needed|r",
                classColor, pInfo.name
            ))
            playerLabel:SetFullWidth(true)
            dungeonGroup:AddChild(playerLabel)
        else
            -- Show main-spec count + off-spec count if any
            local countText
            if pInfo.offSpecCount and pInfo.offSpecCount > 0 then
                local osTag = NS.L["OFF_SPEC_TAG"] or "[OS]"
                countText = string.format("%d BIS item(s) needed |cffcc88ff(+%d %s)|r",
                    pInfo.mainSpecCount or pInfo.count, pInfo.offSpecCount, osTag)
            else
                countText = string.format("%d BIS item(s) needed:", pInfo.count)
            end
            playerLabel:SetText(string.format(
                "   |cff%s%s|r  -  %s", classColor, pInfo.name, countText
            ))
            playerLabel:SetFullWidth(true)
            dungeonGroup:AddChild(playerLabel)

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
                    if item.isOffSpec then
                        local osTag = NS.L["OFF_SPEC_TAG"] or "[OS]"
                        itemLabel:SetText(string.format(
                            "%s|cffcc88ff%s [%s]|r |cffcc88ff%s|r%s",
                            indent, osTag, item.slotName, displayName, minKeyStr
                        ))
                    else
                        itemLabel:SetText(string.format(
                            "%s|cffeda55f[%s]|r |cff69ccf0%s|r%s",
                            indent, item.slotName, displayName, minKeyStr
                        ))
                    end
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
        end
    end
end

-- ============================================================================
-- ============================================================================
-- #41: READY CHECK RESULTS
-- ============================================================================
function UI:ShowReadyCheckResults(results)
    if not self.mainFrame then self:CreateMainFrame() end
    self.mainFrame:Show()
    self.mainFrame:ReleaseChildren()

    local heading = AceGUI:Create("Heading")
    heading:SetText(NS.L["READYCHECK_TITLE"])
    heading:SetFullWidth(true)
    self.mainFrame:AddChild(heading)

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    self.mainFrame:AddChild(scroll)

    for _, result in ipairs(results) do
        local classColor = NS.CLASS_COLORS[result.class] or "ffffff"

        local playerGroup = AceGUI:Create("InlineGroup")
        playerGroup:SetFullWidth(true)
        playerGroup:SetTitle(string.format(
            "|cff%s%s|r  [%d/%d]",
            classColor, result.name, result.passCount, result.totalChecks
        ))
        playerGroup:SetLayout("Flow")
        scroll:AddChild(playerGroup)

        if not result.inRange then
            local rangeLabel = AceGUI:Create("Label")
            rangeLabel:SetText("   " .. NS.L["READYCHECK_RANGE"])
            rangeLabel:SetFullWidth(true)
            playerGroup:AddChild(rangeLabel)
        else
            -- Enchants
            local enchantStatus = result.checks.enchants.pass and NS.L["READYCHECK_PASS"] or NS.L["READYCHECK_FAIL"]
            local enchantExtra = ""
            if not result.checks.enchants.pass and #result.checks.enchants.missing > 0 then
                enchantExtra = " (" .. table.concat(result.checks.enchants.missing, ", ") .. ")"
            end
            local enchantLabel = AceGUI:Create("Label")
            enchantLabel:SetText(string.format("   %s %s: %s%s",
                result.checks.enchants.pass and "|cff00ff00[+]|r" or "|cffff4444[-]|r",
                NS.L["READYCHECK_ENCHANTS"], enchantStatus, enchantExtra))
            enchantLabel:SetFullWidth(true)
            playerGroup:AddChild(enchantLabel)

            -- Gems
            local gemStatus = result.checks.gems.pass and NS.L["READYCHECK_PASS"] or NS.L["READYCHECK_FAIL"]
            local gemLabel = AceGUI:Create("Label")
            gemLabel:SetText(string.format("   %s %s: %s",
                result.checks.gems.pass and "|cff00ff00[+]|r" or "|cffff4444[-]|r",
                NS.L["READYCHECK_GEMS"], gemStatus))
            gemLabel:SetFullWidth(true)
            playerGroup:AddChild(gemLabel)

            -- Flask
            local flaskStatus = result.checks.flask.pass and NS.L["READYCHECK_PASS"] or NS.L["READYCHECK_FAIL"]
            local flaskLabel = AceGUI:Create("Label")
            flaskLabel:SetText(string.format("   %s %s: %s",
                result.checks.flask.pass and "|cff00ff00[+]|r" or "|cffff4444[-]|r",
                NS.L["READYCHECK_FLASK"], flaskStatus))
            flaskLabel:SetFullWidth(true)
            playerGroup:AddChild(flaskLabel)

            -- Food
            local foodStatus = result.checks.food.pass and NS.L["READYCHECK_PASS"] or NS.L["READYCHECK_FAIL"]
            local foodLabel = AceGUI:Create("Label")
            foodLabel:SetText(string.format("   %s %s: %s",
                result.checks.food.pass and "|cff00ff00[+]|r" or "|cffff4444[-]|r",
                NS.L["READYCHECK_FOOD"], foodStatus))
            foodLabel:SetFullWidth(true)
            playerGroup:AddChild(foodLabel)

            -- Rune
            local runeStatus = result.checks.rune.pass and NS.L["READYCHECK_PASS"] or NS.L["READYCHECK_FAIL"]
            local runeLabel = AceGUI:Create("Label")
            runeLabel:SetText(string.format("   %s %s: %s",
                result.checks.rune.pass and "|cff00ff00[+]|r" or "|cffff4444[-]|r",
                NS.L["READYCHECK_RUNE"], runeStatus))
            runeLabel:SetFullWidth(true)
            playerGroup:AddChild(runeLabel)
        end
    end

    -- Back button
    local backBtn = AceGUI:Create("Button")
    backBtn:SetText("Back to Main")
    backBtn:SetWidth(150)
    backBtn:SetCallback("OnClick", function() self:RefreshUI() end)
    self.mainFrame:AddChild(backBtn)
end

-- ============================================================================
-- #35: LOOT TRADING ALERTS
-- ============================================================================

--- Called by Core when a tradeable BIS item is detected
function UI:OnTradeableLoot(lootEvent)
    if not NS.Core.db.profile.lootAlertEnabled then return end

    -- Print a chat notification
    local looterColor = NS.CLASS_COLORS[lootEvent.looterClass] or "ffffff"
    local looterShort = lootEvent.looter:match("^([^-]+)") or lootEvent.looter
    local msg = string.format(
        "|cff00ff00%s|r %s |cff%s%s|r looted %s",
        NS.L["LOOT_TRADEABLE"],
        NS.L["LOOT_LOOTED_BY"],
        looterColor, looterShort,
        lootEvent.itemLink
    )

    -- List candidates
    for _, c in ipairs(lootEvent.candidates) do
        local pColor = NS.CLASS_COLORS[c.playerData.class] or "ffffff"
        local pShort = c.playerName:match("^([^-]+)") or c.playerName
        msg = msg .. string.format(
            " -> |cff%s%s|r (%s)",
            pColor, pShort, c.tag
        )
    end

    NS.Core:Print(msg)

    -- Refresh UI if visible to show in loot alerts section
    self:RefreshIfVisible()
end

--- Render loot alerts section in the shared top area (called from RefreshUI)
function UI:RenderLootAlerts(parent)
    if not NS.tradeableLoot or #NS.tradeableLoot == 0 then return end

    -- Only show alerts from the last 5 minutes
    local cutoff = time() - 300
    local recentAlerts = {}
    for _, alert in ipairs(NS.tradeableLoot) do
        if alert.timestamp >= cutoff then
            table.insert(recentAlerts, alert)
        end
    end
    if #recentAlerts == 0 then return end

    local heading = AceGUI:Create("Heading")
    heading:SetText(NS.L["LOOT_ALERTS"])
    heading:SetFullWidth(true)
    parent:AddChild(heading)

    for _, alert in ipairs(recentAlerts) do
        local alertGroup = AceGUI:Create("SimpleGroup")
        alertGroup:SetFullWidth(true)
        alertGroup:SetLayout("Flow")
        parent:AddChild(alertGroup)

        local looterColor = NS.CLASS_COLORS[alert.looterClass] or "ffffff"
        local looterShort = alert.looter:match("^([^-]+)") or alert.looter
        local itemName = GetItemInfo(alert.itemId) or alert.itemLink or ("Item #" .. alert.itemId)

        local infoLabel = AceGUI:Create("InteractiveLabel")
        infoLabel:SetText(string.format(
            "  |cff%s%s|r looted |cff69ccf0%s|r",
            looterColor, looterShort, itemName
        ))
        infoLabel:SetWidth(400)

        -- Item tooltip on hover
        local capturedItemId = alert.itemId
        infoLabel:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_RIGHT")
            GameTooltip:SetItemByID(capturedItemId)
            GameTooltip:Show()
        end)
        infoLabel:SetCallback("OnLeave", function() GameTooltip:Hide() end)
        alertGroup:AddChild(infoLabel)

        -- Candidates
        for _, c in ipairs(alert.candidates) do
            local pColor = NS.CLASS_COLORS[c.playerData.class] or "ffffff"
            local pShort = c.playerName:match("^([^-]+)") or c.playerName

            local candidateLabel = AceGUI:Create("Label")
            candidateLabel:SetText(string.format(
                "    -> |cff%s%s|r |cff888888(%s)|r",
                pColor, pShort, c.tag
            ))
            candidateLabel:SetFullWidth(true)
            alertGroup:AddChild(candidateLabel)
        end

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
