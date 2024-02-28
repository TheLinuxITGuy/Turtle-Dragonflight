--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]
-----------------Inside the bag empty slot icon-----------------
-- Iterate through each bag (0 is backpack, 1-4 are the bag slots)
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
            texture:SetTexture("Interface\\AddOns\\tDF\\img\\bagicons.tga")
            -- Set the size of the texture to match the size of the frame
            texture:SetWidth(frame:GetWidth())
            texture:SetHeight(frame:GetHeight())
            -- Position the texture to cover the entire frame
            texture:SetAllPoints(frame)
        end
    end
end
-----------------Inside the bag empty slot icon-----------------

-----------------Inside the bag Top Left Bag icon-----------------
-- Create a local instance of ContainerFrame1PortraitButton
local button = ContainerFrame1PortraitButton
-- Reskin the button with a custom image
button:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bigbag")
button:SetPoint("TOPLEFT", ContainerFrame1, -1, 2)
button:SetWidth(50)
button:SetHeight(50)
-----------------Inside the bag Top Left Bag icon-----------------

--hides the original Blizzard artwork
MainMenuBarBackpackButton:Hide()
CharacterBag0Slot:Hide()
CharacterBag1Slot:Hide()
CharacterBag2Slot:Hide()
CharacterBag3Slot:Hide()

-----------------Main Bag icon-----------------

local bbMain = CreateFrame("Button", "MyBagButton", UIParent, "UIPanelButtonTemplate")
bbMain:SetWidth(35)
bbMain:SetHeight(35)
bbMain:SetPoint("TOPLEFT", mbHelp, -25, 45) --the -25 is to the left, the 45 is up
bbMain:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
local MainBagNormalTexture = bbMain:GetNormalTexture()
--MainBagNormalTexture:SetTexCoord(2/256, 80/256, 2/512, 86/512)
MainBagNormalTexture:SetTexCoord(6/512, 84/512, 4/128, 88/128)
--MainBagNormalTexture:SetWidth(35)
--MainBagNormalTexture:SetHeight(35)
--Set the button's pushed texture
bbMain:SetPushedTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
--Get the texture object and set its coordinates
local MainBagPushedTexture = bbMain:GetPushedTexture()
MainBagPushedTexture:SetTexCoord(204/512, 280/512, 4/128, 88/128)
--Set the button's highlight texture
bbMain:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
--Get the texture object and set its coordinates
local MainBagHighlightTexture = bbMain:GetHighlightTexture()
MainBagHighlightTexture:SetTexCoord(104/512, 185/512, 4/128, 90/128)
--click
bbMain:SetScript("OnClick", function(self, button, down)
    ToggleBag(0)
  end)
-----------------Main Bag icon-----------------

-----------------Arrow to the left of the Main Bag icon-----------------
  --Point left
  local bbLeftArrow = CreateFrame("Button", "bbArrow", UIParent, "UIPanelButtonTemplate")
  bbLeftArrow:SetWidth(10)
  bbLeftArrow:SetHeight(15)
  bbLeftArrow:SetPoint("CENTER", bbMain, -28, 0) --the -25 is to the left, the 45 is up
  bbLeftArrow:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
  local ArrowLeftNormalTexture = bbArrow:GetNormalTexture()
  ArrowLeftNormalTexture:SetTexCoord(487/512, 503/512, 2/128, 33/128)--pointing left
  --Set the button's pushed texture
  bbLeftArrow:SetPushedTexture("")
  --Get the texture object and set its coordinates
  local ArrowLeftPushedTexture = bbLeftArrow:GetPushedTexture()
  ArrowLeftPushedTexture:SetTexCoord(204/512, 280/512, 4/128, 88/128)
  --Set the button's highlight texture
  bbLeftArrow:SetHighlightTexture("")
  --Get the texture object and set its coordinates
  local ArrowLeftHighlightTexture = bbLeftArrow:GetHighlightTexture()
  ArrowLeftHighlightTexture:SetTexCoord(104/512, 183/512, 4/128, 88/128)
  bbLeftArrow:Hide()
  --click
  bbLeftArrow:SetScript("OnClick", function(self, button, down)
      --hide Bags 1-3
          --ArrowNormalTexture:SetTexCoord(487/512, 503/512, 2/128, 33/128) --pointing left
          bbLeftArrow:Hide()
          bbLeftArrow:Disable()
          bbArrow:Enable()
          bbArrow:Show()
          lb1:Show()
          lb2:Show()
          lb3:Show()
          lb4:Show()
          kr:Show()
    end)

