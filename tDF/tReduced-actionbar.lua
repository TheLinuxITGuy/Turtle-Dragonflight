--[[
All code in this file was taken from ShaguTweaks. 
Full credit goes to him.
]]

-- general function to hide textures and frames
  local addonpath = "Interface\\AddOns\\ShaguTweaks"
  local function hide(frame, texture)
    if not frame then return end

    if texture and texture == 1 and frame.SetTexture then
      frame:SetTexture("")
    elseif texture and texture == 2 and frame.SetNormalTexture then
      frame:SetNormalTexture("")
    else
      frame:ClearAllPoints()
      frame.Show = function() return end
      frame:Hide()
    end
  end

  -- frames that shall be hidden
  
  local frames = {
    -- actionbar paging
    MainMenuBarPageNumber, ActionBarUpButton, ActionBarDownButton,
    -- xp and reputation bar
    MainMenuXPBarTexture2, MainMenuXPBarTexture3,
   ReputationWatchBarTexture2, ReputationWatchBarTexture3,

    -- actionbar backgrounds
	-- MainMenuBarTexture0,
    -- MainMenuBarTexture1,
    MainMenuBarTexture2, MainMenuBarTexture3,
    MainMenuMaxLevelBar2, MainMenuMaxLevelBar3, 
	--BonusActionBarTexture0,
    -- shapeshift backgrounds
    ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight,
  }

  --[[
    I removed these from the local frames so I can reskin them
    -- micro button panel
    CharacterMicroButton, SpellbookMicroButton, TalentMicroButton,
    QuestLogMicroButton, MainMenuMicroButton, SocialsMicroButton,
    WorldMapMicroButton, MainMenuBarPerformanceBarFrame, HelpMicroButton,
    -- bag panel
    CharacterBag3Slot, CharacterBag2Slot, CharacterBag1Slot,
    CharacterBag0Slot, MainMenuBarBackpackButton, KeyRingButton,
    
  ]]

  --the bagmenu
local bbMain = MainMenuBarBackpackButton
bbMain:ClearAllPoints()
bbMain:SetPoint("TOPLEFT", mbHelp, -15, 60)
bbMain:SetBackdrop(nil)
--bbMain:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bigbag")
--bbMain:SetWidth(55)
--bbMain:SetHeight(55)
-- Create a new texture
local bbMainTexture = bbMain:CreateTexture(nil, "OVERLAY")
-- Set the size of the texture
bbMainTexture:SetWidth(60)
bbMainTexture:SetHeight(60)
-- Set the texture file
bbMainTexture:SetTexture("Interface\\AddOns\\tDF\\img\\bigbag")
-- Position the texture on the button
bbMainTexture:SetPoint("CENTER", bbMain)

local lb1 = CharacterBag0Slot
--lb1:SetWidth(30)
--lb1:SetHeight(30)
lb1:ClearAllPoints()
lb1:SetPoint("TOPLEFT", mbHelp, -60, 60)
-- Hide the border
lb1:SetBackdrop(nil)
--lb1:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bigbag")
-- Create a new texture
local lb1Texture = lb1:CreateTexture(nil, "OVERLAY")
-- Set the size of the texture
lb1Texture:SetWidth(45)
lb1Texture:SetHeight(45)
-- Set the texture file
lb1Texture:SetTexture("Interface\\AddOns\\tDF\\img\\bigbag")
-- Position the texture on the button
lb1Texture:SetPoint("CENTER", lb1)

local lb2 = CharacterBag1Slot
--bbMain:ClearAllPoints()
lb2:SetPoint("TOPLEFT", mbHelp, -105, 60)
lb2:SetBackdrop(nil)
local lb2Texture = lb2:CreateTexture(nil, "OVERLAY")
lb2Texture:SetWidth(45)
lb2Texture:SetHeight(45)
lb2Texture:SetTexture("Interface\\AddOns\\tDF\\img\\bigbag")
lb2Texture:SetPoint("CENTER", lb2)

local lb3 = CharacterBag2Slot
--bbMain:ClearAllPoints()
lb3:SetPoint("TOPLEFT", mbHelp, -150, 60)
lb3:SetBackdrop(nil)
local lb3Texture = lb3:CreateTexture(nil, "OVERLAY")
lb3Texture:SetWidth(45)
lb3Texture:SetHeight(45)
lb3Texture:SetTexture("Interface\\AddOns\\tDF\\img\\bigbag")
lb3Texture:SetPoint("CENTER", lb3)

local lb4 = CharacterBag3Slot
--bbMain:ClearAllPoints()
lb4:SetPoint("TOPLEFT", mbHelp, -195, 60)
lb3:SetBackdrop(nil)
local lb4Texture = lb4:CreateTexture(nil, "OVERLAY")
lb4Texture:SetWidth(45)
lb4Texture:SetHeight(45)
lb4Texture:SetTexture("Interface\\AddOns\\tDF\\img\\bigbag")
lb4Texture:SetPoint("CENTER", lb4)

