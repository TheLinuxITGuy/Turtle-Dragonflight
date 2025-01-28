local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T

local module = tDFUI:register({
    title = T["Loot Table at Mouse"],
    description = T["The loot table displays to the right of the cursor."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    category = T["Tooltip & Items"],
    enabled = nil,
  })

module.enable = function(self)

    local function PositionLootFrame()
        local x, y = GetCursorPosition()
        local scale = UIParent:GetEffectiveScale()
        LootFrame:ClearAllPoints()
        LootFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / scale - 10, y / scale + 10)
    end

    local f = CreateFrame("Frame")
    f:RegisterEvent("LOOT_OPENED")
    f:SetScript("OnEvent", PositionLootFrame)

end
