local _G = ShaguTweaks.GetGlobalEnv()

for i = 1, 5 do
    local frame = _G["ContainerFrame"..i]
    if frame then
        local closeButton = _G["ContainerFrame"..i.."CloseButton"]
        if closeButton then
            closeButton:SetNormalTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
            closeButton:SetPushedTexture('Interface\\AddOns\\tDF\\Textures\\closebutonpushed')
            closeButton:SetHighlightTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
            closeButton:SetWidth(20)
            closeButton:SetHeight(20)
            closeButton:SetPoint('TOPRIGHT', frame, 'TOPRIGHT', -6, -6)
        end
    end
end

local characterFrameCloseButton = _G["CharacterFrameCloseButton"]
if characterFrameCloseButton then
    characterFrameCloseButton:SetNormalTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    characterFrameCloseButton:SetPushedTexture('Interface\\AddOns\\tDF\\Textures\\closebutonpushed')
    characterFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    characterFrameCloseButton:SetWidth(20)
    characterFrameCloseButton:SetHeight(20)
    characterFrameCloseButton:SetPoint('TOPRIGHT', _G["CharacterFrame"], 'TOPRIGHT', -34, -15)
end

local spellBookCloseButton = _G["SpellBookCloseButton"]
if spellBookCloseButton then
    spellBookCloseButton:SetNormalTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    spellBookCloseButton:SetPushedTexture('Interface\\AddOns\\tDF\\Textures\\closebutonpushed')
    spellBookCloseButton:SetHighlightTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    spellBookCloseButton:SetWidth(20)
    spellBookCloseButton:SetHeight(20)
    spellBookCloseButton:SetPoint('TOPRIGHT', _G["SpellBookFrame"], 'TOPRIGHT', -34, -15)
end

local talentFrameCloseButton = _G["TalentFrameCloseButton"]
if talentFrameCloseButton then
    talentFrameCloseButton:SetNormalTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    talentFrameCloseButton:SetPushedTexture('Interface\\AddOns\\tDF\\Textures\\closebutonpushed')
    talentFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    talentFrameCloseButton:SetWidth(20)
    talentFrameCloseButton:SetHeight(20)
    talentFrameCloseButton:SetPoint('TOPRIGHT', _G["TalentFrame"], 'TOPRIGHT', -34, -15)
end

local questLogFrameCloseButton = _G["QuestLogFrameCloseButton"]
if questLogFrameCloseButton then
    questLogFrameCloseButton:SetNormalTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    questLogFrameCloseButton:SetPushedTexture('Interface\\AddOns\\tDF\\Textures\\closebutonpushed')
    questLogFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    questLogFrameCloseButton:SetWidth(20)
    questLogFrameCloseButton:SetHeight(20)
    questLogFrameCloseButton:SetPoint('TOPRIGHT', _G["QuestLogFrame"], 'TOPRIGHT', -91, -15)
end

local friendsFrameCloseButton = _G["FriendsFrameCloseButton"]
if friendsFrameCloseButton then
    friendsFrameCloseButton:SetNormalTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    friendsFrameCloseButton:SetPushedTexture('Interface\\AddOns\\tDF\\Textures\\closebutonpushed')
    friendsFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    friendsFrameCloseButton:SetWidth(20)
    friendsFrameCloseButton:SetHeight(20)
    friendsFrameCloseButton:SetPoint('TOPRIGHT', _G["FriendsFrame"], 'TOPRIGHT', -36, -15)
end

local worldMapFrameCloseButton = _G["WorldMapFrameCloseButton"]
if worldMapFrameCloseButton then
    worldMapFrameCloseButton:SetNormalTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    worldMapFrameCloseButton:SetPushedTexture('Interface\\AddOns\\tDF\\Textures\\closebutonpushed')
    worldMapFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    worldMapFrameCloseButton:SetWidth(20)
    worldMapFrameCloseButton:SetHeight(20)
    worldMapFrameCloseButton:SetPoint('TOPRIGHT', _G["WorldMapFrame"], 'TOPRIGHT', 3, 20)
end

local shopFrameCloseButton = _G["ShopFrameFrameCloseButton"]
if shopFrameCloseButton then
    shopFrameCloseButton:SetNormalTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    shopFrameCloseButton:SetPushedTexture('Interface\\AddOns\\tDF\\Textures\\closebutonpushed')
    shopFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    shopFrameCloseButton:SetWidth(20)
    shopFrameCloseButton:SetHeight(20)
    shopFrameCloseButton:SetPoint('TOPRIGHT', _G["ShopFrame"], 'TOPRIGHT', -7, -15)
end

local helpFrameCloseButton = _G["HelpFrameCloseButton"]
if helpFrameCloseButton then
    helpFrameCloseButton:SetNormalTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    helpFrameCloseButton:SetPushedTexture('Interface\\AddOns\\tDF\\Textures\\closebutonpushed')
    helpFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    helpFrameCloseButton:SetWidth(20)
    helpFrameCloseButton:SetHeight(20)
    helpFrameCloseButton:SetPoint('TOPRIGHT', _G["HelpFrame"], 'TOPRIGHT', -48, -8)
end

local lftFrameCloseButton = _G["LFTFrameCloseButton"]
if lftFrameCloseButton then
    lftFrameCloseButton:SetNormalTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    lftFrameCloseButton:SetPushedTexture('Interface\\AddOns\\tDF\\Textures\\closebutonpushed')
    lftFrameCloseButton:SetHighlightTexture('Interface\\AddOns\\tDF\\Textures\\closebutonnormal')
    lftFrameCloseButton:SetWidth(20)
    lftFrameCloseButton:SetHeight(20)
    lftFrameCloseButton:SetPoint('TOPRIGHT', _G["LFTFrame"], 'TOPRIGHT', -7, -15)
end