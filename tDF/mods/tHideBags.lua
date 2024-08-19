local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
  title = T["Hide Bags"],
  description = T["Hides the bags from the UI."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  enabled = nil,
})

module.enable = function(self)
    MyBagButton:Hide()
    lb1:Hide()
    lb2:Hide()
    lb3:Hide()
    lb4:Hide()
    CharacterBag0Slot:Hide()
    CharacterBag1Slot:Hide()
    CharacterBag2Slot:Hide()
    CharacterBag3Slot:Hide()
    kr:Hide()
    bbArrow:Hide()
    bbArrow:ClearAllPoints()
    bbArrow:SetPoint("BOTTOMRIGHT", UIParent, 500, 0)
end