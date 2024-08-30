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

--[[ Original
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
]]

local T = ShaguTweaks.T
local GetExpansion = ShaguTweaks.GetExpansion

castbar = CreateFrame("StatusBar", "tDFImprovedCastbar", UIParent)
castbar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 225)
castbar:SetStatusBarTexture("Interface\\AddOns\\tDF\\img\\Castbar\\Timers.tga")
castbar:SetStatusBarColor(1, .8, 0, 1)
castbar:SetWidth(200)
castbar:SetHeight(15)
castbar:Hide()

castbar.bg = castbar:CreateTexture(nil, "BACKGROUND")
castbar.bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
castbar.bg:SetVertexColor(.1, .1, 0, .8)
castbar.bg:SetAllPoints(true)

castbar.spark = castbar:CreateTexture(nil, "OVERLAY")
castbar.spark:SetTexture("Interface\\AddOns\\tDF\\img\\Castbar\\CastingBarSpark")
castbar.spark:SetWidth(20)
castbar.spark:SetHeight(20)
castbar.spark:SetBlendMode("ADD")

castbar.backdrop = CreateFrame("Frame", "BORDER", castbar)
castbar.backdrop:SetFrameStrata("MEDIUM")
castbar.backdrop:SetPoint("TOPLEFT", castbar, "TOPLEFT", -2, 3)
castbar.backdrop:SetPoint("BOTTOMRIGHT", castbar, "BOTTOMRIGHT", 2, -3)
castbar.backdrop:SetBackdrop({
  bgFile = "Interface\\AddOns\\tDF\\img\\Castbar\\CastingBarFrame2.tga"
})

castbar.text = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
castbar.text:SetPoint("CENTER", castbar, "CENTER", 0, -15)
local font, size, opts = castbar.text:GetFont()
castbar.text:SetFont(font, size, opts)
castbar.text:SetTextColor(1,1,1)

castbar.timerText = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
castbar.timerText:SetPoint("CENTER", castbar, "CENTER", 0, 0)
castbar.timerText:SetFont(font, size, opts)
castbar.timerText:SetTextColor(1,1,1)

castbar.lag = castbar:CreateTexture(nil, "OVERLAY")
castbar.lag:SetPoint("TOPRIGHT", castbar, "TOPRIGHT", 0, 0)
castbar.lag:SetPoint("BOTTOMRIGHT", castbar, "BOTTOMRIGHT", 0, 0)
castbar.lag:SetTexture(1,.2,.2,.5)
castbar.lag:Hide()

castbar.lagText = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
castbar.lagText:SetPoint("RIGHT", castbar, "RIGHT", 0, -15)
castbar.lagText:SetFont(font, size - 2, opts)
castbar.lagText:SetTextColor(1,1,1)
castbar.lagText:Hide()

CastingBarFrame:UnregisterAllEvents()
CastingBarFrame:Hide()
local UnitCastingInfo = ShaguTweaks.UnitCastingInfo
local UnitChannelInfo = ShaguTweaks.UnitChannelInfo

if ShaguTweaks.DarkMode then
  castbar.backdrop:SetBackdropColor( .3, .3, .3, .9)
end

local name = GetUnitName("player")

castbar:SetScript("OnUpdate", function()
  local cast, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo("player")
  if not cast then
  -- scan for channel spells if no cast was found
  cast, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo("player")
  end

  local alpha = CastingBarFrame:GetAlpha()
  castbar:SetAlpha(alpha)

  if cast then
    local channel = UnitChannelInfo(name)
    local duration = endTime - startTime
    local max = duration / 1000
    local cur = GetTime() - startTime / 1000

    if channel then
      cur = max + startTime/1000 - GetTime()
    end

    cur = cur > max and max or cur
    cur = cur < 0 and 0 or cur

    local rem = max - cur
    rem = string.format("%.1f"..T["s"], rem)

    castbar:Show()
    castbar:SetMinMaxValues(0, duration / 1000)
    castbar:SetValue(cur)

    local percent = cur / max
    local x = castbar:GetWidth()*percent
    castbar.spark:SetPoint("CENTER", castbar, "LEFT", x, 0)

    local _, _, lag = GetNetStats()
    local width = castbar:GetWidth() / (duration/1000) * (lag/1000)
    castbar.lag:SetWidth(math.min(castbar:GetWidth(), width))

    castbar.text:SetText(cast)
    castbar.timerText:SetText(rem)
    castbar.lagText:SetText(lag .. "ms")

  else
    castbar:Hide()
  end
end)

local events = CreateFrame("Frame", nil, UIParent)
events:RegisterEvent("SPELLCAST_START")
events:RegisterEvent("SPELLCAST_CHANNEL_START")
events:SetScript("OnEvent", function()
  castbar:Show()
end)