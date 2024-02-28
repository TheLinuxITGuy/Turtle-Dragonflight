--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file Hide the original Blizzard art work from 1.12. I've created new buttons and textured them to match
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

---------------------------------------------WorldMap Micro Button--------------------------------------------------
--Hide the original WorldMapMicroButton
WorldMapMicroButton:Hide()
--Create a new button
local mbWorldMap = CreateFrame("Button", "mbWorldMap", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbWorldMap:SetWidth(18)
mbWorldMap:SetHeight(25)
mbWorldMap:SetPoint("BOTTOMRIGHT", UIParent, -50, 12) --sets the location of the button
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
mbSocials:SetPoint("BOTTOMRIGHT", UIParent, -70, 12) --sets the location of the button
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
mbQuestLog:SetPoint("BOTTOMRIGHT", UIParent, -90, 12) --sets the location of the button
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
mbTalent:SetPoint("BOTTOMRIGHT", UIParent, -110, 12) --sets the location of the button
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
mbSpellBook:SetPoint("BOTTOMRIGHT", UIParent, -130, 12) --sets the location of the button
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
mbCharacter:SetPoint("BOTTOMRIGHT", UIParent, -150, 12) -- position Character button next to Spellbook
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