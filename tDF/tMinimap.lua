local tMinimapZoomIn = MinimapZoomIn
local tMinimapZoomOut = MinimapZoomOut
local tBuffButton0 = BuffButton0
local tBuffButton16 = BuffButton16
local tTempEnchant1 = TempEnchant1
local tMinimapCluster = MinimapCluster
local tMinimap = Minimap

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    -- Move the MinimapCluster off the screen
    tMinimapCluster:ClearAllPoints()
    tMinimapCluster:SetPoint("TOPRIGHT", 0, 5000) -- Move it far off to the right
    tMinimapCluster:SetFrameStrata('BACKGROUND')

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
    tMinimap:SetParent(actualMinimap)
    tMinimap:SetPoint("CENTER", 1, -3)
    tMinimap:SetWidth(131*1.36)
    tMinimap:SetHeight(131*1.36)
    --Minimap:SetFrameStrata("LOW")
    tMinimap:SetFrameLevel(tMinimap:GetFrameLevel() - 1)

    -- Add the Minimap border texture (displayed above the actual Minimap)
    local borderTexture = customMinimap:CreateTexture(nil, "OVERLAY")
    borderTexture:SetTexture("Interface\\AddOns\\tDF\\img\\uiminimapborder.tga")
    borderTexture:SetAllPoints(customMinimap)

    --Add text over the Minimap
    MinimapZoneText:SetParent(UIParent)
    MinimapZoneText:ClearAllPoints()
    MinimapZoneText:SetPoint("CENTER", customMinimap, 0, 110)
    MinimapToggleButton:Hide()

    --MiniMapTrackingFrame
        -- Clear existing points
        MiniMapTrackingFrame:ClearAllPoints()
        -- Set new point relative to MiniMapZoneText
        MiniMapTrackingFrame:SetPoint("TOPRIGHT", UIParent, -0,2)
    --MiniMapTrackingFrame

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
local zoomLevel = tMinimap:GetZoom()
-- Create a frame to handle the event
local frame = CreateFrame("Frame")
-- Set the OnUpdate script
frame:SetScript("OnUpdate", function(self, elapsed)
    local zoomLevel = tMinimap:GetZoom()
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
tBuffButton0:SetPoint("TOPRIGHT", MinimapZoneText, "TOPLEFT", -50, -6)

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

--Moves pfQuest if exists to bottom left corner
if pfBrowserIcon then
  pfBrowserIcon:SetParent(UIParent)
  pfBrowserIcon:ClearAllPoints()
  pfBrowserIcon:SetPoint("BOTTOMLEFT", UIParent, 0, 0)
end

--"You've got mail!"" -AOL 1998
-- Define the path to your custom icon
local customMailIcon = "Interface\\AddOns\\tDF\\img\\mail.tga"

--Set it
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", tMinimap, "TOPRIGHT", -150, -150)
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture(customMailIcon)
MiniMapMailIcon:SetWidth(32)
MiniMapMailIcon:SetHeight(32)