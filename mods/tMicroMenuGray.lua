
local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T
local create_button = tDF.utils.create_button

local module = tDFUI:register({
  title = T["Gray MicroMenu"],
  description = T["Smaller gray MicroMenu."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  category = T["General"],
  enabled = nil,
})

module.enable = function(self)
  microbutton_removemi()
  local microbar_buttons =
  {
    {
      Name = "mbHelp",
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {202/256, 237/256, 215/512, 265/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {162/256, 198/256, 215/512, 265/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {162/256, 198/256, 215/512, 265/512},
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
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {2/256, 37/256, 107/512, 157/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {122/256, 157/256, 323/512, 372/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {122/256, 157/256, 323/512, 372/512},
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
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {0/256, 37/256, 269/512, 319/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {161/256, 197/256, 161/512, 211/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {161/256, 197/256, 161/512, 211/512},
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
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {41/256, 78/256, 161/512, 211/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {0/256, 38/256, 431/512, 482/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {0/256, 38/256, 431/512, 482/512},
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
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {0/256, 38/256, 161/512, 211/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {41/256, 78/256, 107/512, 157/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {41/256, 78/256, 107/512, 157/512},
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
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {162/256, 196/256, 107/512, 157/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {202/256, 237/256, 54/512, 102/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {202/256, 237/256, 54/512, 102/512},
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
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {42/256, 76/256, 54/512, 102/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {42/256, 77/256, 0/512, 48/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {42/256, 77/256, 0/512, 48/512},
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
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {202/256, 237/256, 270/512, 318/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {42/256, 77/256, 432/512, 480/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {42/256, 77/256, 432/512, 480/512},
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
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {162/256, 197/256, 0/512, 48/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {82/256, 117/256, 0/512, 48/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {82/256, 117/256, 0/512, 48/512},
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
      NormalTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      NormalTextureCoord = {122/256, 157/256, 54/512, 102/512},
      PushedTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      PushedTextureCoord = {190/256, 225/256, 432/512, 480/512},
      HighlightTexture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\uimicromenu2x.tga",
      HighlightTextureCoord = {190/256, 225/256, 432/512, 480/512},
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

  local microbutton_eye = create_microbutton_eye(tDFmicrobutton, -140, 50)

  local mbLatency = create_microbutton_latency(MainMenuBarPerformanceBarFrameButton, 1, -8)
end