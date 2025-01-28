local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T

local module = tDFUI:register({
    title = T["Hide XP outdoors"],
    description = T["Hide XP after leaving rest zone."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    category = T["XP & Reputation"],
    enabled = nil,
})

module.enable = function(self)
    xpbar.text:Hide()
end
