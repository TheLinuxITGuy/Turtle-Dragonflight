local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
    title = T["Hide Bags"],
    description = T["Hides the bags from the UI."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    enabled = nil,
})

module.enable = function(self)
    tDFbagMain:Hide()
    tDFbagArrow:Hide()
    tDFbagFreeSlots:Hide()
    bags_hideall()
end