-- ============================================================================
-- DungeonOptimizer - UI.lua
-- V4: Hybrid AceGUI/CreateFrame dashboard
-- AceGUI handles outer frame (drag/resize/close), CreateFrame for inner components
-- ============================================================================

local ADDON_NAME, NS = ...
local AceGUI = LibStub("AceGUI-3.0")

NS.UI = {}
local UI = NS.UI

UI.mainFrame = nil
UI._wasShownBeforeRun = nil
UI._dashboardBuilt = false

-- ============================================================================
-- COLORS
-- ============================================================================
-- Colors: 3-value tables (r,g,b) for text, 4-value (r,g,b,a) for backdrops
local C = {
    bg       = { 0.06, 0.06, 0.14, 0.95 },
    border   = { 0.23, 0.23, 0.36, 1 },
    gold     = { 0.91, 0.72, 0.29 },
    green    = { 0.12, 1, 0 },
    orange   = { 1, 0.55, 0 },
    purple   = { 0.64, 0.21, 0.93 },
    blue     = { 0, 0.8, 1 },
    red      = { 1, 0.27, 0.27 },
    yellow   = { 1, 1, 0 },
    dim      = { 0.53, 0.53, 0.53 },
    white    = { 0.88, 0.88, 0.88 },
    section  = { 0.1, 0.1, 0.2, 0.8 },
    card     = { 1, 1, 1, 0.03 },
    cardBord = { 0.17, 0.17, 0.3, 1 },
}

local RANK_COLORS = {
    [1] = "00ff00",
    [2] = "e8b849",
    [3] = "ff8800",
}

local function RankColor(rank)
    return RANK_COLORS[rank] or "ff4444"
end

local function ClassColorHex(class)
    return NS.CLASS_COLORS[class] or "ffffff"
end

local function Hex(r, g, b)
    return string.format("%02x%02x%02x", r * 255, g * 255, b * 255)
end

-- ============================================================================
-- FRAME HELPERS
-- ============================================================================
local function CreatePanel(parent, r, g, b, a)
    local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    f:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
    })
    f:SetBackdropColor(r or 0.1, g or 0.1, b or 0.2, a or 0.8)
    f:SetBackdropBorderColor(unpack(C.cardBord))
    return f
end

local function CreateText(parent, size, r, g, b, justify)
    local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fs:SetFont(STANDARD_TEXT_FONT, size or 12, "")
    -- Guard: if justify got a number (from unpack leaking alpha), ignore it
    if type(justify) == "number" then justify = nil end
    fs:SetTextColor(r or 0.88, g or 0.88, b or 0.88, 1)
    if justify then fs:SetJustifyH(justify) end
    fs:SetWordWrap(false)
    return fs
end

local function CreateBar(parent, r, g, b)
    local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    bar:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8" })
    bar:SetBackdropColor(r or 0.5, g or 0.5, b or 0.5, 1)
    return bar
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================
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
    NS.Core:BroadcastKeystone()
    NS.Core:BroadcastOffSpec()
end

-- ============================================================================
-- MAIN FRAME (AceGUI outer shell)
-- ============================================================================
function UI:CreateMainFrame()
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("DungeonOptimizer")
    frame:SetStatusText(NS.L["STATUS_TEXT"])
    frame:SetLayout("Fill")
    frame:SetWidth(760)
    frame:SetHeight(750)
    frame:SetCallback("OnClose", function(widget) widget:Hide() end)
    self.mainFrame = frame

    -- Get the underlying WoW frame for parenting CreateFrame widgets
    self._innerParent = frame.frame
end

-- ============================================================================
-- DASHBOARD BUILDER (create once, reuse)
-- ============================================================================
function UI:BuildDashboard()
    if self._dashboardBuilt then return end

    local parent = self._innerParent
    -- Content area: offset from AceGUI title/statusbar
    local content = CreateFrame("Frame", nil, parent)
    content:SetPoint("TOPLEFT", parent, "TOPLEFT", 12, -28)
    content:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -12, 28)
    self._content = content

    -- Scrollable container
    local scroll = CreateFrame("ScrollFrame", "DOptDashboardScroll", content, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 0, 0)
    scroll:SetPoint("BOTTOMRIGHT", -24, 0)
    self._scroll = scroll

    local scrollChild = CreateFrame("Frame", nil, scroll)
    scrollChild:SetWidth(scroll:GetWidth() or 700)
    scroll:SetScrollChild(scrollChild)
    self._scrollChild = scrollChild

    -- We'll set scrollChild height dynamically in RefreshUI
    self._dashboardBuilt = true
end

