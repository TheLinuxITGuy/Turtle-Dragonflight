-- Hide the original gryphons
MainMenuBarLeftEndCap:Hide()
MainMenuBarRightEndCap:Hide()

-- Create new textures
local leftGryphon = MainMenuBar:CreateTexture(nil, "OVERLAY")
local rightGryphon = MainMenuBar:CreateTexture(nil, "OVERLAY")

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
leftGryphon:SetWidth(100)
leftGryphon:SetHeight(100)
rightGryphon:SetWidth(100)
rightGryphon:SetHeight(100)

-- Position the new textures
leftGryphon:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT", -80, 5)
rightGryphon:SetPoint("RIGHT", MainMenuBarArtFrame, "RIGHT", 80, 5)
-- Flip the right texture
rightGryphon:SetTexCoord(1, 0, 0, 1)