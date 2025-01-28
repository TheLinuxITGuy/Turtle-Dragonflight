local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T
local GetExpansion = tDFUI.GetExpansion
local create_castbar = tDF.utils.create_castbar

local module = tDFUI:register({
    title = T["Enemy Castbars"],
    description = T["Shows an enemy castbar on target unit frame."],
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = T["Unit Frames"],
    enabled = true,
})

module.enable = function(self)
    local castbar = create_castbar("target", "tDFTargetCastbar", TargetFrame, "BOTTOM", -12, -10, 140, 10, 2)
	-- Set the frame strata and level to ensure it's in front
    castbar:SetFrameStrata("HIGH")  -- Set the frame strata to 'HIGH' to ensure it appears above most UI elements.
end
