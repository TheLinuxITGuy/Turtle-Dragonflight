--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]

local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
  title = T["Colorful MicroMenu"],
  description = T["Dragonflight MicroMenu. Please uncheck Gray if you use this option. They will overlap."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  category = T["General"],
  enabled = true,
})

module.enable = function(self)
  local mbButtonX = 18 --28
  local mbButtonY = 25 --36
  local theSpaceBetween = -20 -- -29
  ---------------------------------------------Help Micro Button--------------------------------------------------
  --Hide the original HelpMicroButton
  HelpMicroButton:Hide()
  --Create a new Help button
  mbHelp = CreateFrame("Button", "mbHelp", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbHelp:SetWidth(mbButtonX)
  mbHelp:SetHeight(mbButtonY)
  mbHelp:SetPoint("BOTTOMRIGHT", UIParent, -10, 8) --sets the location of mbHelp

  --Set the button's normal texture
  mbHelp:SetNormalTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\question-regular.tga")
  local HelpNormalTexture = mbHelp:GetNormalTexture()
  HelpNormalTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's pushed texture
  mbHelp:SetPushedTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\question-faded.tga")
  local HelpPushedTexture = mbHelp:GetPushedTexture()
  HelpPushedTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's highlight texture
  mbHelp:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\question-highlight.tga")
  local HelpHighlightTexture = mbHelp:GetHighlightTexture()
  HelpHighlightTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --GameTooltip
  mbHelp:SetScript("OnEnter", function()  
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText(HelpMicroButton.tooltipText, 1, 1, 1, 1, true)
    GameTooltip:AddLine(HelpMicroButton.newbieText, nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbHelp:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  ------
  --click
  mbHelp:SetScript("OnClick", function(self, button, down)
    ToggleHelpFrame()
  end)
  ---------------------------------------------Help Micro Button------------------------------------------------------

  ---------------------------------------------MainMenu Micro Button--------------------------------------------------
  --Hide the original MainMenuMicroButton
  MainMenuMicroButton:Hide()
  --Create a new button
  local mbMainMenu = CreateFrame("Button", "mbMainMenu", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbMainMenu:SetWidth(mbButtonX)
  mbMainMenu:SetHeight(mbButtonY)
  mbMainMenu:SetPoint("BOTTOMRIGHT", mbHelp, theSpaceBetween, 0) --sets the location of the button original -30, 12

  --Set the button's normal texture
  mbMainMenu:SetNormalTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\wow-regular.tga")
  local MainMenuNormalTexture = mbMainMenu:GetNormalTexture()
  MainMenuNormalTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's pushed texture
  mbMainMenu:SetPushedTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\wow-faded.tga")
  local MainMenuPushedTexture = mbMainMenu:GetPushedTexture()
  MainMenuPushedTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's highlight texture
  mbMainMenu:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\wow-highlight.tga")
  local MainMenuHighlightTexture = mbMainMenu:GetHighlightTexture()
  MainMenuHighlightTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --GameTooltip
  mbMainMenu:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText(MainMenuMicroButton.tooltipText, 1, 1, 1, 1, true)
    GameTooltip:AddLine(MainMenuMicroButton.newbieText, nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbMainMenu:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  ------
  --click
  mbMainMenu:SetScript("OnClick", function(self, button, down)
    ToggleGameMenu()
  end)
  ---------------------------------------------MainMenu Micro Button--------------------------------------------------

  ---------------------------------------------PvP Micro Button--------------------------------------------------
  --Hide the original TWMiniMapBattlefieldFrame
  TWMiniMapBattlefieldFrame:Hide()
  --Create a new button
  local mbPvP = CreateFrame("Button", "mbPvP", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbPvP:ClearAllPoints()
  mbPvP:SetWidth(mbButtonX) --28
  mbPvP:SetHeight(mbButtonY) --38
  mbPvP:SetPoint("BOTTOMRIGHT", mbMainMenu, theSpaceBetween, 0) --sets the location of the button

  --Set the button's normal texture
  mbPvP:SetNormalTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\book-regular.tga")
  local PvPNormalTexture = mbPvP:GetNormalTexture()
  PvPNormalTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's pushed texture
  mbPvP:SetPushedTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\book-faded.tga")
  local PvPPushedTexture = mbPvP:GetPushedTexture()
  PvPPushedTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's highlight texture
  mbPvP:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\book-highlight.tga")
  local PvPHighlightTexture = mbPvP:GetHighlightTexture()
  PvPHighlightTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  function ShowTWBGQueueMenu()
    local TWBGQueueMinimapMenuFrame = CreateFrame('Frame', 'TWBGQueueMinimapMenuFrame', UIParent, 'UIDropDownMenuTemplate')
    UIDropDownMenu_Initialize(TWBGQueueMinimapMenuFrame, BuildTWBGQueueMenu, "MENU");
    ToggleDropDownMenu(1, nil, TWBGQueueMinimapMenuFrame, "cursor", -150, 25);
  end

  --GameTooltip
  mbPvP:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText("Player vs. Player", 1, 1, 1, 1, true)
    GameTooltip:AddLine("Compete against the enemy faction in the battlegrounds.", nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbPvP:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  ------
  --click
  mbPvP:SetScript("OnClick", function(self, button, down)
    if BattlefieldFrame:IsVisible() then
      ToggleGameMenu()
    else
      --ShowUIPanel(BattlefieldFrame)
        ShowTWBGQueueMenu()
    end
  end)
  ---------------------------------------------PvP Micro Button--------------------------------------------------

  ---------------------------------------------Turtle WoW Shop Micro Button--------------------------------------------------
  --Hide the original TWMinimapShopFrame
  TWMinimapShopFrame:SetParent(UIParent)
  TWMinimapShopFrame:ClearAllPoints()
  TWMinimapShopFrame:SetPoint("TOPRIGHT", 5000, 5000)
  TWMinimapShopFrame:SetAlpha(0)
  TWMinimapShopFrame:SetHeight(0)
  TWMinimapShopFrame:SetWidth(0)
  --Create a new button
  local mbShop = CreateFrame("Button", "mbShop", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbShop:SetWidth(mbButtonX)
  mbShop:SetHeight(mbButtonY)
  mbShop:SetPoint("BOTTOMRIGHT", mbPvP, theSpaceBetween, 0) --sets the location of the button

  --Set the button's normal texture
  mbShop:SetNormalTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\horseshoe-regular.tga")
  local ShopNormalTexture = mbShop:GetNormalTexture()
  ShopNormalTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's pushed texture
  mbShop:SetPushedTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\horseshoe-faded.tga")
  local ShopPushedTexture = mbShop:GetPushedTexture()
  ShopPushedTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's highlight texture
  mbShop:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\horseshoe-highlight.tga")
  local ShopHighlightTexture = mbShop:GetHighlightTexture()
  ShopHighlightTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --GameTooltip
  mbShop:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText("Donation Rewards", 1, 1, 1, 1, true)
    GameTooltip:AddLine("Thank you for supporting Turtle WoW.", nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbShop:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  ------
  --click
  mbShop:SetScript("OnClick", function(self, button, down)
    tws_toggle()
  end)
  ---------------------------------------------Turtle WoW Shop Micro Button--------------------------------------------------

  ---------------------------------------------Looking for Turtle Micro Button--------------------------------------------------
  --Hide the original LFT_Minimap
  --TWMinimapShopFrame:SetAlpha(0)
  LFT_Minimap:SetParent(UIParent)
  LFT_Minimap:ClearAllPoints()
  --LFT_Minimap:SetPoint("BOTTOMRIGHT", UIParent, -270, 55)
  LFT_Minimap:SetPoint("CENTER", mbHelp, -250, 50)
  LFT_Minimap:Hide()
  -----Creates a new microButton-----
  local mbLFT = CreateFrame("Button", "mbLFT", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbLFT:SetWidth(mbButtonX)
  mbLFT:SetHeight(mbButtonY)
  mbLFT:SetPoint("BOTTOMRIGHT", mbShop, theSpaceBetween, 0) --sets the location of the button

  --Set the button's normal texture
  mbLFT:SetNormalTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\eye-regular.tga")
  local LFTNormalTexture = mbLFT:GetNormalTexture()
  LFTNormalTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's pushed texture
  mbLFT:SetPushedTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\eye-faded.tga")
  local LFTPushedTexture = mbLFT:GetPushedTexture()
  LFTPushedTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's highlight texture
  mbLFT:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\eye-highlight.tga")
  local LFTHighlightTexture = mbLFT:GetHighlightTexture()
  LFTHighlightTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --GameTooltip
  mbLFT:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText("Looking for Turtles", 1, 1, 1, 1, true)
    GameTooltip:AddLine("Find other players to fill your party. Running to the dungeon is required.", nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbLFT:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  ------

  -----Reskins the eye-----
  -- Create a new frame
  local overlay = CreateFrame("Frame", nil, LFT_MinimapEye:GetParent())

  -- Set the frame strata to be higher than LFT_MinimapEye
  overlay:SetFrameStrata("DIALOG")

  -- Set the size and position of the overlay to match LFT_MinimapEye
  overlay:SetWidth(LFT_MinimapEye:GetWidth())
  overlay:SetHeight(LFT_MinimapEye:GetHeight())
  overlay:SetPoint("CENTER", LFT_MinimapEye, "CENTER")

  -- Set the texture for the overlay
  overlay.texture = overlay:CreateTexture()
  overlay.texture:SetAllPoints()
  overlay.texture:SetTexture("Interface\\AddOns\\tDF\\img\\uigroupfinderflipbookeye.tga")
  overlay.texture:SetTexCoord(10/512, 55/512, 8/256, 55/256)

  ----------------ANIMATION----------------
  -- Define the TexCoords for each frame of the animation
  local texCoords = {
    --512 is left and right, 256 is up and down
    {10/512, 55/512, 8/256, 55/256}, -- 1st row
    {74/512, 119/512, 8/256, 55/256}, --256 will stay the same as we are going right down the row
    {138/512, 183/512, 8/256, 55/256}, -- Add 64 to all of 512
    {202/512, 247/512, 8/256, 55/256}, -- Add 64 to all of 256
    {266/512, 311/512, 8/256, 55/256},
    {330/512, 375/512, 8/256, 55/256},
    {394/512, 439/512, 8/256, 55/256},
    {458/512, 503/512, 8/256, 55/256},

    {10/512, 55/512, 72/256, 119/256}, --2nd row
    {74/512, 119/512, 72/256, 119/256}, 
    {138/512, 183/512, 72/256, 119/256},
    {202/512, 247/512, 72/256, 119/256},
    {266/512, 311/512, 72/256, 119/256},
    {330/512, 375/512, 72/256, 119/256},
    {394/512, 439/512, 72/256, 119/256},
    {458/512, 503/512, 72/256, 119/256},

    {10/512, 55/512, 136/256, 183/256}, -- 3rd row
    {74/512, 119/512, 136/256, 183/256},
    {138/512, 183/512, 136/256, 183/256},
    {202/512, 247/512, 136/256, 183/256},
    {266/512, 311/512, 136/256, 183/256},
    {330/512, 375/512, 136/256, 183/256},
    {394/512, 439/512, 136/256, 183/256},
    {458/512, 503/512, 136/256, 183/256},

    {10/512, 55/512, 200/256, 247/256},--4th row
    {74/512, 119/512, 200/256, 247/256},
    {138/512, 183/512, 200/256, 247/256},
    {202/512, 247/512, 200/256, 247/256},
    {266/512, 311/512, 200/256, 247/256}
  }

  -- Function to update the texture coordinates
  local currentFrame = 1
  local function UpdateTexCoords()
    local coords = texCoords[currentFrame]
    overlay.texture:SetTexCoord(unpack(coords))
    currentFrame = currentFrame + 1
    if currentFrame > table.getn(texCoords) then
        currentFrame = 1
    end
  end

  -- OnUpdate script to change the TexCoords every 0.1 seconds
  local timeSinceLastUpdate = 0
  local updateInterval = .1 -- Adjust this to change the speed of the animation
  overlay:SetScript("OnUpdate", function(self, elapsed)
    local elapsed = arg1 or 0
    timeSinceLastUpdate = timeSinceLastUpdate + elapsed
    if timeSinceLastUpdate > updateInterval then
        timeSinceLastUpdate = 0
        UpdateTexCoords()
    end
  end)

  --when group is formed
  local frame = CreateFrame("Frame")
  frame:RegisterEvent("PARTY_MEMBERS_CHANGED")

  frame:SetScript("OnEvent", function(self, event, ...)
    if GetNumPartyMembers() > 0 then
      --DEFAULT_CHAT_FRAME:AddMessage("The group has been formed!")
      --code here to stop the animation
      overlay:SetScript("OnUpdate", nil)
      overlay.texture:SetTexCoord(10/512, 55/512, 8/256, 55/256)
    else
      -- Reattach the OnUpdate script to restart the animation
      overlay:SetScript("OnUpdate", function(self, elapsed)
        local elapsed = arg1 or 0
        timeSinceLastUpdate = timeSinceLastUpdate + elapsed
        if timeSinceLastUpdate > updateInterval then
            timeSinceLastUpdate = 0
            UpdateTexCoords()
        end
      end)  
      UpdateTexCoords()
      LFT_Minimap:Hide()
    end
  end)
  ----------------ANIMATION----------------

  --findGroupButton
  findGroupButton:SetScript("OnClick", function(self, button, down)
    LFT_Minimap:Show()
    overlay.texture:Show()
    findGroup()
  end)

  --findMoreButton
  findMoreButton:SetScript("OnClick", function(self, button, down)
    LFT_Minimap:Show()
    overlay.texture:Show()
    findGroup()
  end)

  --leaveQueueButton
  leaveQueueButton:SetScript("OnClick", function(self, button, down)
    LFT_Minimap:Hide()
    overlay.texture:Hide()
    leaveQueue()
  end)
  -----Reskins the eye-----

  --click
  mbLFT:SetScript("OnClick", function(self, button, down)
    LFT_Toggle()
  end)
  ---------------------------------------------Looking for Turtle Micro Button--------------------------------------------------

  ---------------------------------------------Radio Micro Button--------------------------------------------------
  --Hide the original EBC_Minimap
  --TWMinimapShopFrame:SetAlpha(0)
  EBC_Minimap:SetParent(UIParent)
  EBC_Minimap:ClearAllPoints()
  EBC_Minimap:Hide()
  --Create a new button
  local mbEBC = CreateFrame("Button", "mbEBC", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbEBC:SetWidth(mbButtonX)
  mbEBC:SetHeight(mbButtonY)
  mbEBC:SetPoint("BOTTOMRIGHT", mbLFT, theSpaceBetween, 0 ) --sets the location of the button
  --Set the button's normal texture
  mbEBC:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
  --Get the texture object and set its coordinates
  local EBCNormalTexture = mbEBC:GetNormalTexture()
  EBCNormalTexture:SetTexCoord(82/256, 119/256, 325/512, 374/512)
  --Set the button's pushed texture
  mbEBC:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
  --Get the texture object and set its coordinates
  local EBCPushedTexture = mbEBC:GetPushedTexture()
  EBCPushedTexture:SetTexCoord(82/256, 119/256, 378/512, 429/512)
  --Set the button's highlight texture
  mbEBC:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
  --Get the texture object and set its coordinates
  local EBCHighlightTexture = mbEBC:GetHighlightTexture()
  EBCHighlightTexture:SetTexCoord(82/256, 119/256, 378/512, 429/512)
  --GameTooltip
  mbEBC:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText("Everlook Broadcasting Co.", 1, 1, 1, 1, true)
    GameTooltip:AddLine("Listen to some awesome tunes while you play Turtle WoW.", nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbEBC:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  ------
  --click
  function ShowEBCMinimapDropdown()
    if EBCMinimapDropdown:IsVisible() then
    EBCMinimapDropdown:Hide()
  else
    EBCMinimapDropdown:Show()
  end
  end
  mbEBC:SetScript("OnClick", function(self, button, down)
    --Look into the radio EBCMinimapDropdown:SetClampedToScreen()
    EBCMinimapDropdown:ClearAllPoints()
    EBCMinimapDropdown:SetPoint("CENTER", mbEBC, 0, 65)
    ShowEBCMinimapDropdown()
  end)
  ---------------------------------------------Radio Micro Button--------------------------------------------------

  ---------------------------------------------WorldMap Micro Button--------------------------------------------------
  --Hide the original Map Button
  WorldMapMicroButton:Hide()
  --Create a new button
  local mbWorldMap = CreateFrame("Button", "mbWorldMap", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbWorldMap:SetWidth(mbButtonX)
  mbWorldMap:SetHeight(mbButtonY)
  mbWorldMap:SetPoint("BOTTOMRIGHT", mbEBC, theSpaceBetween, 0) --sets the location of the button

  --Set the button's normal texture
  mbWorldMap:SetNormalTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\shield-regular.tga")
  local WorldMapNormalTexture = mbWorldMap:GetNormalTexture()
  WorldMapNormalTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's pushed texture
  mbWorldMap:SetPushedTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\shield-faded.tga")
  local WorldMapPushedTexture = mbWorldMap:GetPushedTexture()
  WorldMapPushedTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's highlight texture
  mbWorldMap:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\shield-highlight.tga")
  local WorldMapHighlightTexture = mbWorldMap:GetHighlightTexture()
  WorldMapHighlightTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --GameTooltip
  mbWorldMap:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText(WorldMapMicroButton.tooltipText, 1, 1, 1, 1, true)
    GameTooltip:AddLine(WorldMapMicroButton.newbieText, nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbWorldMap:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  ------
  --click
  mbWorldMap:SetScript("OnClick", function(self, button, down)
    ToggleWorldMap()
  end)
  ---------------------------------------------WorldMap Micro Button--------------------------------------------------

  ---------------------------------------------Social Micro Button--------------------------------------------------
  --Hide the original SocialsMicroButton
  SocialsMicroButton:Hide()
  --Create a new button
  local mbSocials = CreateFrame("Button", "mbSocials", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbSocials:SetWidth(mbButtonX)
  mbSocials:SetHeight(mbButtonY)
  mbSocials:SetPoint("BOTTOMRIGHT", mbWorldMap, theSpaceBetween, 0) --sets the location of the button

  --Set the button's normal texture
  mbSocials:SetNormalTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\tabard-regular.tga")
  local SocialsNormalTexture = mbSocials:GetNormalTexture()
  SocialsNormalTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's pushed texture
  mbSocials:SetPushedTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\tabard-faded.tga")
  local SocialsPushedTexture = mbSocials:GetPushedTexture()
  SocialsPushedTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's highlight texture
  mbSocials:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\tabard-highlight.tga")
  local SocialsHighlightTexture = mbSocials:GetHighlightTexture()
  SocialsHighlightTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  mbSocials:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText(SocialsMicroButton.tooltipText, 1, 1, 1, 1, true)
    GameTooltip:AddLine(SocialsMicroButton.newbieText, nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbSocials:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  ------
  --click
  mbSocials:SetScript("OnClick", function(self, button, down)
    ToggleFriendsFrame()
  end)
  ---------------------------------------------Social Micro Button--------------------------------------------------

  ---------------------------------------------QuestLog Micro Button--------------------------------------------------
  --Hide the original QuestLogMicroButton
  QuestLogMicroButton:Hide()
  --Create a new button
  local mbQuestLog = CreateFrame("Button", "mbQuestLog", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbQuestLog:SetWidth(mbButtonX)
  mbQuestLog:SetHeight(mbButtonY)
  mbQuestLog:SetPoint("BOTTOMRIGHT", mbSocials, theSpaceBetween, 0) --sets the location of the button

  --Set the button's normal texture
  mbQuestLog:SetNormalTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\quest-regular.tga")
  local QuestLogNormalTexture = mbQuestLog:GetNormalTexture()
  QuestLogNormalTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's pushed texture
  mbQuestLog:SetPushedTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\quest-faded.tga")
  local QuestLogPushedTexture = mbQuestLog:GetPushedTexture()
  QuestLogPushedTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's highlight texture
  mbQuestLog:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\quest-highlight.tga")
  local QuestLogHighlightTexture = mbQuestLog:GetHighlightTexture()
  QuestLogHighlightTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  mbQuestLog:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText(QuestLogMicroButton.tooltipText, 1, 1, 1, 1, true)
    GameTooltip:AddLine(QuestLogMicroButton.newbieText, nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbQuestLog:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  ------
  --click
  mbQuestLog:SetScript("OnClick", function(self, button, down)
    ToggleQuestLog()
  end)
  ---------------------------------------------QuestLog Micro Button--------------------------------------------------

  ---------------------------------------------Talent Micro Button--------------------------------------------------
  --Hide the original TalentMicroButton
  TalentMicroButton:ClearAllPoints()
  TalentMicroButton:SetPoint("BOTTOMLEFT", UIParent, -30, -30)
  --TalentMicroButton:Hide() didn't work for the original Talent button, so I moved it off the screen with SetPoint
  --Create a new button
  local mbTalent = CreateFrame("Button", "mbTalent", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbTalent:SetWidth(mbButtonX)
  mbTalent:SetHeight(mbButtonY)
  mbTalent:SetPoint("BOTTOMRIGHT", mbQuestLog, theSpaceBetween, 0) --sets the location of the button

  --Set the button's normal texture
  mbTalent:SetNormalTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\talents-regular.tga")
  local TalentNormalTexture = mbTalent:GetNormalTexture()
  TalentNormalTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's pushed texture
  mbTalent:SetPushedTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\talents-faded.tga")
  local TalentPushedTexture = mbTalent:GetPushedTexture()
  TalentPushedTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's highlight texture
  mbTalent:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\talents-highlight.tga")
  local TalentHighlightTexture = mbTalent:GetHighlightTexture()
  TalentHighlightTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  mbTalent:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText(TalentMicroButton.tooltipText, 1, 1, 1, 1, true)
    GameTooltip:AddLine(TalentMicroButton.newbieText, nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbTalent:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  --click
  mbTalent:SetScript("OnClick", function(self, button, down)
    ToggleTalentFrame()
  end)
  ---------------------------------------------Talent Micro Button--------------------------------------------------

  ---------------------------------------------Spellbook Micro Button--------------------------------------------------
  --Hide the original QuestLogMicroButton
  SpellbookMicroButton:Hide()
  --Create a new button
  local mbSpellBook = CreateFrame("Button", "mbSpellBook", UIParent, "UIPanelButtonTemplate")
  --Set its properties
  mbSpellBook:SetWidth(mbButtonX)
  mbSpellBook:SetHeight(mbButtonY)
  mbSpellBook:SetPoint("BOTTOMRIGHT", mbTalent, theSpaceBetween, 0) --sets the location of the button

  --Set the button's normal texture
  mbSpellBook:SetNormalTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\spellbook-regular.tga")
  local SpellbookNormalTexture = mbSpellBook:GetNormalTexture()
  SpellbookNormalTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's pushed texture
  mbSpellBook:SetPushedTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\spellbook-faded.tga")
  local SpellbookPushedTexture = mbSpellBook:GetPushedTexture()
  SpellbookPushedTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  --Set the button's highlight texture
  mbSpellBook:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\colormicromenu\\spellbook-highlight.tga")
  local SpellbookHighlightTexture = mbSpellBook:GetHighlightTexture()
  SpellbookHighlightTexture:SetTexCoord(36/128, 86/128, 29/128, 98/128)

  mbSpellBook:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
    GameTooltip:SetText("Spellbook & Abilities", 1, 1, 1, 1, true)
    GameTooltip:AddLine("All of your spells and abilities. To move a spell or ability to your Action Bar, open the Spellbook & Abilities window, left-click that spell or ability, and drag it down to your Action Bar.", nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbSpellBook:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  ------
  --click
  mbSpellBook:SetScript("OnClick", function(self, button, down)
    ToggleSpellBook(BOOKTYPE_SPELL)
  end)
  ---------------------------------------------Spellbook Micro Button--------------------------------------------------
  ---------------------------------------------Character Micro Button--------------------------------------------------
  -- Hide the original CharacterMicroButton
  CharacterMicroButton:Hide()

  -- Create a new button
  local mbCharacter = CreateFrame("Button", "mbCharacter", UIParent, "UIPanelButtonTemplate")

  -- Set its properties
  mbCharacter:SetWidth(mbButtonX)
  mbCharacter:SetHeight(mbButtonY)
  mbCharacter:ClearAllPoints()
  mbCharacter:SetPoint("BOTTOMRIGHT", mbSpellBook, theSpaceBetween, 0) -- position Character button next to Spellbook

  -- Helper function to set texture coordinates
  local function SetButtonTexCoords(button, left, right, top, bottom)
      button:SetTexCoord(left, right, top, bottom)
  end

  -- Set the texture path once
  local texturePath = "Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga"

  -- Set the button's normal texture
  local CharacterNormalTexture = mbCharacter:GetNormalTexture()
  CharacterNormalTexture:SetTexture(texturePath)
  SetButtonTexCoords(CharacterNormalTexture, 2/256, 37/256, 324/512, 372/512)

  -- Set the button's pushed texture
  local CharacterPushedTexture = mbCharacter:GetPushedTexture()
  CharacterPushedTexture:SetTexture(texturePath)
  SetButtonTexCoords(CharacterPushedTexture, 82/256, 116/256, 216/512, 264/512)

  -- Set the button's highlight texture
  local CharacterHighlightTexture = mbCharacter:GetHighlightTexture()
  CharacterHighlightTexture:SetTexture(texturePath)
  SetButtonTexCoords(CharacterHighlightTexture, 82/256, 116/256, 216/512, 264/512)

  -- Function to set the portrait texture
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

  -- GameTooltip
  mbCharacter:SetScript("OnEnter", function()
    GameTooltip:SetOwner(mbCharacter, "ANCHOR_RIGHT")
    GameTooltip:SetText(CharacterMicroButton.tooltipText, 1, 1, 1, 1, true)
    GameTooltip:AddLine(CharacterMicroButton.newbieText, nil, nil, nil, true)
    GameTooltip:Show()
  end)

  mbCharacter:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  -- Click
  mbCharacter:SetScript("OnClick", function(self, button, down)
    ToggleCharacter("PaperDollFrame")
  end)
  ---------------------------------------------Character Micro Button--------------------------------------------------
  ---------------------------------------------Latency Micro Button---------------------------------------------
  -- Create your own button
  local mbLatency = MainMenuBarPerformanceBarFrameButton

  -- Set the normal texture and store a reference to it
  mbLatency.texture = mbLatency:CreateTexture(nil, "BACKGROUND")
  mbLatency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\Latency.tga")
  --mbLatency:SetTexCoord(3/32, 28/32, 56/64, 60/64)
  -- Set the position and size of your button
  mbLatency:ClearAllPoints()
  mbLatency:SetPoint("CENTER", mbHelp, 1, -16) -- You can adjust the position as needed
  mbLatency:SetWidth(20)
  mbLatency:SetHeight(15)

  -- Add this to update each frame
  mbLatency:SetScript("OnUpdate", function(self, elapsed)
    -- Get the current latency
    local _, _, latencyHome = GetNetStats()
    --this.texture:SetVertexColor(0, 1, 0)
    -- Change the color based on latency
    if latencyHome < 200 then
      mbLatency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\LatencyGreen.tga")
        -- Latency is good, set color to green
        --this.texture:SetVertexColor(0, 1, 0)
    elseif latencyHome < 300 then
        -- Latency is poor, set color to yellow
        --this.texture:SetVertexColor(1, 1, 0)
        mbLatency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\LatencyYellow.tga")
    else
        -- Latency is bad, set color to red
        --this.texture:SetVertexColor(1, 0, 0)
        mbLatency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\LatencyRed.tga")
    end
  end)
  ---------------------------------------------Latency Micro Button---------------------------------------------
end