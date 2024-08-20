--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
Mod: scorpzor
Description: Micromenu lib
]]
tDFmicrobutton = CreateFrame("Frame", "tDFmicrobutton", UIParent)
tDFmicrobutton:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 8)
tDFmicrobutton:SetHeight(30)
tDFmicrobutton:SetWidth(250)
tDFmicrobutton:SetFrameStrata("MEDIUM")

HelpMicroButton:ClearAllPoints()
HelpMicroButton:Hide()

MainMenuMicroButton:ClearAllPoints()
MainMenuMicroButton:Hide()

WorldMapMicroButton:ClearAllPoints()
WorldMapMicroButton:Hide()

SocialsMicroButton:ClearAllPoints()
SocialsMicroButton:Hide()

QuestLogMicroButton:ClearAllPoints()
QuestLogMicroButton:Hide()

TalentMicroButton:ClearAllPoints()
TalentMicroButton:Hide()

SpellbookMicroButton:ClearAllPoints()
SpellbookMicroButton:Hide()

CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:Hide()


function create_microbutton(Name,
  NormalTexture,
  NormalTextureCoord,
  PushedTexture,
  PushedTextureCoord,
  HighlightTexture,
  HighlightTextureCoord,
  f_OnEnter,
  f_OnLeave,
  f_OnClick,
  offset_x,
  offset_y,
  parent_frame)
  local mbButtonX = 18
  local mbButtonY = 25
  local frame = CreateFrame("Button", Name, parent_frame, "UIPanelButtonTemplate")
  frame:SetWidth(mbButtonX)
  frame:SetHeight(mbButtonY)
  frame:SetPoint("BOTTOMRIGHT", parent_frame, offset_x, offset_y)

  frame:SetNormalTexture(NormalTexture)
  local i_NormalTexture = frame:GetNormalTexture()
  i_NormalTexture:SetTexCoord(NormalTextureCoord[1], NormalTextureCoord[2], NormalTextureCoord[3], NormalTextureCoord[4])

  frame:SetPushedTexture(PushedTexture)
  local i_PushedTexture = frame:GetPushedTexture()
  i_PushedTexture:SetTexCoord(PushedTextureCoord[1], PushedTextureCoord[2], PushedTextureCoord[3], PushedTextureCoord[4])

  frame:SetHighlightTexture(HighlightTexture)
  local i_HighlightTexture = frame:GetHighlightTexture()
  i_HighlightTexture:SetTexCoord(HighlightTextureCoord[1], HighlightTextureCoord[2], HighlightTextureCoord[3], HighlightTextureCoord[4])

  frame:SetScript("OnEnter", f_OnEnter)
  frame:SetScript("OnLeave", f_OnLeave)
  frame:SetScript("OnClick", f_OnClick)
  return frame
end

function ShowTWBGQueueMenu()
  local TWBGQueueMinimapMenuFrame = CreateFrame('Frame', 'TWBGQueueMinimapMenuFrame', UIParent, 'UIDropDownMenuTemplate')
  UIDropDownMenu_Initialize(TWBGQueueMinimapMenuFrame, BuildTWBGQueueMenu, "MENU");
  ToggleDropDownMenu(1, nil, TWBGQueueMinimapMenuFrame, "cursor", -150, 25);
end

