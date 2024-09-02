local T = ShaguTweaks.T
local GetExpansion = ShaguTweaks.GetExpansion
local create_castbar = tDF.utils.create_castbar

local castbar = create_castbar("player", "tDFImprovedCastbar", UIParent, "BOTTOM", 0, 225, 200, 15, nil)

CastingBarFrame:UnregisterAllEvents()
CastingBarFrame:Hide()