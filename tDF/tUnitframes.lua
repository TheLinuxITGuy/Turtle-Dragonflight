local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
  title = T["Turtle Dragonflight (default)"],
  description = T["Turtle Dragonflight Unitframes. Uncheck this if you want to use the other Unit Frame options."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  category = T["Unit Frames"],
  enabled = true,
})

local addonpath
local tocs = { "", "-master", "-tbc", "-wotlk" }
for _, name in pairs(tocs) do
  local current = string.format("ShaguTweaks%s", name)
  local _, title = GetAddOnInfo(current)
  if title then
    addonpath = "Interface\\AddOns\\" .. current
    break
  end
end

module.enable = function(self)
-- DF Texture

  --Player Frame
  PlayerFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\new-unitframes\\UI-TargetingFrameDF.tga")
  --PlayerFrameBackground:SetWidth(122)
  PlayerFrameBackground:SetTexture("")
  PlayerStatusTexture:SetTexture[[Interface\Addons\tDF\img\UI-Player-Status]]
  PlayerFrameHealthBar:SetWidth(130)
  PlayerFrameHealthBar:SetHeight(30)
  PlayerFrameManaBar:SetWidth(125)
  PlayerFrameHealthBar:SetPoint("TOPLEFT", 100, -29)
  PlayerFrameManaBar:SetPoint("TOPLEFT", 103, -53)
  PlayerStatusTexture:SetTexture("Interface\\AddOns\\tDF\\img\\UI-Player-Status")
  PlayerFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\new-unitframes\healthDF2.tga]])               
  PlayerFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Player-PortraitOn-Bar-Mana-Status.tga]])
  --Move playername
  local playerName = PlayerFrame.name
  -- Adjust the position of the name text
  playerName:ClearAllPoints()
  playerName:SetPoint("CENTER", PlayerFrame, "CENTER", 22, 25)
  -- Move player level text
  local playerLevelText = PlayerLevelText
  -- Adjust the position of the level text
  playerLevelText:ClearAllPoints()
  playerLevelText:SetPoint("CENTER", PlayerFrame, "CENTER", 102, 25)
  --Resize Player portrait
  local playerPortrait = PlayerFrame.portrait
  playerPortrait:SetHeight(62)
  playerPortrait:SetWidth(62)

  --Target Frame
  TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\new-unitframes\\UI-TargetingFrameDF1.tga")
  TargetFrameHealthBar:SetPoint("TOPRIGHT", -100, -29)
  TargetFrameHealthBar:SetWidth(130)
  TargetFrameHealthBar:SetHeight(30)
  TargetFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\new-unitframes\healthDF2.tga]]) 
  TargetFrameManaBar:SetPoint("TOPRIGHT", -96, -52)
  TargetFrameManaBar:SetWidth(130)
  TargetFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Target-PortraitOn-Bar-Mana-Status.tga]])
  TargetFrameBackground:SetTexture("")
  --Move Targetname
  local targetName = TargetFrame.name
  -- Adjust the position of the name text
  targetName:ClearAllPoints()
  targetName:SetPoint("CENTER", TargetFrame, "CENTER", -62, 25)
  -- Move Target level text
  local targetLevelText = TargetLevelText
  -- Adjust the position of the level text
  targetLevelText:ClearAllPoints()
  targetLevelText:SetPoint("CENTER", TargetFrame, "CENTER", -104, 25)
  --Resize Target portrait
  local targetPortrait = TargetFrame.portrait
  targetPortrait:SetHeight(60)
  targetPortrait:SetWidth(60)

--DF Texture ends

--DF Pet
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
--DF Pet ends

  local original = TargetFrame_CheckClassification
  function TargetFrame_CheckClassification()
    local classification = UnitClassification("target")
    if ( classification == "worldboss" ) then
      TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\UI-TargetingFrame-Elite")
    elseif ( classification == "rareelite"  ) then
      TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\UI-TargetingFrame-Elite")
    elseif ( classification == "elite"  ) then
      TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\UI-TargetingFrame-Elite")
    elseif ( classification == "rare"  ) then
      TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\UI-TargetingFrame-Rare")
    else
      TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\new-unitframes\\UI-TargetingFrameDF1.tga")
      --TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\UI-TargetingFrame2")
    end
  end

  local wait = CreateFrame("Frame")
  wait:RegisterEvent("PLAYER_ENTERING_WORLD")
  wait:SetScript("OnEvent", function()
    if ShaguTweaks.DarkMode then
      PlayerFrameTexture:SetVertexColor(.3,.3,.3,.9)
      TargetFrameTexture:SetVertexColor(.3,.3,.3,.9)
    end

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
      PlayerFrameHealthBar.TextString:SetPoint("TOP", PlayerFrameHealthBar, "BOTTOM", 0, 32)
    end

    if TargetFrameHealthBar.TextString then
      TargetFrameHealthBar.TextString:SetPoint("TOP", TargetFrameHealthBar, "BOTTOM", 2, 32)
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

-- Party space fix with pet
  if PetFrame:IsVisible() then
    if PartyMemberFrame1:IsVisible() then
      PartyMemberFrame1:ClearAllPoints()
      PartyMemberFrame1:SetPoint("TOPLEFT", UIParent, 30, -150)
    else
      --print("partyMember1 does not exist")
    end
  else
      PartyMemberFrame1:ClearAllPoints()
      PartyMemberFrame1:SetPoint("TOPLEFT", UIParent, 30, -150)
  end

  end)
end
