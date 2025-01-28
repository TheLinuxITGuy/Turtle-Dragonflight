local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T

local module = tDFUI:register({
  title = T["Hide Microbutton"],
  description = T["Hide the Microbutton from the UI."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  enabled = nil,
})

module.enable = function(self)
    tDFmicrobutton:Hide()
end