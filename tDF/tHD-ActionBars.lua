--[[
Author: ShaguTweaks
Modified by: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]

for _, g in pairs({MainMenuBarTexture1, MainMenuBarTexture0, BonusActionBarTexture1}) do
    if g then
        g:SetTexture("Interface\\Addons\\tDF\\img\\UI-MainMenuBar-Dwarf")
    end
end