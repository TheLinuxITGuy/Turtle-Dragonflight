local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T

local module = tDFUI:register({
  title = T["Movable Unit Frames Extended"],
  description = T["mufe_desc"],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  category = T["Unit Frames"],
  enabled = true,
})

local movables = { 
  "PartyMemberFrame1",
  "PartyMemberFrame2",
  "PartyMemberFrame3",
  "PartyMemberFrame4"
}

local nonmovables = {
  "tDFmicrobutton",
  "MyCustomMinimap", -- minimap
  --"tDFImprovedCastbar", -- player castbar
  "tDFbagMain", -- bags bar
  "BuffButton0", -- buffrow1
  "BuffButton8", -- buffrow2
  --"BuffButton16", -- debuffs
  "TempEnchant1", -- weapon buffs
  "xpbar",
  "tDFquestwatchframe",
  "tDFDurability",
  "MiniMapMailFrame",
  "repbar"
}

module.enable = function(self)
  tDFUI_config = tDFUI_config or {}
  tDFUI_config["MoveUnitframesExtended"] = tDFUI_config["MoveUnitframesExtended"] or {}
  local movedb = tDFUI_config["MoveUnitframesExtended"]

  local unlocker = CreateFrame("Frame", nil, UIParent)
  unlocker:SetAllPoints(UIParent)

  unlocker.movable = nil
  unlocker:SetScript("OnUpdate", function()
    if IsShiftKeyDown() and IsControlKeyDown() then
      if not unlocker.movable then
        for _, frame in pairs(movables) do
         _G[frame]:SetUserPlaced(true)
         _G[frame]:SetMovable(true)
         _G[frame]:EnableMouse(true)
         _G[frame]:RegisterForDrag("LeftButton")
         _G[frame]:SetScript("OnDragStart", function() this:StartMoving() end)
         _G[frame]:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
        end

        for _, frame in pairs(nonmovables) do
         _G[frame]:SetMovable(true)
         _G[frame]:EnableMouse(true)
         _G[frame]:RegisterForDrag("LeftButton")

         if frame == "Minimap" then
          _G[frame]:GetParent():SetMovable(true)
          _G[frame]:SetScript("OnDragStart", function()
            -- this:StartMoving()
            this:GetParent():StartMoving()
          end)
          _G[frame]:SetScript("OnDragStop", function()
            -- this:StopMovingOrSizing()
            this:GetParent():StopMovingOrSizing()
          end)
         else
          _G[frame]:SetScript("OnDragStart", function() this:StartMoving() end)
          _G[frame]:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
         end
        end

        unlocker.movable = true
        unlocker.grid:Show()
      end
    elseif unlocker.movable then
      for _, frame in pairs(movables) do
       _G[frame]:SetScript("OnDragStart", function() end)
       _G[frame]:SetScript("OnDragStop", function() end)
       _G[frame]:StopMovingOrSizing()
      end

      for _, frame in pairs(nonmovables) do
       _G[frame]:SetScript("OnDragStart", function() end)
       _G[frame]:SetScript("OnDragStop", function() end)
       _G[frame]:StopMovingOrSizing()

       if frame == "Minimap" then
        movedb[_G[frame]:GetParent():GetName()] = {_G[frame]:GetParent():GetLeft(), _G[frame]:GetParent():GetTop()}
       else
        movedb[_G[frame]:GetName()] = {_G[frame]:GetLeft(), _G[frame]:GetTop()}
       end
      end      

      unlocker.movable = nil
      unlocker.grid:Hide()
    end
  end)

  unlocker.grid = CreateFrame("Frame", nil, WorldFrame)
  unlocker.grid:SetAllPoints(WorldFrame)
  unlocker.grid:Hide()

  local size = 1
  local line = {}

  local width = GetScreenWidth()
  local height = GetScreenHeight()

  local ratio = width / GetScreenHeight()
  local rheight = GetScreenHeight() * ratio

  local wStep = width / 64
  local hStep = rheight / 64

  -- vertical lines
  for i = 0, 64 do
    if i == 64 / 2 then
      line = unlocker.grid:CreateTexture(nil, 'BORDER')
      line:SetTexture(.8, .6, 0)
    else
      line = unlocker.grid:CreateTexture(nil, 'BACKGROUND')
      line:SetTexture(0, 0, 0, .2)
    end
    line:SetPoint("TOPLEFT", unlocker.grid, "TOPLEFT", i*wStep - (size/2), 0)
    line:SetPoint('BOTTOMRIGHT', unlocker.grid, 'BOTTOMLEFT', i*wStep + (size/2), 0)
  end

  -- horizontal lines
  for i = 1, floor(height/hStep) do
    if i == floor(height/hStep / 2) then
      line = unlocker.grid:CreateTexture(nil, 'BORDER')
      line:SetTexture(.8, .6, 0)
    else
      line = unlocker.grid:CreateTexture(nil, 'BACKGROUND')
      line:SetTexture(0, 0, 0, .2)
    end

    line:SetPoint("TOPLEFT", unlocker.grid, "TOPLEFT", 0, -(i*hStep) + (size/2))
    line:SetPoint('BOTTOMRIGHT', unlocker.grid, 'TOPRIGHT', 0, -(i*hStep + size/2))
  end

  -- position nonmovables
  for _, frame in pairs(nonmovables) do
    if frame == "Minimap" then
      if movedb[_G[frame]:GetParent():GetName()] then 
       _G[frame]:GetParent():ClearAllPoints()
       _G[frame]:GetParent():SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", movedb[_G[frame]:GetParent():GetName()][1], movedb[_G[frame]:GetParent():GetName()][2])
      end
    else
      if movedb[_G[frame]:GetName()] then
       _G[frame]:ClearAllPoints()
       _G[frame]:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", movedb[_G[frame]:GetName()][1], movedb[_G[frame]:GetName()][2])
      end
    end
  end
end