function create_microbutton_eye(parent_frame, x, y)
  LFT_Minimap:SetPoint("CENTER", tDFmicrobutton, x, y)
  local overlay = CreateFrame("Frame", nil, LFT_MinimapEye:GetParent())

  -- Set the frame strata to be higher than LFT_MinimapEye
  overlay:SetFrameStrata("DIALOG")

  -- Set the size and position of the overlay to match LFT_MinimapEye
  overlay:SetWidth(LFT_MinimapEye:GetWidth())
  overlay:SetHeight(LFT_MinimapEye:GetHeight())
  overlay:SetPoint("CENTER", LFT_MinimapEye, "CENTER")

  -- Set the texture for the overlay
  overlay.texture = overlay:CreateTexture()
  overlay.texture:SetAllPoints()
  overlay.texture:SetTexture("Interface\\AddOns\\tDF\\img\\uigroupfinderflipbookeye.tga")
  overlay.texture:SetTexCoord(10/512, 55/512, 8/256, 55/256)

  ----------------ANIMATION----------------
  -- Define the TexCoords for each frame of the animation
  local texCoords = {
    --512 is left and right, 256 is up and down
    {10/512, 55/512, 8/256, 55/256}, -- 1st row
    {74/512, 119/512, 8/256, 55/256}, --256 will stay the same as we are going right down the row
    {138/512, 183/512, 8/256, 55/256}, -- Add 64 to all of 512
    {202/512, 247/512, 8/256, 55/256}, -- Add 64 to all of 256
    {266/512, 311/512, 8/256, 55/256},
    {330/512, 375/512, 8/256, 55/256},
    {394/512, 439/512, 8/256, 55/256},
    {458/512, 503/512, 8/256, 55/256},

    {10/512, 55/512, 72/256, 119/256}, --2nd row
    {74/512, 119/512, 72/256, 119/256}, 
    {138/512, 183/512, 72/256, 119/256},
    {202/512, 247/512, 72/256, 119/256},
    {266/512, 311/512, 72/256, 119/256},
    {330/512, 375/512, 72/256, 119/256},
    {394/512, 439/512, 72/256, 119/256},
    {458/512, 503/512, 72/256, 119/256},

    {10/512, 55/512, 136/256, 183/256}, -- 3rd row
    {74/512, 119/512, 136/256, 183/256},
    {138/512, 183/512, 136/256, 183/256},
    {202/512, 247/512, 136/256, 183/256},
    {266/512, 311/512, 136/256, 183/256},
    {330/512, 375/512, 136/256, 183/256},
    {394/512, 439/512, 136/256, 183/256},
    {458/512, 503/512, 136/256, 183/256},

    {10/512, 55/512, 200/256, 247/256},--4th row
    {74/512, 119/512, 200/256, 247/256},
    {138/512, 183/512, 200/256, 247/256},
    {202/512, 247/512, 200/256, 247/256},
    {266/512, 311/512, 200/256, 247/256}
  }

  -- Function to update the texture coordinates
  local currentFrame = 1
  local function UpdateTexCoords()
    local coords = texCoords[currentFrame]
    overlay.texture:SetTexCoord(unpack(coords))
    currentFrame = currentFrame + 1
    if currentFrame > table.getn(texCoords) then
        currentFrame = 1
    end
  end

  -- OnUpdate script to change the TexCoords every 0.1 seconds
  local timeSinceLastUpdate = 0
  local updateInterval = .1 -- Adjust this to change the speed of the animation
  overlay:SetScript("OnUpdate", function(self, elapsed)
    local elapsed = arg1 or 0
    timeSinceLastUpdate = timeSinceLastUpdate + elapsed
    if timeSinceLastUpdate > updateInterval then
        timeSinceLastUpdate = 0
        UpdateTexCoords()
    end
  end)

  --when group is formed
  local frame = CreateFrame("Frame")
  frame:RegisterEvent("PARTY_MEMBERS_CHANGED")

  frame:SetScript("OnEvent", function(self, event, ...)
    if GetNumPartyMembers() > 0 then
      --DEFAULT_CHAT_FRAME:AddMessage("The group has been formed!")
      --code here to stop the animation
      overlay:SetScript("OnUpdate", nil)
      overlay.texture:SetTexCoord(10/512, 55/512, 8/256, 55/256)
    else
      -- Reattach the OnUpdate script to restart the animation
      overlay:SetScript("OnUpdate", function(self, elapsed)
        local elapsed = arg1 or 0
        timeSinceLastUpdate = timeSinceLastUpdate + elapsed
        if timeSinceLastUpdate > updateInterval then
            timeSinceLastUpdate = 0
            UpdateTexCoords()
        end
      end)  
      UpdateTexCoords()
      LFT_Minimap:Hide()
    end
  end)
  ----------------ANIMATION----------------

  --findGroupButton
  findGroupButton:SetScript("OnClick", function(self, button, down)
    LFT_Minimap:Show()
    overlay.texture:Show()
    findGroup()
  end)

  --findMoreButton
  findMoreButton:SetScript("OnClick", function(self, button, down)
    LFT_Minimap:Show()
    overlay.texture:Show()
    findGroup()
  end)

  --leaveQueueButton
  leaveQueueButton:SetScript("OnClick", function(self, button, down)
    LFT_Minimap:Hide()
    overlay.texture:Hide()
    leaveQueue()
  end)

  return overlay
end

function ShowEBCMinimapDropdown()
  if EBCMinimapDropdown:IsVisible() then
    EBCMinimapDropdown:Hide()
  else
    EBCMinimapDropdown:Show()
  end
end

function create_microbutton_latency(wow_latency_button, offset_x, offset_y)
  local latency = wow_latency_button

  -- Set the normal texture and store a reference to it
  latency.texture = latency:CreateTexture(nil, "BACKGROUND")
  latency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\Latency.tga")
  latency:ClearAllPoints()
  latency:SetPoint("BOTTOMRIGHT", tDFmicrobutton, offset_x, offset_y)
  latency:SetWidth(20)
  latency:SetHeight(15)

  -- Add this to update each frame
  latency:SetScript("OnUpdate", function(self, elapsed)
    local _, _, latencyHome = GetNetStats()
    -- Change the color based on latency
    if latencyHome < 200 then
      latency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\LatencyGreen.tga")
    elseif latencyHome < 300 then
        latency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\LatencyYellow.tga")
    else
        latency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\LatencyRed.tga")
    end
  end)

  return latency
end

function microbutton_removemi()
  EBC_Minimap:SetParent(UIParent)
  EBC_Minimap:ClearAllPoints()
  EBC_Minimap:Hide()
  
  LFT_Minimap:SetParent(UIParent)
  LFT_Minimap:ClearAllPoints()
  LFT_Minimap:Hide()
  
  EBC_Minimap:SetParent(UIParent)
  EBC_Minimap:ClearAllPoints()
  EBC_Minimap:Hide()
  
  TWMinimapShopFrame:SetParent(UIParent)
  TWMinimapShopFrame:ClearAllPoints()
  TWMinimapShopFrame:SetPoint("TOPRIGHT", 5000, 5000)
  TWMinimapShopFrame:SetAlpha(0)
  TWMinimapShopFrame:SetHeight(0)
  TWMinimapShopFrame:SetWidth(0)
end