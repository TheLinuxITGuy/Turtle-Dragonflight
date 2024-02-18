--Define local vars
local tMinimapBorder = MinimapBorder
local tMinimapCluster = MinimapCluster
local tMinimapToggleButton = MinimapToggleButton
local tGameTimeFrame = GameTimeFrame
local tMinimapZoomIn = MinimapZoomIn
local tMinimapZoomOut = MinimapZoomOut
local tMinimapBorderTop = MinimapBorderTop
local tBuffButton0 = BuffButton0

--Set DF texture and scale to match DF size

tMinimapBorder:SetTexture("Interface\\AddOns\\tDF\\img\\Dragonflight-MiniMap")
--MinimapBorder:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT", 0, -40)
tMinimapCluster:SetScale(1.4)
tMinimapToggleButton:Hide()
tGameTimeFrame:Hide()
--MinimapZoomIn:SetNormalTexture("Interface\\AddOns\\tDF\\img\\ZoomIn")
--MinimapZoomIn:SetPushedTexture()
--MinimapZoomIn:SetHighlightTexture()
--MinimapZoomOut:SetTexture("")
tMinimapZoomIn:Hide()
tMinimapZoomOut:Hide()
tMinimapBorderTop:SetTexture()
--Minimap:SetPoint("TOPLEFT", MinimapCluster, "BOTTOMLEFT", 0, -10)

--scoot buffbars to the left of the 1.4x minimap
tBuffButton0:ClearAllPoints()
tBuffButton0:SetPoint("TOPRIGHT", MinimapCluster, "TOPLEFT", 10, -10)


--[[
-- Create a button frame
local zoomInButton = CreateFrame("Button", "MyZoomInButton", Minimap, "UIPanelButtonTemplate")

-- Set the position and size of the button
zoomInButton:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT")
zoomInButton:SetWidth(30)
zoomInButton:SetHeight(30)

-- Set the normal texture (the texture displayed when the button is not being clicked or highlighted)
zoomInButton:SetNormalTexture("Interface\\AddOns\\tDF\\img\\ZoomIn32.tga")
zoomInButton:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\ZoomIn32.tga")
zoomInButton:SetPushedTexture("Interface\\AddOns\\tDF\\img\\ZoomIn32.tga")


-- Set the script to run when the button is clicked
zoomInButton:SetScript("OnClick", function()
    MinimapZoomIn:Click()
end)
]]
