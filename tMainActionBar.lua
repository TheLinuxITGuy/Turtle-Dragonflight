
-- Create a new frame for each ActionBar
for _, barName in pairs({"MainMenuBar", "BonusActionBarFrame"}) do
    local bar = getglobal(barName)

    -- Create a new frame
    local Leftframe = CreateFrame("Frame", nil, bar)
    local Rightframe = CreateFrame("Frame", nil, bar)

    -- Set the size of the frame
    --frame:SetWidth(512)
    --frame:SetHeight(48)
    Leftframe:SetWidth(256)
    Leftframe:SetHeight(256)
    Rightframe:SetWidth(256)
    Rightframe:SetHeight(256)

    -- Set the frame's position to the center of the bar
    Leftframe:SetPoint("CENTER", MainMenuBar, "CENTER", -125, -5)
    Rightframe:SetPoint("CENTER", MainMenuBar, "CENTER", 127, -5)

    -- Set the strata of the bar and your frame
    bar:SetFrameStrata("LOW")
    Leftframe:SetFrameStrata("LOW")
    Rightframe:SetFrameStrata("LOW")

    -- Create a texture for the frame on the OVERLAY layer
    local Lefttexture = Leftframe:CreateTexture(nil, "BACKGROUND")
    local Righttexture = Rightframe:CreateTexture(nil, "BACKGROUND")

    -- Set the texture's image file (replace "Interface\\Addons\\Turtle-Dragonflight\\img\\MainActionBar3.tga" with the actual path)
    Lefttexture:SetTexture("Interface\\Addons\\Turtle-Dragonflight\\img\\HDActionBar.tga")
    Righttexture:SetTexture("Interface\\Addons\\Turtle-Dragonflight\\img\\HDActionBar.tga")

    -- Set the texture to cover the entire frame
    Lefttexture:SetAllPoints(Leftframe)
    Righttexture:SetAllPoints(Rightframe)
    Righttexture:SetTexCoord(1, 0, 0, 1)

    -- Show the frame
    Leftframe:Show()
    Rightframe:Show()
end

-- Set the strata of all ActionButtons to be above your frame
for i = 1, 12 do
    getglobal("ActionButton" .. i):SetFrameStrata("MEDIUM")
    getglobal("BonusActionButton" .. i):SetFrameStrata("MEDIUM")
end
