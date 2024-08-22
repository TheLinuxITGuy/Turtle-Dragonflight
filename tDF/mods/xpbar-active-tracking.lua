local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
    title = T["Continuous rest XP"],
    description = T["Continuously track rested XP while resting."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    category = T["XP & Reputation"],
    enabled = nil,
})

module.enable = function(self)
    xpbar_watcher_tent:RegisterEvent("PLAYER_UPDATE_RESTING")
    xpbar_watcher_tent:SetScript("OnEvent", function()
        if event == "PLAYER_UPDATE_RESTING" then
            if not xpbar_hide(xpbar) then
                if IsResting() then
                    xpbar.text:Show()
                    xpbar_watcher_tent:SetScript("OnUpdate", function()
                        xpbar_update(xpbar, false)
                    end)
                else
                    xpbar.text:Hide()
                    xpbar_watcher_tent:SetScript("OnUpdate", nil)
                end
            end
        end
    end)
end