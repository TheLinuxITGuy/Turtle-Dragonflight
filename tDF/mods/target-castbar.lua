local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T
local GetExpansion = ShaguTweaks.GetExpansion
local create_castbar = tDF.utils.create_castbar

local module = ShaguTweaks:register({
    title = T["Enemy Castbars"],
    description = T["Shows an enemy castbar on target unit frame."],
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = T["Unit Frames"],
    enabled = true,
})

module.enable = function(self)
    local castbar = create_castbar("target", "tDFTargetCastbar", TargetFrame, "BOTTOM", -12, -4, 140, 10, 2)
end
