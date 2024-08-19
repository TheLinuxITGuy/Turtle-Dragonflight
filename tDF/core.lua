local _G = getfenv(0)

local classes = { 'Druid', 'Hunter', 'Mage', 'Paladin', 'Priest', 'Rogue', 'Shaman', 'Warlock', 'Warrior' }

CRAP = CreateFrame('Frame', nil, UIParent)
CRAP:RegisterEvent('PLAYER_ENTERING_WORLD')
CRAP:RegisterEvent('PARTY_MEMBERS_CHANGED')
CRAP:RegisterEvent('RAID_ROSTER_UPDATE')

local function HandleEvent()
	if event == 'PLAYER_ENTERING_WORLD' then
		CRAP:InitOptions()
		
		for i = 1, MAX_PARTY_MEMBERS do
			local frame = getglobal('PartyMemberFrame' .. i)
			if frame then
				frame:Hide()
				frame:UnregisterAllEvents()
				frame.Show = function() return end
			end
		end
	end

	CRAP:Update()
end

CRAP:SetScript('OnEvent', HandleEvent)

function CRAP:Update(mock)
	local group = _G['GroupFrame']
	group:Show()
	group:SetPoint('TOPLEFT', UIParent, CRAP_Config['GROUP_POSITION']['X'], CRAP_Config['GROUP_POSITION']['Y'])
	group:SetBackdropBorderColor(CRAP_Config['BORDER_COLOR']['R'], CRAP_Config['BORDER_COLOR']['G'], CRAP_Config['BORDER_COLOR']['B'], CRAP_Config['BORDER_COLOR']['A'])

	if CRAP_Config['GROUP_LAYOUT'] then
		GroupFrameMemberFrame21:SetPoint('TOPLEFT', GroupFrameMemberFrame16, 'TOPRIGHT', 0, 0)
	else
		GroupFrameMemberFrame21:SetPoint('TOPLEFT', GroupFrameMemberFrame5, 'BOTTOMLEFT', 0, CRAP_Config['GROUP_HEADERS'] and -30 or 0)
	end

	for index, frame in pairs({ group:GetChildren() }) do
		frame:Hide()
		frame:EnableMouse(true)
		frame.unit = 'raid' .. index

		CRAP:UpdateMember(frame, true)

		if mock then
			frame:Show()
			frame:EnableMouse(false)
		end
	end

	local head = _G['GroupFrameMemberFrame1GroupHeader']
	head:SetText('Group 1')

	local cols = mock and (CRAP_Config['GROUP_LAYOUT'] and 8 or 4) or 0
	local rows = mock and (CRAP_Config['GROUP_LAYOUT'] and 5 or 10) or 0

	if not mock then
		if GetNumRaidMembers() > 0 then
			for i = 1, 8 do
				if RAID_SUBGROUP_LISTS and RAID_SUBGROUP_LISTS[i] then
					for frameNumber, raidNumber in pairs(RAID_SUBGROUP_LISTS[i]) do
						local index = (i - 1) * 5 + frameNumber
						local frame = _G['GroupFrameMemberFrame' .. index]
						frame:Show()
						frame.unit = 'raid' .. raidNumber

						CRAP:UpdateMember(frame)

						cols = CRAP_Config['GROUP_LAYOUT'] and i or max(cols, mod((i - 1), 4) + 1)
						if CRAP_Config['GROUP_LAYOUT'] then
							rows = max(rows, frameNumber)
						else
							if index <= 20 then
								rows = max(rows, mod(index, 5) == 0 and 5 or mod(index, 5))
							else
								rows = max(rows, mod(index, 5) == 0 and 10 or mod(index, 5) + 5)
							end
						end
					end
				end
			end
		elseif GetNumPartyMembers() > 0 then
			head:SetText('Party')

			local members = GetNumPartyMembers()
			cols = 1
			rows = members + 1

			for i = 0, members do
				local frame = _G['GroupFrameMemberFrame' .. i + 1]
				frame:Show()
				frame:SetID(i)

				if i == 0 then
					frame.unit = 'player'
				else
					frame.unit = 'party' .. i
				end

				CRAP:UpdateMember(frame)
			end
		else
			group:Hide()

			return
		end
	end

	group:SetWidth(cols * CRAP_Config['UNIT_SIZE']['W'] + 10)
	group:SetHeight(rows * CRAP_Config['UNIT_SIZE']['H'] + ((CRAP_Config['GROUP_HEADERS'] and rows > 5) and 40 or 10))
end

