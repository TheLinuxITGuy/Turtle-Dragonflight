--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard XP bar in 1.12. I've created a new XP bar to match
Dragonflight.
]]

MainMenuExpBar:SetAlpha(0) -- Required for XPbar.lua to work

tDFUI_config = tDFUI_config or {}
tDFUI_config["Hide XP outdoors"] = tDFUI_config["Hide XP outdoors"] or 0
tDFUI_config["Always show detailed XP"] = tDFUI_config["Always show detailed XP"] or 0

function xpbar_update(xpbar, show_full)
    local currentXP = UnitXP("player")
    local maxXP = UnitXPMax("player")
    local maxExhXP = GetXPExhaustion("player") or 0
    local xpPercent = currentXP / maxXP
    local xpMaxPercent = maxExhXP / maxXP

    -- Ensure the status bar dimensions are consistent
    --xpbar.status:SetWidth(XP_BAR_STATUS_WIDTH)
    --xpbar.status:SetHeight(XP_BAR_STATUS_HEIGHT)

    if GetXPExhaustion() then
        xpbar.restedbar:Show()
        xpbar.restedbar:SetMinMaxValues(0, maxXP)
        xpbar.restedbar:SetValue(currentXP + maxExhXP)
        if xpMaxPercent == 1.5 then
            xpbar.status:SetStatusBarTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\TentMax.tga")
            xpbar.restedbar:SetStatusBarTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\TentMax.tga")
        else
            xpbar.status:SetStatusBarTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\Rested1.tga")
            xpbar.restedbar:SetStatusBarTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\Rested1.tga")
        end
    else
        xpbar.status:SetStatusBarTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\Main1.tga")
        xpbar.restedbar:Hide()
    end

    xpbar.status:SetValue(xpPercent)

    if show_full then
        xpbar.text:SetText(format("XP: %i/%i | Remaining: %i | Rested: %i/%i", currentXP, maxXP, maxXP-currentXP, maxExhXP, maxXP*1.5))
    else
        xpbar.text:SetText(format("XP: %.2f%% | Rested: %.2f%%", xpPercent * 100, xpMaxPercent * 100))
    end
end

function xpbar_hide(xpbar)
    bool = false
    if UnitLevel("player") == 60 then
        xpbar:Hide()
        bool = true
    end
    return bool
end

