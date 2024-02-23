--Define local vars
local tMinimapBorder = MinimapBorder
local tMinimapCluster = MinimapCluster
local tMinimap = Minimap
local tMinimapToggleButton = MinimapToggleButton
local tGameTimeFrame = GameTimeFrame
local tMinimapZoomIn = MinimapZoomIn
local tMinimapZoomOut = MinimapZoomOut
local tMinimapBorderTop = MinimapBorderTop
local tBuffButton0 = BuffButton0

--Set Minimap to DF texture and scale to match DF size
tMinimapBorder:SetTexture("Interface\\AddOns\\tDF\\img\\Dragonflight-MiniMap")
--MinimapBorder:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT", 0, -40)
tMinimapCluster:SetScale(1.4)
tMinimapToggleButton:Hide()
tGameTimeFrame:Hide()

--Sets the ZoomIn and ZoomOut buttons
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

--Sets the Top Minimap background
tMinimapBorderTop:SetTexture()

--Move buffbars to the left of the 1.4x minimap
tBuffButton0:ClearAllPoints()
tBuffButton0:SetPoint("TOPRIGHT", MinimapCluster, "TOPLEFT", 10, -10)
