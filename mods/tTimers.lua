local T = tDFUI.T
local GetExpansion = tDFUI.GetExpansion

local module = tDFUI:register({
  title = T["tDF Timers"],
  description = T["Dragonflight Timers, Breath, etc."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  enabled = true,
})

module.enable = function(self)

    for i = 1, MIRRORTIMER_NUMTIMERS do
        local frame = getglobal("MirrorTimer"..i)
        frame:GetRegions():Hide()
        frame:SetWidth(200)
        frame:SetHeight(15)
        frame:SetScript("OnUpdate", function()
        if this.paused or not this.timer then return end
            MirrorTimerFrame_OnUpdate(this, arg1)
        end)

        frame:ClearAllPoints()
        frame:SetPoint("TOP", UIParent, "TOP", 0, -120-(i-1)*(10))

        frame.border = getglobal("MirrorTimer"..i.."Border")
        frame.border:SetTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\Castbar\\CastingBarFrame2.tga")
        frame.border:SetWidth(frame:GetWidth()+5.5)
        frame.border:SetHeight(frame:GetHeight()+5.5)
        frame.border:ClearAllPoints()
        frame.border:SetPoint("CENTER", frame, "CENTER", 0, 0) 

        frame.bg = frame:CreateTexture(nil, "BACKGROUND")
        frame.bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
        frame.bg:SetVertexColor(.1, .1, 0, .8)
        frame.bg:SetPoint("CENTER", frame, 0, 0)
        frame.bg:SetWidth(200.2)
        frame.bg:SetHeight(15)

        frame.statusbar = getglobal("MirrorTimer"..i.."StatusBar")
        frame.statusbar:SetStatusBarTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\Castbar\\Timers.tga")
        frame.statusbar:SetAllPoints(frame)
        frame.statusbar:SetStatusBarColor(0, 0, 1)

        --Set text below frame
        local textRegion = getglobal("MirrorTimer"..i.."Text")
        if textRegion then
            textRegion:ClearAllPoints()
            textRegion:SetPoint("CENTER", frame.statusbar, "CENTER", 0, -15)
        end

    end

end