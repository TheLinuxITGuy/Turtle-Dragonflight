local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T

local module = tDFUI:register({
    title = T["Continuous rest XP"],
    description = T["Continuously track rested XP while resting."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    category = T["XP & Reputation"],
    enabled = true,
})

tDFUI_config = tDFUI_config or {}

module.enable = function(self)
    xpbar_watcher_rest:RegisterEvent("UPDATE_EXHAUSTION")
    xpbar_watcher_rest:RegisterEvent("PLAYER_UPDATE_RESTING")
    xpbar_watcher_rest:SetScript("OnEvent", function()
        if not xpbar_hide(xpbar) then
            local xpExhaustion = GetXPExhaustion("player")
            if IsResting() and xpExhaustion and ((xpExhaustion / UnitXPMax("player") ~= 1.5) or xpExhaustion == 0) then
                xpbar.text:Show()
                xpbar_update(xpbar, tDFUI_config["Always show detailed XP"] == 1 and true or nil)
            else
                if tDFUI_config["Hide XP outdoors"] == 1 then
                    xpbar.text:Hide()
                end
            end
        end
    end)
end
