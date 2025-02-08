local _G = tDFUI.GetGlobalEnv()

local closeButtonData = {
    {"CharacterFrame", "CharacterFrameCloseButton", -34, -15},
    {"SpellBookFrame", "SpellBookCloseButton", -34, -15},
    {"TalentFrame", "TalentFrameCloseButton", -34, -15},
    {"QuestLogFrame", "QuestLogFrameCloseButton", -91, -15},
    {"FriendsFrame", "FriendsFrameCloseButton", -36, -15},
    {"WorldMapFrame", "WorldMapFrameCloseButton", 3, 20},
    {"ShopFrame", "ShopFrameFrameCloseButton", -7, -15},
    {"HelpFrame", "HelpFrameCloseButton", -48, -8},
    {"LFTFrame", "LFTFrameCloseButton", -7, -15},
    {"QuestFrame", "QuestFrameCloseButton", -32, -20},
}

-- Add ContainerFrames data to the table
for i = 1, 5 do
    table.insert(closeButtonData, {"ContainerFrame"..i, "ContainerFrame"..i.."CloseButton", -6, -6})
end

local texturePath = "Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonnormal"
local pushedTexturePath = "Interface\\AddOns\\Turtle-Dragonflight\\Textures\\closebutonpushed"

for _, data in ipairs(closeButtonData) do
    local frameName, buttonName, offsetX, offsetY = unpack(data)
    local frame = _G[frameName]
    local button = _G[buttonName]

    if button then
        button:SetNormalTexture(texturePath)
        button:SetPushedTexture(pushedTexturePath)
        button:SetHighlightTexture(texturePath)
        button:SetWidth(20)
        button:SetHeight(20)
        button:SetPoint('TOPRIGHT', frame, 'TOPRIGHT', offsetX, offsetY)
    end
end
