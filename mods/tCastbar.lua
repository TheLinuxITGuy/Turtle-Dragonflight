local T = ShaguTweaks.T
local GetExpansion = ShaguTweaks.GetExpansion
local create_castbar = tDF.utils.create_castbar

local module = ShaguTweaks:register({
  title = T["tDF Castbar"],
  description = T["Dragonflight castbar."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  enabled = true,
})

module.enable = function(self)

    local castbar = create_castbar("player", "tDFImprovedCastbar", UIParent, "BOTTOM", 0, 225, 200, 15, nil)

    CastingBarFrame:UnregisterAllEvents()
    CastingBarFrame:Hide()
end