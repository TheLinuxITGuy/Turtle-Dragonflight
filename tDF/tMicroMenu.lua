--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]

---------------------------------------------Help Micro Button--------------------------------------------------
--Hide the original HelpMicroButton
HelpMicroButton:Hide()
--Create a new Help button
mbHelp = CreateFrame("Button", "mbHelp", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbHelp:SetWidth(18)
mbHelp:SetHeight(25)
mbHelp:SetPoint("BOTTOMRIGHT", UIParent, -10, 12) --sets the location of the button
--Set the button's normal texture
mbHelp:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local HelpNormalTexture = mbHelp:GetNormalTexture()
HelpNormalTexture:SetTexCoord(202/256, 237/256, 215/512, 265/512)
--Set the button's pushed texture
mbHelp:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local HelpPushedTexture = mbHelp:GetPushedTexture()
HelpPushedTexture:SetTexCoord(162/256, 198/256, 215/512, 265/512)
--Set the button's highlight texture
mbHelp:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local HelpHighlightTexture = mbHelp:GetHighlightTexture()
HelpHighlightTexture:SetTexCoord(162/256, 198/256, 215/512, 265/512)
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
mbMainMenu:SetWidth(18)
mbMainMenu:SetHeight(25)
mbMainMenu:SetPoint("BOTTOMRIGHT", UIParent, -30, 12) --sets the location of the button
--Set the button's normal texture
mbMainMenu:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local MainMenuNormalTexture = mbMainMenu:GetNormalTexture()
MainMenuNormalTexture:SetTexCoord(2/256, 37/256, 107/512, 157/512)
--Set the button's pushed texture
mbMainMenu:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local MainMenuPushedTexture = mbMainMenu:GetPushedTexture()
MainMenuPushedTexture:SetTexCoord(122/256, 157/256, 323/512, 372/512)
--Set the button's highlight texture
mbMainMenu:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local MainMenuHighlightTexture = mbMainMenu:GetHighlightTexture()
MainMenuHighlightTexture:SetTexCoord(122/256, 157/256, 323/512, 372/512)
-----Creates a new microButton-----

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
mbPvP:SetWidth(18)
mbPvP:SetHeight(25)
mbPvP:SetPoint("BOTTOMRIGHT", UIParent, -50, 12) --sets the location of the button
--Set the button's normal texture
mbPvP:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local PvPNormalTexture = mbPvP:GetNormalTexture()
PvPNormalTexture:SetTexCoord(0/256, 37/256, 269/512, 319/512)
--Set the button's pushed texture
mbPvP:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local PvPPushedTexture = mbPvP:GetPushedTexture()
PvPPushedTexture:SetTexCoord(161/256, 197/256, 161/512, 211/512)
--Set the button's highlight texture
mbPvP:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local PvPHighlightTexture = mbPvP:GetHighlightTexture()
PvPHighlightTexture:SetTexCoord(161/256, 197/256, 161/512, 211/512)

function ShowTWBGQueueMenu()
  local TWBGQueueMinimapMenuFrame = CreateFrame('Frame', 'TWBGQueueMinimapMenuFrame', UIParent, 'UIDropDownMenuTemplate')
  UIDropDownMenu_Initialize(TWBGQueueMinimapMenuFrame, BuildTWBGQueueMenu, "MENU");
  ToggleDropDownMenu(1, nil, TWBGQueueMinimapMenuFrame, "cursor", -150, 25);
end
-----Creates a new microButton-----

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
mbShop:SetWidth(18)
mbShop:SetHeight(25)
mbShop:SetPoint("BOTTOMRIGHT", UIParent, -70, 12) --sets the location of the button
--Set the button's normal texture
mbShop:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local ShopNormalTexture = mbShop:GetNormalTexture()
ShopNormalTexture:SetTexCoord(41/256, 78/256, 161/512, 211/512)
--Set the button's pushed texture
mbShop:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local ShopPushedTexture = mbShop:GetPushedTexture()
ShopPushedTexture:SetTexCoord(0/256, 38/256, 431/512, 482/512)
--Set the button's highlight texture
mbShop:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local ShopHighlightTexture = mbShop:GetHighlightTexture()
ShopHighlightTexture:SetTexCoord(0/256, 38/256, 431/512, 482/512)
-----Creates a new microButton-----

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
LFT_Minimap:SetPoint("BOTTOMRIGHT", UIParent, -270, 6)
LFT_Minimap:Hide()
-----Creates a new microButton-----
local mbLFT = CreateFrame("Button", "mbLFT", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbLFT:SetWidth(18)
mbLFT:SetHeight(25)
mbLFT:SetPoint("BOTTOMRIGHT", UIParent, -90, 12) --sets the location of the button
--Set the button's normal texture
mbLFT:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local LFTNormalTexture = mbLFT:GetNormalTexture()
LFTNormalTexture:SetTexCoord(0/256, 38/256, 161/512, 211/512)
--Set the button's pushed texture
mbLFT:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local LFTPushedTexture = mbLFT:GetPushedTexture()
LFTPushedTexture:SetTexCoord(41/256, 78/256, 107/512, 157/512)
--Set the button's highlight texture
mbLFT:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local LFTHighlightTexture = mbLFT:GetHighlightTexture()
LFTHighlightTexture:SetTexCoord(41/256, 78/256, 107/512, 157/512)
-----Creates a new microButton-----

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

 -- Animation works, but it gets cut off before it finishes
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
mbEBC:SetWidth(18)
mbEBC:SetHeight(25)
mbEBC:SetPoint("BOTTOMRIGHT", UIParent, -110, 12) --sets the location of the button
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
mbWorldMap:SetWidth(18)
mbWorldMap:SetHeight(25)
mbWorldMap:SetPoint("BOTTOMRIGHT", UIParent, -130, 12) --sets the location of the button
--Set the button's normal texture
mbWorldMap:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local WorldMapNormalTexture = mbWorldMap:GetNormalTexture()
WorldMapNormalTexture:SetTexCoord(162/256, 196/256, 107/512, 157/512)
--Set the button's pushed texture
mbWorldMap:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local WorldMapPushedTexture = mbWorldMap:GetPushedTexture()
WorldMapPushedTexture:SetTexCoord(202/256, 237/256, 54/512, 102/512)
--Set the button's highlight texture
mbWorldMap:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local WorldMapHighlightTexture = mbWorldMap:GetHighlightTexture()
WorldMapHighlightTexture:SetTexCoord(202/256, 237/256, 54/512, 102/512)
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
mbSocials:SetWidth(18)
mbSocials:SetHeight(25)
mbSocials:SetPoint("BOTTOMRIGHT", UIParent, -150, 12) --sets the location of the button
--Set the button's normal texture
mbSocials:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local SocialsNormalTexture = mbSocials:GetNormalTexture()
SocialsNormalTexture:SetTexCoord(42/256, 76/256, 54/512, 102/512)
--Set the button's pushed texture
mbSocials:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local SocialsPushedTexture = mbSocials:GetPushedTexture()
SocialsPushedTexture:SetTexCoord(42/256, 77/256, 0/512, 48/512)
--Set the button's highlight texture
mbSocials:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local SocialsHighlightTexture = mbSocials:GetHighlightTexture()
SocialsHighlightTexture:SetTexCoord(42/256, 77/256, 0/512, 48/512)
--GameTooltip
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
mbQuestLog:SetWidth(18)
mbQuestLog:SetHeight(25)
mbQuestLog:SetPoint("BOTTOMRIGHT", UIParent, -170, 12) --sets the location of the button
--Set the button's normal texture
mbQuestLog:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local QuestLogNormalTexture = mbQuestLog:GetNormalTexture()
QuestLogNormalTexture:SetTexCoord(202/256, 237/256, 270/512, 318/512)
--Set the button's pushed texture
mbQuestLog:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local QuestLogPushedTexture = mbQuestLog:GetPushedTexture()
QuestLogPushedTexture:SetTexCoord(42/256, 77/256, 432/512, 480/512)
--Set the button's highlight texture
mbQuestLog:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local QuestLogHighlightTexture = mbQuestLog:GetHighlightTexture()
QuestLogHighlightTexture:SetTexCoord(42/256, 77/256, 432/512, 480/512)
--GameTooltip
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
mbTalent:SetWidth(18)
mbTalent:SetHeight(25)
mbTalent:SetPoint("BOTTOMRIGHT", UIParent, -190, 12) --sets the location of the button
--Set the button's normal texture
mbTalent:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local TalentNormalTexture = mbTalent:GetNormalTexture()
TalentNormalTexture:SetTexCoord(162/256, 197/256, 0/512, 48/512)
--Set the button's pushed texture
mbTalent:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local TalentPushedTexture = mbTalent:GetPushedTexture()
TalentPushedTexture:SetTexCoord(82/256, 117/256, 0/512, 48/512)
--Set the button's highlight texture
mbTalent:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local TalentHighlightTexture = mbTalent:GetHighlightTexture()
TalentHighlightTexture:SetTexCoord(82/256, 117/256, 0/512, 48/512)
------
--GameTooltip
mbTalent:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText(TalentMicroButton.tooltipText, 1, 1, 1, 1, true)
  GameTooltip:AddLine(TalentMicroButton.newbieText, nil, nil, nil, true)
  GameTooltip:Show()
end)

mbTalent:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------
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
mbSpellBook:SetWidth(18)
mbSpellBook:SetHeight(25)
mbSpellBook:SetPoint("BOTTOMRIGHT", UIParent, -210, 12) --sets the location of the button
--Set the button's normal texture
mbSpellBook:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local SpellbookNormalTexture = mbSpellBook:GetNormalTexture()
SpellbookNormalTexture:SetTexCoord(122/256, 157/256, 54/512, 102/512)
--Set the button's pushed texture
mbSpellBook:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local SpellbookPushedTexture = mbSpellBook:GetPushedTexture()
SpellbookPushedTexture:SetTexCoord(190/256, 225/256, 432/512, 480/512)
--Set the button's highlight texture
mbSpellBook:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
--Get the texture object and set its coordinates
local SpellbookHighlightTexture = mbSpellBook:GetHighlightTexture()
SpellbookHighlightTexture:SetTexCoord(190/256, 225/256, 432/512, 480/512)

------
--GameTooltip
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

---------------------------------------------Character Micro Button---------------------------------------------
-- Hide the original CharacterMicroButton
CharacterMicroButton:Hide()
-- Create a new button
local mbCharacter = CreateFrame("Button", "mbCharacter", UIParent, "UIPanelButtonTemplate")
-- Set its properties
mbCharacter:SetWidth(18)
mbCharacter:SetHeight(25)
mbCharacter:ClearAllPoints()
mbCharacter:SetPoint("BOTTOMRIGHT", UIParent, -230, 12) -- position Character button next to Spellbook
-- Set the button's normal texture
mbCharacter:SetNormalTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
-- Get the texture object and set its coordinates
local CharacterNormalTexture = mbCharacter:GetNormalTexture()
CharacterNormalTexture:SetTexCoord(2/256, 37/256, 324/512, 372/512)
-- Set the button's pushed texture
mbCharacter:SetPushedTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
-- Get the texture object and set its coordinates
local CharacterPushedTexture = mbCharacter:GetPushedTexture()
CharacterPushedTexture:SetTexCoord(82/256, 116/256, 216/512, 264/512) -- adjust these values as needed 
-- Set the button's highlight texture
mbCharacter:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\uimicromenu2x.tga")
-- Get the texture object and set its coordinates
local CharacterHighlightTexture = mbCharacter:GetHighlightTexture()
CharacterHighlightTexture:SetTexCoord(82/256, 116/256, 216/512, 264/512) -- adjust these values as needed
------
--GameTooltip
mbCharacter:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText(CharacterMicroButton.tooltipText, 1, 1, 1, 1, true)
  GameTooltip:AddLine(CharacterMicroButton.newbieText, nil, nil, nil, true)
  GameTooltip:Show()
end)

mbCharacter:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------

--click
mbCharacter:SetScript("OnClick", function(self, button, down)
    -- code to run when the button is clicked
    ToggleCharacter("PaperDollFrame")
end)
---------------------------------------------Character Micro Button---------------------------------------------

---------------------------------------------Latency Micro Button---------------------------------------------
-- Create your own button
local mbLatency = MainMenuBarPerformanceBarFrameButton

-- Set the normal texture and store a reference to it
mbLatency.texture = mbLatency:CreateTexture(nil, "BACKGROUND")
mbLatency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\Latency.tga")
--mbLatency:SetTexCoord(3/32, 28/32, 56/64, 60/64)
-- Set the position and size of your button
mbLatency:ClearAllPoints()
mbLatency:SetPoint("CENTER", mbHelp, 0, -16) -- You can adjust the position as needed
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
