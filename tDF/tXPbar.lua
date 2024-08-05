--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard XP bar in 1.12. I've created a new XP bar to match
Dragonflight.
]]

MainMenuExpBar:SetAlpha(0) -- Required for XPbar.lua to work

local playerLevel = UnitLevel("player")
local MyXPBar = CreateFrame("Frame", "MyXPBar", UIParent)
local MyXPBarTexture = MyXPBar:CreateTexture("MyXPBarTexture", "ARTWORK")
local MyXPBarStatus = CreateFrame("StatusBar", "MyXPBarStatus", UIParent)
local MyXPBarText = MyXPBar:CreateFontString(nil, "OVERLAY")
local leftFrame = CreateFrame("Frame", "LeftFrame", UIParent)
local rightFrame = CreateFrame("Frame", "RightFrame", UIParent)
MyXPBar:Hide() -- Hide initially
local ticker = ExhaustionTick

local XP_BAR_WIDTH = 256
local XP_BAR_HEIGHT = 18
local XP_BAR_STATUS_WIDTH = 508
local XP_BAR_STATUS_HEIGHT = 400
local TICKER_WIDTH = 10
local TICKER_HEIGHT = 24

if playerLevel < 60 then

  MyXPBar:SetWidth(510)
  MyXPBar:SetHeight(19)
  MyXPBar:SetPoint("CENTER", MainMenuExpBar, "CENTER", 0, 2) -- -588
  MyXPBar:Show()
  
  MyXPBarTexture:SetTexture("")
  --MyXPBarTexture:SetTexCoord(0/512, 512/512, 245/512, 264/512)
  --MyXPBarTexture:SetAllPoints(MyXPBar)

  -- Create the left frame
  leftFrame:SetWidth(XP_BAR_WIDTH)
  leftFrame:SetHeight(XP_BAR_HEIGHT)
  leftFrame:SetPoint("LEFT", MyXPBar, "LEFT", 0, 0)
  leftFrame:SetFrameStrata("MEDIUM")

  local leftTexture = leftFrame:CreateTexture(nil, "BACKGROUND")
  leftTexture:SetTexture("Interface\\AddOns\\tDF\\img\\XP\\leftFrame.tga")
  leftTexture:SetAllPoints(leftFrame)

  -- Create the right frame
  rightFrame:SetWidth(XP_BAR_WIDTH)
  rightFrame:SetHeight(XP_BAR_HEIGHT)
  rightFrame:SetPoint("RIGHT", MyXPBar, "RIGHT", 0, 0)
  rightFrame:SetFrameStrata("MEDIUM")

  local rightTexture = rightFrame:CreateTexture(nil, "BACKGROUND")
  rightTexture:SetTexture("Interface\\AddOns\\tDF\\img\\XP\\leftFrame.tga")
  rightTexture:SetAllPoints(rightFrame)
  rightTexture:SetTexCoord(1, 0, 0, 1) --flip right

  ticker:SetNormalTexture("Interface\\AddOns\\tDF\\img\\ticker.tga")
  local tickerNormalTexture = ticker:GetNormalTexture()
  ticker:SetWidth(TICKER_WIDTH)
  ticker:SetHeight(TICKER_HEIGHT)
  ticker:SetPoint("TOPLEFT", MyXPBarTexture, "TOPLEFT", 0, 5)
  tickerNormalTexture:SetTexCoord(18/32, 28/32, 8/32, 30/32)

  ticker:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\ticker.tga")
  local tickerHighlightTexture = ticker:GetHighlightTexture()
  tickerHighlightTexture:SetTexCoord(2/32, 16/32, 8/32, 23/32)

  -- Create the frame for the blue, purple, or green bar
  MyXPBarStatus:SetWidth(XP_BAR_STATUS_WIDTH)
  MyXPBarStatus:SetHeight(XP_BAR_STATUS_HEIGHT)
  MyXPBarStatus:SetPoint("CENTER", MyXPBar, "CENTER", 0, 0)
  MyXPBarStatus:SetMinMaxValues(0, 1)
  MyXPBarStatus:SetValue(1)
  MyXPBarStatus:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
  MyXPBarStatus:SetFrameStrata("LOW")

  -- Create the text
  MyXPBarText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
  MyXPBarText:SetPoint("CENTER", MyXPBar, "CENTER", 0, 2)
  MyXPBar:SetFrameStrata("HIGH")

  -- Register the events
  MyXPBar:RegisterEvent("PLAYER_XP_UPDATE")
  MyXPBar:RegisterEvent("PLAYER_LEVEL_UP")
  MyXPBar:RegisterEvent("PLAYER_ENTERING_WORLD")

  --update
  local function UpdateXPBar()
  local currentXP = UnitXP("player")
  local maxXP = UnitXPMax("player")
  local maxExhXP = GetXPExhaustion("player") or 0
  local xpPercent = currentXP / maxXP
  local xpMaxPercent = maxExhXP / maxXP

    -- Ensure the status bar dimensions are consistent
    MyXPBarStatus:SetWidth(XP_BAR_STATUS_WIDTH)
    MyXPBarStatus:SetHeight(XP_BAR_STATUS_HEIGHT)

    if GetXPExhaustion() then
        if xpMaxPercent == 1.5 then
            MyXPBarStatus:SetStatusBarTexture("Interface\\AddOns\\tDF\\img\\TentMax.tga")
        else
            MyXPBarStatus:SetStatusBarTexture("Interface\\AddOns\\tDF\\img\\Rested1.tga")
        end
    else
        MyXPBarStatus:SetStatusBarTexture("Interface\\AddOns\\tDF\\img\\Main1.tga")
    end

    MyXPBarStatus:SetValue(xpPercent)
    MyXPBarText:SetText(format("XP: %.2f%% | Rested: %.2f%%", xpPercent * 100, xpMaxPercent * 100))
  end

    -- Show the text when the mouse enters the frame
    MainMenuExpBar:SetScript("OnEnter", function(self)
        MyXPBarText:Show()
        UpdateXPBar()
    end)

    -- Hide the text when the mouse leaves the frame
    MainMenuExpBar:SetScript("OnLeave", function(self)
        MyXPBarText:Hide()
    end)

    -- Update the event handler
    MyXPBar:SetScript("OnEvent", function(self, event, ...)
        if event == "PLAYER_ENTERING_WORLD" then
            self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        end
        UpdateXPBar()
    end)
    UpdateXPBar()
end

-- Hide the XP bar if you're 60
local loginFrame = CreateFrame("Frame")
loginFrame:SetScript("OnEvent", function()
    loginFrame:SetScript("OnUpdate", function(self, elapsed)
        if UnitLevel("player") == 60 then
            MyXPBar:Hide()
            leftFrame:Hide()
            rightFrame:Hide()
        end
    end)
end)
loginFrame:RegisterEvent("PLAYER_LOGIN")