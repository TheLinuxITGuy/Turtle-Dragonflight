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
TalentMicroButton:SetPoint("BOTTOMLEFT", UIParent, -30, -30)
TalentMicroButton:Hide()

SpellbookMicroButton:ClearAllPoints()
SpellbookMicroButton:Hide()

CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:Hide()


function ShowTWBGQueueMenu()
  local TWBGQueueMinimapMenuFrame = CreateFrame('Frame', 'TWBGQueueMinimapMenuFrame', UIParent, 'UIDropDownMenuTemplate')
  UIDropDownMenu_Initialize(TWBGQueueMinimapMenuFrame, BuildTWBGQueueMenu, "MENU");
  ToggleDropDownMenu(1, nil, TWBGQueueMinimapMenuFrame, "cursor", -150, 25);
end

function create_microbutton_eye(parent_frame, x, y)
  LFT:SetPoint("CENTER", tDFmicrobutton, x, y)
  local overlay = CreateFrame("Frame", nil, LFTMinimapButtonEye:GetParent())

  -- Set the frame strata to be higher than LFTMinimapButtonEye 
  overlay:SetFrameStrata("DIALOG")

  -- Set the size and position of the overlay to match LFT_MinimapEye
  overlay:SetWidth(LFTMinimapButtonEye:GetWidth())
  overlay:SetHeight(LFTMinimapButtonEye:GetHeight())
  overlay:SetPoint("CENTER", LFTMinimapButtonEye, "CENTER")

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
      LFTFrameMainButton:Hide()
    end
  end)
  ----------------ANIMATION----------------
    findGroupButton.HookScript = findGroupButton.HookScript or ShaguTweaks.HookScript
    findMoreButton.HookScript = findMoreButton.HookScript or ShaguTweaks.HookScript
    leaveQueueButton.HookScript = leaveQueueButton.HookScript or ShaguTweaks.HookScript
    findGroupButton:HookScript("OnClick", function(self, button, down)
        LFTFrameMainButton:Show()
        overlay.texture:Show()
        end)
    findMoreButton:HookScript("OnClick", function(self, button, down)
        LFTFrameMainButton:Show()
        overlay.texture:Show()
        end)
    leaveQueueButton:HookScript("OnClick", function(self, button, down)
        LFTFrameMainButton:Hide()
        overlay.texture:Hide()
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
  
  LFT:SetParent(UIParent)
  LFT:ClearAllPoints()
  LFT:Hide()
  
  EBC_Minimap:SetParent(UIParent)
  EBC_Minimap:ClearAllPoints()
  EBC_Minimap:Hide()
  
  MinimapShopFrame:SetParent(UIParent)
  MinimapShopFrame:ClearAllPoints()
  MinimapShopFrame:SetPoint("TOPRIGHT", 5000, 5000)
  MinimapShopFrame:SetAlpha(0)
  MinimapShopFrame:SetHeight(0)
  MinimapShopFrame:SetWidth(0)

  TWMiniMapBattlefieldFrame:Hide()
end