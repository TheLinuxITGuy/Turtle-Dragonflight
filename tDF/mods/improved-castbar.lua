local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T
local GetExpansion = ShaguTweaks.GetExpansion
local UnitCastingInfo = ShaguTweaks.UnitCastingInfo
local UnitChannelInfo = ShaguTweaks.UnitChannelInfo

local module = ShaguTweaks:register({
  title = T["Improved Castbar"],
  description = T["Adds a remaining cast time to the cast bar."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  enabled = nil,
})

local castbar = CreateFrame("StatusBar", "ShaguTargetCastbar", UIParent)
castbar:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
castbar:SetStatusBarTexture("Interface\\AddOns\\tDF\\img\\Castbar\\Timers.tga")
castbar:SetStatusBarColor(1, .8, 0, 1)
castbar:SetWidth(140)
castbar:SetHeight(10)
castbar:Hide()

castbar.texture = CreateFrame("Frame", nil, castbar)
castbar.texture:SetPoint("RIGHT", castbar, "LEFT", -2, 0)
castbar.texture:SetHeight(20)
castbar.texture:SetWidth(20)

castbar.texture.icon = castbar.texture:CreateTexture(nil, "BACKGROUND")
castbar.texture.icon:SetPoint("CENTER", 0, 0)
castbar.texture.icon:SetWidth(16)
castbar.texture.icon:SetHeight(16)
castbar.texture:SetBackdrop({
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  tile = true, tileSize = 8, edgeSize = 12,
  insets = { left = 3, right = 3, top = 3, bottom = 3 }
})

castbar.bg = castbar:CreateTexture(nil, "BACKGROUND")
castbar.bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
castbar.bg:SetVertexColor(.1, .1, 0, .8)
castbar.bg:SetAllPoints(true)

castbar.spark = castbar:CreateTexture(nil, "OVERLAY")
castbar.spark:SetTexture("Interface\\AddOns\\tDF\\img\\Castbar\\CastingBarSpark")
castbar.spark:SetWidth(20)
castbar.spark:SetHeight(20)
castbar.spark:SetBlendMode("ADD")

castbar.backdrop = CreateFrame("Frame", nil, castbar)
castbar.backdrop:SetFrameStrata("BACKGROUND")
castbar.backdrop:SetPoint("TOPLEFT", castbar, "TOPLEFT", -2, 2)
castbar.backdrop:SetPoint("BOTTOMRIGHT", castbar, "BOTTOMRIGHT", 2, -2)
castbar.backdrop:SetBackdrop({
  bgFile = "Interface\\AddOns\\tDF\\img\\Castbar\\CastingBarFrame2.tga"
})

castbar.text = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
castbar.text:SetPoint("CENTER", castbar, "CENTER", 0, -15)
local font, size, opts = castbar.text:GetFont()
castbar.text:SetFont(font, size - 2, opts)

castbar.timerText = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
castbar.timerText:SetPoint("CENTER", castbar, "CENTER", 0, 0)
castbar.timerText:SetFont(font, size - 2, opts)


module.enable = function(self)
  --local _G = ShaguTweaks.GetGlobalEnv()
  --local oldUpdate = UIParent:GetScript("OnUpdate")
  --UIParent:SetScript("OnUpdate", function(arg)
  --  if oldUpdate then oldUpdate(arg) end

  local UnitCastingInfo = ShaguTweaks.UnitCastingInfo
  local UnitChannelInfo = ShaguTweaks.UnitChannelInfo

  --local castbar = CreateFrame("FRAME", "STImprovedCastbar", CastingBarFrame)
  CastingBarFrame:UnregisterAllEvents()
  CastingBarFrame:Hide()

  if ShaguTweaks.DarkMode then
    castbar.texture:SetBackdropBorderColor( .3, .3, .3, .9)
  end

  --castbar.spellText = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
  --castbar.spellText:SetPoint("CENTER", CastingBarFrame, "CENTER", -3, -15)
  --local font, size, opts = castbar.spellText:GetFont()
  --castbar.spellText:SetFont(font, size, opts)
--
  --castbar.timerText = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
  --castbar.timerText:SetPoint("CENTER", CastingBarFrame, "CENTER", 0, 0)
  --castbar.timerText:SetFont(font, size, opts)



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
      local channel = UnitChannelInfo(this.unit)
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

      if texture then
        castbar.texture.icon:SetTexture(texture)
        castbar.texture.icon:Show()
      else
        castbar.texture.icon:Hide()
      end

      --if TargetofTargetFrame and TargetofTargetFrame:IsShown() then
      --  if not castbar.dodged then
      --    castbar:SetPoint("BOTTOM", TargetFrame, "BOTTOM", -12, -24)
      --    castbar.dodged = true
      --  end
      --elseif castbar.dodged then
      --  castbar:SetPoint("BOTTOM", TargetFrame, "BOTTOM", -12, -4)
      --  castbar.dodged = nil
      --end
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
