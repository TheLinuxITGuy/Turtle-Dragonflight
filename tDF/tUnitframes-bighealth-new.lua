  --Code from ShaguTweaks
  
  PlayerFrameTexture:SetTexture[[Interface\Addons\tDF\img\UI-TargetingFrame]]  
  PlayerStatusTexture:SetTexture[[Interface\Addons\tDF\img\UI-Player-Status]]  
  PlayerFrameHealthBar:SetPoint("TOPLEFT", 106, -23)
 
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

  PetFrame:ClearAllPoints()
  PetFrame:SetPoint("BOTTOM", PlayerFrame, -10, -30)
  PetFrameTexture:SetTexture[[Interface\Addons\tDF\img\pet]]  

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