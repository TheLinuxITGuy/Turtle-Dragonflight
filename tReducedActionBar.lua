

-- general function to hide textures and frames
  local addonpath = "Interface\\AddOns\\Turtle-Dragonflight"
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
	  --MainMenuBarTexture0,
    --MainMenuBarTexture1,
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
  --UIErrorsFrame:Hide();

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
    local anchor = MultiBarBottomLeftButton1
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor

    offset = anchor == ActionButton1 and ( MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() ) and 6 or 0
    offset = anchor == ActionButton1 and offset + 6 or offset
    ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", -10, 2 + offset)

-- new to support 3rd bar
-- Create a frame
local ShapeFrame = CreateFrame("Frame")

-- Set the OnUpdate script
ShapeFrame:SetScript("OnUpdate", function(self, elapsed)
    if MultiBarBottomRightButton1 then
        ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", -10, 10 + offset)
    else
        ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", -10, 2 + offset)
    end
end)

    -- move castbar ontop of other bars
    local anchor = MainMenuBarArtFrame
    anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
    anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor
    local pet_offset = PetActionBarFrame:IsVisible() and 40 or 0
    CastingBarFrame:SetPoint("BOTTOM", anchor, "TOP", 0, 50 + pet_offset)
  end

MainMenuExpBar:SetAlpha(0) --Required for tXPbar.lua to work
--MainMenuBarPerformanceBarFrame:Hide()
--Hide the original MainMenuBarPerformanceBarFrame
MainMenuBarPerformanceBarFrame:ClearAllPoints()
MainMenuBarPerformanceBarFrame:SetPoint("BOTTOMLEFT", UIParent, -300, -300)