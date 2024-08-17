
SLASH_RELOAD1 = '/rl'
function SlashCmdList.RELOAD(msg, editbox)
  ReloadUI()
end

SLASH_SHAGUPLATES1 = '/tDFplates'
SLASH_SHAGUPLATES2 = '/tdfplates'
SLASH_SHAGUPLATES3 = '/tdfp'
function SlashCmdList.SHAGUPLATES(msg, editbox)
  if ShaguPlates.gui:IsShown() then
    ShaguPlates.gui:Hide()
  else
    ShaguPlates.gui:Show()
  end
end

SLASH_GM1, SLASH_GM2 = '/gm', '/support'
function SlashCmdList.GM(msg, editbox)
  ToggleHelpFrame(1)
end

ShaguPlates = CreateFrame("Frame", nil, UIParent)
ShaguPlates:RegisterEvent("ADDON_LOADED")

-- setup bootvar
ShaguPlates.bootup = true

-- initialize saved variables
ShaguPlates_playerDB = {}
ShaguPlates_config = {}
ShaguPlates_init = {}
ShaguPlates_profiles = {}
ShaguPlates_addon_profiles = {}
ShaguPlates_cache = {}

-- localization
ShaguPlates_locale = {}
ShaguPlates_translation = {}

-- initialize default variables
ShaguPlates.cache = {}
ShaguPlates.module = {}
ShaguPlates.modules = {}
ShaguPlates.skin = {}
ShaguPlates.skins = {}
ShaguPlates.environment = {}
ShaguPlates.movables = {}
ShaguPlates.version = {}
ShaguPlates.hooks = {}
ShaguPlates.env = {}

-- detect current addon path
local tocs = { "", "-master", "-tbc", "-wotlk" }
for _, name in pairs(tocs) do
  local current = string.format("tDF%s", name)
  local _, title = GetAddOnInfo(current)
  if title then
    ShaguPlates.name = current
    ShaguPlates.path = "Interface\\AddOns\\" .. current
    break
  end
end

--[[
-- handle/convert media dir paths
ShaguPlates.media = setmetatable({}, { __index = function(tab,key)
  local value = tostring(key)
  if strfind(value, "img:") then
    value = string.gsub(value, "img:", ShaguPlates.path .. "\\img\\")
  elseif strfind(value, "font:") then
    value = string.gsub(value, "font:", ShaguPlates.path .. "\\fonts\\")
  else
    value = string.gsub(value, "Interface\\AddOns\\tDF\\", ShaguPlates.path .. "\\")
  end
  rawset(tab,key,value)
  return value
end})
]]
-- handle/convert media dir paths
ShaguPlates.media = setmetatable({}, { __index = function(tab,key)
  local value = tostring(key)
  if strfind(value, "img:") then
    value = string.gsub(value, "img:", "Interface\\AddOns\\tDF\\img\\")
  elseif strfind(value, "font:") then
    value = string.gsub(value, "font:", "Interface\\AddOns\\tDF\\fonts\\")
  else
    --value = string.gsub(value, "Interface\\AddOns\\tDF\\", "Interface\\AddOns\\tDF\\")
  end
  rawset(tab,key,value)
  return value
end})


--print(ShaguPlates.path)
--print(ShaguPlates.media["img:glow2"])

-- cache client version
local _, _, _, client = GetBuildInfo()
client = client or 11200

-- detect client expansion
if client >= 20000 and client <= 20400 then
  ShaguPlates.expansion = "tbc"
  ShaguPlates.client = client
elseif client >= 30000 and client <= 30300 then
  ShaguPlates.expansion = "wotlk"
  ShaguPlates.client = client
else
  ShaguPlates.expansion = "vanilla"
  ShaguPlates.client = client
end

-- setup ShaguPlates namespace
setmetatable(ShaguPlates.env, {__index = getfenv(0)})

function ShaguPlates:UpdateColors()
  if ShaguPlates.expansion == "vanilla" then
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
  end
end

