local ShaguTweaks = CreateFrame("Frame")

  --Shagu's GetExpansion function from his helpers.lua
    ShaguTweaks.GetExpansion = function()
        local _, _, _, client = GetBuildInfo()
        client = client or 11200
      
        -- detect client expansion
        if client >= 20000 and client <= 20400 then
          return "tbc"
        elseif client >= 30000 and client <= 30300 then
          return "wotlk"
        else
          return "vanilla"
        end
      end

--Shagu's GetGlobalEnv function from his helpers.lua
    ShaguTweaks.GetGlobalEnv = function()
        if ShaguTweaks.GetExpansion() == 'vanilla' then
          return getfenv(0)
        else
          return _G or getfenv(0)
        end
      end
    
      local _G = ShaguTweaks.GetGlobalEnv()

        -- update table to get unknown colors and blue shamans for vanilla
  RAID_CLASS_COLORS = {
    ["WARRIOR"] = { r = 0.78, g = 0.61, b = 0.43, colorStr = "ffc79c6e" },
    ["MAGE"]    = { r = 0.41, g = 0.8,  b = 0.94, colorStr = "ff69ccf0" },
    ["ROGUE"]   = { r = 1,    g = 0.96, b = 0.41, colorStr = "fffff569" },
    ["DRUID"]   = { r = 1,    g = 0.49, b = 0.04, colorStr = "ffff7d0a" },
    ["HUNTER"]  = { r = 0.67, g = 0.83, b = 0.45, colorStr = "ffabd473" },
    ["SHAMAN"]  = { r = 0.14, g = 0.35, b = 1.0,  colorStr = "ff0070de" },
    ["PRIEST"]  = { r = 1,    g = 1,    b = 1,    colorStr = "ffffffff" },
    ["WARLOCK"] = { r = 0.58, g = 0.51, b = 0.79, colorStr = "ff9482c9" },
    ["PALADIN"] = { r = 0.96, g = 0.55, b = 0.73, colorStr = "fff58cba" },
  }

  RAID_CLASS_COLORS = setmetatable(RAID_CLASS_COLORS, { __index = function(tab,key)
    return { r = 0.6,  g = 0.6,  b = 0.6,  colorStr = "ff999999" }
  end})

local partycolors = function()
  for id = 1, MAX_PARTY_MEMBERS do
    local name = _G['PartyMemberFrame'..id..'Name']
    local _, class = UnitClass("party" .. id)
    local class = RAID_CLASS_COLORS[class] or { r = .5, g = .5, b = .5, a = 1 }
    if name then name:SetTextColor(class.r, class.g, class.b, 1) end
  end
end

  -- enable class color backgrounds
  local original = TargetFrame_CheckFaction
  function TargetFrame_CheckFaction(self)
    original(self)

    local reaction = UnitReaction("target", "player")

	  if UnitIsPlayer("target") then
	    local _, class = UnitClass("target")
	    local class = RAID_CLASS_COLORS[class] or { r = .5, g = .5, b = .5, a = 1 }
	    TargetFrameNameBackground:SetVertexColor(class.r, class.g, class.b, 1)
	    TargetFrameNameBackground:Show()
	  elseif reaction and reaction > 4 then
	    TargetFrameNameBackground:Hide()
    else
	    TargetFrameNameBackground:Show()
    end
  end

  local _, class = UnitClass("player")
  local class = RAID_CLASS_COLORS[class] or { r = .5, g = .5, b = .5, a = 1 }

  -- add name background to player frame
  PlayerFrameNameBackground = PlayerFrame:CreateTexture(nil, "BACKGROUND")
  PlayerFrameNameBackground:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-LevelBackground")
  PlayerFrameNameBackground:SetWidth(119)
  PlayerFrameNameBackground:SetHeight(19)
  PlayerFrameNameBackground:SetPoint("TOPLEFT", 106, -22)
  PlayerFrameNameBackground:SetVertexColor(class.r, class.g, class.b, 1)

  local wait = CreateFrame("Frame")
  wait:RegisterEvent("PLAYER_ENTERING_WORLD")
  wait:SetScript("OnEvent", function()
    local _, class = UnitClass("player")
    local class = RAID_CLASS_COLORS[class] or { r = .5, g = .5, b = .5, a = 1 }
    PlayerFrameNameBackground:SetVertexColor(class.r, class.g, class.b, 1)
    this:UnregisterAllEvents()

    -- make sure to keep name background above frame shadow
    PlayerFrameNameBackground:SetDrawLayer("BORDER")
    TargetFrameNameBackground:SetDrawLayer("BORDER")
  end)

  -- add font outline
  local font, size = PlayerFrame.name:GetFont()
  PlayerFrame.name:SetFont(font, size, "NONE")
  TargetFrame.name:SetFont(font, size, "NONE")

  -- add party frame class colors
  local HookPartyMemberFrame_UpdateMember = PartyMemberFrame_UpdateMember
  PartyMemberFrame_UpdateMember = function(self)
    HookPartyMemberFrame_UpdateMember(self)
    partycolors()
  end

  partycolors()
