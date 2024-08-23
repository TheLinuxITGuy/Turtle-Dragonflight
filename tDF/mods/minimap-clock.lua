local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
  title = T["MiniMap Clock"],
  description = T["Adds a small 12h clock to the mini map."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  category = T["World & MiniMap"],
  enabled = true,
})

------------------Add Clock------------------
MinimapClock = CreateFrame("Frame", "MinimapClock", UIParent)
MinimapClock:Hide()
MinimapClock:SetFrameLevel(64)
MinimapClock:SetPoint("TOPRIGHT", Minimap, 25, 36)
MinimapClock:SetWidth(68)
MinimapClock:SetHeight(23)
MinimapClock:SetBackdrop({
  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  tile = true, tileSize = 8, edgeSize = 16,
  insets = { left = 3, right = 3, top = 3, bottom = 3 }
})
MinimapClock:SetBackdropBorderColor(.9,.8,.5,0) --Sets Alpha to 0
MinimapClock:SetBackdropColor(.4,.4,.4,0) --Sets Alpha to 0

module.enable = function(self)
  MinimapClock:Show()
  MinimapClock:EnableMouse(true)

  MinimapClock.text = MinimapClock:CreateFontString("Status", "LOW", "GameFontNormal")
  MinimapClock.text:SetFont(STANDARD_TEXT_FONT, 10, "None")
  MinimapClock.text:SetAllPoints(MinimapClock)
  MinimapClock.text:SetFontObject(GameFontWhite)
  MinimapClock:SetScript("OnUpdate", function()
      this.text:SetText(date("%I:%M ")) --%p
  end)

  MinimapClock:SetScript("OnEnter", function()
      local h, m = GetGameTime()
      local servertime
      if h > 12 then
          servertime = string.format("%.2d:%.2d PM", h - 12, m)
      else
          servertime = string.format("%.2d:%.2d AM", h, m)
      end
      local time = date("%I:%M %p")

      GameTooltip:ClearLines()
      GameTooltip:SetOwner(this, ANCHOR_BOTTOMLEFT)

      GameTooltip:AddLine("Clock")
      GameTooltip:AddDoubleLine("Local time", time, 1,1,1,1,1,1)
      GameTooltip:AddDoubleLine("Server time", servertime, 1,1,1,1,1,1)
      GameTooltip:Show()
  end)

  MinimapClock:SetScript("OnLeave", function()
      GameTooltip:Hide()
  end)
end