function ShaguPlates:UpdateFonts()
  -- abort when config is not ready yet
  if not ShaguPlates_config or not ShaguPlates_config.global then return end

  -- load font configuration
  local default, tooltip, unit, unit_name, combat
  if ShaguPlates_config.global.force_region == "1" and GetLocale() == "zhCN" and ShaguPlates.expansion == "vanilla" then
    -- force locale compatible fonts (zhCN 1.12)
    default = "Fonts\\FZXHLJW.TTF"
    tooltip = "Fonts\\FZXHLJW.TTF"
    combat = "Fonts\\FZXHLJW.TTF"
    unit = "Fonts\\FZXHLJW.TTF"
    unit_name = "Fonts\\FZXHLJW.TTF"
  elseif ShaguPlates_config.global.force_region == "1" and GetLocale() == "zhCN" and ShaguPlates.expansion == "tbc" then
    -- force locale compatible fonts (zhCN 2.4.3)
    default = "Fonts\\ZYHei.ttf"
    tooltip = "Fonts\\ZYHei.ttf"
    combat = "Fonts\\ZYKai_C.ttf"
    unit = "Fonts\\ZYKai_T.ttf"
    unit_name = "Fonts\\ZYHei.ttf"
  elseif ShaguPlates_config.global.force_region == "1" and GetLocale() == "zhTW" and ShaguPlates.expansion == "vanilla" then
    -- force locale compatible fonts (zhTW 1.12)
    default = "Fonts\\FZXHLJW.ttf"
    tooltip = "Fonts\\FZXHLJW.ttf"
    combat = "Fonts\\FZXHLJW.ttf"
    unit = "Fonts\\FZXHLJW.ttf"
    unit_name = "Fonts\\FZXHLJW.ttf"
  elseif ShaguPlates_config.global.force_region == "1" and GetLocale() == "zhTW" and ShaguPlates.expansion == "tbc" then
    -- force locale compatible fonts (zhTW 2.4.3)
    default = "Fonts\\bHEI01B.ttf"
    tooltip = "Fonts\\bHEI01B.ttf"
    combat = "Fonts\\bHEI01B.ttf"
    unit = "Fonts\\bHEI01B.ttf"
    unit_name = "Fonts\\bHEI01B.ttf"
  elseif ShaguPlates_config.global.force_region == "1" and GetLocale() == "koKR" then
    -- force locale compatible fonts (koKR)
    default = "Fonts\\2002.TTF"
    tooltip = "Fonts\\2002.TTF"
    combat = "Fonts\\2002.TTF"
    unit = "Fonts\\2002.TTF"
    unit_name = "Fonts\\2002.TTF"
  else
    -- use default entries
    default = ShaguPlates.media[ShaguPlates_config.global.font_default]
    tooltip = ShaguPlates.media[ShaguPlates_config.tooltip.font_tooltip]
    combat = ShaguPlates.media[ShaguPlates_config.global.font_combat]
    unit = ShaguPlates.media[ShaguPlates_config.global.font_unit]
    unit_name = ShaguPlates.media[ShaguPlates_config.global.font_unit_name]
  end

  -- write setting shortcuts
  ShaguPlates.font_default = default
  ShaguPlates.font_combat = combat
  ShaguPlates.font_unit = unit
  ShaguPlates.font_unit_name = unit_name

  -- skip setting fonts, keep blizzard defaults
  if ShaguPlates_config.global.font_blizzard == "1" then
    return
  end

  -- set game constants

  -- set dropdown font to default size

  -- change default game font objects

  if TextStatusBarTextSmall then -- does not exist in koKR
  end
end

