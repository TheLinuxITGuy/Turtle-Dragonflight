--[[ libpredict ]]--
-- A pfUI library that detects, receives and sends heal and resurrection predictions.
-- Healing predictions are done by caching the last known "normal" heal value of the
-- spell when last being used. Those chaches are cleared when new talents are detected.
-- The API provides function calls similar to later WoW expansions such as:
--   UnitGetIncomingHeals(unit)
--   UnitHasIncomingResurrection(unit)

local _G = getfenv(0)

local senttarget
local heals, ress, events, hooks = {}, {}, {}, {}

local resurrections = {
  ["Resurrection"] = true,
  ["Rebirth"] = true,
  ["Redemption"] = true,
  ["Ancestral Spirit"] = true,
}

local gfind = string.gmatch or string.gfind

local sanitize_cache = {}
local function SanitizePattern(pattern)
  if not sanitize_cache[pattern] then
    local ret = pattern
    -- escape magic characters
    ret = gsub(ret, "([%+%-%*%(%)%?%[%]%^])", "%%%1")
    -- remove capture indexes
    ret = gsub(ret, "%d%$","")
    -- catch all characters
    ret = gsub(ret, "(%%%a)","%(%1+%)")
    -- convert all %s to .+
    ret = gsub(ret, "%%s%+",".+")
    -- set priority to numbers over strings
    ret = gsub(ret, "%(.%+%)%(%%d%+%)","%(.-%)%(%%d%+%)")
    -- cache it
    sanitize_cache[pattern] = ret
  end

  return sanitize_cache[pattern]
end

local capture_cache = {}
local function GetCaptures(pat)
  local r = capture_cache
  if not r[pat] then
    for a, b, c, d, e in gfind(gsub(pat, "%((.+)%)", "%1"), gsub(pat, "%d%$", "%%(.-)$")) do
      r[pat] = { a, b, c, d, e}
    end
  end

  if not r[pat] then return nil, nil, nil, nil end
  return r[pat][1], r[pat][2], r[pat][3], r[pat][4], r[pat][5]
end

local a, b, c, d, e
local _, va, vb, vc, vd, ve
local ra, rb, rc, rd, re
local function cmatch(str, pat)
  -- read capture indexes
  a, b, c, d, e = GetCaptures(pat)
  _, _, va, vb, vc, vd, ve = string.find(str, SanitizePattern(pat))

  -- put entries into the proper return values
  ra = e == 1 and ve or d == 1 and vd or c == 1 and vc or b == 1 and vb or va
  rb = e == 2 and ve or d == 2 and vd or c == 2 and vc or a == 2 and va or vb
  rc = e == 3 and ve or d == 3 and vd or a == 3 and va or b == 3 and vb or vc
  rd = e == 4 and ve or a == 4 and va or c == 4 and vc or b == 4 and vb or vd
  re = a == 5 and va or d == 5 and vd or c == 5 and vc or b == 5 and vb or ve

  return ra, rb, rc, rd, re
end

local function strsplit(delimiter, subject)
  if not subject then return nil end
  local delimiter, fields = delimiter or ":", {}
  local pattern = string.format("([^%s]+)", delimiter)
  string.gsub(subject, pattern, function(c) fields[table.getn(fields)+1] = c end)
  return unpack(fields)
end

