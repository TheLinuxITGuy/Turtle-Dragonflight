local _G = tDFUI.GetGlobalEnv()
local create_button = tDF.utils.create_button

-----------------Inside the bag Top Left Bag icon-----------------
-- Create a local instance of ContainerFrame1PortraitButton
local button = ContainerFrame1PortraitButton
-- Reskin the button with a custom image
button:SetNormalTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\bigbag")
button:SetPoint("TOPLEFT", ContainerFrame1, -1, 2)
button:SetWidth(50)
button:SetHeight(50)
-----------------Inside the bag Top Left Bag icon-----------------

MainMenuBarBackpackButton:Hide()
KeyRingButton:ClearAllPoints()
KeyRingButton:Hide()

tDFUI_config = tDFUI_config or {}
tDFUI_config["tDFbags_hide"] = tDFUI_config["tDFbags_hide"] or 0

local bags_texture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\bagslots2x1.tga"
local bags_keys_texture = "Interface\\AddOns\\Turtle-Dragonflight\\img\\bagslots2key.tga"
local normal_txc = {295/512, 354/512, 64/128, 124/128}
local pushed_txc = {422/512, 475/512, 65/128, 118/128}
local highlight_txc = {358/512, 414/512, 1/128, 56/128}
local bags_data =
{
    {
        Name = "tDFbag1",
        offset_x = -50,  -- changed from -50
        f_OnClick = function() ToggleBag(1) end
    },
    {
        Name = "tDFbag2",
        offset_x = -80,  -- changed from -85
        f_OnClick = function() ToggleBag(2) end
    },
    {
        Name = "tDFbag3",
        offset_x = -110,  -- changed from -120
        f_OnClick = function() ToggleBag(3) end
    },
    {
        Name = "tDFbag4",
        offset_x = -140,  -- changed from -155
        f_OnClick = function() ToggleBag(4) end
    },
}

local function bags_override(frame, parent_frame)
    frame:SetNormalTexture("")
    frame:SetPushedTexture("")
    frame:SetHighlightTexture("")
    frame:ClearAllPoints()
    frame:SetWidth(16)  -- changed from 18
    frame:SetHeight(16) -- changed from 18
    frame:SetPoint("CENTER", parent_frame, -.75, .75)
end

local function bags_main_onclick()
    if IsShiftKeyDown() then
        ToggleBag(0)
        ToggleBag(1)
        ToggleBag(2)
        ToggleBag(3)
        ToggleBag(4)
    else
        ToggleBag(0)
    end
end

function bags_showall()
    tDFbag1:Show()
    tDFbag2:Show()
    tDFbag3:Show()
    tDFbag4:Show()
    tDFbagKeys:Show()
    CharacterBag0Slot:Show()
    CharacterBag1Slot:Show()
    CharacterBag2Slot:Show()
    CharacterBag3Slot:Show()
end

function bags_hideall()
    tDFbag1:Hide()
    tDFbag2:Hide()
    tDFbag3:Hide()
    tDFbag4:Hide()
    tDFbagKeys:Hide()
    CharacterBag0Slot:Hide()
    CharacterBag1Slot:Hide()
    CharacterBag2Slot:Hide()
    CharacterBag3Slot:Hide()
end

local function bags_toggle()
    local tx = tDFbagArrow:GetNormalTexture()
    if tDFUI_config["tDFbags_hide"] == 1 then
        bags_showall()
        tDFUI_config["tDFbags_hide"] = 0
        tx:SetTexCoord(488/512, 504/512, 38/128, 70/128)
    else
        bags_hideall()
        tDFUI_config["tDFbags_hide"] = 1
        tx:SetTexCoord(487/512, 503/512, 2/128, 33/128)
    end
end

local function freeSlots()
    local free = 0
    for i = 0, 4 do
        for slot = 1, GetContainerNumSlots(i) do
            local link = GetContainerItemLink(i, slot)
            if not (link) then
                free = free + 1
            end
        end
    end
    if this.text then
        this.text:SetText("(" .. free .. ")")
    end
end

local bags_main = create_button("tDFbagMain", UIParent, "BOTTOMRIGHT", 40, 40,
    bags_texture, bags_texture, bags_texture,
    {4/512, 90/512, 2/128, 94/128},
    {204/512, 280/512, 4/128, 88/128},
    {104/512, 185/512, 4/128, 90/128},
    -10, 40, nil, nil, bags_main_onclick)

