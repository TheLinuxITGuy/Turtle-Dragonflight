--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]

--CastingBarFrame
--CastingBarBorder
--CastingBarSpark
--CastingBarFlash
--CastingBarText

local castbar = CastingBarFrame
castbar:SetStatusBarTexture("Interface\\AddOns\\tDF\\img\\Castbar\\Timers.tga")
castbar:SetHeight(castbar:GetHeight())
castbar:SetWidth(castbar:GetWidth())

local castbartext = CastingBarText
castbartext:ClearAllPoints()
castbartext:SetPoint("CENTER", castbar, "CENTER", 0, -15)
castbartext:SetTextColor(1,1,1)

local border = CastingBarBorder
border:SetTexture("Interface\\AddOns\\tDF\\img\\Castbar\\CastingBarFrame2.tga")
-- Set the border size to match the castbar
border:SetWidth(castbar:GetWidth()+5.5) 
border:SetHeight(castbar:GetHeight()+5.5) 
border:ClearAllPoints()
border:SetPoint("CENTER", castbar, "CENTER", 0, 0)

local spark = CastingBarSpark
spark:SetTexture("Interface\\AddOns\\tDF\\img\\Castbar\\CastingBarSpark")
spark:ClearAllPoints()
spark:SetPoint("CENTER", castbar, "CENTER", 0,0)
spark:SetHeight(32/1.5)
spark:SetWidth(32/1.5)

local flash = CastingBarFlash
flash:ClearAllPoints()
flash:SetPoint("CENTER", UIParent, 5000, 0)