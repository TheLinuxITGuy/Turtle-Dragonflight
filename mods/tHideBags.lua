local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T

local module = tDFUI:register({
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