function CRAP:UpdateMember(frame, mock)
   if frame and (mock or frame.unit) then
      local width = CRAP_Config['UNIT_SIZE']['W']
      local height = CRAP_Config['UNIT_SIZE']['H']
      frame:SetWidth(width)
      frame:SetHeight(height)

      local size = math.sqrt(width + height) + 4
      for i = 1, 4 do
         local aura = _G[frame:GetName() .. 'AuraButton' .. i]
         aura:SetWidth(size)
         aura:SetHeight(size)
      end

      local name = mock and classes[math.random(1, 9)] or UnitName(frame.unit)
      local nametext = _G[frame:GetName() .. 'NameText']
      nametext:SetText(CRAP_Config['UPPERCASE_NAMES'] and strupper(name) or name)
      nametext:SetWidth(width - 18)

      local _, ec = UnitClass(frame.unit)
      local class = mock and strupper(name) or ec
      local color = CRAP_Config['CLASS_COLORS'] and RAID_CLASS_COLORS[class] or { r = 0.0, g = 1.0, b = 0.0 }
      local bar = _G[frame:GetName() .. 'HealthBar']
      bar:SetStatusBarColor(color.r, color.g, color.b)

      local power = mock and math.random(0, 3) or UnitPowerType(frame.unit)
      color = power == 0 and { r = 0.0, g = 0.4, b = 1.0 } or ManaBarColor[power]
      if not CRAP_Config['MANA_ONLY'] or (CRAP_Config['MANA_ONLY'] and power == 0) then
         frame:RegisterEvent('UNIT_ENERGY')
         frame:RegisterEvent('UNIT_MANA')
         frame:RegisterEvent('UNIT_RAGE')

         bar:SetPoint('TOPLEFT', frame)
         bar:SetPoint('BOTTOMRIGHT', frame, 0, 6)
      else
         frame:UnregisterEvent('UNIT_ENERGY')
         frame:UnregisterEvent('UNIT_MANA')
         frame:UnregisterEvent('UNIT_RAGE')

         bar:SetPoint('TOPLEFT', frame)
         bar:SetPoint('BOTTOMRIGHT', frame)
      end

      bar = _G[frame:GetName() .. 'PowerBar']
      bar:SetStatusBarColor(color.r, color.g, color.b)
      bar:SetBackdropColor(color.r - 0.6, color.g - 0.6, color.b - 0.6, 0.8)

      local header = _G[frame:GetName() .. 'GroupHeader']
      if header then
         if CRAP_Config['GROUP_HEADERS'] then
            header:Show()
         else
            header:Hide()
         end
      end

      CRAP:UpdateMemberAuras(frame)
      if not mock then
         CRAP:UpdateMemberHealth(frame)
         CRAP:UpdateMemberPower(frame)
      end
   end
end

function CRAP:UpdateMemberAuras(frame)
   local indicator = _G[frame:GetName() .. 'DebuffIndicator']
   indicator:Hide()
   
   for i = 1, 4 do
      local button = _G[frame:GetName() .. 'AuraButton' .. i]
      button:Hide()
      button:SetID(0)
   end

   for i = 1, 40 do
      local _, _, type = UnitDebuff(frame.unit, i, true)
      if type then
         indicator:SetTexture('Interface\\AddOns\\CRAP\\assets\\RaidFrame-Debuff' .. type)
         indicator:Show()

         break
      end
   end

   for i = 1, 16 do
      local buff = UnitBuff(frame.unit, i, true)
      if buff then
         for j = 1, 16 do
            if buff == UnitBuff(frame.unit, j) then
               for k = 1, 4 do
                  local button = _G[frame:GetName() .. 'AuraButton' .. k]
                  if button:GetID() == 0 then
                     button:SetID(j)
                     button:Show()

                     _G[button:GetName() .. 'Texture']:SetTexture(buff)

                     break
                  end
               end
            end
         end
      end
   end
end

function CRAP:UpdateMemberHealth(frame)
   local member = frame.unit
   local healthbar = _G[frame:GetName() .. 'HealthBar']
   local status = _G[frame:GetName() .. 'StatusText']
   
   healthbar:SetMinMaxValues(0, UnitHealthMax(member))
   healthbar:SetValue(UnitHealth(member))

   CRAP:UpdateMemberIncomingHeal(frame)

   status:SetText(not UnitIsConnected(member) and 'Offline' or UnitIsDeadOrGhost(member) and 'Dead')
end

function CRAP:UpdateMemberIncomingHeal(frame)
   local unit = frame.unit
	local bar = _G[frame:GetName() .. 'HealthBarHealBar']
	local healed = libpredict:UnitGetIncomingHeals(unit)
	if healed > 0 then
		local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)
		if health < maxHealth then
			local healthWidth = frame:GetWidth() * (health / maxHealth)
			local incWidth = frame:GetWidth() * (healed / maxHealth)
			if healthWidth + incWidth > (frame:GetWidth()) then
				incWidth = frame:GetWidth() - healthWidth
			end

			bar:Show()
			bar:SetWidth(incWidth)
			bar:ClearAllPoints()
			bar:SetPoint('TOPLEFT', frame, 'TOPLEFT', healthWidth, 0)
			bar:SetPoint('BOTTOMLEFT', frame, 'BOTTOMLEFT', healthWidth, (CRAP_Config['MANA_ONLY'] and UnitPowerType(unit) ~= 0) and 0 or 6)
		end
	else
		bar:Hide()
	end
end

function CRAP:UpdateMemberPower(frame)
   local member = frame.unit
   local power = _G[frame:GetName() .. 'PowerBar']
   power:SetMinMaxValues(0, UnitManaMax(member))
	power:SetValue(UnitMana(member))
end