-- ============================================================================
-- KPI CARD
-- ============================================================================
function UI:CreateKPICard(parent, x, y, width)
    local card = CreatePanel(parent, unpack(C.card))
    card:SetSize(width or 160, 60)
    card:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

    card._label = CreateText(card, 9, unpack(C.dim))
    card._label:SetPoint("TOP", card, "TOP", 0, -8)

    card._value = CreateText(card, 20, unpack(C.gold))
    card._value:SetPoint("CENTER", card, "CENTER", 0, 0)

    card._sub = CreateText(card, 9, unpack(C.dim))
    card._sub:SetPoint("BOTTOM", card, "BOTTOM", 0, 6)

    return card
end

function UI:SetKPICard(card, label, value, sub, r, g, b)
    card._label:SetText(string.upper(label))
    card._value:SetText(value)
    card._value:SetTextColor(r or unpack(C.gold))
    card._sub:SetText(sub or "")
end

-- ============================================================================
-- REFRESH UI (update data on existing frames)
-- ============================================================================
function UI:RefreshUI()
    if not self.mainFrame then return end

    self:BuildDashboard()

    local sc = self._scrollChild
    -- Clear previous dynamic frames
    if self._dynamicFrames then
        for _, f in ipairs(self._dynamicFrames) do
            f:Hide()
            f:SetParent(nil)
        end
    end
    self._dynamicFrames = {}

    local yOffset = 0
    local contentWidth = self._scroll:GetWidth() or 700

    -- Recalculate rankings
    NS.Core:RecalculateAllRankings()

    local activeMode = NS.Core.db.profile.activeMode or "mplus"

    -- === MODE TOGGLE ===
    yOffset = self:RenderModeToggle(sc, yOffset, contentWidth, activeMode)

    -- === KPI HEADER ===
    yOffset = self:RenderKPIHeader(sc, yOffset, contentWidth, activeMode)

    if activeMode == "mplus" then
        -- === GROUP KEYSTONES ===
        yOffset = self:RenderGroupKeystones(sc, yOffset, contentWidth)

        -- === BEST PICK CALLOUT ===
        yOffset = self:RenderBestPickCallout(sc, yOffset, contentWidth)
    end

    -- === DUNGEON / RAID RANKINGS ===
    yOffset = self:RenderRankings(sc, yOffset, contentWidth, activeMode)

    if activeMode == "mplus" then
        -- === GREAT VAULT ===
        yOffset = self:RenderVaultProgress(sc, yOffset, contentWidth)
    end

    -- === ACTION BUTTONS ===
    yOffset = self:RenderActionButtons(sc, yOffset, contentWidth)

    -- Set scroll child height
    sc:SetHeight(math.abs(yOffset) + 20)
    sc:SetWidth(contentWidth)
end

-- ============================================================================
-- MODE TOGGLE (M+ / Raid)
-- ============================================================================
function UI:RenderModeToggle(parent, yOffset, width, activeMode)
    local toggleFrame = CreatePanel(parent, 0.06, 0.06, 0.14, 0.9)
    toggleFrame:SetSize(width, 30)
    toggleFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
    table.insert(self._dynamicFrames, toggleFrame)

    local modes = {
        { key = "mplus", label = "M+" },
        { key = "raid", label = "Raid" },
    }

    local btnWidth = 70
    local startX = (width - (#modes * (btnWidth + 4))) / 2

    for i, mode in ipairs(modes) do
        local btn = CreateFrame("Button", nil, toggleFrame, "BackdropTemplate")
        btn:SetSize(btnWidth, 22)
        btn:SetPoint("LEFT", toggleFrame, "LEFT", startX + (i - 1) * (btnWidth + 4), 0)
        btn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            edgeSize = 1,
        })

        local isActive = (mode.key == activeMode)
        if isActive then
            btn:SetBackdropColor(0.23, 0.17, 0.43, 1)
            btn:SetBackdropBorderColor(unpack(C.gold))
        else
            btn:SetBackdropColor(0.04, 0.04, 0.12, 1)
            btn:SetBackdropBorderColor(unpack(C.cardBord))
        end

        local label = CreateText(btn, 11)
        label:SetPoint("CENTER")
        label:SetText(mode.label)
        if isActive then
            label:SetTextColor(unpack(C.gold))
        else
            label:SetTextColor(unpack(C.dim))
        end

        btn:SetScript("OnClick", function()
            NS.Core.db.profile.activeMode = mode.key
            self:RefreshUI()
        end)
    end

    return yOffset - 36
end

