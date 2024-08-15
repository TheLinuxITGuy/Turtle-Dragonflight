local T = ShaguTweaks.T

local module = ShaguTweaks:register({
  title = T["Improved Castbar"],
  description = T["Adds a remaining cast time to the cast bar."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  enabled = nil,
})

module.enable = function(self)
  local _G = ShaguTweaks.GetGlobalEnv()

  local UnitCastingInfo = ShaguTweaks.UnitCastingInfo
  local UnitChannelInfo = ShaguTweaks.UnitChannelInfo

  local castbar = CreateFrame("FRAME", "STImprovedCastbar", CastingBarFrame)
  castbar:Hide()

  if ShaguTweaks.DarkMode then
    castbar.texture:SetBackdropBorderColor( .3, .3, .3, .9)
  end

  castbar.spellText = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
  castbar.spellText:SetPoint("CENTER", CastingBarFrame, "CENTER", -3, -15)
  local font, size, opts = castbar.spellText:GetFont()
  castbar.spellText:SetFont(font, size, opts)

  castbar.timerText = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
  castbar.timerText:SetPoint("CENTER", CastingBarFrame, "CENTER", 0, 0)
  castbar.timerText:SetFont(font, size, opts)

  CastingBarText:Hide()

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
  
      castbar.spellText:SetText(cast)
      castbar.timerText:SetText(rem)

    else
      if ( alpha == 0 ) then
        castbar:Hide()
      end
    end
  end)

  local events = CreateFrame("Frame", nil, UIParent)
  events:RegisterEvent("SPELLCAST_START")
  events:RegisterEvent("SPELLCAST_CHANNEL_START")
  events:SetScript("OnEvent", function()
    castbar:Show()
  end)
end