function xpbar_create(name)
    local XP_BAR_WIDTH = 256
    local XP_BAR_HEIGHT = 18
    local XP_BAR_STATUS_WIDTH = 508
    local XP_BAR_STATUS_HEIGHT = 400
    --local TICKER_WIDTH = 10
    --local TICKER_HEIGHT = 24
    local xpbar = CreateFrame("Frame", name, UIParent)
    xpbar:SetWidth(XP_BAR_WIDTH*2)
    xpbar:SetHeight(XP_BAR_HEIGHT)

    --xpbar.ticker = ExhaustionTick
    
    xpbar:SetWidth(510)
    xpbar:SetHeight(19)
    xpbar:SetPoint("CENTER", MainMenuExpBar, "CENTER", 0, 2) -- -588

    xpbar.leftFrame = CreateFrame("Frame", nil, xpbar)
    xpbar.leftFrame:SetWidth(XP_BAR_WIDTH)
    xpbar.leftFrame:SetHeight(XP_BAR_HEIGHT)
    xpbar.leftFrame:SetPoint("LEFT", xpbar, "LEFT", 0, 0)
    xpbar.leftFrame:SetFrameLevel(2)
    xpbar.leftTexture = xpbar.leftFrame:CreateTexture(nil, "BACKGROUND")
    xpbar.leftTexture:SetTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\XP\\leftFrame.tga")
    xpbar.leftTexture:SetAllPoints(xpbar.leftFrame)
    -- Create the right frame
    xpbar.rightFrame = CreateFrame("Frame", nil, xpbar)
    xpbar.rightFrame:SetWidth(XP_BAR_WIDTH)
    xpbar.rightFrame:SetHeight(XP_BAR_HEIGHT)
    xpbar.rightFrame:SetPoint("RIGHT", xpbar, "RIGHT", 0, 0)
    xpbar.rightFrame:SetFrameLevel(2)
    xpbar.rightTexture = xpbar.leftFrame:CreateTexture(nil, "BACKGROUND")
    xpbar.rightTexture:SetTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\XP\\leftFrame.tga")
    xpbar.rightTexture:SetAllPoints(xpbar.rightFrame)
    xpbar.rightTexture:SetTexCoord(1, 0, 0, 1) --flip right
    --ticker:SetNormalTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\ticker.tga")
    --local tickerNormalTexture = ticker:GetNormalTexture()
    --ticker:SetWidth(TICKER_WIDTH)
    --ticker:SetHeight(TICKER_HEIGHT)
    --ticker:SetPoint("TOPLEFT", MyXPBarTexture, "TOPLEFT", 0, 5)
    --tickerNormalTexture:SetTexCoord(18/32, 28/32, 8/32, 30/32)
    --ticker:SetHighlightTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\ticker.tga")
    --local tickerHighlightTexture = ticker:GetHighlightTexture()
    --tickerHighlightTexture:SetTexCoord(2/32, 16/32, 8/32, 23/32)
    -- Create the frame for the blue, purple, or green bar
    xpbar.status = CreateFrame("StatusBar", nil, xpbar)
    xpbar.status:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    xpbar.status:SetPoint("CENTER", xpbar, "CENTER", 0, 0)
    xpbar.status:SetWidth(XP_BAR_STATUS_WIDTH)
    xpbar.status:SetHeight(XP_BAR_STATUS_HEIGHT)

    xpbar.status:SetMinMaxValues(0, 1)
    xpbar.status:SetValue(1)
    xpbar.status:SetFrameLevel(1)
    -- Create the text
    xpbar.text = xpbar:CreateFontString(nil, "OVERLAY")
    xpbar.text:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
    xpbar.text:SetPoint("CENTER", xpbar, "CENTER", 0, 1)

    xpbar.restedbar = CreateFrame("StatusBar", nil, xpbar)
    xpbar.restedbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    xpbar.restedbar:SetPoint("CENTER", xpbar, "CENTER", 0, 0)
    xpbar.restedbar:SetWidth(XP_BAR_STATUS_WIDTH)
    xpbar.restedbar:SetHeight(XP_BAR_STATUS_HEIGHT)
    xpbar.restedbar:SetStatusBarColor(.1,.1,.1,.8)
    xpbar.restedbar:SetFrameLevel(0)

    xpbar:SetFrameLevel(3)

    return xpbar
end

xpbar = xpbar or xpbar_create("tDFxpbar")

xpbar_watcher = CreateFrame("Frame")
xpbar_watcher_rest = CreateFrame("Frame")

xpbar_watcher:RegisterEvent("PLAYER_ENTERING_WORLD")
xpbar_watcher:RegisterEvent("PLAYER_LEVEL_UP")
xpbar_watcher:RegisterEvent("PLAYER_XP_UPDATE")
xpbar_watcher:SetScript("OnEvent", function()
    xpbar = xpbar or xpbar_create()
    if not xpbar_hide(xpbar) then
        xpbar_update(xpbar, tDFUI_config["Always show detailed XP"] == 1 and true or nil)
    end
end)

MainMenuExpBar:SetScript("OnEnter", function(self)
    xpbar.text:Show()
    xpbar_update(xpbar, tDFUI_config["Always show detailed XP"] == 1 and true or nil)
    xpbar_watcher:SetScript("OnUpdate", function()
        if IsShiftKeyDown() then
            xpbar_update(xpbar, true)
            xpbar_watcher:SetScript("OnUpdate", nil)
        end
    end)
end)
MainMenuExpBar:SetScript("OnLeave", function(self)
    xpbar_update(xpbar, tDFUI_config["Always show detailed XP"] == 1 and true or nil)
    if tDFUI_config["Hide XP outdoors"] == 1 and not IsResting() then
        xpbar.text:Hide()
    end
    xpbar_watcher:SetScript("OnUpdate", nil)
    xpbar_watcher_rest:SetScript("OnUpdate", nil)
end)