-- ============================================================================
-- KPI HEADER
-- ============================================================================
function UI:RenderKPIHeader(parent, yOffset, width, activeMode)
    local headerFrame = CreateFrame("Frame", nil, parent)
    headerFrame:SetSize(width, 70)
    headerFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
    table.insert(self._dynamicFrames, headerFrame)

    local cardWidth = math.floor((width - 30) / 4)
    local gap = 10

    -- Card 1: M+ Score or Raid Progress
    local card1 = self:CreateKPICard(headerFrame, 0, 0, cardWidth)
    if activeMode == "mplus" then
        local overallScore = 0
        if C_ChallengeMode and C_ChallengeMode.GetOverallDungeonScore then
            overallScore = C_ChallengeMode.GetOverallDungeonScore() or 0
        end
        self:SetKPICard(card1, "M+ Score", tostring(overallScore), nil, unpack(C.orange))
    else
        self:SetKPICard(card1, "Raid", "Gear", nil, unpack(C.purple))
    end

    -- Card 2: BIS Progress
    local card2 = self:CreateKPICard(headerFrame, cardWidth + gap, 0, cardWidth)
    local bisHave, bisTotal = 0, 0
    local myName = NS.Inspect and NS.Inspect.GetUnitFullName and NS.Inspect:GetUnitFullName("player")
    if myName and NS.groupData[myName] then
        local missing, total = NS.Core:CountMissingBIS(NS.groupData[myName])
        bisHave = total - missing
        bisTotal = total
    end
    local bisPct = bisTotal > 0 and math.floor((bisHave / bisTotal) * 100) or 0
    self:SetKPICard(card2, "BIS Progress", bisHave .. "/" .. bisTotal, bisPct .. "% complete", unpack(C.purple))

    -- Card 3: Vault
    local card3 = self:CreateKPICard(headerFrame, 2 * (cardWidth + gap), 0, cardWidth)
    local vault = NS.Core:GetVaultProgress()
    local vaultDone = 0
    local vaultTotal = vault.slots and #vault.slots or 3
    if vault.slots then
        for _, s in ipairs(vault.slots) do
            if s.progress >= s.threshold then vaultDone = vaultDone + 1 end
        end
    end
    local vaultSub = ""
    if vaultDone < vaultTotal then
        vaultSub = "Need more keys"
    else
        vaultSub = "All slots filled!"
    end
    self:SetKPICard(card3, "Vault", vaultDone .. "/" .. vaultTotal, vaultSub, unpack(C.blue))

    -- Card 4: Group Keys
    local card4 = self:CreateKPICard(headerFrame, 3 * (cardWidth + gap), 0, cardWidth)
    local numKeys = 0
    local myKey = NS.Core:GetOwnKeystone()
    if myKey then numKeys = numKeys + 1 end
    for _ in pairs(NS.partyKeystones) do numKeys = numKeys + 1 end
    local scanned = NS.Inspect:GetScannedCount()
    local totalGroup = IsInGroup() and GetNumGroupMembers() or 1
    self:SetKPICard(card4, "Group Keys", tostring(numKeys), scanned .. "/" .. totalGroup .. " scanned", unpack(C.green))

    return yOffset - 80
end

-- ============================================================================
-- GROUP KEYSTONES ROW
-- ============================================================================
function UI:RenderGroupKeystones(parent, yOffset, width)
    local keys = {}

    -- Own key first
    local myKey = NS.Core:GetOwnKeystone()
    if myKey then
        local myName = UnitName("player") or "You"
        local myClass = select(2, UnitClass("player"))
        table.insert(keys, { name = myName, class = myClass, dungeon = myKey.dungeonName, level = myKey.level })
    end

    -- Party keys
    for sender, keyData in pairs(NS.partyKeystones) do
        local shortName = sender:match("^([^-]+)") or sender
        local pClass = NS.groupData[sender] and NS.groupData[sender].class or nil
        table.insert(keys, { name = shortName, class = pClass, dungeon = keyData.dungeonName, level = keyData.level })
    end

    if #keys == 0 then
        local emptyFrame = CreateFrame("Frame", nil, parent)
        emptyFrame:SetSize(width, 24)
        emptyFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
        table.insert(self._dynamicFrames, emptyFrame)

        local emptyText = CreateText(emptyFrame, 10, unpack(C.dim))
        emptyText:SetPoint("LEFT", 8, 0)
        emptyText:SetText("No keystones detected")

        return yOffset - 28
    end

    local sectionFrame = CreateFrame("Frame", nil, parent)
    sectionFrame:SetSize(width, 40)
    sectionFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
    table.insert(self._dynamicFrames, sectionFrame)

    local titleLabel = CreateText(sectionFrame, 9, unpack(C.gold))
    titleLabel:SetPoint("TOPLEFT", 4, -2)
    titleLabel:SetText("GROUP KEYSTONES")

    -- Key pills
    local xPos = 4
    local pillY = -16
    for _, k in ipairs(keys) do
        local pillWidth = 12 + #(k.name .. " " .. k.dungeon .. " +" .. k.level) * 6

        local pill = CreatePanel(sectionFrame, 1, 1, 1, 0.04)
        pill:SetSize(pillWidth, 20)
        pill:SetPoint("TOPLEFT", sectionFrame, "TOPLEFT", xPos, pillY)

        -- Class color dot
        local dot = CreateFrame("Frame", nil, pill, "BackdropTemplate")
        dot:SetSize(8, 8)
        dot:SetPoint("LEFT", pill, "LEFT", 4, 0)
        dot:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8" })
        local cc = ClassColorHex(k.class)
        local r = tonumber(cc:sub(1, 2), 16) / 255
        local g = tonumber(cc:sub(3, 4), 16) / 255
        local b = tonumber(cc:sub(5, 6), 16) / 255
        dot:SetBackdropColor(r, g, b, 1)

        local text = CreateText(pill, 10, unpack(C.white))
        text:SetPoint("LEFT", dot, "RIGHT", 4, 0)
        text:SetText(string.format("|cff%s%s|r %s |cff00ff00+%d|r", cc, k.name, k.dungeon, k.level))

        xPos = xPos + pillWidth + 6
        if xPos + pillWidth > width then
            xPos = 4
            pillY = pillY - 24
        end
    end

    local totalHeight = math.abs(pillY) + 24
    sectionFrame:SetHeight(totalHeight)

    return yOffset - totalHeight - 6
