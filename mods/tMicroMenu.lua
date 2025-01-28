

local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T
local create_button = tDF.utils.create_button

local module = tDFUI:register({
  title = T["Colorful MicroMenu"],
  description = T["Dragonflight MicroMenu."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  category = T["General"],
  enabled = true,
})

module.enable = function(self)
  microbutton_removemi()
  local microbar_buttons =
  {
    {
      Name = "mbHelp",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\question-regular.tga",
      NormalTextureCoord = {36/128, 86/128, 29/128, 98/128},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\question-faded.tga",
      PushedTextureCoord = {36/128, 86/128, 29/128, 98/128},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\question-highlight.tga",
      HighlightTextureCoord = {36/128, 86/128, 29/128, 98/128},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText(HelpMicroButton.tooltipText, 1, 1, 1, 1, true)
        GameTooltip:AddLine(HelpMicroButton.newbieText, nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        ToggleHelpFrame()
      end
    },
    {
      Name = "mbMainMenu",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\wow-regular.tga",
      NormalTextureCoord = {36/128, 86/128, 29/128, 98/128},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\wow-faded.tga",
      PushedTextureCoord = {36/128, 86/128, 29/128, 98/128},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\wow-highlight.tga",
      HighlightTextureCoord = {36/128, 86/128, 29/128, 98/128},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText(MainMenuMicroButton.tooltipText, 1, 1, 1, 1, true)
        GameTooltip:AddLine(MainMenuMicroButton.newbieText, nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        ToggleGameMenu()
      end
    },
    {
      Name = "mbPvP",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\book-regular.tga",
      NormalTextureCoord = {36/128, 86/128, 29/128, 98/128},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\book-faded.tga",
      PushedTextureCoord = {36/128, 86/128, 29/128, 98/128},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\book-highlight.tga",
      HighlightTextureCoord = {36/128, 86/128, 29/128, 98/128},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText("Player vs. Player", 1, 1, 1, 1, true)
        GameTooltip:AddLine("Compete against the enemy faction in the battlegrounds.", nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        if BattlefieldFrame:IsVisible() then
          ToggleGameMenu()
        else
            ShowTWBGQueueMenu()
        end
      end
    },
    {
      Name = "mbShop",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\horseshoe-regular.tga",
      NormalTextureCoord = {36/128, 86/128, 29/128, 98/128},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\horseshoe-faded.tga",
      PushedTextureCoord = {36/128, 86/128, 29/128, 98/128},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\horseshoe-highlight.tga",
      HighlightTextureCoord = {36/128, 86/128, 29/128, 98/128},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText("Donation Rewards", 1, 1, 1, 1, true)
        GameTooltip:AddLine("Thank you for supporting Turtle WoW.", nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        ShopFrame_Toggle()
      end
    },
    {
      Name = "mbLFT",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\eye-regular.tga",
      NormalTextureCoord = {36/128, 86/128, 29/128, 98/128},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\eye-faded.tga",
      PushedTextureCoord = {36/128, 86/128, 29/128, 98/128},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\eye-highlight.tga",
      HighlightTextureCoord = {36/128, 86/128, 29/128, 98/128},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText("Looking for Turtles", 1, 1, 1, 1, true)
        GameTooltip:AddLine("Find other players to fill your party. Running to the dungeon is required.", nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        LFT_Toggle()
      end
    },
    {
      Name = "mbEBC",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {82/256, 119/256, 325/512, 374/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {82/256, 119/256, 378/512, 429/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {82/256, 119/256, 378/512, 429/512},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText("Everlook Broadcasting Co.", 1, 1, 1, 1, true)
        GameTooltip:AddLine("Listen to some awesome tunes while you play Turtle WoW.", nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        EBCMinimapDropdown:ClearAllPoints()
        EBCMinimapDropdown:SetPoint("CENTER", tDFmicrobutton, 0, 65)
        ShowEBCMinimapDropdown()
      end
    },
    {
      Name = "mbWorldMap",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\shield-regular.tga",
      NormalTextureCoord = {36/128, 86/128, 29/128, 98/128},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\shield-faded.tga",
      PushedTextureCoord = {36/128, 86/128, 29/128, 98/128},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\shield-highlight.tga",
      HighlightTextureCoord = {36/128, 86/128, 29/128, 98/128},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText(WorldMapMicroButton.tooltipText, 1, 1, 1, 1, true)
        GameTooltip:AddLine(WorldMapMicroButton.newbieText, nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        ToggleWorldMap()
      end
    },
    {
      Name = "mbSocials",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\tabard-regular.tga",
      NormalTextureCoord = {36/128, 86/128, 29/128, 98/128},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\tabard-faded.tga",
      PushedTextureCoord = {36/128, 86/128, 29/128, 98/128},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\tabard-highlight.tga",
      HighlightTextureCoord = {36/128, 86/128, 29/128, 98/128},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText(SocialsMicroButton.tooltipText, 1, 1, 1, 1, true)
        GameTooltip:AddLine(SocialsMicroButton.newbieText, nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        ToggleFriendsFrame()
      end
    },
    {
      Name = "mbQuestLog",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\quest-regular.tga",
      NormalTextureCoord = {36/128, 86/128, 29/128, 98/128},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\quest-faded.tga",
      PushedTextureCoord = {36/128, 86/128, 29/128, 98/128},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\quest-highlight.tga",
      HighlightTextureCoord = {36/128, 86/128, 29/128, 98/128},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText(QuestLogMicroButton.tooltipText, 1, 1, 1, 1, true)
        GameTooltip:AddLine(QuestLogMicroButton.newbieText, nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        ToggleQuestLog()
      end
    },
    {
      Name = "mbTalent",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\talents-regular.tga",
      NormalTextureCoord = {36/128, 86/128, 29/128, 98/128},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\talents-faded.tga",
      PushedTextureCoord = {36/128, 86/128, 29/128, 98/128},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\talents-highlight.tga",
      HighlightTextureCoord = {36/128, 86/128, 29/128, 98/128},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText(TalentMicroButton.tooltipText, 1, 1, 1, 1, true)
        GameTooltip:AddLine(TalentMicroButton.newbieText, nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        ToggleTalentFrame()
      end
    },
    {
      Name = "mbSpellBook",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\spellbook-regular.tga",
      NormalTextureCoord = {36/128, 86/128, 29/128, 98/128},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\spellbook-faded.tga",
      PushedTextureCoord = {36/128, 86/128, 29/128, 98/128},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\colormicromenu\\spellbook-highlight.tga",
      HighlightTextureCoord = {36/128, 86/128, 29/128, 98/128},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText("Spellbook & Abilities", 1, 1, 1, 1, true)
        GameTooltip:AddLine("All of your spells and abilities. To move a spell or ability to your Action Bar, open the Spellbook & Abilities window, left-click that spell or ability, and drag it down to your Action Bar.", nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        ToggleSpellBook(BOOKTYPE_SPELL)
      end
    },
    {
      Name = "mbCharacter",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {2/256, 37/256, 324/512, 372/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {82/256, 116/256, 216/512, 264/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {82/256, 116/256, 216/512, 264/512},
      f_OnEnter = function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText(CharacterMicroButton.tooltipText, 1, 1, 1, 1, true)
        GameTooltip:AddLine(CharacterMicroButton.newbieText, nil, nil, nil, true)
        GameTooltip:Show()
      end,
      f_OnLeave = function()
        GameTooltip:Hide()
      end,
      f_OnClick = function(self, button, down)
        ToggleCharacter("PaperDollFrame")
      end
    },
  }

  local mbButtonX = 18
  local mbButtonY = 25
  local theSpaceBetween = 20

  local offset = 0

  for i, button in ipairs(microbar_buttons) do
    local frame = create_button(button.Name,
    tDFmicrobutton,
    "BOTTOMRIGHT",
    18,
    25,
    button.NormalTexture,
    button.PushedTexture,
    button.HighlightTexture,
    button.NormalTextureCoord,
    button.PushedTextureCoord,
    button.HighlightTextureCoord,
    offset,
    0,
    button.f_OnEnter,
    button.f_OnLeave,
    button.f_OnClick)

    offset = offset - theSpaceBetween
  end

  local function SetCharacterPortrait()
    local portraitTexture = mbCharacter:CreateTexture(nil, "OVERLAY")
    -- Set the portrait texture to the character's portrait
    SetPortraitTexture(portraitTexture, "player")
    portraitTexture:SetWidth(16) -- 23 adjust size as needed
    portraitTexture:SetHeight(16)
    portraitTexture:SetPoint("CENTER", mbCharacter, "CENTER", 0, 0) -- adjust position as needed
  end

  -- Create a frame to listen for the PLAYER_LOGIN event
  local loginFrame = CreateFrame("Frame")
  local timeSinceLastUpdate = 0

  -- Set the script to run when the PLAYER_LOGIN event fires
  loginFrame:SetScript("OnEvent", function()
      -- Set the OnUpdate script
      this:SetScript("OnUpdate", function()
          timeSinceLastUpdate = timeSinceLastUpdate + arg1
          if timeSinceLastUpdate < 5 then
            SetCharacterPortrait()
              return
          end

          -- Reset the time
          timeSinceLastUpdate = 0

          -- Remove the OnUpdate script
          this:SetScript("OnUpdate", nil)

      end)
  end)

  -- Register the PLAYER_LOGIN event
  loginFrame:RegisterEvent("PLAYER_LOGIN")
  loginFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

  local microbutton_eye = create_microbutton_eye(tDFmicrobutton, -140, 50)

  local mbLatency = create_microbutton_latency(MainMenuBarPerformanceBarFrameButton, 1, -8)
end