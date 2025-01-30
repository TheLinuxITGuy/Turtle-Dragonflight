-- Hide the original ReputationWatchBar
ReputationWatchBar:SetAlpha(0)

-- Constants
local REP_BAR_WIDTH = 256
local REP_BAR_HEIGHT = 18

-- Create the main reputation bar frame
repbar = CreateFrame("Frame", "CustomReputationBar", UIParent)
repbar:SetWidth(REP_BAR_WIDTH * 2)
repbar:SetHeight(REP_BAR_HEIGHT)
repbar:SetPoint("CENTER", ReputationWatchBar, "CENTER", 0, -60) -- Position the bar at the bottom
repbar:SetFrameLevel(2)
repbar:SetWidth(510)
repbar:SetHeight(19)

-- Create the left frame
repbar.leftFrame = CreateFrame("Frame", nil, repbar)
repbar.leftFrame:SetWidth(REP_BAR_WIDTH)
repbar.leftFrame:SetHeight(REP_BAR_HEIGHT)
repbar.leftFrame:SetPoint("LEFT", repbar, "LEFT", 0, 0)
repbar.leftFrame:SetFrameLevel(2)
repbar.leftTexture = repbar.leftFrame:CreateTexture(nil, "BACKGROUND")
repbar.leftTexture:SetTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\XP\\leftFrame.tga")
repbar.leftTexture:SetAllPoints(repbar.leftFrame)

-- Create the right frame
repbar.rightFrame = CreateFrame("Frame", nil, repbar)
repbar.rightFrame:SetWidth(REP_BAR_WIDTH)
repbar.rightFrame:SetHeight(REP_BAR_HEIGHT)
repbar.rightFrame:SetPoint("RIGHT", repbar, "RIGHT", 0, 0)
repbar.rightFrame:SetFrameLevel(2)
repbar.rightTexture = repbar.rightFrame:CreateTexture(nil, "BACKGROUND")
repbar.rightTexture:SetTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\XP\\leftFrame.tga")
repbar.rightTexture:SetAllPoints(repbar.rightFrame)
repbar.rightTexture:SetTexCoord(1, 0, 0, 1) -- Flip right texture

-- Create a status bar for reputation progress
local repStatusBar = CreateFrame("StatusBar", nil, repbar)
repStatusBar:SetWidth(510)
repStatusBar:SetHeight(500)
repStatusBar:SetPoint("CENTER", repbar, "CENTER", 0, 0)
repStatusBar:SetStatusBarTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\TentMax.tga")
repStatusBar:SetMinMaxValues(0, 1) -- Initial range, will update dynamically
repStatusBar:SetFrameLevel(1)

-- Create a font string for the custom text
local customRepText = repbar:CreateFontString(nil, "OVERLAY")
customRepText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
customRepText:SetPoint("CENTER", repbar, "CENTER", 0, 1)
customRepText:SetJustifyH("CENTER")

-- Function to update the custom text and status bar with the current faction info
local function UpdateCustomReputationText()
    local name, reaction, min, max, value = GetWatchedFactionInfo()
    if name then
        customRepText:SetText(string.format("%s: %d / %d", name, value - min, max - min))
        repbar:Show()
        -- Update the status bar to reflect reputation progress
        local progress = (value - min) / (max - min)
        repStatusBar:SetValue(progress)
    else
        customRepText:SetText("")
        repbar:Hide()
    end
end

-- Hook the function to events that might change the watched faction
local frame = CreateFrame("Frame")
frame:RegisterEvent("UPDATE_FACTION")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", UpdateCustomReputationText)

-- Initial update call
UpdateCustomReputationText()