end

-- ============================================================================
-- BEST PICK CALLOUT
-- ============================================================================
function UI:RenderBestPickCallout(parent, yOffset, width)
    local ranking = NS.Core.lastRanking
    if not ranking or #ranking == 0 then return yOffset end

    local best = ranking[1]
    if not best.rioSimulation and best.bisScore == 0 then return yOffset end

    local callout = CreatePanel(parent, 1, 0.55, 0, 0.08)
    callout:SetBackdropBorderColor(1, 0.55, 0, 0.3)
    callout:SetSize(width, 44)
    callout:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
    table.insert(self._dynamicFrames, callout)

    local arrow = CreateText(callout, 20, unpack(C.orange))
    arrow:SetPoint("LEFT", callout, "LEFT", 12, 0)
    arrow:SetText("\226\150\178") -- ▲

    local mainText = ""
    if best.rioSimulation and best.rioSimulation.delta > 0 then
        mainText = string.format(
            "Time |cffff8c00%s|r \226\134\146 Score |cffff8c00%d \226\134\146 %d (+%d)|r",
            best.dungeon.name,
            best.rioSimulation.currentTotal,
            best.rioSimulation.projectedTotal,
            math.floor(best.rioSimulation.delta)
        )
    else
        mainText = string.format("Run |cffff8c00%s|r for best gear upgrades", best.dungeon.name)
    end

    local bisCount = best.bisScore or 0
    local subText = string.format("|cffa335ee+ %d BIS items available for group|r", math.floor(bisCount))

    local mainLabel = CreateText(callout, 12, unpack(C.white))
    mainLabel:SetPoint("TOPLEFT", arrow, "TOPRIGHT", 10, 2)
    mainLabel:SetText(mainText)

    local subLabel = CreateText(callout, 10, unpack(C.purple))
    subLabel:SetPoint("TOPLEFT", mainLabel, "BOTTOMLEFT", 0, -2)
    subLabel:SetText(subText)

    return yOffset - 52
end

-- ============================================================================
-- DUNGEON / RAID RANKINGS
-- ============================================================================
function UI:RenderRankings(parent, yOffset, width, activeMode)
    local ranking
    if activeMode == "mplus" then
        ranking = NS.Core.lastRanking or {}
    else
        ranking = NS.Core.lastRaidRanking or {}
    end

    -- Section title
    local titleFrame = CreateFrame("Frame", nil, parent)
    titleFrame:SetSize(width, 18)
    titleFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
    table.insert(self._dynamicFrames, titleFrame)

    local titleText = CreateText(titleFrame, 9, unpack(C.gold))
    titleText:SetPoint("LEFT", 4, 0)
    local titleStr = activeMode == "mplus" and "DUNGEON RANKINGS" or "RAID RANKINGS"
    titleText:SetText(titleStr)

    yOffset = yOffset - 22

    if #ranking == 0 then
        local emptyFrame = CreateFrame("Frame", nil, parent)
        emptyFrame:SetSize(width, 30)
        emptyFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
        table.insert(self._dynamicFrames, emptyFrame)
        local emptyLabel = CreateText(emptyFrame, 11, unpack(C.dim))
        emptyLabel:SetPoint("LEFT", 8, 0)
        emptyLabel:SetText("No data available. Scan the group to start.")
        return yOffset - 34
    end

    for rank, entry in ipairs(ranking) do
        yOffset = self:RenderDungeonEntry(parent, yOffset, width, rank, entry, activeMode)
    end

    return yOffset
