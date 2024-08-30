local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
    title = T["Hide XP outdoors"],
    description = T["Hide XP after leaving rest zone."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    category = T["XP & Reputation"],
    enabled = nil,
})

module.enable = function(self)
    xpbar.text:Hide()
end
