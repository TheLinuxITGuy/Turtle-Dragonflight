local tMinimapZoomIn = MinimapZoomIn
local tMinimapZoomOut = MinimapZoomOut
local tBuffButton0 = BuffButton0
local tBuffButton16 = BuffButton16

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    -- Move the MinimapCluster off the screen
    MinimapCluster:ClearAllPoints()
    MinimapCluster:SetPoint("TOPRIGHT", 0, 5000) -- Move it far off to the right
    MinimapCluster:SetFrameStrata('BACKGROUND')

    local customMinimap = CreateFrame("Frame", "MyCustomMinimap", UIParent)
    customMinimap:SetWidth(150*1.36) -- Set the desired size for your minimap (mask size)
    customMinimap:SetHeight(150*1.36)
    customMinimap:SetPoint("TOPRIGHT", 0, -20) -- Position your minimap

    -- Set the minimap mask texture (with alpha channel)
    customMinimap.texture = customMinimap:CreateTexture(nil, "BACKGROUND")
    customMinimap.texture:SetTexture("Interface\\AddOns\\tDF\\img\\uiminimapmask.tga")
    customMinimap.texture:SetAllPoints(customMinimap)
    customMinimap.texture:SetVertexColor(1, 1, 1, 0) -- Fully transparent

    -- Set the actual Minimap as the child frame (display the game world inside the mask)
    local actualMinimap = CreateFrame("Frame", "MyActualMinimap", customMinimap)
    actualMinimap:SetAllPoints(customMinimap)

    -- Set the actual Minimap as the child frame's texture
    Minimap:SetParent(actualMinimap)
    Minimap:SetPoint("CENTER", 1, -3)
    Minimap:SetWidth(131*1.36)
    Minimap:SetHeight(131*1.36)
    --Minimap:SetFrameStrata("LOW")
    Minimap:SetFrameLevel(Minimap:GetFrameLevel() - 1)

    -- Add the Minimap border texture (displayed above the actual Minimap)
    local borderTexture = customMinimap:CreateTexture(nil, "OVERLAY")
    borderTexture:SetTexture("Interface\\AddOns\\tDF\\img\\uiminimapborder.tga")
    borderTexture:SetAllPoints(customMinimap)

    --Add text over the Minimap
    MinimapZoneText:SetParent(UIParent)
    MinimapZoneText:ClearAllPoints()
    MinimapZoneText:SetPoint("CENTER", customMinimap, 0, 110)
    MinimapToggleButton:Hide()

    -- Show your custom minimap
    customMinimap:Show()
end)

--Sets the ZoomIn and ZoomOut buttons
tMinimapZoomIn:ClearAllPoints()
tMinimapZoomOut:ClearAllPoints()
tMinimapZoomIn:SetPoint("TOPRIGHT", MinimapZoneText, "TOPLEFT", 160, -160)
tMinimapZoomOut:SetPoint("TOPRIGHT", MinimapZoneText, "TOPLEFT", 145, -180)
--Normal
tMinimapZoomIn:SetNormalTexture("Interface\\AddOns\\tDF\\img\\ZoomIn32.tga")
tMinimapZoomIn:SetWidth(16)
tMinimapZoomIn:SetHeight(16)
--Mouse over
tMinimapZoomIn:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\ZoomIn32-over.tga")
--Mouse click
tMinimapZoomIn:SetPushedTexture("Interface\\AddOns\\tDF\\img\\ZoomIn32-push.tga")

tMinimapZoomOut:SetNormalTexture("Interface\\AddOns\\tDF\\img\\ZoomOut32.tga")
tMinimapZoomOut:SetWidth(16)
tMinimapZoomOut:SetHeight(16)
--Mouse over
tMinimapZoomOut:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\ZoomOut32-push.tga")
--Mouse click
tMinimapZoomOut:SetPushedTexture("Interface\\AddOns\\tDF\\img\\ZoomOut32-push.tga")

-------------Event-----------------
-- Get the current minimap zoom level
local zoomLevel = Minimap:GetZoom()
-- Create a frame to handle the event
local frame = CreateFrame("Frame")
-- Set the OnUpdate script
frame:SetScript("OnUpdate", function(self, elapsed)
    local zoomLevel = Minimap:GetZoom()
-- Check if the zoom level is 0 or 5
        if zoomLevel == 0 then
            --print("The minimap is zoomed out to the maximum.")
            tMinimapZoomOut:Hide()
            tMinimapZoomIn:Show()
        elseif zoomLevel == 5 then
            --print("The minimap is zoomed in to the maximum.")
            tMinimapZoomIn:Hide()
            tMinimapZoomOut:Show()
        else
            --print("The minimap zoom level is between the minimum and maximum.")
            tMinimapZoomIn:Show()
            tMinimapZoomOut:Show()
        end
end)
-------------Event-----------------

--Move buffbars to the left of the 1.4x minimap
tBuffButton0:ClearAllPoints()
tBuffButton0:SetPoint("TOPRIGHT", MinimapZoneText, "TOPLEFT", -40, -10)

--Move Debuffs
local eventFrame = CreateFrame("Frame")
-- Set up the event handler
eventFrame:SetScript("OnUpdate", function(self, elapsed)
    -- Check if tBuffButton16 exists
    if tBuffButton16 then
        tBuffButton16:SetParent(UIParent)
        tBuffButton16:ClearAllPoints()
        tBuffButton16:SetPoint("CENTER", tBuffButton0, 0, -125)
    end

    if tTempEnchant1 then
        tTempEnchant1:SetParent(UIParent)
        tTempEnchant1:ClearAllPoints()
        tTempEnchant1:SetPoint("CENTER", tBuffButton0, 0, -50)
    end
end)

------------------Add Clock------------------
MinimapClock = CreateFrame("Frame", "Clock", Minimap)
MinimapClock:Hide()
MinimapClock:SetFrameLevel(64)
MinimapClock:SetPoint("CENTER", MinimapZoneText, 0, -225)
MinimapClock:SetWidth(68)
MinimapClock:SetHeight(23)
MinimapClock:SetBackdrop({
  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  tile = true, tileSize = 8, edgeSize = 16,
  insets = { left = 3, right = 3, top = 3, bottom = 3 }
})
MinimapClock:SetBackdropBorderColor(.9,.8,.5,1)
MinimapClock:SetBackdropColor(.4,.4,.4,1)

MinimapClock:Show()
MinimapClock:EnableMouse(true)

MinimapClock.text = MinimapClock:CreateFontString("Status", "LOW", "GameFontNormal")
MinimapClock.text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
MinimapClock.text:SetAllPoints(MinimapClock)
MinimapClock.text:SetFontObject(GameFontWhite)
MinimapClock:SetScript("OnUpdate", function()
    this.text:SetText(date("%I:%M %p"))
end)

MinimapClock:SetScript("OnEnter", function()
    local h, m = GetGameTime()
    local servertime
    if h > 12 then
        servertime = string.format("%.2d:%.2d PM", h - 12, m)
    else
        servertime = string.format("%.2d:%.2d AM", h, m)
    end
    local time = date("%I:%M %p")

    GameTooltip:ClearLines()
    GameTooltip:SetOwner(this, ANCHOR_BOTTOMLEFT)

    GameTooltip:AddLine("Clock")
    GameTooltip:AddDoubleLine("Local time", time, 1,1,1,1,1,1)
    GameTooltip:AddDoubleLine("Server time", servertime, 1,1,1,1,1,1)
    GameTooltip:Show()
end)

MinimapClock:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
