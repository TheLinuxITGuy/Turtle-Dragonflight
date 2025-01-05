local _G = ShaguTweaks.GetGlobalEnv()

for i = 1, 5 do
    local frame = _G["ContainerFrame"..i]
    if frame then
        local closeButton = _G["ContainerFrame"..i.."CloseButton"]
        if closeButton then
            closeButton:SetNormalTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
            closeButton:SetPushedTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed')
            closeButton:SetHighlightTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
            closeButton:SetWidth(20)
            closeButton:SetHeight(20)
            closeButton:SetPoint('TOPRIGHT', frame, 'TOPRIGHT', -6, -6)
        end
    end
end

local characterFrameCloseButton = _G["CharacterFrameCloseButton"]
if characterFrameCloseButton then
    characterFrameCloseButton:SetNormalTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    characterFrameCloseButton:SetPushedTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed')
    characterFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    characterFrameCloseButton:SetWidth(20)
    characterFrameCloseButton:SetHeight(20)
    characterFrameCloseButton:SetPoint('TOPRIGHT', _G["CharacterFrame"], 'TOPRIGHT', -34, -15)
end

local spellBookCloseButton = _G["SpellBookCloseButton"]
if spellBookCloseButton then
    spellBookCloseButton:SetNormalTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    spellBookCloseButton:SetPushedTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed')
    spellBookCloseButton:SetHighlightTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    spellBookCloseButton:SetWidth(20)
    spellBookCloseButton:SetHeight(20)
    spellBookCloseButton:SetPoint('TOPRIGHT', _G["SpellBookFrame"], 'TOPRIGHT', -34, -15)
end

local talentFrameCloseButton = _G["TalentFrameCloseButton"]
if talentFrameCloseButton then
    talentFrameCloseButton:SetNormalTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    talentFrameCloseButton:SetPushedTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed')
    talentFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    talentFrameCloseButton:SetWidth(20)
    talentFrameCloseButton:SetHeight(20)
    talentFrameCloseButton:SetPoint('TOPRIGHT', _G["TalentFrame"], 'TOPRIGHT', -34, -15)
end

local questLogFrameCloseButton = _G["QuestLogFrameCloseButton"]
if questLogFrameCloseButton then
    questLogFrameCloseButton:SetNormalTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    questLogFrameCloseButton:SetPushedTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed')
    questLogFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    questLogFrameCloseButton:SetWidth(20)
    questLogFrameCloseButton:SetHeight(20)
    questLogFrameCloseButton:SetPoint('TOPRIGHT', _G["QuestLogFrame"], 'TOPRIGHT', -91, -15)
end

local friendsFrameCloseButton = _G["FriendsFrameCloseButton"]
if friendsFrameCloseButton then
    friendsFrameCloseButton:SetNormalTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    friendsFrameCloseButton:SetPushedTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed')
    friendsFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    friendsFrameCloseButton:SetWidth(20)
    friendsFrameCloseButton:SetHeight(20)
    friendsFrameCloseButton:SetPoint('TOPRIGHT', _G["FriendsFrame"], 'TOPRIGHT', -36, -15)
end

local worldMapFrameCloseButton = _G["WorldMapFrameCloseButton"]
if worldMapFrameCloseButton then
    worldMapFrameCloseButton:SetNormalTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    worldMapFrameCloseButton:SetPushedTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed')
    worldMapFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    worldMapFrameCloseButton:SetWidth(20)
    worldMapFrameCloseButton:SetHeight(20)
    worldMapFrameCloseButton:SetPoint('TOPRIGHT', _G["WorldMapFrame"], 'TOPRIGHT', 3, 20)
end

local shopFrameCloseButton = _G["ShopFrameFrameCloseButton"]
if shopFrameCloseButton then
    shopFrameCloseButton:SetNormalTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    shopFrameCloseButton:SetPushedTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed')
    shopFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    shopFrameCloseButton:SetWidth(20)
    shopFrameCloseButton:SetHeight(20)
    shopFrameCloseButton:SetPoint('TOPRIGHT', _G["ShopFrame"], 'TOPRIGHT', -7, -15)
end

local helpFrameCloseButton = _G["HelpFrameCloseButton"]
if helpFrameCloseButton then
    helpFrameCloseButton:SetNormalTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    helpFrameCloseButton:SetPushedTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed')
    helpFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    helpFrameCloseButton:SetWidth(20)
    helpFrameCloseButton:SetHeight(20)
    helpFrameCloseButton:SetPoint('TOPRIGHT', _G["HelpFrame"], 'TOPRIGHT', -48, -8)
end

local lftFrameCloseButton = _G["LFTFrameCloseButton"]
if lftFrameCloseButton then
    lftFrameCloseButton:SetNormalTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    lftFrameCloseButton:SetPushedTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed')
    lftFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal')
    lftFrameCloseButton:SetWidth(20)
    lftFrameCloseButton:SetHeight(20)
    lftFrameCloseButton:SetPoint('TOPRIGHT', _G["LFTFrame"], 'TOPRIGHT', -7, -15)
end