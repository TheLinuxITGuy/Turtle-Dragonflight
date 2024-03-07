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
--click
mbPvP:SetScript("OnClick", function(self, button, down)
  if BattlefieldFrame:IsVisible() then
    ToggleGameMenu()
  else
    ShowUIPanel(BattlefieldFrame)
  end
end)
---------------------------------------------PvP Micro Button--------------------------------------------------

---------------------------------------------Turtle WoW Shop Micro Button--------------------------------------------------
--Hide the original TWMinimapShopFrame
--TWMinimapShopFrame:SetAlpha(0)
TWMinimapShopFrame:SetParent(UIParent)
TWMinimapShopFrame:ClearAllPoints()
TWMinimapShopFrame:SetPoint("BOTTOMLEFT", UIParent, -700, -500)
TWMinimapShopFrame:SetAlpha(0)
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
LFT_Minimap:Hide()
--Create a new button
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
