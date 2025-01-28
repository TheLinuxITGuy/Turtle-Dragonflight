local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T

local module = tDFUI:register({
  title = T["MiniMap Square"],
  description = T["Draw the mini map in a squared shape instead of a round one."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  category = T["World & MiniMap"],
  enabled = nil,
})

module.enable = function(self)
  Minimap:SetMaskTexture("Interface\\BUTTONS\\WHITE8X8")

  Minimap.border = CreateFrame("Frame", nil, Minimap)
  Minimap.border:SetFrameStrata("MEDIUM")
  Minimap.border:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -4, 3)
  Minimap.border:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 3, -3)
  Minimap.border:SetBackdrop({
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 8, edgeSize = 16,
    insets = { left = 3, right = 3, top = 3, bottom = 3 }})

  Minimap.border:SetBackdropBorderColor(.9,.8,.5,1)
  Minimap.border:SetBackdropColor(.4,.4,.4,1)

  tMinimapZoomIn:ClearAllPoints()
  tMinimapZoomOut:ClearAllPoints()
  tMinimapZoomIn:SetPoint("TOPRIGHT", MinimapZoneText, "TOPLEFT", 165, -213)
  tMinimapZoomOut:SetPoint("TOPRIGHT", MinimapZoneText, "TOPLEFT", 150, -213)
end
