ShaguTweaks = CreateFrame("Frame")

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