local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T

local module = tDFUI:register({
  title = T["Hide Errors"],
  description = T["Hides and ignores all Lua errors produced by broken addons."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  enabled = nil,
})

module.enable = function(self)
  error = function() return end
  seterrorhandler(error)
end