local translations
function ShaguPlates:GetEnvironment()
  -- load api into environment
  for m, func in pairs(ShaguPlates.api or {}) do
    ShaguPlates.env[m] = func
  end

  if ShaguPlates_config and ShaguPlates_config.global and ShaguPlates_config.global.language and not translations then
    local lang = ShaguPlates_config and ShaguPlates_config.global and ShaguPlates_config.global.language and ShaguPlates_translation[ShaguPlates_config.global.language] and ShaguPlates_config.global.language or GetLocale()
    ShaguPlates.env.T = setmetatable(ShaguPlates_translation[lang] or {}, { __index = function(tab,key)
      local value = tostring(key)
      rawset(tab,key,value)
      return value
    end})
    translations = true
  end

  ShaguPlates.env._G = getfenv(0)
  ShaguPlates.env.C = ShaguPlates_config
  ShaguPlates.env.L = (ShaguPlates_locale[GetLocale()] or ShaguPlates_locale["enUS"])

  return ShaguPlates.env
end

function ShaguPlates:RegisterModule(name, a2, a3)
  if ShaguPlates.module[name] then return end
  local hasv = type(a2) == "string"
  local func, version = hasv and a3 or a2, hasv and a2 or "vanilla:tbc:wotlk"

  -- check for client compatibility
  if not strfind(version, ShaguPlates.expansion) then return end

  ShaguPlates.module[name] = func
  table.insert(ShaguPlates.modules, name)
  if not ShaguPlates.bootup then
    ShaguPlates:LoadModule(name)
  end
end

function ShaguPlates:RegisterSkin(name, a2, a3)
  if ShaguPlates.skin[name] then return end
  local hasv = type(a2) == "string"
  local func, version = hasv and a3 or a2, hasv and a2 or "vanilla:tbc:wotlk"

  -- check for client compatibility
  if not strfind(version, ShaguPlates.expansion) then return end

  ShaguPlates.skin[name] = func
  table.insert(ShaguPlates.skins, name)
  if not ShaguPlates.bootup then
    ShaguPlates:LoadSkin(name)
  end
end

function ShaguPlates:LoadModule(m)
  setfenv(ShaguPlates.module[m], ShaguPlates:GetEnvironment())
  ShaguPlates.module[m]()
end

function ShaguPlates:LoadSkin(s)
  setfenv(ShaguPlates.skin[s], ShaguPlates:GetEnvironment())
  ShaguPlates.skin[s]()
end

ShaguPlates:SetScript("OnEvent", function()
  -- enforce color updates on each event
  ShaguPlates:UpdateColors()

  -- make sure to initialize and set our fonts
  -- each time an addon got loaded but only
  -- when the config is already accessible
  if not ShaguPlates.bootup then
    ShaguPlates:UpdateFonts()
  end

  if arg1 == ShaguPlates.name then
    -- read ShaguPlates version from .toc file
    local major, minor, fix = ShaguPlates.api.strsplit(".", tostring(GetAddOnMetadata(ShaguPlates.name, "Version")))
    ShaguPlates.version.major = tonumber(major) or 1
    ShaguPlates.version.minor = tonumber(minor) or 2
    ShaguPlates.version.fix   = tonumber(fix)   or 0
    ShaguPlates.version.string = ShaguPlates.version.major .. "." .. ShaguPlates.version.minor .. "." .. ShaguPlates.version.fix

    -- use "Modern" as default profile on a fresh install
    if ShaguPlates.api.isempty(ShaguPlates_init) and ShaguPlates.api.isempty(ShaguPlates_config) then
      ShaguPlates_config = ShaguPlates.api.CopyTable(ShaguPlates_profiles["Modern"]) or {}
    end

    ShaguPlates:LoadConfig()
    ShaguPlates:MigrateConfig()
    ShaguPlates:UpdateFonts()

    -- load modules
    for _, m in pairs(this.modules) do
      if not ( ShaguPlates_config["disabled"] and ShaguPlates_config["disabled"][m]  == "1" ) then
        ShaguPlates:LoadModule(m)
      end
    end

    -- load skins
    for _, s in pairs(this.skins) do
      if not ( ShaguPlates_config["disabled"] and ShaguPlates_config["disabled"]["skin_" .. s]  == "1" ) then
        ShaguPlates:LoadSkin(s)
      end
    end

    ShaguPlates.bootup = nil
  end
end)