end

-- ============================================================================
-- SINGLE DUNGEON/RAID ENTRY
-- ============================================================================
function UI:RenderDungeonEntry(parent, yOffset, width, rank, entry, activeMode)
    local dungeon = entry.dungeon
    local details = entry.details or {}
    local rankCol = RankColor(rank)

    -- Count total BIS items for the group
    local totalNeeded = 0
    for _, pInfo in pairs(details) do
        totalNeeded = totalNeeded + (pInfo.mainSpecCount or 0)
    end

    -- Entry container
    local entryHeight = 44
    local entryFrame = CreatePanel(parent, 0.06, 0.06, 0.14, 0.5)
    entryFrame:SetBackdropBorderColor(0.1, 0.1, 0.2, 1)
    entryFrame:SetSize(width, entryHeight)
    entryFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
    table.insert(self._dynamicFrames, entryFrame)

    -- Rank number
    local rankLabel = CreateText(entryFrame, 18, 1, 1, 1)
    rankLabel:SetPoint("LEFT", entryFrame, "LEFT", 10, 0)
    rankLabel:SetText(string.format("|cff%s#%d|r", rankCol, rank))

    -- Dungeon name
    local nameLabel = CreateText(entryFrame, 13, unpack(C.white))
    nameLabel:SetPoint("TOPLEFT", entryFrame, "TOPLEFT", 40, -6)
    nameLabel:SetText(dungeon.name)

    -- Tags row
    local tagStr = ""

    -- BIS drops tag
    if totalNeeded > 0 then
        tagStr = tagStr .. string.format("|cffa335ee%d BIS|r  ", totalNeeded)
    end

    -- RIO tag (M+ only)
    if activeMode == "mplus" and entry.rioDelta and entry.rioDelta > 0 then
        tagStr = tagStr .. string.format("|cffff8c00+%d RIO|r  ", math.floor(entry.rioDelta))
    end

    -- Vault tag
    if entry.vaultBonus and entry.vaultBonus > 0 then
        tagStr = tagStr .. "|cff00ccffVault|r  "
    end

    -- Timer prediction (M+ only)
    if activeMode == "mplus" and not entry.isRaid then
        local prediction = NS.Core:GetDungeonTimerPrediction(dungeon.id)
        if prediction then
            tagStr = tagStr .. string.format("|cff%s%d%% %s|r  ", prediction.color, prediction.confidence, prediction.tag)
        end
    end

    -- Key owner tag
    if activeMode == "mplus" then
        local keyOwner = self:FindKeyOwner(dungeon.id)
        if keyOwner then
            tagStr = tagStr .. string.format("|cffaaaaaa%s|r  ", keyOwner)
        end
    end

    local tagLabel = CreateText(entryFrame, 10, unpack(C.dim))
    tagLabel:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 0, -2)
    tagLabel:SetText(tagStr)

    -- Score (right side)
    local scoreLabel = CreateText(entryFrame, 18, unpack(C.gold))
    scoreLabel:SetPoint("RIGHT", entryFrame, "RIGHT", -12, 4)
    local displayScore = entry.score
    if activeMode ~= "mplus" then
        displayScore = entry.bisScore or entry.score
    end
    scoreLabel:SetText(string.format("%.1f", displayScore))

    -- Score breakdown
    local breakdownLabel = CreateText(entryFrame, 9, unpack(C.dim))
    breakdownLabel:SetPoint("TOP", scoreLabel, "BOTTOM", 0, -1)
    if activeMode == "mplus" then
        local gearPart = (entry.gearWeight or 0.6) * (entry.normalizedGear or 0)
        local rioPart = (entry.rioWeight or 0.4) * (entry.normalizedRIO or 0)
        breakdownLabel:SetText(string.format("gear %.2f + rio %.2f", gearPart, rioPart))
    else
        breakdownLabel:SetText(string.format("%d items", math.floor(entry.bisScore or 0)))
    end

    -- Score bar (bottom of entry)
    local barBg = CreateBar(entryFrame, 0.1, 0.1, 0.24)
    barBg:SetSize(width - 80, 3)
    barBg:SetPoint("BOTTOMLEFT", entryFrame, "BOTTOMLEFT", 40, 4)

    local gearBarWidth = math.max(1, (entry.normalizedGear or 0) * (width - 80))
    local gearBar = CreateBar(entryFrame, unpack(C.purple))
    gearBar:SetSize(gearBarWidth, 3)
    gearBar:SetPoint("BOTTOMLEFT", barBg, "BOTTOMLEFT", 0, 0)

    if activeMode == "mplus" then
        local rioBarWidth = math.max(0, (entry.normalizedRIO or 0) * (width - 80))
        if rioBarWidth > 0 then
            local rioBar = CreateBar(entryFrame, unpack(C.orange))
            rioBar:SetSize(rioBarWidth, 3)
            rioBar:SetPoint("BOTTOMLEFT", gearBar, "BOTTOMRIGHT", 0, 0)
        end
    end

    -- Click to expand
    local isExpanded = self._expanded and self._expanded[dungeon.id]
    entryFrame:EnableMouse(true)
    entryFrame:SetScript("OnMouseDown", function()
        self._expanded = self._expanded or {}
        self._expanded[dungeon.id] = not self._expanded[dungeon.id]
        self:RefreshUI()
    end)

    -- Highlight on hover
    entryFrame:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.1, 0.1, 0.22, 0.8)
    end)
    entryFrame:SetScript("OnLeave", function(self)
        self:SetBackdropColor(0.06, 0.06, 0.14, 0.5)
    end)

    yOffset = yOffset - entryHeight - 2

    -- Expanded detail
    if isExpanded then
        yOffset = self:RenderExpandedDetail(parent, yOffset, width, details)
    end

    return yOffset
