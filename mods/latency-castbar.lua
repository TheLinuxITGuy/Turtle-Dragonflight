local T = tDFUI.T
local GetExpansion = tDFUI.GetExpansion

local module = tDFUI:register({
  title = T["Latency Castbar"],
  description = T["Adds a remaining cast time to the cast bar."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  enabled = nil,
})

module.enable = function(self)
  tDFImprovedCastbar.lag:Show()
  tDFImprovedCastbar.lagText:Show()
end
