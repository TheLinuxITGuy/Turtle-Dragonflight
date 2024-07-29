--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]

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
            button:SetNormalTexture("Interface\\Addons\\tDF\\img\\uiactionbariconframe.tga")
            button:SetHighlightTexture("Interface\\Addons\\tDF\\img\\uiactionbariconframehighlight.tga")
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
            button:SetNormalTexture("Interface\\Addons\\tDF\\img\\uiactionbariconframe.tga")
            button:SetHighlightTexture("Interface\\Addons\\tDF\\img\\uiactionbariconframehighlight.tga")
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
            button:SetNormalTexture("Interface\\Addons\\tDF\\img\\uiactionbariconframe.tga")
            button:SetHighlightTexture("Interface\\Addons\\tDF\\img\\uiactionbariconframehighlight.tga")
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
            button:SetNormalTexture("Interface\\Addons\\tDF\\img\\uiactionbariconframe.tga")
            button:SetHighlightTexture("Interface\\Addons\\tDF\\img\\uiactionbariconframehighlight.tga")
            local texture = button:GetNormalTexture()
            texture:SetWidth(36)
            texture:SetHeight(36)
        end
    end
end)
