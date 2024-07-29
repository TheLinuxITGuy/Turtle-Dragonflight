
-- Create a new frame for each ActionBar
for _, barName in pairs({"MainMenuBar", "BonusActionBarFrame"}) do
    local bar = getglobal(barName)

    -- Create a new frame
    local frame = CreateFrame("Frame", nil, bar)

    -- Set the size of the frame
    frame:SetWidth(508)
    frame:SetHeight(46)

    -- Set the frame's position to the center of the bar
    frame:SetPoint("CENTER", MainMenuBar, "CENTER", 0, -5)

    -- Set the strata of the bar and your frame
    bar:SetFrameStrata("LOW")
    frame:SetFrameStrata("LOW")

    -- Create a texture for the frame on the OVERLAY layer
    local texture = frame:CreateTexture(nil, "BACKGROUND")

    -- Set the texture's image file (replace "Interface\\Addons\\tDF\\img\\MainActionBar3.tga" with the actual path)
    texture:SetTexture("Interface\\Addons\\tDF\\img\\MainActionBar3.tga")

    -- Set the texture to cover the entire frame
    texture:SetAllPoints(frame)

    -- Show the frame
    frame:Show()
end

-- Set the strata of all ActionButtons to be above your frame
for i = 1, 12 do
    getglobal("ActionButton" .. i):SetFrameStrata("MEDIUM")
    getglobal("BonusActionButton" .. i):SetFrameStrata("MEDIUM")
end
