

-- Hide the original gryphons
MainMenuBarLeftEndCap:Hide()
MainMenuBarRightEndCap:Hide()

-- Create new frames
leftGryphonFrame = CreateFrame("Frame", nil, MainMenuBar)
rightGryphonFrame = CreateFrame("Frame", nil, MainMenuBar)

-- Set the new frames to a higher strata
leftGryphonFrame:SetFrameStrata("HIGH")
rightGryphonFrame:SetFrameStrata("HIGH")

-- Create new textures
local leftGryphon = leftGryphonFrame:CreateTexture(nil, "OVERLAY")
local rightGryphon = rightGryphonFrame:CreateTexture(nil, "OVERLAY")

--Checking Horde vs. Alliance wouldn't work, so using races
local race = UnitRace("player")
--DEFAULT_CHAT_FRAME:AddMessage("Your race is " .. race .. ".")

-- Set common properties
leftGryphon:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT", -100, -2)
rightGryphon:SetPoint("RIGHT", MainMenuBarArtFrame, "RIGHT", 103, -2)

-- Set texture based on race
local texturePath
if race == "Night Elf" then
    texturePath = "Interface\\Addons\\Turtle-Dragonflight\\img\\GryphonNew.tga"
elseif race == "Human" or race == "Gnome" or race == "Dwarf" or race == "High Elf" then
    texturePath = "Interface\\Addons\\Turtle-Dragonflight\\img\\GryphonNew.tga"
else
    texturePath = "Interface\\Addons\\Turtle-Dragonflight\\img\\WyvernNew.tga"
end

leftGryphon:SetTexture(texturePath)
rightGryphon:SetTexture(texturePath)

--Size the endcaps
leftGryphon:SetWidth(150)
leftGryphon:SetHeight(150)
rightGryphon:SetWidth(150)
rightGryphon:SetHeight(150)

-- Flip the right texture
rightGryphon:SetTexCoord(1, 0, 0, 1)