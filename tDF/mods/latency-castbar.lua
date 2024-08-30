local T = ShaguTweaks.T
local GetExpansion = ShaguTweaks.GetExpansion

local module = ShaguTweaks:register({
  title = T["Latency Castbar"],
  description = T["Adds a remaining cast time to the cast bar."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  enabled = nil,
})

module.enable = function(self)
  castbar.lag:Show()
  castbar.lagText:Show()
end