local bbArrow = CreateFrame("Button", "bbArrow", UIParent, "UIPanelButtonTemplate")
bbArrow:SetWidth(10)
bbArrow:SetHeight(15)
bbArrow:SetPoint("CENTER", bbMain, -28, 0) --the -25 is to the left, the 45 is up
bbArrow:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
local ArrowNormalTexture = bbArrow:GetNormalTexture()
ArrowNormalTexture:SetTexCoord(488/512, 504/512, 38/128, 70/128) --pointing right
--Set the button's pushed texture
bbArrow:SetPushedTexture("")
--Get the texture object and set its coordinates
local ArrowPushedTexture = bbArrow:GetPushedTexture()
ArrowPushedTexture:SetTexCoord(204/512, 280/512, 4/128, 88/128)
--Set the button's highlight texture
bbArrow:SetHighlightTexture("")
--Get the texture object and set its coordinates
local ArrowHighlightTexture = bbArrow:GetHighlightTexture()
ArrowHighlightTexture:SetTexCoord(104/512, 183/512, 4/128, 88/128)
--click
bbArrow:SetScript("OnClick", function(self, button, down)
    --hide Bags 1-3
        --ArrowNormalTexture:SetTexCoord(487/512, 503/512, 2/128, 33/128) --pointing left
        bbArrow:Hide()
        bbArrow:Disable()
        bbLeftArrow:Show()
        bbLeftArrow:Enable()
        lb1:Hide()
        lb2:Hide()
        lb3:Hide()
        lb4:Hide()
        kr:Hide()
  end)
-----------------Arrow to the left of the Main Bag icon-----------------

-----------------Bag 1 icon-----------------

local lb1 = CreateFrame("Button", "lb1", UIParent, "UIPanelButtonTemplate")
lb1:SetWidth(25)
lb1:SetHeight(25)
lb1:SetPoint("CENTER", bbMain, -50, 0) --the -45 is to the left, the 45 is up
lb1:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
local lb1NormalTexture = lb1:GetNormalTexture()
--MainBagNormalTexture:SetTexCoord(2/256, 80/256, 2/512, 86/512)
lb1NormalTexture:SetTexCoord(295/512, 353/512, 64/128, 124/128)
--MainBagNormalTexture:SetWidth(25)
--MainBagNormalTexture:SetHeight(25)
--Set the button's pushed texture
lb1:SetPushedTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
--Get the texture object and set its coordinates
local lb1PushedTexture = lb1:GetPushedTexture()
lb1PushedTexture:SetTexCoord(422/512, 475/512, 65/128, 118/128)
--Set the button's highlight texture
lb1:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
--Get the texture object and set its coordinates
local lb1HighlightTexture = lb1:GetHighlightTexture()
lb1HighlightTexture:SetTexCoord(358/512, 414/512, 1/128, 56/128)
--click
lb1:SetScript("OnClick", function(self, button, down)
    ToggleBag(1)
  end)
-----------------Bag 1 icon-----------------

-----------------Bag 2 icon-----------------

local lb2 = CreateFrame("Button", "lb2", UIParent, "UIPanelButtonTemplate")
lb2:SetWidth(25)
lb2:SetHeight(25)
lb2:SetPoint("CENTER", bbMain, -75, 0) --the -45 is to the left, the 45 is up
lb2:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
local lb2NormalTexture = lb2:GetNormalTexture()
--MainBagNormalTexture:SetTexCoord(2/256, 80/256, 2/512, 86/512)
lb2NormalTexture:SetTexCoord(295/512, 353/512, 64/128, 124/128)
--MainBagNormalTexture:SetWidth(25)
--MainBagNormalTexture:SetHeight(25)
--Set the button's pushed texture
lb2:SetPushedTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
--Get the texture object and set its coordinates
local lb2PushedTexture = lb2:GetPushedTexture()
lb2PushedTexture:SetTexCoord(422/512, 475/512, 65/128, 118/128)
--Set the button's highlight texture
lb2:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
--Get the texture object and set its coordinates
local lb2HighlightTexture = lb2:GetHighlightTexture()
lb2HighlightTexture:SetTexCoord(358/512, 414/512, 1/128, 56/128)
--click
lb2:SetScript("OnClick", function(self, button, down)
    ToggleBag(2)
  end)
