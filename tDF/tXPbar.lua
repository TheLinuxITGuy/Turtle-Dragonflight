--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard XP bar in 1.12. I've created a new XP bar to match
Dragonflight.
]]

MainMenuExpBar:SetAlpha(0) --Required for XPbar.lua to work

local playerLevel = UnitLevel("player")
local MyXPBar = CreateFrame("Frame", "MyXPBar", UIParent)
local MyXPBarTexture = MyXPBar:CreateTexture("MyXPBarTexture", "ARTWORK")
local MyXPBarStatus = CreateFrame("StatusBar", "MyXPBarStatus", UIParent)
local MyXPBarText = MyXPBar:CreateFontString(nil, "OVERLAY")
MyXPBar:Hide() --hide initially

if playerLevel < 60 then

MyXPBar:SetWidth(510)
MyXPBar:SetHeight(19)
MyXPBar:SetPoint("CENTER", MainMenuExpBar, "CENTER", 0, 2) -- -588
MyXPBar:Show()
MyXPBar:SetFrameStrata("HIGH")

MyXPBarTexture:SetTexture("Interface\\AddOns\\tDF\\img\\XP512.tga")
MyXPBarTexture:SetTexCoord(0/512, 512/512, 245/512, 264/512)
MyXPBarTexture:SetAllPoints(MyXPBar)

-- Create the frame for the blue or purple bar
MyXPBarStatus:SetWidth(515)
MyXPBarStatus:SetHeight(9)
MyXPBarStatus:SetPoint("CENTER", MyXPBar, "CENTER", 0, 0)
MyXPBarStatus:SetMinMaxValues(0, 1)
MyXPBarStatus:SetValue(1)

-- Set the texture
MyXPBarStatus:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
--MyXPBarStatus:SetStatusBarColor(1, 0, 1, 1)

-- Create the text
MyXPBarText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
MyXPBarText:SetPoint("CENTER", MyXPBar, "CENTER", 0, 2)

-- Register the events
MyXPBar:RegisterEvent("PLAYER_XP_UPDATE")
MyXPBar:RegisterEvent("PLAYER_LEVEL_UP")
MyXPBar:RegisterEvent("PLAYER_ENTERING_WORLD") -- Add this line

-- Update function
local function UpdateXPBar()
  local currentXP = UnitXP("player")
  local maxXP = UnitXPMax("player")
  local maxExhXP = GetXPExhaustion("player") or 0
  local xpPercent = currentXP / maxXP
  local xpMaxPercent = maxExhXP / maxXP -- calculates the Tent XP to a max of 150%

  MyXPBarStatus:SetWidth(512)
  MyXPBarStatus:SetHeight(500)

      -- Check if the player is rested
      if GetXPExhaustion() then
        -- The player is rested
        if xpMaxPercent == 1.5 then
          -- Rested XP is exactly 150%
          MyXPBarStatus:SetStatusBarTexture("Interface\\AddOns\\tDF\\img\\TentMax.tga")
        else
          -- Rested XP is less than 150%
          MyXPBarStatus:SetStatusBarTexture("Interface\\AddOns\\tDF\\img\\Rested.tga")
        end
      else
        -- The player is not rested, set the status bar color to purple
        --MyXPBarStatus:SetStatusBarColor(1, 0, 1)
        MyXPBarStatus:SetStatusBarTexture("Interface\\AddOns\\tDF\\img\\Main.tga")
      end
  MyXPBarStatus:SetValue(xpPercent)
  --MyXPBarStatus:SetValue(xpMaxPercent)
  --MyXPBarText:SetText(format("Current: %d / %d (Max: %.2f%%)", currentXP, maxXP, xpMaxPercent * 100))
  MyXPBarText:SetText(format("XP: %.2f%% | Rested: %.2f%%", xpPercent *100, xpMaxPercent * 100))
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
      -- Unregister the PLAYER_ENTERING_WORLD event after the first time it's handled
      self:UnregisterEvent("PLAYER_ENTERING_WORLD")

      --ReloadUI()
            -- Hide the ExhaustionTick
            --ExhaustionTick:Hide()
  end
  UpdateXPBar()
end)
UpdateXPBar()

end --if player < 60

-------------HIDES THE XP BAR IF YOU'RE 60-------------
  -- Create a frame to listen for the PLAYER_LOGIN event
  local loginFrame = CreateFrame("Frame")

  -- Create a variable to track the time
  local timeSinceLastUpdate = 0
  
  -- Set the script to run when the PLAYER_LOGIN event fires
  loginFrame:SetScript("OnEvent", function()
      -- Set the OnUpdate script
      this:SetScript("OnUpdate", function()
          local elapsed = arg1 or 0
          timeSinceLastUpdate = timeSinceLastUpdate + elapsed
          if timeSinceLastUpdate < 1 then
              return
          end
  
          -- Reset the time
          timeSinceLastUpdate = 0
  
          -- Remove the OnUpdate script
          this:SetScript("OnUpdate", nil)
            --print("Grats on 60, removing XP bar.")
            if UnitLevel("player") == 60 then
              MyXPBar:Hide()
            end
      end)
  end)
  
  -- Register the PLAYER_LOGIN event
  loginFrame:RegisterEvent("PLAYER_LOGIN")
  -------------HIDES THE XP BAR IF YOU'RE 60-------------
