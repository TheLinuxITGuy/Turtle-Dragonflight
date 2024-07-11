--[[
Author: ShaguTweaks
Modified by: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]
  
--UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health.tga
PlayerFrameTexture:SetTexture[[Interface\Addons\tDF\img\UI-TargetingFrame]]  
PlayerStatusTexture:SetTexture[[Interface\Addons\tDF\img\UI-Player-Status]]  
PlayerFrameHealthBar:SetPoint("TOPLEFT", 106, -23)


--[[
Original
-- Get the Player unitframe
local playerFrame = PlayerFrame
-- Change the font of the Player unitframe
playerFrame.healthbar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
playerFrame.healthbar.TextString:SetTextColor(1, 1, 1)
playerFrame.manabar.TextString:SetFont(STANDARD_TEXT_FONT, 10,"OUTLINE")
playerFrame.manabar.TextString:SetTextColor(1, 1, 1)
]]
  
-- Get the Player unitframe
local playerFrame = PlayerFrame

-- Function to update health and mana text
local function UpdateText()
  local health = UnitHealth("player")
  local maxHealth = UnitHealthMax("player")
  local healthPercent = math.floor((health / maxHealth) * 100)

  local mana = UnitMana("player")
  local maxMana = UnitManaMax("player")
  local manaPercent = math.floor((mana / maxMana) * 100)

  playerFrame.healthbar.TextString:SetText(string.format("%d%%", healthPercent))
  playerFrame.manabar.TextString:SetText(string.format("%d%%", manaPercent))
end

-- Change the font of the Player unitframe
playerFrame.healthbar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
playerFrame.healthbar.TextString:SetTextColor(1, 1, 1)
playerFrame.manabar.TextString:SetFont(STANDARD_TEXT_FONT, 10,"OUTLINE")
playerFrame.manabar.TextString:SetTextColor(1, 1, 1)
-- Register the function to update text on health and mana changes
playerFrame:SetScript("OnUpdate", UpdateText)

----new code for %'s ^^^

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

-- Party space fix with pet
if petFrame:IsVisible() then
  --print("petFrame is visible")
  --local PartyMemberFrame1 = partyMember1
  if PartyMemberFrame1:IsVisible() then
    --print("partyMember1 exists")
    PartyMemberFrame1:SetParent(petFrame)
    PartyMemberFrame1:ClearAllPoints()
    PartyMemberFrame1:SetPoint("BOTTOMLEFT", petFrame, 0, -75)
  else
    --print("partyMember1 does not exist")
  end
else
  --print("petFrame is not visible")
end

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
  -- Change the texture of the Health bar
  --PlayerFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health.tga]])
  PlayerFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health-Status.tga]])
  --Change the texture of the Mana bar
 -- local powerType, powerToken = UnitPowerType("player")
  --if powerToken == "MANA" then
   -- PlayerFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Player-PortraitOn-Bar-Mana.tga]])
   -- PlayerFrameManaBar:SetStatusBarColor(0, 0, 0, 1)
  --else
    --PlayerFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Player-PortraitOn-Bar-Mana-Status.tga]])
    --PlayerFrameManaBar:SetStatusBarColor(0, 0, 0, 0)
  --end
  PlayerFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Player-PortraitOn-Bar-Mana-Status.tga]])
  TargetFrameTexture:SetTexture[[Interface\Addons\tDF\img\UI-TargetingFrame2]]  
  TargetFrameHealthBar:SetPoint("TOPRIGHT", -103, -23)
  TargetFrameHealthBar:SetHeight(30)
  TargetFrameHealthBar:SetWidth(123)
  TargetFrameManaBar:SetPoint("TOPRIGHT", -103, -52)
  TargetFrameManaBar:SetWidth(123)
  TargetFrameBackground:SetPoint("TOPRIGHT", -103, -22)
  TargetFrameBackground:SetWidth(123)
  -- Change the texture of the Health bar
  --TargetFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Target-PortraitOn-Bar-Health.tga]])
  TargetFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health-Status.tga]])
  --Change the texture of the Mana bar
  TargetFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Target-PortraitOn-Bar-Mana-Status.tga]])
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
      PetFrameTexture:SetDrawLayer("BACKGROUND") -- Set the draw layer of the texture
      PetFrame:ClearAllPoints()
      PetFrame:SetPoint("BOTTOM", PlayerFrame, -10, -30)
      -- Change the frame strata of the HealthBar and ManaBar
  
      --PetFrameHealthBar:SetFrameStrata("MEDIUM")
      PetFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-Bar-Health]])
        -- Adjust the position of the PetFrameHealthBar
      PetFrameHealthBar:SetHeight(13)
      PetFrameHealthBar:ClearAllPoints()
      PetFrameHealthBar:SetPoint("CENTER", PetFrame, "CENTER", 15, 3)
      --PetFrameManaBar:SetFrameStrata("MEDIUM")
      local class = UnitClass("player")
      if class == "Hunter" then
        PetFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-Bar-Focus]])
      else
        PetFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-Bar-Mana]])
      end
      -- Adjust the position of the PetFrameManaBar
      PetFrameManaBar:ClearAllPoints()
      PetFrameManaBar:SetPoint("CENTER", PetFrame, "CENTER", 15, -7)
      -- Adjust the position of the PetName
      PetName:ClearAllPoints()
      PetName:SetPoint("CENTER", PetFrame, "CENTER", 5, 16)
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
