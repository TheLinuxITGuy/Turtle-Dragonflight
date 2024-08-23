tMinimapZoomIn = MinimapZoomIn
tMinimapZoomOut = MinimapZoomOut
local tBuffButton0 = BuffButton0
local tBuffButton16 = BuffButton16
local tTempEnchant1 = TempEnchant1
local tMinimapCluster = MinimapCluster
local tMinimap = Minimap

local f = CreateFrame("Frame")
--f:RegisterEvent("PLAYER_LOGIN")
--f:SetScript("OnEvent", function()
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
	
-- Create a frame for the border around MinimapZoneText
local borderFrame = CreateFrame("Frame", "BorderFrameForZoneText", UIParent)
borderFrame:SetWidth(180) -- Width of the border frame (adjust as needed)
borderFrame:SetHeight(30) -- Height of the border frame (adjust as needed)
borderFrame:SetPoint("CENTER", customMinimap, 15, 105) -- Position relative to the customMinimap
borderFrame:Show()

-- Add a texture to the borderFrame
local borderTexture = borderFrame:CreateTexture(nil, "BACKGROUND")
borderTexture:SetTexture("Interface\\AddOns\\tDF\\img\\MinimapBorder.tga")
borderTexture:SetAllPoints(borderFrame) -- Make the texture fill the entire frame
borderTexture:Show()

-- Position and style MinimapZoneText within the border frame
MinimapZoneText:SetParent(borderFrame) -- Set the parent to the new border frame
MinimapZoneText:ClearAllPoints()
MinimapZoneText:SetPoint("LEFT", borderFrame, "LEFT", -14, 6) -- Center the text within the border frame

-- Optionally hide MinimapToggleButton
MinimapToggleButton:Hide()

--MiniMapTrackingFrame
    -- Clear existing points
    MiniMapTrackingFrame:ClearAllPoints()
    -- Set new point relative to MiniMapZoneText
    MiniMapTrackingFrame:SetPoint("LEFT", MinimapZoneText, -14, 2.5)
    -- Set the scale to 50%
    MiniMapTrackingFrame:SetScale(0.6)
    -- Hide the border textures based on dimensions
    local regions = {MiniMapTrackingFrame:GetRegions()}
    for _, region in ipairs(regions) do
        if region and region:GetObjectType() == "Texture" then
            local width, height = region:GetWidth(), region:GetHeight()
            if width > 30 and height > 30 then
                region:Hide()
            end
        end
    end
--MiniMapTrackingFrame





    -- Show your custom minimap
    customMinimap:Show()
--end
--)

--Sets the ZoomIn and ZoomOut buttons
tMinimapZoomIn:ClearAllPoints()
tMinimapZoomOut:ClearAllPoints()
tMinimapZoomIn:SetPoint("TOPRIGHT", MinimapZoneText, "TOPLEFT", 180, -170)
tMinimapZoomOut:SetPoint("TOPRIGHT", MinimapZoneText, "TOPLEFT", 165, -190)

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

if MBB_MinimapButtonFrame then
    -- reposition MBB to the bottom of the styleFrame (under the minimap)
    -- show the button OnEnter and hide when OnLeave
    
    if IsAddOnLoaded("MinimapButtonBag-TurtleWoW") then
        MBB_MinimapButtonFrame_Texture:SetTexture("Interface\\Icons\\Inv_misc_bag_10_green")
    else
        MBB_MinimapButtonFrame_Texture:SetTexture("Interface\\Icons\\Inv_misc_bag_10")
    end            

    MBB_MinimapButtonFrame:ClearAllPoints()
    MBB_MinimapButtonFrame:SetPoint("BOTTOMLEFT", UIParent, 0, 0)
       
    
    local function showButton(button)
        button:SetAlpha(1)
    end

    local function hideButton(button)
        button:SetAlpha(0)  
    end            

    hideButton(MBB_MinimapButtonFrame)
    local hide = CreateFrame("BUTTON", nil, MBB_MinimapButtonFrame)
    hide:SetAllPoints(hide:GetParent())

    hide:SetScript("OnEnter", function()
        showButton(MBB_MinimapButtonFrame)
    end)

    hide:SetScript("OnLeave", function()
        hide.timer = GetTime() + 6
        hide:SetScript("OnUpdate", function()            
            if (GetTime() > hide.timer) then
                MBB_HideButtons() -- MBB function to hide buttons
                hideButton(MBB_MinimapButtonFrame)
                hide:SetScript("OnUpdate", nil)
            end
        end)
    end)
    
    hide:RegisterForClicks("LeftButtonDown","RightButtonDown")
    hide:SetScript("OnClick", function()
        MBB_OnClick(arg1)
    end)
end

--Moves pfQuest if exists to bottom left corner, do nothing if MBB is detected
if pfBrowserIcon and MBB_MinimapButtonFrame then
else if pfBrowserIcon then 
  pfBrowserIcon:SetParent(UIParent)
  pfBrowserIcon:ClearAllPoints()
  pfBrowserIcon:SetPoint("BOTTOMLEFT", UIParent, 0, 0) end
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