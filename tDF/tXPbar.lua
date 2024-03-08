--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard XP bar in 1.12. I've created a new XP bar to match
Dragonflight.
]]

MainMenuExpBar:SetAlpha(0) --Required for XPbar.lua to work

local MyXPBar = CreateFrame("Frame", "MyXPBar", UIParent)
MyXPBar:SetWidth(510)
MyXPBar:SetHeight(19)
MyXPBar:SetPoint("CENTER", MainMenuExpBar, "CENTER", 0, 2) -- -588
MyXPBar:Show()
MyXPBar:SetFrameStrata("HIGH")

local MyXPBarTexture = MyXPBar:CreateTexture("MyXPBarTexture", "ARTWORK")
MyXPBarTexture:SetTexture("Interface\\AddOns\\tDF\\img\\XP512.tga")
--MyXPBarTexture:SetVertexColor(0, 0.8, 1)
MyXPBarTexture:SetTexCoord(0/512, 512/512, 245/512, 264/512)
MyXPBarTexture:SetAllPoints(MyXPBar)

-- Create the frame for the blue or purple bar
local MyXPBarStatus = CreateFrame("StatusBar", "MyXPBarStatus", UIParent)
MyXPBarStatus:SetWidth(500)
MyXPBarStatus:SetHeight(9)
MyXPBarStatus:SetPoint("CENTER", MyXPBar, "CENTER", 0, 0)
MyXPBarStatus:SetMinMaxValues(0, 1)
MyXPBarStatus:SetValue(1)

-- Set the texture
MyXPBarStatus:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
MyXPBarStatus:SetStatusBarColor(1, 0, 1, 1)

-- Create the text
local MyXPBarText = MyXPBar:CreateFontString(nil, "OVERLAY")
MyXPBarText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
MyXPBarText:SetPoint("CENTER", MyXPBar, "CENTER", 0, 0)

-- Update function
local function UpdateXPBar()
    local currentXP = UnitXP("player")
    local maxXP = UnitXPMax("player")
    local xpPercent = currentXP / maxXP

    MyXPBarStatus:SetValue(xpPercent)
    MyXPBarText:SetText(format("%d / %d (%.2f%%)", currentXP, maxXP, xpPercent * 100))
end

-- Register the events
MyXPBar:RegisterEvent("PLAYER_XP_UPDATE")
MyXPBar:RegisterEvent("PLAYER_LEVEL_UP")
MyXPBar:RegisterEvent("PLAYER_ENTERING_WORLD") -- Add this line

local function UpdateXPBar()
  local currentXP = UnitXP("player")
  local maxXP = UnitXPMax("player")
  local xpPercent = currentXP / maxXP
      -- Check if the player is rested
      if GetXPExhaustion() then
        -- The player is rested, set the status bar color to DF blue
        MyXPBarStatus:SetStatusBarColor(0.1, 0.1, 1)
    else
        -- The player is not rested, set the status bar color to purple
        MyXPBarStatus:SetStatusBarColor(1, 0, 1)
    end
  MyXPBarStatus:SetValue(xpPercent)
  MyXPBarText:SetText(format("%d / %d (%.2f%%)", currentXP, maxXP, xpPercent * 100))
end

-- Update the event handler
MyXPBar:SetScript("OnEvent", function(self, event, ...)
  if event == "PLAYER_ENTERING_WORLD" then
      -- Unregister the PLAYER_ENTERING_WORLD event after the first time it's handled
      self:UnregisterEvent("PLAYER_ENTERING_WORLD")

            -- Hide the ExhaustionTick
            --ExhaustionTick:Hide()
  end
  UpdateXPBar()
end)

-- Create a frame to listen for the PLAYER_LOGIN event
local loginframe = CreateFrame("Frame")

-- Set the script to run when the PLAYER_LOGIN event fires
loginframe:SetScript("OnEvent", function(self, event, ...)
    -- Get the player's level
    local playerLevel = UnitLevel("player")
    -- Check if the player is level 60
    if playerLevel == 60 then
        -- Set the frame strata of MainMenuBarMaxLevelBar to be lower than that of MainMenuBar
        MainMenuBarMaxLevelBar:SetFrameStrata("BACKGROUND")
        MyXPBar:SetFrameStrata("BACKGROUND")
        MainMenuBarMaxLevelBar:Hide()
        MyXPBar:Hide()
        MyXPBarTexture:Hide()
    end
end)

-- Register the PLAYER_LOGIN event
loginframe:RegisterEvent("PLAYER_LOGIN")
