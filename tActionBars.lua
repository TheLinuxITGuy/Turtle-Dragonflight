

for _, g in pairs({MainMenuBarTexture1, MainMenuBarTexture0, BonusActionBarTexture1, BonusActionBarTexture0, BonusActionBarTexture2}) do
    if g then
        g:SetTexture("")
    end
end

local frameBotLeft = CreateFrame("Frame")
frameBotLeft:SetScript("OnUpdate", function()
    for i = 1, 12 do
        local button = getglobal("MultiBarBottomLeftButton" .. i)
        if button then
            button:SetWidth(36)
            button:SetHeight(36)
            button:SetNormalTexture("Interface\\Addons\\Turtle-Dragonflight\\img\\uiactionbariconframe.tga")
            button:SetHighlightTexture("Interface\\Addons\\Turtle-Dragonflight\\img\\uiactionbariconframehighlight.tga")
            local texture = button:GetNormalTexture()
            texture:SetWidth(36)
            texture:SetHeight(36)
        end
    end
end)

local frameRight = CreateFrame("Frame")
frameRight:SetScript("OnUpdate", function()
    for i = 1, 12 do
        local button = getglobal("MultiBarRightButton" .. i)
        if button then
            button:SetWidth(36)
            button:SetHeight(36)
            button:SetNormalTexture("Interface\\Addons\\Turtle-Dragonflight\\img\\uiactionbariconframe.tga")
            button:SetHighlightTexture("Interface\\Addons\\Turtle-Dragonflight\\img\\uiactionbariconframehighlight.tga")
            local texture = button:GetNormalTexture()
            texture:SetWidth(36)
            texture:SetHeight(36)
        end
    end
end)

local frameBotRight2 = CreateFrame("Frame")
frameBotRight2:SetScript("OnUpdate", function()
    for i = 1, 12 do
        local button = getglobal("MultiBarLeftButton" .. i)
        if button then
            button:SetWidth(36)
            button:SetHeight(36)
            button:SetNormalTexture("Interface\\Addons\\Turtle-Dragonflight\\img\\uiactionbariconframe.tga")
            button:SetHighlightTexture("Interface\\Addons\\Turtle-Dragonflight\\img\\uiactionbariconframehighlight.tga")
            local texture = button:GetNormalTexture()
            texture:SetWidth(36)
            texture:SetHeight(36)
        end
    end
end)

local frameBotRight = CreateFrame("Frame")
frameBotRight:SetScript("OnUpdate", function()
    for i = 1, 12 do
        local button = getglobal("MultiBarBottomRightButton" .. i)
        if button then
            button:SetWidth(36)
            button:SetHeight(36)
            button:SetNormalTexture("Interface\\Addons\\Turtle-Dragonflight\\img\\uiactionbariconframe.tga")
            button:SetHighlightTexture("Interface\\Addons\\Turtle-Dragonflight\\img\\uiactionbariconframehighlight.tga")
            local texture = button:GetNormalTexture()
            texture:SetWidth(36)
            texture:SetHeight(36)
        end
    end
end)

-- Get the right action bar frame
local rightActionBar = MultiBarRight

-- Get the current position of the right action bar
local point, relativeTo, relativePoint, xOfs, yOfs = rightActionBar:GetPoint()

-- Reposition the right action bar 10 pixels up
rightActionBar:ClearAllPoints()
rightActionBar:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs + 10)
