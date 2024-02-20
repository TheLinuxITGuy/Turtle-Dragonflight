--Define local vars
local tMinimapBorder = MinimapBorder
local tMinimapCluster = MinimapCluster
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

--Minimap:SetPoint("TOPLEFT", MinimapCluster, "BOTTOMLEFT", 0, -10)
--[[
-- Initially hide the button
tMinimapZoomIn:Hide()
-- When the mouse is over the Minimap, show the button
tMinimapZoomIn:SetScript("OnEnter", function()
    tMinimapZoomIn:Show()
end)
-- When the mouse leaves the Minimap, hide the button
tMinimapZoomIn:SetScript("OnLeave", function()
    tMinimapZoomIn:Hide()
end)
]]

--Sets the Top Minimap background
tMinimapBorderTop:SetTexture()

--Move buffbars to the left of the 1.4x minimap
tBuffButton0:ClearAllPoints()
tBuffButton0:SetPoint("TOPRIGHT", MinimapCluster, "TOPLEFT", 10, -10)
