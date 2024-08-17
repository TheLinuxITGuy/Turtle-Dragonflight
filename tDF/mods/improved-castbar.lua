local T = ShaguTweaks.T
local GetExpansion = ShaguTweaks.GetExpansion

local module = ShaguTweaks:register({
  title = T["Improved Castbar"],
  description = T["Adds a remaining cast time to the cast bar."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  enabled = nil,
})

local castbar = CreateFrame("StatusBar", "tDFImprovedCastbar", UIParent)
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
castbar.spark:SetWidth(22)
castbar.spark:SetHeight(30)
castbar.spark:SetBlendMode("ADD")

castbar.backdrop = CreateFrame("Frame", nil, castbar)
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

castbar.timerText = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
castbar.timerText:SetPoint("CENTER", castbar, "CENTER", 0, 0)
castbar.timerText:SetFont(font, size, opts)

CastingBarFrame:UnregisterAllEvents()
CastingBarFrame:Hide()


module.enable = function(self)
  local UnitCastingInfo = ShaguTweaks.UnitCastingInfo
  local UnitChannelInfo = ShaguTweaks.UnitChannelInfo

  if ShaguTweaks.DarkMode then
    castbar.texture:SetBackdropBorderColor( .3, .3, .3, .9)
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

      castbar.text:SetText(cast)
      castbar.timerText:SetText(rem)

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
end
