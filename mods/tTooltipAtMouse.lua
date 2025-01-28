local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T

local module = tDFUI:register({
    title = T["Tooltip at Mouse"],
    description = T["The Tooltips display to the right of the cursor."],
    expansions = { ["vanilla"] = true, ["tbc"] = true },
    category = T["Tooltip & Items"],
    enabled = nil,
  })

module.enable = function(self)
    local function UpdateTooltipPosition()
        local x, y = GetCursorPosition()
        local scale = UIParent:GetEffectiveScale()
        GameTooltip:ClearAllPoints()
        GameTooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", x / scale, y / scale)
    end

    local function ShowTooltipUntilMouseMove()
        local initialX, initialY = GetCursorPosition()
        local scale = UIParent:GetEffectiveScale()
        local padding = 50

        GameTooltip:SetScript("OnUpdate", function()
            local currentX, currentY = GetCursorPosition()
            if math.abs(currentX - initialX) > padding or math.abs(currentY - initialY) > padding then
                GameTooltip:Hide()
                GameTooltip:SetScript("OnUpdate", nil)
            else
                GameTooltip:ClearAllPoints()
                GameTooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", initialX / scale, initialY / scale)
            end
        end)
    end

    local function OnTooltipShow()
        if IsShiftKeyDown() then
            -- Allow the Equip Compare module to show comparisons
            tDF.eqcompare.GameTooltipShow(GameTooltip)
        end
        ShowTooltipUntilMouseMove() -- Continue to update position based on mouse movement
    end

    -- Set tooltip to follow the mouse cursor
    GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
    GameTooltip:SetScript("OnUpdate", UpdateTooltipPosition)
    GameTooltip:SetScript("OnShow", OnTooltipShow)
end

