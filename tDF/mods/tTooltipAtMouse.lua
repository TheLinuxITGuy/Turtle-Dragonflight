local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
    title = T["Tooltip at Mouse"],
    description = T["The Tooltips display to the right of the cursor."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    category = T["Tooltip & Items"],
    enabled = nil,
  })

module.enable = function(self)

  local function UpdateTooltipPosition()
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    GameTooltip:ClearAllPoints()
    GameTooltip:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / scale - 10, y / scale + 10)
  end

GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
GameTooltip:SetScript("OnUpdate", UpdateTooltipPosition)

end