end

-- Find who has the key for a given dungeon
function UI:FindKeyOwner(dungeonId)
    -- Own key
    local myKey = NS.Core:GetOwnKeystone()
    if myKey then
        local myDungeonKey = NS.CHALLENGE_MODE_MAP and NS.CHALLENGE_MODE_MAP[myKey.mapID]
        if myDungeonKey == dungeonId then
            local name = UnitName("player") or "You"
            return name .. " +" .. myKey.level
        end
    end
    -- Party keys
    for sender, keyData in pairs(NS.partyKeystones) do
        local dk = NS.CHALLENGE_MODE_MAP and NS.CHALLENGE_MODE_MAP[keyData.mapID]
        if dk == dungeonId then
            local shortName = sender:match("^([^-]+)") or sender
            return shortName .. " +" .. keyData.level
        end
    end
    return nil
end

-- ============================================================================
-- EXPANDED PLAYER DETAIL
-- ============================================================================
function UI:RenderExpandedDetail(parent, yOffset, width, details)
    if not details or not next(details) then return yOffset end

    local sortedPlayers = {}
    for playerName, playerInfo in pairs(details) do
        table.insert(sortedPlayers, { name = playerName, info = playerInfo })
    end
    table.sort(sortedPlayers, function(a, b) return a.info.count > b.info.count end)

    for _, playerEntry in ipairs(sortedPlayers) do
        local pInfo = playerEntry.info
        local cc = ClassColorHex(pInfo.class)

        -- Player line
        local lineHeight = 16
        local playerFrame = CreateFrame("Frame", nil, parent)
        playerFrame:SetSize(width, lineHeight)
        playerFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
        table.insert(self._dynamicFrames, playerFrame)

        local playerLabel = CreateText(playerFrame, 11, unpack(C.white))
        playerLabel:SetPoint("LEFT", 48, 0)

        if pInfo.count == 0 then
            playerLabel:SetText(string.format("|cff%s%s|r  |cff555555no upgrades|r", cc, pInfo.name))
        else
            local countText = string.format("%d item(s)", pInfo.mainSpecCount or pInfo.count)
            if pInfo.offSpecCount and pInfo.offSpecCount > 0 then
                countText = countText .. string.format(" |cffcc88ff+%d OS|r", pInfo.offSpecCount)
            end
            playerLabel:SetText(string.format("|cff%s%s|r  %s", cc, pInfo.name, countText))
        end

        yOffset = yOffset - lineHeight

        -- Item lines
        if pInfo.needed then
            for _, item in ipairs(pInfo.needed) do
                local itemFrame = CreateFrame("Frame", nil, parent)
                itemFrame:SetSize(width, 14)
                itemFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
                table.insert(self._dynamicFrames, itemFrame)

                local displayName = GetItemInfo(item.itemId)
                    or (item.itemName ~= "" and item.itemName)
                    or ("Item #" .. item.itemId)

                local itemLabel = CreateText(itemFrame, 10, unpack(C.white))
                itemLabel:SetPoint("LEFT", 64, 0)

                if item.isUpgrade then
                    local ilvlStr = ""
                    if item.currentIlvl and item.targetIlvl then
                        ilvlStr = string.format(" (%d\226\134\146%d)", item.currentIlvl, item.targetIlvl)
                    end
                    itemLabel:SetText(string.format("|cff00cc00[UPG] [%s]|r |cff88cc88%s|r%s", item.slotName, displayName, ilvlStr))
                elseif item.isOffSpec then
                    itemLabel:SetText(string.format("|cffcc88ff[OS] [%s]|r |cffcc88ff%s|r", item.slotName, displayName))
                else
                    itemLabel:SetText(string.format("|cffe8b849[%s]|r |cff69ccf0%s|r", item.slotName, displayName))
                end

                -- Item tooltip on hover
                itemFrame:EnableMouse(true)
                local capturedId = item.itemId
                itemFrame:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetItemByID(capturedId)
                    GameTooltip:Show()
                end)
                itemFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)

                yOffset = yOffset - 14
            end
        end
    end

    -- Small spacer after expanded section
    yOffset = yOffset - 4
    return yOffset