local function hooksecurefunc(name, func, append)
  if not _G[name] then return end

  hooks[tostring(func)] = {}
  hooks[tostring(func)]["old"] = _G[name]
  hooks[tostring(func)]["new"] = func

  if append then
    hooks[tostring(func)]["function"] = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
      hooks[tostring(func)]["old"](a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
      hooks[tostring(func)]["new"](a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
    end
  else
    hooks[tostring(func)]["function"] = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
      hooks[tostring(func)]["new"](a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
      hooks[tostring(func)]["old"](a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
    end
  end

  _G[name] = hooks[tostring(func)]["function"]
end

libpredict = CreateFrame("Frame")
libpredict:RegisterEvent("UNIT_HEALTH")
libpredict:RegisterEvent("PLAYER_TARGET_CHANGED")
libpredict:SetScript("OnEvent", function()
  if event == "UNIT_HEALTH" then
    local name = UnitName(arg1)
    if ress[name] and not UnitIsDeadOrGhost(arg1) then
      ress[UnitName(arg1)] = nil
    end
  end
end)

libpredict:SetScript("OnUpdate", function()
  -- update on timeout events
  for timestamp, targets in pairs(events) do
    if GetTime() >= timestamp then
      events[timestamp] = nil
    end
  end
end)

function libpredict:AddEvent(time, target)
  events[time] = events[time] or {}
  table.insert(events[time], target)
end

function libpredict:Heal(sender, target, amount, duration)
  if not sender or not target or not amount or not duration then
    return
  end

  local timeout = duration/1000 + GetTime()
  heals[target] = heals[target] or {}
  heals[target][sender] = { amount, timeout }
  libpredict:AddEvent(timeout, target)
end

function libpredict:HealStop(sender)
  for ttarget, t in pairs(heals) do
    for tsender in pairs(heals[ttarget]) do
      if sender == tsender then
        heals[ttarget][tsender] = nil
      end
    end
  end
end

function libpredict:HealDelay(sender, delay)
  local delay = delay/1000
  for target, t in pairs(heals) do
    for tsender, amount in pairs(heals[target]) do
      if sender == tsender then
        amount[2] = amount[2] + delay
        libpredict:AddEvent(amount[2], target)
      end
    end
  end
end

function libpredict:Ress(sender, target)
  ress[target] = ress[target] or {}
  ress[target][sender] = true
end

function libpredict:RessStop(sender)
  for ttarget, t in pairs(ress) do
    for tsender in pairs(ress[ttarget]) do
      if sender == tsender then
        ress[ttarget][tsender] = nil
      end
    end
  end
end

function libpredict:UnitGetIncomingHeals(unit)
  if not unit or not UnitName(unit) then return 0 end
  if UnitIsDeadOrGhost(unit) then return 0 end
  local name = UnitName(unit)

  local sumheal = 0
  if not heals[name] then
    return sumheal
  else
    for sender, amount in pairs(heals[name]) do
      if amount[2] <= GetTime() then
        heals[name][sender] = nil
      else
        sumheal = sumheal + amount[1]
      end
    end
  end
  return sumheal
end

function libpredict:UnitHasIncomingResurrection(unit)
  if not unit or not UnitName(unit) then return nil end
  local name = UnitName(unit)

  if not ress[name] then
    return nil
  else
    for sender, val in pairs(ress[name]) do
      if val == true then
        return val
      end
    end
  end
  return nil
end

local spell_queue = { "DUMMY", "DUMMYRank 9", "TARGET" }
local realm = GetRealmName()
local player = UnitName("player")
local cache, gear_string = {}, ""
local resetcache = CreateFrame("Frame")
resetcache:RegisterEvent("PLAYER_ENTERING_WORLD")
resetcache:RegisterEvent("LEARNED_SPELL_IN_TAB")
resetcache:RegisterEvent("CHARACTER_POINTS_CHANGED")
resetcache:RegisterEvent("UNIT_INVENTORY_CHANGED")
resetcache:SetScript("OnEvent", function()
  if event == "PLAYER_ENTERING_WORLD" then
    -- load and initialize previous caches of spell amounts
    CRAP_Cache = CRAP_Cache or {}
    CRAP_Cache[realm] = CRAP_Cache[realm] or {}
    CRAP_Cache[realm][player] = CRAP_Cache[realm][player] or {}
    CRAP_Cache[realm][player]["heals"] = CRAP_Cache[realm][player]["heals"] or {}
    cache = CRAP_Cache[realm][player]["heals"]
    return
  end

  if event == "UNIT_INVENTORY_CHANGED" then
    -- skip non-player events
    if arg1 and arg1 ~= "player" then return end

    local gear = ""
    for id = 1, 18 do
      gear = gear .. (GetInventoryItemLink("player",id) or "")
    end

    -- abort when inventory didn't change
    if gear == gear_string then return end
    gear_string = gear
  end

  -- flag all cached heals for renewal
  for k in pairs(cache) do
    if type(cache[k]) == "number" or type(cache[k]) == "string" then
      -- migrate old data
      local oldval = cache[k]
      cache[k] = { [1] = oldval }
    end

    -- flag for reset
    cache[k][2] = true
  end
end)

local function UpdateCache(spell, heal, crit)
  local heal = heal and tonumber(heal)
  if not spell or not heal then return end

  if not cache[spell] or cache[spell][2] then
    -- skills or equipment changed, save whatever is detected
    cache[spell] = cache[spell] or {}
    cache[spell][1] = crit and heal*2/3 or heal
    cache[spell][2] = crit
  elseif not crit and cache[spell][1] < heal then
    -- safe the best heal we can get
    cache[spell][1] = heal
    cache[spell][2] = nil
  end
end

-- Gather Data by User Actions
hooksecurefunc("CastSpell", function(id, bookType)
  if not libpredict.sender.enabled then return end
  local effect, rank = libspell.GetSpellInfo(id, bookType)
  if not effect then return end
  spell_queue[1] = effect
  spell_queue[2] = effect.. ( rank or "" )
  spell_queue[3] = UnitName("target") and UnitCanAssist("player", "target") and UnitName("target") or UnitName("player")
end, true)

hooksecurefunc("CastSpellByName", function(effect, target)
  if not libpredict.sender.enabled then return end
  local effect, rank = libspell.GetSpellInfo(effect)
  if not effect then return end

  local default = UnitName("target") and UnitCanAssist("player", "target") and UnitName("target") or UnitName("player")

  spell_queue[1] = effect
  spell_queue[2] = effect.. ( rank or "" )
  spell_queue[3] = default
end, true)

local scanner = libtipscan:GetScanner("prediction")
hooksecurefunc("UseAction", function(slot, target, selfcast)
  if not libpredict.sender.enabled then return end
  if GetActionText(slot) or not IsCurrentAction(slot) then return end
  scanner:SetAction(slot)
  local effect, rank = scanner:Line(1)
  if not effect then return end
  spell_queue[1] = effect
  spell_queue[2] = effect.. ( rank or "" )
  spell_queue[3] = selfcast and UnitName("player") or UnitName("target") and UnitCanAssist("player", "target") and UnitName("target") or UnitName("player")
end, true)

libpredict.sender = CreateFrame("Frame", "pfPredictionSender", UIParent)
libpredict.sender.enabled = true

-- vanilla
libpredict.sender:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
libpredict.sender:RegisterEvent("SPELLCAST_START")
libpredict.sender:RegisterEvent("SPELLCAST_STOP")
libpredict.sender:RegisterEvent("SPELLCAST_FAILED")
libpredict.sender:RegisterEvent("SPELLCAST_INTERRUPTED")
libpredict.sender:RegisterEvent("SPELLCAST_DELAYED")

-- force cache updates
libpredict.sender:RegisterEvent("UNIT_INVENTORY_CHANGED")
libpredict.sender:RegisterEvent("SKILL_LINES_CHANGED")

libpredict.sender:SetScript("OnEvent", function()
  if event == "CHAT_MSG_SPELL_SELF_BUFF" then -- vanilla
    local spell, _, heal = cmatch(arg1, HEALEDSELFOTHER) -- "Your %s heals %s for %d."
    if spell and heal then
      if spell == spell_queue[1] then UpdateCache(spell_queue[2], heal) end
      return
    end

    local spell, heal = cmatch(arg1, HEALEDSELFSELF) -- "Your %s heals you for %d."
    if spell and heal then
      if spell == spell_queue[1] then UpdateCache(spell_queue[2], heal) end
      return
    end

    local spell, heal = cmatch(arg1, HEALEDCRITSELFOTHER) -- "Your %s critically heals %s for %d."
    if spell and heal then
      if spell == spell_queue[1] then UpdateCache(spell_queue[2], heal, true) end
      return
    end

    local spell, _, heal = cmatch(arg1, HEALEDCRITSELFSELF) -- "Your %s critically heals you for %d."
    if spell and heal then
      if spell == spell_queue[1] then UpdateCache(spell_queue[2], heal, true) end
      return
    end
  elseif event == "COMBAT_LOG_EVENT_UNFILTERED" and arg2 == "SPELL_HEAL" and arg4 == player then -- tbc
    local spell, heal, crit = arg10, arg12, arg13
    if spell and heal and crit then
      if spell == spell_queue[1] then UpdateCache(spell_queue[2], heal, true) end
    elseif spell and heal then
      if spell == spell_queue[1] then UpdateCache(spell_queue[2], heal) end
    end
  elseif event == "UNIT_SPELLCAST_SENT" and arg4 then -- fix tbc mouseover macros
      senttarget = arg4
  elseif strfind(event, "SPELLCAST_START", 1) then
    local spell, time = arg1, arg2

    if strfind(event, "UNIT_", 1) then -- tbc
      if arg1 ~= "player" then return end
      local spellname, _, _, _, starttime, endtime = UnitCastingInfo("player")
      spell, time = spellname, endtime - starttime
    end

    if spell_queue[1] == spell and cache[spell_queue[2]] then
      local sender = player
      local target = senttarget or spell_queue[3]
      local amount = cache[spell_queue[2]][1]
      local casttime = time

      if spell == "Prayer of Healing" then
        target = sender

        for i=1,4 do
          if CheckInteractDistance("party"..i, 4) then
            libpredict:Heal(player, UnitName("party"..i), amount, casttime)
            libpredict.sender.healing = true
          end
        end
      end

      libpredict:Heal(player, target, amount, casttime)
      libpredict.sender.healing = true

    elseif spell_queue[1] == spell and resurrections[spell] then
      local target = senttarget or spell_queue[3]
      libpredict:Ress(player, target)
      libpredict.sender.resurrecting = true
    end
  elseif strfind(event, "SPELLCAST_FAILED", 1) or strfind(event, "SPELLCAST_INTERRUPTED", 1) then
    if strfind(event, "UNIT_", 1) and arg1 ~= "player" then return end
    if libpredict.sender.healing then
      libpredict:HealStop(player)
      libpredict.sender.healing = nil
    elseif libpredict.sender.resurrecting then
      local target = senttarget or spell_queue[3]
      libpredict:RessStop(player)
      libpredict.sender.resurrecting = nil
    end
  elseif event == "SPELLCAST_DELAYED" then
    if libpredict.sender.healing then
      libpredict:HealDelay(player, arg1)
    end
  elseif strfind(event, "SPELLCAST_STOP", 1) then
    if strfind(event, "UNIT_", 1) and arg1 ~= "player" then return end
    libpredict:HealStop(player)
  end
end)