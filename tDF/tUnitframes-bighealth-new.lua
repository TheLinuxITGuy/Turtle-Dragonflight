--[[
Author: ShaguTweaks
Modified by: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]
  
  PlayerFrameTexture:SetTexture[[Interface\Addons\tDF\img\UI-TargetingFrame]]  
  PlayerStatusTexture:SetTexture[[Interface\Addons\tDF\img\UI-Player-Status]]  
  PlayerFrameHealthBar:SetPoint("TOPLEFT", 106, -23)

  -- Get the Player unitframe
local playerFrame = PlayerFrame
-- Change the font of the Player unitframe
playerFrame.healthbar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
playerFrame.healthbar.TextString:SetTextColor(1, 1, 1)
playerFrame.manabar.TextString:SetFont(STANDARD_TEXT_FONT, 10,"OUTLINE")
playerFrame.manabar.TextString:SetTextColor(1, 1, 1)
local petFrame = PetFrame
petFrame.healthbar.TextString:SetFont(STANDARD_TEXT_FONT, 8, "OUTLINE")
petFrame.healthbar.TextString:SetTextColor(1, 1, 1)
petFrame.manabar.TextString:SetFont(STANDARD_TEXT_FONT, 8, "OUTLINE")
petFrame.manabar.TextString:SetTextColor(1, 1, 1)
 -- Center the text over the Heal and Mana bars
petFrame.healthbar.TextString:SetPoint("CENTER", petFrame.healthbar, "CENTER", 0, 0)
petFrame.healthbar.TextString:SetJustifyH("CENTER")
petFrame.manabar.TextString:SetPoint("CENTER", petFrame.manabar, "CENTER", 0, 0)
petFrame.manabar.TextString:SetJustifyH("CENTER")

-- Get the MainMenuExpBar
local expBar = MainMenuExpBar
-- Change the font of the MainMenuExpBar
expBar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
expBar.TextString:SetTextColor(1, 1, 1)
 
  PlayerFrameHealthBar:SetWidth(120)
  PlayerFrameHealthBar:SetHeight(30)
  PlayerFrameManaBar:SetWidth(120)
  PlayerFrameBackground:SetWidth(122)
  PlayerStatusTexture:SetTexture[[Interface\Addons\tDF\img\UI-Player-Status]]

  TargetFrameTexture:SetTexture[[Interface\Addons\tDF\img\UI-TargetingFrame2]]  
  TargetFrameHealthBar:SetPoint("TOPRIGHT", -103, -23)
  TargetFrameHealthBar:SetHeight(30)
  TargetFrameHealthBar:SetWidth(123)
  TargetFrameManaBar:SetPoint("TOPRIGHT", -103, -52)
  TargetFrameManaBar:SetWidth(123)
  TargetFrameBackground:SetPoint("TOPRIGHT", -103, -22)
  TargetFrameBackground:SetWidth(123)
  --TargetFrame:SetWidth(120)
  -- TargetLevelText:ClearAllPoints()
  -- TargetLevelText:SetPoint("BOTTOMRIGHT",TargetFrameHealthBar, 65, -20)
  -- Get the PlayerName text object
-- Get the PlayerName and Health text objects
local playerNameText = PlayerFrame.healthbar.TextString
playerNameText:SetHeight(30)

  TargetofTargetFrame:ClearAllPoints()
   TargetofTargetFrame:SetPoint("BOTTOM", TargetFrame, 38, -15)

  -- Hook the PetFrame_Update function
    local new_PetFrame_Update = PetFrame_Update
    local new_PetFrame = PetFrame
    PetFrame_Update = function()
      -- Call the original function
      new_PetFrame_Update()
      PetFrameTexture:SetTexture("Interface\\Addons\\tDF\\img\\pet")
      PetFrame:ClearAllPoints()
      PetFrame:SetPoint("BOTTOM", PlayerFrame, -10, -30)
    end

  local original = TargetFrame_CheckClassification
  function TargetFrame_CheckClassification()
    local classification = UnitClassification("target")
    if ( classification == "worldboss" ) then
      TargetFrameTexture:SetTexture[[Interface\Addons\tDF\img\UI-TargetingFrame-Elite]]
    elseif ( classification == "rareelite"  ) then
      TargetFrameTexture:SetTexture[[Interface\Addons\tDF\img\UI-TargetingFrame-Elite]]
    elseif ( classification == "elite"  ) then
      TargetFrameTexture:SetTexture[[Interface\Addons\tDF\img\UI-TargetingFrame-Elite]]
    elseif ( classification == "rare"  ) then
      TargetFrameTexture:SetTexture[[Interface\Addons\tDF\img\UI-TargetingFrame-Elite_Rare]]
    else
      TargetFrameTexture:SetTexture[[Interface\Addons\tDF\img\UI-TargetingFrame2]]  
    end
  end

  local wait = CreateFrame("Frame")
  wait:RegisterEvent("PLAYER_ENTERING_WORLD")
  wait:SetScript("OnEvent", function()

    -- adjust healthbar colors to frame colors
    local original = TargetFrame_CheckFaction
    function TargetFrame_CheckFaction(self)
      original(self)

      if TargetFrameHealthBar._SetStatusBarColor then
        local r, g, b, a = TargetFrameNameBackground:GetVertexColor()
        TargetFrameHealthBar:_SetStatusBarColor(r, g, b, a)
      end
    end
  end)

  -- delay to first draw
  wait:SetScript("OnUpdate", function()
    -- move text strings a bit higher
    if PlayerFrameHealthBar.TextString then
      PlayerFrameHealthBar.TextString:SetPoint("TOP", PlayerFrameHealthBar, "BOTTOM", 0, 23)
    end

    if TargetFrameHealthBar.TextString then
      TargetFrameHealthBar.TextString:SetPoint("TOP", TargetFrameHealthBar, "BOTTOM", -2, 23)
    end

    -- use class color for player (if enabled)
    if PlayerFrameNameBackground then
      -- disable vanilla ui color restore functions
      PlayerFrameHealthBar._SetStatusBarColor = PlayerFrameHealthBar.SetStatusBarColor
      PlayerFrameHealthBar.SetStatusBarColor = function() return end

      -- set player healthbar to class color
      local r, g, b, a = PlayerFrameNameBackground:GetVertexColor()
      PlayerFrameHealthBar:_SetStatusBarColor(r, g, b, a)

      -- hide status textures
      PlayerFrameNameBackground:Hide()
      PlayerFrameNameBackground.Show = function() return end
    end

    -- use frame color for target frame
    if TargetFrameNameBackground then
      -- disable vanilla ui color restore functions
      TargetFrameHealthBar._SetStatusBarColor = TargetFrameHealthBar.SetStatusBarColor
      TargetFrameHealthBar.SetStatusBarColor = function() return end

      -- hide status textures
      TargetFrameNameBackground.Show = function() return end
      TargetFrameNameBackground:Hide()
    end

    TargetFrame_CheckFaction(PlayerFrame)
    wait:UnregisterAllEvents()
    wait:Hide()
  end)
