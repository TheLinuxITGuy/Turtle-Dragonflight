--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]
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

if race == "Night Elf" then
    leftGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Gryphon")
    rightGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Gryphon")
elseif race == "Human" then
    leftGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Gryphon")
    rightGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Gryphon")
elseif race == "Gnome" then
    leftGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Gryphon")
    rightGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Gryphon")
elseif race == "Dwarf" then
    leftGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Gryphon")
    rightGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Gryphon")
elseif race == "High Elf" then
    leftGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Gryphon")
    rightGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Gryphon")
else
    leftGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Wyvern")
    rightGryphon:SetTexture("Interface\\Addons\\tDF\\img\\Wyvern")
end

--Size the endcaps
leftGryphon:SetWidth(84)
leftGryphon:SetHeight(84)
rightGryphon:SetWidth(84)
rightGryphon:SetHeight(84)

-- Position the new textures
leftGryphon:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT", -65, 2)
rightGryphon:SetPoint("RIGHT", MainMenuBarArtFrame, "RIGHT", 65, 2)
-- Flip the right texture
rightGryphon:SetTexCoord(1, 0, 0, 1)
