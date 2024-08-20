local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
  title = T["Hide Gryphons"],
  description = T["Hides the gryphons left and right of the action bar."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  category = T["Action Bar"],
  enabled = nil,
})

module.enable = function(self)
  MainMenuBarLeftEndCap:Hide()
  MainMenuBarRightEndCap:Hide()
  leftGryphonFrame:Hide()
  rightGryphonFrame:Hide()
end
