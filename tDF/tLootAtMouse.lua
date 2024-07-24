local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
    title = T["Loot Table at Mouse"],
    description = T["The loot table displays to the left of the cursor."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    category = T["Tooltip & Items"],
    enabled = nil,
  })

module.enable = function(self)

    local function PositionLootFrame()
        local x, y = GetCursorPosition()
        local scale = UIParent:GetEffectiveScale()
        LootFrame:ClearAllPoints()
        LootFrame:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", x / scale - 10, y / scale + 10)
    end

    local f = CreateFrame("Frame")
    f:RegisterEvent("LOOT_OPENED")
    f:SetScript("OnEvent", PositionLootFrame)

end