ShaguPlates.backdrop = {
  bgFile = "Interface\\BUTTONS\\WHITE8X8", tile = false, tileSize = 0,
  edgeFile = "Interface\\BUTTONS\\WHITE8X8", edgeSize = 1,
  insets = {left = -1, right = -1, top = -1, bottom = -1},
}
ShaguPlates.backdrop_no_top = ShaguPlates.backdrop

ShaguPlates.backdrop_thin = {
  bgFile = "Interface\\BUTTONS\\WHITE8X8", tile = false, tileSize = 0,
  edgeFile = "Interface\\BUTTONS\\WHITE8X8", edgeSize = 1,
  insets = {left = 0, right = 0, top = 0, bottom = 0},
}

ShaguPlates.backdrop_hover = {
  edgeFile = "Interface\\BUTTONS\\WHITE8X8", edgeSize = 24,
  insets = {left = -1, right = -1, top = -1, bottom = -1},
}

ShaguPlates.backdrop_shadow = {
  edgeFile = ShaguPlates.media["img:glow2"], edgeSize = 8,
  insets = {left = 0, right = 0, top = 0, bottom = 0},
}

ShaguPlates.backdrop_blizz_bg = {
  bgFile =  "Interface\\BUTTONS\\WHITE8X8", tile = true, tileSize = 8,
  insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

ShaguPlates.backdrop_blizz_border = {
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12,
  insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

ShaguPlates.backdrop_blizz_full = {
  bgFile =  "Interface\\BUTTONS\\WHITE8X8", tile = true, tileSize = 8,
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12,
  insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

local message = function(msg)
  DEFAULT_CHAT_FRAME:AddMessage("|cffcccc33INFO: |cffffff55" .. ( msg or "nil" ))
end

error = function(msg)
  if PF_DEBUG_MODE then message(debugstack()) end
  if string.find(msg, "AddOns\\ShaguPlates") then
    DEFAULT_CHAT_FRAME:AddMessage("|cffcc3333ERROR: |cffff5555".. (msg or "nil" ))
  elseif not ShaguPlates_config or (ShaguPlates_config.global and ShaguPlates_config.global.errors == "1") then
    DEFAULT_CHAT_FRAME:AddMessage("|cffcc3333ERROR: |cffff5555".. (msg or "nil" ))
  end
end

function ShaguPlates.SetupCVars()
  ClearTutorials()
  TutorialFrame_HideAllAlerts()

  ConsoleExec("CameraDistanceMaxFactor 5")

  SetCVar("autoSelfCast", "1")
  SetCVar("profanityFilter", "0")

  MultiActionBar_ShowAllGrids()
  ALWAYS_SHOW_MULTIBARS = "1"

  SHOW_BUFF_DURATIONS = "1"
  QUEST_FADING_DISABLE = "1"
  NAMEPLATES_ON = "1"

  SHOW_COMBAT_TEXT = "1"
  COMBAT_TEXT_SHOW_LOW_HEALTH_MANA = "1"
  COMBAT_TEXT_SHOW_AURAS = "1"
  COMBAT_TEXT_SHOW_AURA_FADE = "1"
  COMBAT_TEXT_SHOW_COMBAT_STATE = "1"
  COMBAT_TEXT_SHOW_DODGE_PARRY_MISS = "1"
  COMBAT_TEXT_SHOW_RESISTANCES = "1"
  COMBAT_TEXT_SHOW_REPUTATION = "1"
  COMBAT_TEXT_SHOW_REACTIVES = "1"
  COMBAT_TEXT_SHOW_FRIENDLY_NAMES = "1"
  COMBAT_TEXT_SHOW_COMBO_POINTS = "1"
  COMBAT_TEXT_SHOW_MANA = "1"
  COMBAT_TEXT_FLOAT_MODE = "1"
  COMBAT_TEXT_SHOW_HONOR_GAINED = "1"
  UIParentLoadAddOn("Blizzard_CombatText")
end