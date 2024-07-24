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
  PlayerFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\UI-TargetingFrame")
  PlayerFrameHealthBar:SetPoint("TOPLEFT", 103, -22)
  PlayerFrameHealthBar:SetHeight(30)
  PlayerFrameManaBar:SetPoint("TOPLEFT", 103, -53)

  PlayerStatusTexture:SetTexture("Interface\\AddOns\\tDF\\img\\UI-Player-Status")

  TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\UI-TargetingFrame")
  TargetFrameHealthBar:SetPoint("TOPRIGHT", -106, -22)
  TargetFrameHealthBar:SetHeight(30)

-- DF Texture

    PlayerFrameHealthBar:SetWidth(123)
    PlayerFrameHealthBar:SetHeight(30)
    PlayerFrameManaBar:SetWidth(123)
    PlayerFrameBackground:SetWidth(122)
    PlayerStatusTexture:SetTexture[[Interface\Addons\tDF\img\UI-Player-Status]]
    -- Change the texture of the Health bar
    --PlayerFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health.tga]])
    PlayerFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health-Status.tga]])
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
    TargetFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health-Status.tga]])
    --Change the texture of the Mana bar
    TargetFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-Target-PortraitOn-Bar-Mana-Status.tga]])

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
      TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\UI-TargetingFrame")
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

-- Party space fix with pet
  if PetFrame:IsVisible() then
    --print("petFrame is visible")
    --local PartyMemberFrame1 = partyMember1
    if PartyMemberFrame1:IsVisible() then
      --print("partyMember1 exists")
      --PartyMemberFrame1:SetParent(PlayerFrame)
      PartyMemberFrame1:ClearAllPoints()
      PartyMemberFrame1:SetPoint("TOPLEFT", UIParent, 30, -150)
    else
      --print("partyMember1 does not exist")
    end
  else
    --print("petFrame is not visible")
      --PartyMemberFrame1:SetParent(PlayerFrame)
      PartyMemberFrame1:ClearAllPoints()
      PartyMemberFrame1:SetPoint("TOPLEFT", UIParent, 30, -150)
  end

  end)
end