end

-- ============================================================================
-- GREAT VAULT PROGRESS
-- ============================================================================
function UI:RenderVaultProgress(parent, yOffset, width)
    local vault = NS.Core:GetVaultProgress()
    if not vault.slots or #vault.slots == 0 then return yOffset end

    -- Section title
    local titleFrame = CreateFrame("Frame", nil, parent)
    titleFrame:SetSize(width, 18)
    titleFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
    table.insert(self._dynamicFrames, titleFrame)

    local titleText = CreateText(titleFrame, 9, unpack(C.gold))
    titleText:SetPoint("LEFT", 4, 0)
    titleText:SetText("GREAT VAULT PROGRESS")

    if vault.hasRewards then
        local rewardText = CreateText(titleFrame, 9, unpack(C.green))
        rewardText:SetPoint("RIGHT", -4, 0)
        rewardText:SetText("Unclaimed rewards!")
    end

    yOffset = yOffset - 22

    -- Vault slots
    local slotWidth = math.floor((width - 20) / 3)
    local slotNames = { "1 dungeon", "4 dungeons", "8 dungeons" }

    local vaultFrame = CreateFrame("Frame", nil, parent)
    vaultFrame:SetSize(width, 56)
    vaultFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
    table.insert(self._dynamicFrames, vaultFrame)

    for i, slot in ipairs(vault.slots) do
        local x = (i - 1) * (slotWidth + 10)
        local card = CreatePanel(vaultFrame, unpack(C.card))
        card:SetSize(slotWidth, 50)
        card:SetPoint("TOPLEFT", vaultFrame, "TOPLEFT", x, 0)

        -- Threshold label
        local threshLabel = CreateText(card, 9, unpack(C.dim))
        threshLabel:SetPoint("TOP", card, "TOP", 0, -6)
        threshLabel:SetText("Slot " .. i .. " \226\128\148 " .. (slotNames[i] or "?"))

        -- Progress bar
        local barBg = CreateBar(card, 0.1, 0.1, 0.24)
        barBg:SetSize(slotWidth - 16, 4)
        barBg:SetPoint("CENTER", card, "CENTER", 0, 0)

        local progress = (slot.threshold > 0) and (slot.progress / slot.threshold) or 0
        progress = math.min(progress, 1)
        local barFill = CreateBar(card, unpack(C.blue))
        barFill:SetSize(math.max(1, progress * (slotWidth - 16)), 4)
        barFill:SetPoint("LEFT", barBg, "LEFT", 0, 0)

        -- Reward label
        local rewardLabel = CreateText(card, 11, unpack(C.blue))
        rewardLabel:SetPoint("BOTTOM", card, "BOTTOM", 0, 6)
        if slot.progress >= slot.threshold then
            if slot.level and slot.level > 0 then
                rewardLabel:SetText("ilvl " .. NS.Core:GetRewardIlvlForKey(slot.level) or "?")
            else
                rewardLabel:SetText("Complete")
            end
        else
            rewardLabel:SetText(slot.progress .. "/" .. slot.threshold)
        end
    end

    return yOffset - 62
end