-----------------Bag 2 icon-----------------

-----------------Bag 3 icon-----------------

local lb3 = CreateFrame("Button", "lb3", UIParent, "UIPanelButtonTemplate")
lb3:SetWidth(25)
lb3:SetHeight(25)
lb3:SetPoint("CENTER", bbMain, -100, 0) --the -45 is to the left, the 45 is up
lb3:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
local lb3NormalTexture = lb3:GetNormalTexture()
--MainBagNormalTexture:SetTexCoord(2/256, 80/256, 2/512, 86/512)
lb3NormalTexture:SetTexCoord(295/512, 353/512, 64/128, 124/128)
--MainBagNormalTexture:SetWidth(25)
--MainBagNormalTexture:SetHeight(25)
--Set the button's pushed texture
lb3:SetPushedTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
--Get the texture object and set its coordinates
local lb3PushedTexture = lb3:GetPushedTexture()
lb3PushedTexture:SetTexCoord(422/512, 475/512, 65/128, 118/128)
--Set the button's highlight texture
lb3:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
--Get the texture object and set its coordinates
local lb3HighlightTexture = lb3:GetHighlightTexture()
lb3HighlightTexture:SetTexCoord(358/512, 414/512, 1/128, 56/128)
--click
lb3:SetScript("OnClick", function(self, button, down)
    ToggleBag(3)
  end)
-----------------Bag 3 icon-----------------

-----------------Bag 4 icon-----------------

local lb4 = CreateFrame("Button", "lb4", UIParent, "UIPanelButtonTemplate")
lb4:SetWidth(25)
lb4:SetHeight(25)
lb4:SetPoint("CENTER", bbMain, -125, 0) --the -45 is to the left, the 45 is up
lb4:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
local lb4NormalTexture = lb4:GetNormalTexture()
--MainBagNormalTexture:SetTexCoord(2/256, 80/256, 2/512, 86/512)
lb4NormalTexture:SetTexCoord(295/512, 353/512, 64/128, 124/128)
--MainBagNormalTexture:SetWidth(25)
--MainBagNormalTexture:SetHeight(25)
--Set the button's pushed texture
lb4:SetPushedTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
--Get the texture object and set its coordinates
local lb4PushedTexture = lb4:GetPushedTexture()
lb4PushedTexture:SetTexCoord(422/512, 475/512, 65/128, 118/128)
--Set the button's highlight texture
lb4:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\bagslots2x1.tga")
--Get the texture object and set its coordinates
local lb4HighlightTexture = lb4:GetHighlightTexture()
lb4HighlightTexture:SetTexCoord(358/512, 414/512, 1/128, 56/128)
--click
lb4:SetScript("OnClick", function(self, button, down)
    ToggleBag(4)
  end)
-----------------Bag 4 icon-----------------

-----------------Keyring icon-----------------

local kr = CreateFrame("Button", "kr", UIParent, "UIPanelButtonTemplate")
kr:SetWidth(25)
kr:SetHeight(25)
kr:SetPoint("CENTER", bbMain, -150, 0) --the -45 is to the left, the 45 is up
kr:SetNormalTexture("Interface\\AddOns\\tDF\\img\\bagslots2key.tga")
local krNormalTexture = kr:GetNormalTexture()
--MainBagNormalTexture:SetTexCoord(2/256, 80/256, 2/512, 86/512)
krNormalTexture:SetTexCoord(4/128, 62/128, 63/128, 124/128)
--MainBagNormalTexture:SetWidth(25)
--MainBagNormalTexture:SetHeight(25)
--Set the button's pushed texture
kr:SetPushedTexture("Interface\\AddOns\\tDF\\img\\bagslots2key.tga")
--Get the texture object and set its coordinates
local krPushedTexture = kr:GetPushedTexture()
krPushedTexture:SetTexCoord(68/128, 122/128, 63/128, 124/128)
--Set the button's highlight texture
kr:SetHighlightTexture("Interface\\AddOns\\tDF\\img\\bagslots2key.tga")
--Get the texture object and set its coordinates
local krHighlightTexture = kr:GetHighlightTexture()
krHighlightTexture:SetTexCoord(4/128, 62/128, 1/128, 56/128)
--click
kr:SetScript("OnClick", function(self, button, down)
    ToggleKeyRing()
  end)
-----------------Keyring icon-----------------

