local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
  title = T["Hide Microbutton"],
  description = T["Hide the Microbutton from the UI."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  enabled = nil,
})

module.enable = function(self)
    tDFmicrobutton:Hide()
end