-- ============================================================================
-- ACTION BUTTONS
-- ============================================================================
function UI:RenderActionButtons(parent, yOffset, width)
    local btnFrame = CreateFrame("Frame", nil, parent)
    btnFrame:SetSize(width, 30)
    btnFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
    table.insert(self._dynamicFrames, btnFrame)

    local buttons = {
        { text = NS.L["SCAN_GROUP"], width = 100, fn = function() NS.Core:ScanGroup() end },
        { text = "Sync", width = 60, fn = function()
            NS.Core:BroadcastCompletions()
            NS.Core:BroadcastKeystone()
            NS.Core:Print("Synced to group.")
        end },
        { text = "History", width = 70, fn = function() self:ShowHistoryTab() end },
        { text = NS.L["RESET_EXCLUSIONS"], width = 140, fn = function()
            wipe(NS.Core.db.profile.excludedDungeons)
            local myName = NS.Inspect:GetUnitFullName("player")
            if myName then NS.groupCompletions[myName] = {} end
            NS.Core:RecalculateAllRankings()
            self:RefreshUI()
            NS.Core:BroadcastCompletions()
        end },
    }

    local xPos = 4
    for _, btnDef in ipairs(buttons) do
        local btn = CreateFrame("Button", nil, btnFrame, "BackdropTemplate")
        btn:SetSize(btnDef.width, 22)
        btn:SetPoint("LEFT", btnFrame, "LEFT", xPos, 0)
        btn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            edgeSize = 1,
        })
        btn:SetBackdropColor(0.23, 0.17, 0.43, 1)
        btn:SetBackdropBorderColor(0.35, 0.29, 0.56, 1)

        local label = CreateText(btn, 10, unpack(C.gold))
        label:SetPoint("CENTER")
        label:SetText(btnDef.text)

        btn:SetScript("OnClick", function()
            btnDef.fn()
        end)
        btn:SetScript("OnEnter", function(self)
            self:SetBackdropColor(0.3, 0.24, 0.55, 1)
        end)
        btn:SetScript("OnLeave", function(self)
            self:SetBackdropColor(0.23, 0.17, 0.43, 1)
        end)

        xPos = xPos + btnDef.width + 6
    end

    return yOffset - 36
end

-- ============================================================================
-- SEASON HISTORY TAB (kept from v3)
-- ============================================================================
function UI:ShowHistoryTab()
    if not self.mainFrame then self:CreateMainFrame() end
    self.mainFrame:Show()

    -- Hide dashboard, show history via AceGUI
    if self._content then self._content:Hide() end

    -- Use AceGUI for this secondary view
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
        backBtn:SetText("Back to Dashboard")
        backBtn:SetWidth(150)
        backBtn:SetCallback("OnClick", function()
            self.mainFrame:ReleaseChildren()
            if self._content then self._content:Show() end
            self:RefreshUI()
        end)
        self.mainFrame:AddChild(backBtn)
        return
    end

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    self.mainFrame:AddChild(scroll)

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
    backBtn:SetText("Back to Dashboard")
    backBtn:SetWidth(150)
    backBtn:SetCallback("OnClick", function()
        self.mainFrame:ReleaseChildren()
        if self._content then self._content:Show() end
        self:RefreshUI()
    end)
    self.mainFrame:AddChild(backBtn)
end

-- ============================================================================
-- READY CHECK RESULTS (kept from v3)
-- ============================================================================
function UI:ShowReadyCheckResults(results)
    if not self.mainFrame then self:CreateMainFrame() end
    self.mainFrame:Show()

    if self._content then self._content:Hide() end
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
            local checks = {
                { key = "enchants", label = NS.L["READYCHECK_ENCHANTS"] },
                { key = "gems", label = NS.L["READYCHECK_GEMS"] },
                { key = "flask", label = NS.L["READYCHECK_FLASK"] },
                { key = "food", label = NS.L["READYCHECK_FOOD"] },
                { key = "rune", label = NS.L["READYCHECK_RUNE"] },
            }
            for _, check in ipairs(checks) do
                local data = result.checks[check.key]
                local status = data.pass and NS.L["READYCHECK_PASS"] or NS.L["READYCHECK_FAIL"]
                local icon = data.pass and "|cff00ff00[+]|r" or "|cffff4444[-]|r"
                local extra = ""
                if not data.pass and data.missing and #data.missing > 0 then
                    extra = " (" .. table.concat(data.missing, ", ") .. ")"
                end
                local lbl = AceGUI:Create("Label")
                lbl:SetText(string.format("   %s %s: %s%s", icon, check.label, status, extra))
                lbl:SetFullWidth(true)
                playerGroup:AddChild(lbl)
            end
        end
    end

    local backBtn = AceGUI:Create("Button")
    backBtn:SetText("Back to Dashboard")
    backBtn:SetWidth(150)
    backBtn:SetCallback("OnClick", function()
        self.mainFrame:ReleaseChildren()
        if self._content then self._content:Show() end
        self:RefreshUI()
    end)
    self.mainFrame:AddChild(backBtn)
end

-- ============================================================================
-- LFG LISTING (kept from v3)
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
    NS.Core:Print("Use the Group Finder to list for " .. (dungeonKey or "a dungeon") .. ".")
end
