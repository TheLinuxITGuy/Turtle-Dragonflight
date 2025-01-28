
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
  local overlay = CreateFrame("Frame", nil, LFTMinimapButton:GetParent())

  -- Set the frame strata to be higher than LFT_Minimap
  overlay:SetFrameStrata("DIALOG")

  -- Set the size and position of the overlay to match LFT_Minimap
  overlay:SetWidth(LFTMinimapButton:GetWidth()+2)
  overlay:SetHeight(LFTMinimapButton:GetHeight()+2)
  overlay:SetPoint("CENTER", LFTMinimapButton, "CENTER")

  -- Set the texture for the overlay
  overlay.texture = overlay:CreateTexture()
  overlay.texture:SetAllPoints()
  overlay.texture:SetTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\uigroupfinderflipbookeye.tga")
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
      LFT:Hide()
    end
  end)
  ----------------ANIMATION----------------

  -- Function to execute different code based on the button text
  local function ExecuteBasedOnButtonText()
    local buttonText = LFTFrameMainButton:GetText()
    if buttonText then
        if buttonText == "Find Group" then
            -- Code to execute when the button text is "Find Group"
            --print("Executing code for Find Group")
            LFTMinimapButton:Show()
            overlay.texture:Show()
            -- Insert your specific code here
        elseif buttonText == "Leave Queue" then
            -- Code to execute when the button text is "Leave Queue"
            --print("Executing code for Leave Queue")
            LFTMinimapButton:Hide()
            overlay.texture:Hide()
            -- Insert your specific code here
        else
            --print("Button text is empty?: " .. buttonText)
            --LFTMinimapButton:Show()
            --overlay.texture:Show()
        end
    else
        print("LFTFrameMainButton has no text.")
    end
  end

  LFTFrameMainButton.HookScript = LFTFrameMainButton.HookScript or tDFUI.HookScript

  LFTFrameMainButton:HookScript("OnClick", function(self, button, down)
    -- Call the function to check the button text and execute the corresponding code
    ExecuteBasedOnButtonText()
  end)

  LFTMinimapButton:Hide()
  overlay.texture:Hide()

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
  latency:SetNormalTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\Latency.tga")
  latency:ClearAllPoints()
  latency:SetPoint("BOTTOMRIGHT", tDFmicrobutton, offset_x, offset_y)
  latency:SetWidth(20)
  latency:SetHeight(15)

  -- Add this to update each frame
  latency:SetScript("OnUpdate", function(self, elapsed)
    local _, _, latencyHome = GetNetStats()
    -- Change the color based on latency
    if latencyHome < 200 then
      latency:SetNormalTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\LatencyGreen.tga")
    elseif latencyHome < 300 then
        latency:SetNormalTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\LatencyYellow.tga")
    else
        latency:SetNormalTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\LatencyRed.tga")
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