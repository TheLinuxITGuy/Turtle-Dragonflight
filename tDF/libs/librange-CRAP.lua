--[[ librange ]]--
-- A pfUI library that detects and caches distance to units.
--
--  librange:UnitInSpellRange(unit)
--    Returns `1` if the unit is within a 40y range
--

local _G = getfenv(0)

local _, class = UnitClass("player")
librange = CreateFrame("Frame", "pfRangecheck", UIParent)

-- table of 40y spells per class
local spells = {
  ["PALADIN"] = {
    "Interface\\Icons\\Spell_Holy_FlashHeal",
    "Interface\\Icons\\Spell_Holy_HolyBolt",
  },
  ["PRIEST"] = {
    "Interface\\Icons\\Spell_Holy_FlashHeal",
    "Interface\\Icons\\Spell_Holy_LesserHeal",
    "Interface\\Icons\\Spell_Holy_Heal",
    "Interface\\Icons\\Spell_Holy_GreaterHeal",
    "Interface\\Icons\\Spell_Holy_Renew",
  },
  ["DRUID"] = {
    "Interface\\Icons\\Spell_Nature_HealingTouch",
    "Interface\\Icons\\Spell_Nature_ResistNature",
    "Interface\\Icons\\Spell_Nature_Rejuvenation",
  },
  ["SHAMAN"] = {
    "Interface\\Icons\\Spell_Nature_MagicImmunity",
    "Interface\\Icons\\Spell_Nature_HealingWaveLesser",
    "Interface\\Icons\\Spell_Nature_HealingWaveGreater",
  },
}

-- units that should be scanned
local units = {}
table.insert(units, "pet")
for i=1,4 do table.insert(units, "party" .. i) end
for i=1,4 do table.insert(units, "partypet" .. i) end
for i=1,40 do table.insert(units, "raid" .. i) end
for i=1,40 do table.insert(units, "raidpet" .. i) end
local numunits = table.getn(units)

-- cache for unit relations
local unitcache = {}

-- actual unit-range table
local unitdata = { }

-- setup sound function switches
local SoundOn = PlaySound
local SoundOff = function() return end

librange.id = 1

-- Shooting with wands does not make the PlayerFrame inCombat attribute change.
-- This frame makes wand attacks accesible via wandCombat on the PlayerFrame.
local wand = CreateFrame("Frame", "pfWandShootDetect")
wand:RegisterEvent("START_AUTOREPEAT_SPELL")
wand:RegisterEvent("STOP_AUTOREPEAT_SPELL")
wand:SetScript("OnEvent", function()
  PlayerFrame.wandCombat = event == "START_AUTOREPEAT_SPELL" and true or nil
end)

librange:Hide()
librange:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
librange:RegisterEvent("PLAYER_ENTERING_WORLD")
librange:RegisterEvent("PLAYER_ENTER_COMBAT")
librange:RegisterEvent("PLAYER_LEAVE_COMBAT")
librange:SetScript("OnEvent", function()
  -- disable range checking activities
  if not spells[class] then
    this:Hide()
    return
  end

  this.interval = 1000/numunits

  if event == "ACTIONBAR_SLOT_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
    librange.slot = this:GetRangeSlot()
    this:Show()
  elseif event == "PLAYER_ENTER_COMBAT" then
    this.lastattack = GetTime()
    this:Hide()
  elseif event == "PLAYER_LEAVE_COMBAT" then
    if not this:ReAttack() then
      this:Show()
    end
  end
end)

local target_event = TargetFrame_OnEvent
local target_nop = function() return end

librange:SetScript("OnUpdate", function()
  if ( this.tick or 1) > GetTime() then
    return
  else
    this.tick = GetTime() + this.interval
  end

  -- skip invalid units
  while not this:NeedRangeScan(units[this.id]) and this.id <= numunits do
    this.id = this.id + 1
  end

  if this.id <= numunits and librange.slot then
    local unit = units[this.id]
    if not UnitIsUnit("target", unit) then
      -- suspend for various conditions
      if LootFrame and LootFrame:IsShown() then return nil end
      if InspectFrame and InspectFrame:IsShown() then return nil end
      if TradeFrame and TradeFrame:IsShown() then return nil end
      if PlayerFrame and PlayerFrame.inCombat then return nil end
      if PlayerFrame and PlayerFrame.wandCombat then return nil end

      _G.PlaySound = SoundOff
      pfScanActive = true

      -- save and disable target frame events
      target_event = TargetFrame_OnEvent
      _G.TargetFrame_OnEvent = target_nop

      TargetUnit(unit)
      unitdata[unit] = IsActionInRange(librange.slot)
      TargetLastTarget()

      -- restore target events
      _G.TargetFrame_OnEvent = target_event

      _G.PlaySound = SoundOn
      pfScanActive = false

      this:ReAttack()
    end

    this.id = this.id + 1
  else
    this.id = 1
  end
end)

function librange:ReAttack()
  -- we accidentally broke the autoattack... restoring the old state
  if this.lastattack and this.lastattack + this.interval > GetTime() and UnitCanAttack("player", "target") then
    AttackTarget()
    return true
  else
    return nil
  end
end

function librange:NeedRangeScan(unit)
  if not UnitExists(unit) then return nil end
  if not UnitIsVisible(unit) then return nil end
  if CheckInteractDistance(unit, 4) then return nil end
  return true
end

function librange:GetRealUnit(unit)
  if unitdata[unit] then return unit end

  if unitcache[unit] then
    if UnitIsUnit(unitcache[unit], unit) then
      return unitcache[unit]
    end
  end

  for id, realunit in pairs(units) do
    if UnitIsUnit(realunit, unit) then
      unitcache[unit] = realunit
      return realunit
    end
  end

  return unit
end

function librange:GetRangeSlot()
  local texture

  for i=1,120 do
    texture = GetActionTexture(i)
    if texture and not GetActionText(i) then
      for _, check in pairs(spells[class]) do
        if check == texture then
          return i
        end
      end
    end
  end

  return nil
end

function librange:UnitInSpellRange(unit)
  if not librange.slot then return nil end

  if UnitIsUnit("target", unit) then
    return IsActionInRange(librange.slot) == 1 and 1 or nil
  end

  local unit = librange:GetRealUnit(unit)

  if unitdata[unit] and unitdata[unit] == 1 then
    return 1
  elseif not unitdata[unit] then
    return 1
  else
    return nil
  end
end