-- Create a frame to display the number of free bag slots
local tDFbagFreeSlots = CreateFrame("Frame", "tDFbagFreeSlots", tDFbagMain)
tDFbagFreeSlots:SetWidth(50)
tDFbagFreeSlots:SetHeight(20)
tDFbagFreeSlots:SetPoint("CENTER", tDFbagMain, "CENTER", 0, -12)
tDFbagFreeSlots.text = tDFbagFreeSlots:CreateFontString(nil, "OVERLAY", "GameFontNormal")
tDFbagFreeSlots.text:SetPoint("CENTER", tDFbagFreeSlots, "CENTER", 0, 0)
tDFbagFreeSlots.text:SetVertexColor(1, 1, 1)
tDFbagFreeSlots.text:SetFont("Fonts\\FRIZQT__.TTF", 10)  -- added to set font size to 10
tDFbagFreeSlots:RegisterEvent("BAG_UPDATE")
tDFbagFreeSlots:SetScript("OnEvent", freeSlots)

for i, button in ipairs(bags_data) do
    local frame = create_button(button.Name, bags_main, "CENTER", 30, 30,  -- changed from 35, 35
    bags_texture, bags_texture, bags_texture,
    normal_txc, pushed_txc, highlight_txc,
    button.offset_x, 0, nil, nil, button.f_OnClick)

    frame:SetFrameStrata("LOW")
    --frame:SetFrameLevel(3)

    bags_override(_G["CharacterBag" .. i - 1 .. "Slot"], frame)
end

local bags_keys = create_button("tDFbagKeys", tDFbagMain, "CENTER", 30, 30,
    bags_keys_texture, bags_keys_texture, bags_keys_texture,
    {4/128, 62/128, 63/128, 124/128},
    {68/128, 122/128, 63/128, 124/128},
    {4/128, 62/128, 1/128, 56/128},
    -170, 0, nil, nil, function() ToggleKeyRing() end) --was -190

local bags_arrow = create_button("tDFbagArrow", tDFbagMain, "CENTER", 10, 15,
    bags_texture, bags_texture, bags_texture,
    {488/512, 504/512, 38/128, 70/128},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    -28, 0, nil, nil, bags_toggle)
    tDFbagArrow:SetPoint("CENTER", tDFbagMain, -30, 0)

-----------------Inside the bag empty slot icon-----------------
-- Iterate through each bag (0 is backpack, 1-4 are the bag slots)
-- Create a frame to listen for the PLAYER_LOGIN event

local loginFrame = CreateFrame("Frame")

-- Create a variable to track the time
local timeSinceLastUpdate = 0

-- Set the script to run when the PLAYER_LOGIN event fires
loginFrame:SetScript("OnEvent", function()
    -- Set the OnUpdate script
    this:SetScript("OnUpdate", function()
        timeSinceLastUpdate = timeSinceLastUpdate + arg1
        if timeSinceLastUpdate < 1 then
            return
        end

        -- Reset the time
        timeSinceLastUpdate = 0

        -- Remove the OnUpdate script
        this:SetScript("OnUpdate", nil)

        freeSlots(tDFbagFreeSlots)

        if tDFUI_config["Hide Bags"] == 0 then
            local tx = tDFbagArrow:GetNormalTexture()
            if tDFUI_config["tDFbags_hide"] == 1 then
                bags_hideall()
                tx:SetTexCoord(487/512, 503/512, 2/128, 33/128)
            else
                bags_showall()
                tx:SetTexCoord(488/512, 504/512, 38/128, 70/128)
            end
        end

        for bag = 0, 4 do
            -- Get the number of slots in the bag
            local size = GetContainerNumSlots(bag)
            -- Iterate through each slot in the bag
            for slot = 1, size do
                -- Get the frame for the bag slot
                local frame = getglobal("ContainerFrame" .. bag+1 .. "Item" .. slot)
                if frame then
                    -- Create a texture for the frame
                    local texture = frame:CreateTexture(nil, "BACKGROUND")
                    -- Set the texture to your custom image
                    texture:SetTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\bagbg2.tga")
                    -- Set the size of the texture to match the size of the frame
                    texture:SetWidth(frame:GetWidth())
                    texture:SetHeight(frame:GetHeight())
                    -- Position the texture to cover the entire frame
                    texture:SetAllPoints(frame)
                end
            end
        end
    end)
end)

-- Register the PLAYER_LOGIN event
loginFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

