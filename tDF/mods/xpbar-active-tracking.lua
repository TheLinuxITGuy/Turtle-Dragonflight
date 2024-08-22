local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
    title = T["Continuous rest XP"],
    description = T["Continuously track rested XP while resting."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    category = T["XP & Reputation"],
    enabled = true,
})

module.enable = function(self)
    xpbar_watcher_rest:RegisterEvent("UPDATE_EXHAUSTION")
    xpbar_watcher_rest:RegisterEvent("PLAYER_UPDATE_RESTING")
    xpbar_watcher_rest:SetScript("OnEvent", function()
        if not xpbar_hide(xpbar) then
            if IsResting() and (GetXPExhaustion("player") / UnitXPMax("player") ~= 1.5) then
                xpbar.text:Show()
                xpbar_update(xpbar, false)
            else
                xpbar.text:Hide()
            end
        end
    end)
end
