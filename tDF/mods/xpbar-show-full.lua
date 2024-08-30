local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
    title = T["Always show detailed XP"],
    description = T["Always show detailed XP info, otherwise shift-mouseover on the XP bar."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    category = T["XP & Reputation"],
    enabled = nil,
})

module.enable = function(self)
    local xp = {}
end