--[[
local kr = KeyRingButton
--bbMain:ClearAllPoints()
kr:SetPoint("TOPLEFT", mbHelp, -240, 30)
kr:SetBackdrop(nil)
local krTexture = kr:CreateTexture(nil, "OVERLAY")
krTexture:SetWidth(30)
krTexture:SetHeight(30)
kr:SetWidth(30)
kr:SetHeight(30)
krTexture:SetTexture("Interface\\AddOns\\tDF\\img\\KeyRing-Bag-Icon")
krTexture:SetPoint("CENTER", kr)
1
]]



  -- textures that shall be set empty
  local textures = {
    ReputationWatchBarTexture2, ReputationWatchBarTexture3,
    ReputationXPBarTexture2, ReputationXPBarTexture3,
    SlidingActionBarTexture0, SlidingActionBarTexture1,
	
  }

  -- button textures that shall be set empty
  local normtextures = {
    ShapeshiftButton1, ShapeshiftButton2,
    ShapeshiftButton3, ShapeshiftButton4,
    ShapeshiftButton5, ShapeshiftButton6,
  }

  -- elements that shall be resized to 511px
  local resizes = {
    MainMenuBar, MainMenuExpBar, MainMenuBarMaxLevelBar,
    ReputationWatchBar, ReputationWatchStatusBar,
  }

  -- hide frames
  for id, frame in pairs(frames) do hide(frame) end
  
  --hide error frames
 
 UIErrorsFrame:Hide();

  -- clear textures
  for id, frame in pairs(textures) do hide(frame, 1) end
  for id, frame in pairs(normtextures) do hide(frame, 2) end

  -- resize actionbar
  for id, frame in pairs(resizes) do frame:SetWidth(511) end

  -- experience bar
  MainMenuXPBarTexture0:SetPoint("LEFT", MainMenuExpBar, "LEFT")
  MainMenuXPBarTexture1:SetPoint("RIGHT", MainMenuExpBar, "RIGHT")

  -- reputation bar
  ReputationWatchBar:SetPoint("BOTTOM", MainMenuExpBar, "TOP", 0, 0)
  ReputationWatchBarTexture0:SetPoint("LEFT", ReputationWatchBar, "LEFT")
  ReputationWatchBarTexture1:SetPoint("RIGHT", ReputationWatchBar, "RIGHT")
  
  -- move menubar texture background
  MainMenuMaxLevelBar0:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT")
  MainMenuBarTexture0:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT")
  MainMenuBarTexture1:SetPoint("RIGHT", MainMenuBarArtFrame, "RIGHT")

  -- move gryphon textures
  MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 30, 0)
  MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -30, 0)

  -- move MultiBarBottomRight ontop of MultiBarBottomLeft
  MultiBarBottomRight:ClearAllPoints()
  MultiBarBottomRight:SetPoint("BOTTOM", MultiBarBottomLeft, "TOP", 0, 5)
  MultiBarBottomLeft:SetFrameStrata("LOW")

  -- reload custom frame positions after original frame manage runs
  local hookUIParent_ManageFramePositions = UIParent_ManageFramePositions
  UIParent_ManageFramePositions = function(a1, a2, a3)
    -- run original function
    hookUIParent_ManageFramePositions(a1, a2, a3)

    -- move bars above xp bar if xp or reputation is tracked
	MainMenuBarLeftEndCap:ClearAllPoints()
	MainMenuBarRightEndCap:ClearAllPoints()
   -- MainMenuBar:ClearAllPoints()
   if MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() then
	local anchor = GetWatchedFactionInfo() and ReputationWatchBar or MainMenuExpBar
	
	MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 28)
	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 26, 10)
	MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -26, 10)
    else
      MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 13)
	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 26, 25)
	MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -26, 25)
	MainMenuBarMaxLevelBar:SetAlpha(0)
    end

	MainMenuExpBar:ClearAllPoints()
	MainMenuExpBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 2)

	--ActionButton1:ClearAllPoints()
	--ActionButton1:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 18)
	
	--MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 28)
	MultiBarBottomLeft:ClearAllPoints()
	MultiBarBottomLeft:SetPoint("BOTTOM", MainMenuBar, "TOP", 3, -5)
	ReputationWatchStatusBar:ClearAllPoints()
	ReputationWatchStatusBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 2)
	
-- move pet actionbar above other actionbars
PetActionBarFrame:ClearAllPoints()
local anchor = MainMenuBarArtFrame

-- Create a function to update the anchor and position of PetActionBarFrame
local function updatePetActionBarPosition()
    if MultiBarBottomRight:IsVisible() then
        anchor = MultiBarBottomRight
    elseif MultiBarBottomLeft:IsVisible() then
        anchor = MultiBarBottomLeft
    end
    PetActionBarFrame:SetPoint("BOTTOM", anchor, "TOP", 0, 3)
end

-- Call the function initially to set the position
updatePetActionBarPosition()

-- Set scripts to update the position when action bars show/hide
MultiBarBottomRight:SetScript("OnShow", updatePetActionBarPosition)
MultiBarBottomRight:SetScript("OnHide", updatePetActionBarPosition)
MultiBarBottomLeft:SetScript("OnShow", updatePetActionBarPosition)
MultiBarBottomLeft:SetScript("OnHide", updatePetActionBarPosition)


    -- ShapeshiftBarFrame
    ShapeshiftBarFrame:ClearAllPoints()
    local offset = 0
    local anchor = ActionButton1
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor

    offset = anchor == ActionButton1 and ( MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() ) and 6 or 0
    offset = anchor == ActionButton1 and offset + 6 or offset
    ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 8, 2 + offset)

    -- move castbar ontop of other bars
    local anchor = MainMenuBarArtFrame
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor
    local pet_offset = PetActionBarFrame:IsVisible() and 40 or 0
    CastingBarFrame:SetPoint("BOTTOM", anchor, "TOP", 0, 50 + pet_offset)
  end
