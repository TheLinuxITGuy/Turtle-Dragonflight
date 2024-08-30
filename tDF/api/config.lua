-- load ShaguPlates environment
setfenv(1, ShaguPlates:GetEnvironment())

function ShaguPlates:UpdateConfig(group, subgroup, entry, value)
  -- create empty config if not existing
  if not ShaguPlates_config then
    _G.ShaguPlates_config = {}
  end

  -- check for missing config groups
  if not ShaguPlates_config[group] then
    ShaguPlates_config[group] = {}
  end

  -- update config
  if not subgroup and entry and value and not ShaguPlates_config[group][entry] then
    ShaguPlates_config[group][entry] = value
  end

  -- check for missing config subgroups
  if subgroup and not ShaguPlates_config[group][subgroup] then
    ShaguPlates_config[group][subgroup] = {}
  end

  -- update config in subgroup
  if subgroup and entry and value and not ShaguPlates_config[group][subgroup][entry] then
    ShaguPlates_config[group][subgroup][entry] = value
  end
end

function ShaguPlates:LoadConfig()
  --                MODULE        SUBGROUP       ENTRY               VALUE
  ShaguPlates:UpdateConfig("global",     nil,           "language",         GetLocale())
  ShaguPlates:UpdateConfig("global",     nil,           "profile",          "default")
  ShaguPlates:UpdateConfig("global",     nil,           "pixelperfect",     "0")
  ShaguPlates:UpdateConfig("global",     nil,           "offscreen",        "0")

  ShaguPlates:UpdateConfig("global",     nil,           "font_blizzard",    "0")
  ShaguPlates:UpdateConfig("global",     nil,           "font_default", "Fonts\\FRIZQT__.TTF")
  ShaguPlates:UpdateConfig("global",     nil,           "font_size",        "11")
  ShaguPlates:UpdateConfig("global",     nil,           "font_unit", "Interface\\AddOns\\tDF\\fonts\\Myriad-Pro.ttf")
  ShaguPlates:UpdateConfig("global",     nil,           "font_unit_size",   "11")
  ShaguPlates:UpdateConfig("global",     nil,           "font_unit_style",  "OUTLINE")
  ShaguPlates:UpdateConfig("global",     nil,           "font_unit_name",   "Interface\\AddOns\\tDF\\fonts\\Myriad-Pro.ttf")
  ShaguPlates:UpdateConfig("global",     nil,           "font_combat",      "Interface\\AddOns\\tDF\\fonts\\Continuum.ttf")

  ShaguPlates:UpdateConfig("global",     nil,           "force_region",     "1")
  ShaguPlates:UpdateConfig("global",     nil,           "errors",           "1")
  ShaguPlates:UpdateConfig("global",     nil,           "errors_limit",     "1")
  ShaguPlates:UpdateConfig("global",     nil,           "errors_hide",      "0")
  ShaguPlates:UpdateConfig("global",     nil,           "hidebuff",         "0")
  ShaguPlates:UpdateConfig("global",     nil,           "hidewbuff",        "0")
  ShaguPlates:UpdateConfig("global",     nil,           "twentyfour",       "1")
  ShaguPlates:UpdateConfig("global",     nil,           "servertime",       "0")
  ShaguPlates:UpdateConfig("global",     nil,           "autosell",         "0")
  ShaguPlates:UpdateConfig("global",     nil,           "autorepair",       "0")
  ShaguPlates:UpdateConfig("global",     nil,           "libhealth",        "1")
  ShaguPlates:UpdateConfig("global",     nil,           "libhealth_hit",    "4")
  ShaguPlates:UpdateConfig("global",     nil,           "libhealth_dmg",    ".05")

  ShaguPlates:UpdateConfig("gui",        nil,           "reloadmarker",     "0")
  ShaguPlates:UpdateConfig("gui",        nil,           "showdisabled",     "0")

  ShaguPlates:UpdateConfig("buffs",      nil,           "buffs",            "1")
  ShaguPlates:UpdateConfig("buffs",      nil,           "debuffs",          "1")
  ShaguPlates:UpdateConfig("buffs",      nil,           "weapons",          "1")
  ShaguPlates:UpdateConfig("buffs",      nil,           "separateweapons",  "0")
  ShaguPlates:UpdateConfig("buffs",      nil,           "size",             "24")
  ShaguPlates:UpdateConfig("buffs",      nil,           "spacing",          "5")
  ShaguPlates:UpdateConfig("buffs",      nil,           "wepbuffrowsize",   "2")
  ShaguPlates:UpdateConfig("buffs",      nil,           "buffrowsize",      "16")
  ShaguPlates:UpdateConfig("buffs",      nil,           "debuffrowsize",    "16")
  ShaguPlates:UpdateConfig("buffs",      nil,           "textinside",       "0")
  ShaguPlates:UpdateConfig("buffs",      nil,           "fontsize",         "-1")

  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "enable",           "0")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "use_unitfonts", "1")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "sort",             "asc")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "color",            ".5,.5,.5,1")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "bordercolor",      "0,0,0,0")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "textcolor",        "1,1,1,1")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "dtypebg",          "1")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "dtypeborder",      "0")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "dtypetext",        "0")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "colorstacks",      "0")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "width",            "-1")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "height",           "20")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "filter",           "blacklist")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "threshold",        "120")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "whitelist",        "")
  ShaguPlates:UpdateConfig("buffbar",    "pbuff",       "blacklist",        "")

  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "enable",           "0")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "use_unitfonts", "1")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "sort",             "asc")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "color",            "8,.4,.4,1")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "bordercolor",      "0,0,0,0")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "textcolor",        "1,1,1,1")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "dtypebg",          "0")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "dtypeborder",      "1")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "dtypetext",        "0")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "colorstacks",      "0")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "width",            "-1")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "height",           "20")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "filter",           "blacklist")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "threshold",        "120")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "whitelist",        "")
  ShaguPlates:UpdateConfig("buffbar",    "pdebuff",     "blacklist",        "")

  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "enable",           "0")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "use_unitfonts", "1")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "sort",             "asc")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "color",            ".8,.4,.4,1")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "bordercolor",      "0,0,0,0")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "textcolor",        "1,1,1,1")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "dtypebg",          "0")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "dtypeborder",      "1")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "dtypetext",        "0")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "colorstacks",      "0")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "width",            "-1")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "height",           "20")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "filter",           "blacklist")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "threshold",        "120")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "whitelist",        "")
  ShaguPlates:UpdateConfig("buffbar",    "tdebuff",     "blacklist",        "")

  ShaguPlates:UpdateConfig("appearance", "border",      "background",       "0,0,0,1")
  ShaguPlates:UpdateConfig("appearance", "border",      "color",            "0.2,0.2,0.2,1")
  ShaguPlates:UpdateConfig("appearance", "border",      "shadow",           "0")
  ShaguPlates:UpdateConfig("appearance", "border",      "shadow_intensity", ".35")
  ShaguPlates:UpdateConfig("appearance", "border",      "pixelperfect",     "1")
  ShaguPlates:UpdateConfig("appearance", "border",      "force_blizz", "1")
  ShaguPlates:UpdateConfig("appearance", "border",      "hidpi",            "1")
  ShaguPlates:UpdateConfig("appearance", "border",      "default",          "3")
  ShaguPlates:UpdateConfig("appearance", "border",      "nameplates",       "2")
  ShaguPlates:UpdateConfig("appearance", "border",      "actionbars",       "-1")
  ShaguPlates:UpdateConfig("appearance", "border",      "unitframes",       "-1")
  ShaguPlates:UpdateConfig("appearance", "border",      "panels",           "-1")
  ShaguPlates:UpdateConfig("appearance", "border",      "chat",             "-1")
  ShaguPlates:UpdateConfig("appearance", "border",      "bags",             "-1")
  ShaguPlates:UpdateConfig("appearance", "cd",          "lowcolor",         "1,.2,.2,1")
  ShaguPlates:UpdateConfig("appearance", "cd",          "normalcolor",      "1,1,1,1")
  ShaguPlates:UpdateConfig("appearance", "cd",          "minutecolor",      ".2,1,1,1")
  ShaguPlates:UpdateConfig("appearance", "cd",          "hourcolor",        ".2,.5,1,1")
  ShaguPlates:UpdateConfig("appearance", "cd",          "daycolor",         ".2,.2,1,1")
  ShaguPlates:UpdateConfig("appearance", "cd",          "threshold",        "2")
  ShaguPlates:UpdateConfig("appearance", "cd",          "font_size",        "12")
  ShaguPlates:UpdateConfig("appearance", "cd",          "font_size_blizz",  "12")
  ShaguPlates:UpdateConfig("appearance", "cd",          "font_size_foreign","12")
  ShaguPlates:UpdateConfig("appearance", "cd",          "debuffs",          "1")
  ShaguPlates:UpdateConfig("appearance", "cd",          "blizzard",         "0")
  ShaguPlates:UpdateConfig("appearance", "cd",          "foreign",          "0")
  ShaguPlates:UpdateConfig("appearance", "cd",          "milliseconds",     "1")
  ShaguPlates:UpdateConfig("appearance", "cd",          "hideanim",         "0")
  ShaguPlates:UpdateConfig("appearance", "cd",          "dynamicsize",      "1")
  ShaguPlates:UpdateConfig("appearance", "castbar",     "castbarcolor",     ".7,.7,.9,.8")
  ShaguPlates:UpdateConfig("appearance", "castbar",     "channelcolor",     ".9,.9,.7,.8")
  ShaguPlates:UpdateConfig("appearance", "castbar",     "texture",          "Interface\\AddOns\\tDF\\img\\bar")
  ShaguPlates:UpdateConfig("appearance", "infight",     "screen",           "0")
  ShaguPlates:UpdateConfig("appearance", "infight",     "aggro",            "0")
  ShaguPlates:UpdateConfig("appearance", "infight",     "health",           "1")
  ShaguPlates:UpdateConfig("appearance", "infight",     "intensity",           "16")
  ShaguPlates:UpdateConfig("appearance", "bags",        "unusable",         "1")
  ShaguPlates:UpdateConfig("appearance", "bags",        "unusable_color",   ".9,.2,.2,1")
  ShaguPlates:UpdateConfig("appearance", "bags",        "borderlimit",      "1")
  ShaguPlates:UpdateConfig("appearance", "bags",        "borderonlygear",   "0")
  ShaguPlates:UpdateConfig("appearance", "bags",        "movable",          "0")
  ShaguPlates:UpdateConfig("appearance", "bags",        "hidechat",         "0")
  ShaguPlates:UpdateConfig("appearance", "bags",        "icon_size",        "-1")
  ShaguPlates:UpdateConfig("appearance", "bags",        "bagrowlength",     "10")
  ShaguPlates:UpdateConfig("appearance", "bags",        "bankrowlength",    "10")
  ShaguPlates:UpdateConfig("appearance", "minimap",     "mouseoverzone",    "0")
  ShaguPlates:UpdateConfig("appearance", "minimap",     "coordsloc",        "bottomleft")
  ShaguPlates:UpdateConfig("appearance", "minimap",     "tracking_size",    "16")
  ShaguPlates:UpdateConfig("appearance", "minimap",     "tracking_pulse",   "1")
  ShaguPlates:UpdateConfig("appearance", "worldmap",    "tooltipsize",      "0")
  ShaguPlates:UpdateConfig("appearance", "worldmap",    "mapreveal",        "0")
  ShaguPlates:UpdateConfig("appearance", "worldmap",    "mapreveal_color",  ".4,.4,.4,1")
  ShaguPlates:UpdateConfig("appearance", "worldmap",    "mapexploration",   "0")
  ShaguPlates:UpdateConfig("appearance", "worldmap",    "groupcircles",     "3")
  ShaguPlates:UpdateConfig("appearance", "worldmap",    "colornames",       "1")

  ShaguPlates:UpdateConfig("loot",       nil,           "autoresize",       "1")
  ShaguPlates:UpdateConfig("loot",       nil,           "autopickup",       "1")
  ShaguPlates:UpdateConfig("loot",       nil,           "mousecursor",      "1")
  ShaguPlates:UpdateConfig("loot",       nil,           "advancedloot",     "1")
  ShaguPlates:UpdateConfig("loot",       nil,           "rollannouncequal", "3")
  ShaguPlates:UpdateConfig("loot",       nil,           "rollannounce",     "0")
  ShaguPlates:UpdateConfig("loot",       nil,           "raritytimer",      "1")

  ShaguPlates:UpdateConfig("unitframes", nil,           "disable",          "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "pastel",           "1")
  ShaguPlates:UpdateConfig("unitframes", nil,           "custom",           "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "customfullhp",     "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "customfade",       "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "customcolor",      ".2,.2,.2,1")
  ShaguPlates:UpdateConfig("unitframes", nil,           "custombg",         "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "custombgcolor",    ".5,.2,.2,1")
  ShaguPlates:UpdateConfig("unitframes", nil,           "custompbg",        "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "custompbgcolor",   ".5,.2,.2,1")
  ShaguPlates:UpdateConfig("unitframes", nil,           "manacolor",        ".5,.5,1,1")
  ShaguPlates:UpdateConfig("unitframes", nil,           "energycolor",      "1,1,.5,1")
  ShaguPlates:UpdateConfig("unitframes", nil,           "ragecolor",        "1,.5,.5,1")
  ShaguPlates:UpdateConfig("unitframes", nil,           "focuscolor",       "1,1,.75,1")

  ShaguPlates:UpdateConfig("unitframes", nil,           "animation_speed",  "5")
  ShaguPlates:UpdateConfig("unitframes", nil,           "portraitalpha",    "0.1")
  ShaguPlates:UpdateConfig("unitframes", nil,           "always2dportrait", "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "portraittexture",  "1")
  ShaguPlates:UpdateConfig("unitframes", nil,           "layout",           "default")
  ShaguPlates:UpdateConfig("unitframes", nil,           "rangecheck",       "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "buffdetect",       "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "rangechecki",      "4")
  ShaguPlates:UpdateConfig("unitframes", nil,           "combosize",        "6")
  ShaguPlates:UpdateConfig("unitframes", nil,           "abbrevnum",        "1")
  ShaguPlates:UpdateConfig("unitframes", nil,           "abbrevname",       "1")

  ShaguPlates:UpdateConfig("unitframes", nil,           "selfingroup",      "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "selfinraid",       "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "raidforgroup",     "0")
  ShaguPlates:UpdateConfig("unitframes", nil,           "maxraid",          "40")

  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast",        "target")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast_shift",  "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast_alt",    "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast_ctrl",   "")

  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast2",        "menu")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast2_shift",  "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast2_alt",    "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast2_ctrl",   "")

  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast3",        "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast3_shift",  "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast3_alt",    "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast3_ctrl",   "")

  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast4",        "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast4_shift",  "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast4_alt",    "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast4_ctrl",   "")

  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast5",        "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast5_shift",  "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast5_alt",    "")
  ShaguPlates:UpdateConfig("unitframes", nil,           "clickcast5_ctrl",   "")

  ShaguPlates:UpdateConfig("unitframes", "player",      "showPVPMinimap",   "0")
  ShaguPlates:UpdateConfig("unitframes", "player",      "showRest",         "0")
  ShaguPlates:UpdateConfig("unitframes", "player",      "energy",           "1")
  ShaguPlates:UpdateConfig("unitframes", "player",      "manatick",         "0")

  ShaguPlates:UpdateConfig("unitframes", "focus",       "width",            "120")
  ShaguPlates:UpdateConfig("unitframes", "focus",       "height",           "34")
  ShaguPlates:UpdateConfig("unitframes", "focus",       "pheight",          "4")
  ShaguPlates:UpdateConfig("unitframes", "focus",       "buffsize",         "12")
  ShaguPlates:UpdateConfig("unitframes", "focus",       "debuffsize",       "12")

  ShaguPlates:UpdateConfig("unitframes", "focustarget", "visible",          "0")
  ShaguPlates:UpdateConfig("unitframes", "focustarget", "width",            "80")
  ShaguPlates:UpdateConfig("unitframes", "focustarget", "height",           "12")
  ShaguPlates:UpdateConfig("unitframes", "focustarget", "pheight",          "-1")
  ShaguPlates:UpdateConfig("unitframes", "focustarget", "buffs",            "off")
  ShaguPlates:UpdateConfig("unitframes", "focustarget", "debuffs",          "off")
  ShaguPlates:UpdateConfig("unitframes", "focustarget", "txthpleft",        "none")
  ShaguPlates:UpdateConfig("unitframes", "focustarget", "txthpcenter",      "name")
  ShaguPlates:UpdateConfig("unitframes", "focustarget", "txthpright",       "none")

  ShaguPlates:UpdateConfig("unitframes", "group",       "portrait",         "off")
  ShaguPlates:UpdateConfig("unitframes", "group",       "width",            "164")
  ShaguPlates:UpdateConfig("unitframes", "group",       "height",           "32")
  ShaguPlates:UpdateConfig("unitframes", "group",       "pheight",          "4")
  ShaguPlates:UpdateConfig("unitframes", "group",       "buffs",            "BOTTOMLEFT")
  ShaguPlates:UpdateConfig("unitframes", "group",       "buffsize",         "8")
  ShaguPlates:UpdateConfig("unitframes", "group",       "debuffs",          "BOTTOMLEFT")
  ShaguPlates:UpdateConfig("unitframes", "group",       "debuffsize",       "8")
  ShaguPlates:UpdateConfig("unitframes", "group",       "debufflimit",      "8")
  ShaguPlates:UpdateConfig("unitframes", "group",       "buff_indicator",   "1")
  ShaguPlates:UpdateConfig("unitframes", "group",       "debuff_indicator", "2")
  ShaguPlates:UpdateConfig("unitframes", "group",       "faderange",        "1")
  ShaguPlates:UpdateConfig("unitframes", "group",       "glowcombat",       "0")
  ShaguPlates:UpdateConfig("unitframes", "group",       "hide_in_raid",     "0")
  ShaguPlates:UpdateConfig("unitframes", "group",       "txthpright",       "healthmiss")

  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "portrait",         "off")
  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "width",            "120")
  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "height",           "16")
  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "pheight",          "0")
  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "buffs",            "off")
  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "buffsize",         "16")
  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "debuffs",          "off")
  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "debuffsize",       "16")
  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "faderange",        "1")
  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "glowcombat",       "0")
  ShaguPlates:UpdateConfig("unitframes", "grouptarget", "txthpright",       "healthperc")

  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "portrait",         "off")
  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "width",            "100")
  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "height",           "14")
  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "pheight",          "0")
  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "buffs",            "off")
  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "buffsize",         "16")
  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "debuffs",          "off")
  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "debuffsize",       "16")
  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "faderange",        "1")
  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "glowcombat",       "0")
  ShaguPlates:UpdateConfig("unitframes", "grouppet",    "txthpright",       "healthperc")

  ShaguPlates:UpdateConfig("unitframes", "raid",        "portrait",         "off")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "width",            "50")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "height",           "26")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "pheight",          "4")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "buffs",            "off")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "buffsize",         "16")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "debuffs",          "off")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "debuffsize",       "16")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "buff_indicator",   "1")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "debuff_indicator", "2")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "faderange",        "1")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "glowcombat",       "0")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "txthpleft",        "name")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "txthpright",       "healthmiss")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "overhealperc",     "10")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "raidlayout",       "8x5")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "raidpadding",      "3")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "raidfill",         "VERTICAL")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "squareaggro",      "1")
  ShaguPlates:UpdateConfig("unitframes", "raid",        "squaresize",       "6")

  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "width",            "100")
  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "height",           "17")
  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "pheight",          "3")
  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "buffs",            "off")
  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "buffsize",         "16")
  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "debuffs",          "off")
  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "debuffsize",       "16")
  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "txthpleft",        "none")
  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "txthpcenter",      "name")
  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "txthpright",       "none")
  ShaguPlates:UpdateConfig("unitframes", "ttarget",     "overhealperc",     "10")

  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "visible",          "0")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "width",            "100")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "height",           "17")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "pheight",          "3")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "buffs",            "off")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "buffsize",         "16")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "debuffs",          "off")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "debuffsize",       "16")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "txthpleft",        "none")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "txthpcenter",      "name")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "txthpright",       "none")
  ShaguPlates:UpdateConfig("unitframes", "tttarget",    "overhealperc",     "10")

  ShaguPlates:UpdateConfig("unitframes", "pet",         "happinessicon",    "2")
  ShaguPlates:UpdateConfig("unitframes", "pet",         "happinesssize",    "12")
  ShaguPlates:UpdateConfig("unitframes", "pet",         "width",            "100")
  ShaguPlates:UpdateConfig("unitframes", "pet",         "height",           "14")
  ShaguPlates:UpdateConfig("unitframes", "pet",         "pheight",          "4")
  ShaguPlates:UpdateConfig("unitframes", "pet",         "buffsize",         "12")
  ShaguPlates:UpdateConfig("unitframes", "pet",         "debuffsize",       "12")
  ShaguPlates:UpdateConfig("unitframes", "pet",         "txthpleft",        "none")
  ShaguPlates:UpdateConfig("unitframes", "pet",         "txthpcenter",      "name")
  ShaguPlates:UpdateConfig("unitframes", "pet",         "txthpright",       "none")

  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "visible",          "0")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "width",            "100")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "height",           "4")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "pheight",          "-1")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "buffs",            "off")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "buffsize",         "16")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "debuffs",          "off")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "debuffsize",       "16")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "txthpleft",        "none")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "txthpcenter",      "name")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "txthpright",       "none")
  ShaguPlates:UpdateConfig("unitframes", "ptarget",     "overhealperc",     "10")

  local ufs = { "player", "target", "focus", "focustarget", "group", "grouptarget", "grouppet", "raid", "ttarget", "pet", "ptarget", "fallback", "tttarget" }
  for _, unit in pairs(ufs) do
    ShaguPlates:UpdateConfig("unitframes", unit,      "visible",          "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "showPVP",          "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "raidicon",         "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "leadericon",       "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "looticon",         "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "raidiconsize",     "24")
    ShaguPlates:UpdateConfig("unitframes", unit,      "portrait",         "bar")
    ShaguPlates:UpdateConfig("unitframes", unit,      "bartexture",       "Interface\\AddOns\\tDF\\img\\bar")
    ShaguPlates:UpdateConfig("unitframes", unit,      "pbartexture",       "Interface\\AddOns\\tDF\\img\\bar")
    ShaguPlates:UpdateConfig("unitframes", unit,      "width",            "200")
    ShaguPlates:UpdateConfig("unitframes", unit,      "height",           "46")
    ShaguPlates:UpdateConfig("unitframes", unit,      "pheight",          "10")
    ShaguPlates:UpdateConfig("unitframes", unit,      "pwidth",           "-1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "poffx",           "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "poffy",           "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "portraitheight",   "-1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "portraitwidth",    "-1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "panchor",          "TOP")
    ShaguPlates:UpdateConfig("unitframes", unit,      "pspace",           "-3")
    ShaguPlates:UpdateConfig("unitframes", unit,      "cooldown_text",    "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "cooldown_anim",    "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "buffs",            "TOPLEFT")
    ShaguPlates:UpdateConfig("unitframes", unit,      "buffsize",         "20")
    ShaguPlates:UpdateConfig("unitframes", unit,      "bufflimit",        "32")
    ShaguPlates:UpdateConfig("unitframes", unit,      "buffperrow",       "8")
    ShaguPlates:UpdateConfig("unitframes", unit,      "debuffs",          "TOPLEFT")
    ShaguPlates:UpdateConfig("unitframes", unit,      "debuffsize",       "20")
    ShaguPlates:UpdateConfig("unitframes", unit,      "debufflimit",      "32")
    ShaguPlates:UpdateConfig("unitframes", unit,      "debuffperrow",     "8")
    ShaguPlates:UpdateConfig("unitframes", unit,      "invert_healthbar", "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "verticalbar",      "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "buff_indicator",   "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "debuff_indicator", "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "custom_indicator", "")

    ShaguPlates:UpdateConfig("unitframes", unit,      "debuff_ind_pos",   "CENTER")
    ShaguPlates:UpdateConfig("unitframes", unit,      "debuff_ind_size",  ".65")
    ShaguPlates:UpdateConfig("unitframes", unit,      "debuff_ind_class", "1")

    ShaguPlates:UpdateConfig("unitframes", unit,      "show_buffs",       "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "show_hots",        "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "all_hots",         "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "show_procs",       "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "show_totems",      "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "all_procs",        "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "indicator_time",   "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "indicator_stacks", "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "indicator_size",   "10")
    ShaguPlates:UpdateConfig("unitframes", unit,      "indicator_spacing","1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "indicator_pos",    "TOPLEFT")

    ShaguPlates:UpdateConfig("unitframes", unit,      "clickcast",        "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "faderange",        "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "alpha_visible",    "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "alpha_outrange",   ".50")
    ShaguPlates:UpdateConfig("unitframes", unit,      "alpha_offline",    ".25")
    ShaguPlates:UpdateConfig("unitframes", unit,      "squareaggro",      "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "squarecombat",     "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "squaresize",       "8")
    ShaguPlates:UpdateConfig("unitframes", unit,      "squarepos",        "TOPLEFT")

    ShaguPlates:UpdateConfig("unitframes", unit,      "glowaggro",        "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "glowcombat",       "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "showtooltip",      "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "healthcolor",      "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "powercolor",       "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "levelcolor",       "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "classcolor",       "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "txthpleft",        "unit")
    ShaguPlates:UpdateConfig("unitframes", unit,      "txthpcenter",      "none")
    ShaguPlates:UpdateConfig("unitframes", unit,      "txthpright",       "healthdyn")
    ShaguPlates:UpdateConfig("unitframes", unit,      "txtpowerleft",     "none")
    ShaguPlates:UpdateConfig("unitframes", unit,      "txtpowercenter",   "none")
    ShaguPlates:UpdateConfig("unitframes", unit,      "txtpowerright",    "none")
    ShaguPlates:UpdateConfig("unitframes", unit,      "hitindicator",     "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "hitindicatorsize", "15")
    ShaguPlates:UpdateConfig("unitframes", unit,      "hitindicatorfont", "Interface\\AddOns\\tDF\\fonts\\Continuum.ttf")
    ShaguPlates:UpdateConfig("unitframes", unit,      "defcolor",         "1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "custom",           "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "customfullhp",     "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "customfade",       "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "customcolor",      ".2,.2,.2,1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "custombg",         "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "custombgcolor",    ".5,.2,.2,1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "custompbg",        "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "custompbgcolor",   ".5,.2,.2,1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "manacolor",        ".5,.5,1,1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "energycolor",      "1,1,.5,1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "ragecolor",        "1,.5,.5,1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "focuscolor",       "1,1,.75,1")
    ShaguPlates:UpdateConfig("unitframes", unit,      "healcolor",        "0,1,0,0.6")
    ShaguPlates:UpdateConfig("unitframes", unit,      "overhealperc",     "20")
    ShaguPlates:UpdateConfig("unitframes", unit,      "customfont",       "0")
    ShaguPlates:UpdateConfig("unitframes", unit,      "customfont_name",  "Interface\\AddOns\\tDF\\fonts\\BigNoodleTitling.ttf")
    ShaguPlates:UpdateConfig("unitframes", unit,      "customfont_size",  "12")
    ShaguPlates:UpdateConfig("unitframes", unit,      "customfont_style", "OUTLINE")
  end

  ShaguPlates:UpdateConfig("bars",       "bar1",        "pageable",         "1")
  ShaguPlates:UpdateConfig("bars",       "bar2",        "pageable",         "1")

  ShaguPlates:UpdateConfig("bars",       "bar1",        "enable",           "1")
  ShaguPlates:UpdateConfig("bars",       "bar3",        "enable",           "1")
  ShaguPlates:UpdateConfig("bars",       "bar4",        "enable",           "1")
  ShaguPlates:UpdateConfig("bars",       "bar5",        "enable",           "1")
  ShaguPlates:UpdateConfig("bars",       "bar6",        "enable",           "1")
  ShaguPlates:UpdateConfig("bars",       "bar11",       "enable",           "1")
  ShaguPlates:UpdateConfig("bars",       "bar12",       "enable",           "1")

  ShaguPlates:UpdateConfig("bars",       "bar3",        "formfactor",       "6 x 2")
  ShaguPlates:UpdateConfig("bars",       "bar5",        "formfactor",       "6 x 2")
  ShaguPlates:UpdateConfig("bars",       "bar4",        "formfactor",       "1 x 12")
  ShaguPlates:UpdateConfig("bars",       "bar11",       "formfactor",       "10 x 1")
  ShaguPlates:UpdateConfig("bars",       "bar12",       "formfactor",       "10 x 1")

  ShaguPlates:UpdateConfig("bars",       "bar11",       "icon_size",        "18")
  ShaguPlates:UpdateConfig("bars",       "bar12",       "icon_size",        "18")

  for i=1,12 do
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "enable",           "0")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "pageable",         "0")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "icon_size",        "20")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "spacing",          "1")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "formfactor",       "12 x 1")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "background",       "1")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "showempty",        "1")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "showmacro",        "1")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "showkeybind",      "1")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "showcount",        "1")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "autohide",         "0")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "hide_time",        "3")
    ShaguPlates:UpdateConfig("bars",     "bar"..i,      "hide_combat",      "1")
    if i ~= 11 and i ~= 12 then
      ShaguPlates:UpdateConfig("bars",     "bar"..i,      "buttons",           "12")
    end
  end

  ShaguPlates:UpdateConfig("bars",       nil,           "keydown",          "0")
  ShaguPlates:UpdateConfig("bars",       nil,           "altself",          "0")
  ShaguPlates:UpdateConfig("bars",       nil,           "rightself",        "0")
  ShaguPlates:UpdateConfig("bars",       nil,           "animation",        "zoomfade")
  ShaguPlates:UpdateConfig("bars",       nil,           "animmode",         "keypress")
  ShaguPlates:UpdateConfig("bars",       nil,           "animalways",       "0")
  ShaguPlates:UpdateConfig("bars",       nil,           "macroscan",        "1")
  ShaguPlates:UpdateConfig("bars",       nil,           "reagents",         "1")
  ShaguPlates:UpdateConfig("bars",       nil,           "hunterbar",        "0")
  ShaguPlates:UpdateConfig("bars",       nil,           "pagemaster",       "0")
  ShaguPlates:UpdateConfig("bars",       nil,           "druidstealth",     "0")
  ShaguPlates:UpdateConfig("bars",       nil,           "showcastable",     "1")
  ShaguPlates:UpdateConfig("bars",       nil,           "glowrange",        "1")
  ShaguPlates:UpdateConfig("bars",       nil,           "rangecolor",       "1,0.1,0.1,1")
  ShaguPlates:UpdateConfig("bars",       nil,           "showoom",          "1")
  ShaguPlates:UpdateConfig("bars",       nil,           "oomcolor",         ".2,.2,1,1")
  ShaguPlates:UpdateConfig("bars",       nil,           "showna",           "1")
  ShaguPlates:UpdateConfig("bars",       nil,           "nacolor",          ".3,.3,.3,1")
  ShaguPlates:UpdateConfig("bars",       nil,           "showequipped",     "1")
  ShaguPlates:UpdateConfig("bars",       nil,           "eqcolor",          ".2,.8,.2,.2")
  ShaguPlates:UpdateConfig("bars",       nil,           "shiftdrag",        "1")

  ShaguPlates:UpdateConfig("bars",       nil,           "font",             "Interface\\AddOns\\tDF\\fonts\\BigNoodleTitling.ttf")
  ShaguPlates:UpdateConfig("bars",       nil,           "font_offset",      "0")
  ShaguPlates:UpdateConfig("bars",       nil,           "macro_size",       "9")
  ShaguPlates:UpdateConfig("bars",       nil,           "macro_color",      "1,1,1,1")
  ShaguPlates:UpdateConfig("bars",       nil,           "count_size",       "11")
  ShaguPlates:UpdateConfig("bars",       nil,           "count_color",      ".2,1,.8,1")
  ShaguPlates:UpdateConfig("bars",       nil,           "bind_size",        "8")
  ShaguPlates:UpdateConfig("bars",       nil,           "bind_color",       "1,1,0,1")
  ShaguPlates:UpdateConfig("bars",       nil,           "cd_size",          "12")

  ShaguPlates:UpdateConfig("totems",     nil,           "direction",        "HORIZONTAL")
  ShaguPlates:UpdateConfig("totems",     nil,           "iconsize",         "26")
  ShaguPlates:UpdateConfig("totems",     nil,           "spacing",          "3")
  ShaguPlates:UpdateConfig("totems",     nil,           "showbg",           "0")

  ShaguPlates:UpdateConfig("panel",      nil,           "use_unitfonts", "1")
  ShaguPlates:UpdateConfig("panel",      nil,           "hide_leftchat",    "0")
  ShaguPlates:UpdateConfig("panel",      nil,           "hide_rightchat",   "0")
  ShaguPlates:UpdateConfig("panel",      nil,           "hide_minimap",     "0")
  ShaguPlates:UpdateConfig("panel",      nil,           "hide_microbar",    "0")
  ShaguPlates:UpdateConfig("panel",      "left",        "left",             "guild")
  ShaguPlates:UpdateConfig("panel",      "left",        "center",           "durability")
  ShaguPlates:UpdateConfig("panel",      "left",        "right",            "friends")
  ShaguPlates:UpdateConfig("panel",      "right",       "left",             "fps")
  ShaguPlates:UpdateConfig("panel",      "right",       "center",           "time")
  ShaguPlates:UpdateConfig("panel",      "right",       "right",            "gold")
  ShaguPlates:UpdateConfig("panel",      "other",       "minimap",          "zone")
  ShaguPlates:UpdateConfig("panel",      "micro",       "enable",           "0")
  ShaguPlates:UpdateConfig("panel",      nil,           "fpscolors",        "1")

  ShaguPlates:UpdateConfig("panel",      "bag",         "ignorespecial",    "1")
  ShaguPlates:UpdateConfig("panel",      "xp",          "xp_always",        "0")
  ShaguPlates:UpdateConfig("panel",      "xp",          "xp_display",       "XPFLEX")
  ShaguPlates:UpdateConfig("panel",      "xp",          "xp_timeout",       "5")
  ShaguPlates:UpdateConfig("panel",      "xp",          "xp_width",         "5")
  ShaguPlates:UpdateConfig("panel",      "xp",          "xp_height",        "5")
  ShaguPlates:UpdateConfig("panel",      "xp",          "xp_mode",          "VERTICAL")
  ShaguPlates:UpdateConfig("panel",      "xp",          "xp_anchor",        "pfChatLeft")
  ShaguPlates:UpdateConfig("panel",      "xp",          "xp_position",      "RIGHT")
  ShaguPlates:UpdateConfig("panel",      "xp",          "xp_color",         ".25,.25,1,1")
  ShaguPlates:UpdateConfig("panel",      "xp",          "rest_color",       "1,.25,1,.5")

  ShaguPlates:UpdateConfig("panel",      "xp",          "rep_always",       "0")
  ShaguPlates:UpdateConfig("panel",      "xp",          "rep_display",      "REP")
  ShaguPlates:UpdateConfig("panel",      "xp",          "rep_timeout",      "5")
  ShaguPlates:UpdateConfig("panel",      "xp",          "rep_width",        "5")
  ShaguPlates:UpdateConfig("panel",      "xp",          "rep_height",       "5")
  ShaguPlates:UpdateConfig("panel",      "xp",          "rep_mode",         "VERTICAL")
  ShaguPlates:UpdateConfig("panel",      "xp",          "rep_anchor",       "pfChatRight")
  ShaguPlates:UpdateConfig("panel",      "xp",          "rep_position",     "LEFT")
  ShaguPlates:UpdateConfig("panel",      "xp",          "dont_overlap",     "0")

  ShaguPlates:UpdateConfig("castbar",    "player",      "hide_blizz",       "1")
  ShaguPlates:UpdateConfig("castbar",    "player",      "hide_shaguplates",        "0")
  ShaguPlates:UpdateConfig("castbar",    "player",      "width",            "-1")
  ShaguPlates:UpdateConfig("castbar",    "player",      "height",           "-1")
  ShaguPlates:UpdateConfig("castbar",    "player",      "showicon",         "0")
  ShaguPlates:UpdateConfig("castbar",    "player",      "showname",         "1")
  ShaguPlates:UpdateConfig("castbar",    "player",      "showtimer",        "1")
  ShaguPlates:UpdateConfig("castbar",    "player",      "showlag",          "0")
  ShaguPlates:UpdateConfig("castbar",    "player",      "showrank",         "0")
  ShaguPlates:UpdateConfig("castbar",    "target",      "hide_shaguplates",        "0")
  ShaguPlates:UpdateConfig("castbar",    "target",      "width",            "-1")
  ShaguPlates:UpdateConfig("castbar",    "target",      "height",           "-1")
  ShaguPlates:UpdateConfig("castbar",    "target",      "showicon",         "0")
  ShaguPlates:UpdateConfig("castbar",    "target",      "showname",         "1")
  ShaguPlates:UpdateConfig("castbar",    "target",      "showtimer",        "1")
  ShaguPlates:UpdateConfig("castbar",    "target",      "showlag",          "0")
  ShaguPlates:UpdateConfig("castbar",    "target",      "showrank",         "0")
  ShaguPlates:UpdateConfig("castbar",    "focus",       "hide_shaguplates",        "0")
  ShaguPlates:UpdateConfig("castbar",    "focus",       "width",            "-1")
  ShaguPlates:UpdateConfig("castbar",    "focus",       "height",           "-1")
  ShaguPlates:UpdateConfig("castbar",    "focus",       "showicon",         "0")
  ShaguPlates:UpdateConfig("castbar",    "focus",       "showname",         "1")
  ShaguPlates:UpdateConfig("castbar",    "focus",       "showtimer",        "1")
  ShaguPlates:UpdateConfig("castbar",    "focus",       "showlag",          "0")
  ShaguPlates:UpdateConfig("castbar",    "focus",       "showrank",         "0")
  ShaguPlates:UpdateConfig("castbar",    nil,           "use_unitfonts", "1")

  ShaguPlates:UpdateConfig("tooltip",    nil,           "position",         "chat")
  ShaguPlates:UpdateConfig("tooltip",    nil,           "cursoralign",      "native")
  ShaguPlates:UpdateConfig("tooltip",    nil,           "cursoroffset",     "20")
  ShaguPlates:UpdateConfig("tooltip",    nil,           "extguild",         "1")
  ShaguPlates:UpdateConfig("tooltip",    nil,           "itemid",           "0")
  ShaguPlates:UpdateConfig("tooltip",    nil,           "alpha",            "0.8")
  ShaguPlates:UpdateConfig("tooltip",    nil,           "alwaysperc",       "0")
  ShaguPlates:UpdateConfig("tooltip",    "compare",     "basestats",        "1")
  ShaguPlates:UpdateConfig("tooltip",    "compare",     "showalways",       "0")
  ShaguPlates:UpdateConfig("tooltip",    "vendor",      "showalways",       "0")
  ShaguPlates:UpdateConfig("tooltip",    "questitem",   "showquest",        "1")
  ShaguPlates:UpdateConfig("tooltip",    "questitem",   "showcount",        "0")
  ShaguPlates:UpdateConfig("tooltip",    "statusbar",   "texture",          "Interface\\AddOns\\tDF\\img\\bar")
  ShaguPlates:UpdateConfig("tooltip",     nil,          "font_tooltip",     "Interface\\AddOns\\tDF\\fonts\\Myriad-Pro.ttf")
  ShaguPlates:UpdateConfig("tooltip",     nil,          "font_tooltip_size", "12")

  ShaguPlates:UpdateConfig("chat",       "text",        "input_width",      "0")
  ShaguPlates:UpdateConfig("chat",       "text",        "input_height",     "0")
  ShaguPlates:UpdateConfig("chat",       "text",        "outline",          "1")
  ShaguPlates:UpdateConfig("chat",       "text",        "history",          "1")
  ShaguPlates:UpdateConfig("chat",       "text",        "mouseover",        "0")
  ShaguPlates:UpdateConfig("chat",       "text",        "bracket",          "[]")
  ShaguPlates:UpdateConfig("chat",       "text",        "time",             "0")
  ShaguPlates:UpdateConfig("chat",       "text",        "timeformat",       "%H:%M:%S")
  ShaguPlates:UpdateConfig("chat",       "text",        "timebracket",      "[]")
  ShaguPlates:UpdateConfig("chat",       "text",        "timecolor",        ".8,.8,.8,1")
  ShaguPlates:UpdateConfig("chat",       "text",        "tintunknown",      "1")
  ShaguPlates:UpdateConfig("chat",       "text",        "unknowncolor",     ".7,.7,.7,1")
  ShaguPlates:UpdateConfig("chat",       "text",        "channelnumonly",   "1")
  ShaguPlates:UpdateConfig("chat",       "text",        "playerlinks",      "1")
  ShaguPlates:UpdateConfig("chat",       "text",        "detecturl",        "1")
  ShaguPlates:UpdateConfig("chat",       "text",        "classcolor",       "1")
  ShaguPlates:UpdateConfig("chat",       "text",        "whosearchunknown", "0")
  ShaguPlates:UpdateConfig("chat",       "left",        "width",            "380")
  ShaguPlates:UpdateConfig("chat",       "left",        "height",           "180")
  ShaguPlates:UpdateConfig("chat",       "right",       "enable",           "0")
  ShaguPlates:UpdateConfig("chat",       "right",       "width",            "380")
  ShaguPlates:UpdateConfig("chat",       "right",       "height",           "180")
  ShaguPlates:UpdateConfig("chat",       "global",      "hidecombat",       "0")
  ShaguPlates:UpdateConfig("chat",       "global",      "tabdock",          "0")
  ShaguPlates:UpdateConfig("chat",       "global",      "tabmouse",         "0")
  ShaguPlates:UpdateConfig("chat",       "global",      "chatflash",        "1")
  ShaguPlates:UpdateConfig("chat",       "global",      "frameshadow",      "1")
  ShaguPlates:UpdateConfig("chat",       "global",      "custombg",         "0")
  ShaguPlates:UpdateConfig("chat",       "global",      "background",       ".2,.2,.2,.5")
  ShaguPlates:UpdateConfig("chat",       "global",      "border",           ".4,.4,.4,.5")
  ShaguPlates:UpdateConfig("chat",       "global",      "whispermod",       "1")
  ShaguPlates:UpdateConfig("chat",       "global",      "whisper",          "1,.7,1,1")
  ShaguPlates:UpdateConfig("chat",       "global",      "sticky",           "1")
  ShaguPlates:UpdateConfig("chat",       "global",      "fadeout",          "0")
  ShaguPlates:UpdateConfig("chat",       "global",      "fadetime",         "300")
  ShaguPlates:UpdateConfig("chat",       "global",      "scrollspeed",      "1")
  ShaguPlates:UpdateConfig("chat",       "bubbles",     "borders",          "1")
  ShaguPlates:UpdateConfig("chat",       "bubbles",     "alpha",            ".75")

  ShaguPlates:UpdateConfig("nameplates", nil,           "showhostile",      "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "showfriendly",     "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "use_unitfonts", "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "legacy",           "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "overlap",          "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "showcastbar",      "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "targetcastbar",    "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "spellname",        "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "showdebuffs",      "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "guessdebuffs",     "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "clickthrough",     "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "rightclick",       "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "clickthreshold",   "0.5")
  ShaguPlates:UpdateConfig("nameplates", nil,           "enemyclassc",      "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "friendclassc",     "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "friendclassnamec", "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "raidiconsize",     "16")
  ShaguPlates:UpdateConfig("nameplates", nil,           "raidiconpos",      "CENTER")
  ShaguPlates:UpdateConfig("nameplates", nil,           "raidiconoffx",     "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "raidiconoffy",     "-5")
  ShaguPlates:UpdateConfig("nameplates", nil,           "fullhealth",       "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "target",           "1")

  ShaguPlates:UpdateConfig("nameplates", nil,           "enemynpc",         "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "enemyplayer",      "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "neutralnpc",       "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "friendlynpc",      "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "friendlyplayer",   "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "critters",         "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "totems",           "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "totemicons",       "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "showguildname",    "0")

  ShaguPlates:UpdateConfig("nameplates", nil,           "outfriendly",      "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "outfriendlynpc",   "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "outneutral",       "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "outenemy",         "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "targethighlight",  "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "highlightcolor",   "1,1,1,1")

  ShaguPlates:UpdateConfig("nameplates", nil,           "showhp",           "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "hptextpos",        "RIGHT")
  ShaguPlates:UpdateConfig("nameplates", nil,           "hptextformat",     "curmaxs")
  ShaguPlates:UpdateConfig("nameplates", nil,           "vpos",             "-10")
  ShaguPlates:UpdateConfig("nameplates", nil,           "width",            "120")
  ShaguPlates:UpdateConfig("nameplates", nil,           "debuffsize",       "14")
  ShaguPlates:UpdateConfig("nameplates", nil,           "heighthealth",     "14")
  ShaguPlates:UpdateConfig("nameplates", nil,           "heightcast",       "8")
  ShaguPlates:UpdateConfig("nameplates", nil,           "cpdisplay",        "0")
  ShaguPlates:UpdateConfig("nameplates", nil,           "targetglow",       "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "glowcolor",        "1,1,1,1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "targetzoom",       "1")
  ShaguPlates:UpdateConfig("nameplates", nil,           "targetzoomval",    ".40")
  ShaguPlates:UpdateConfig("nameplates", nil,           "notargalpha",      ".75")
  ShaguPlates:UpdateConfig("nameplates", nil,           "healthtexture",    "Interface\\AddOns\\tDF\\img\\bar_tukui")
  ShaguPlates:UpdateConfig("nameplates", "name",        "fontstyle",        "OUTLINE")
  ShaguPlates:UpdateConfig("nameplates", "health",      "offset",           "-10")
  ShaguPlates:UpdateConfig("nameplates", "debuffs",     "filter",           "none")
  ShaguPlates:UpdateConfig("nameplates", "debuffs",     "whitelist",        "")
  ShaguPlates:UpdateConfig("nameplates", "debuffs",     "blacklist",        "")
  ShaguPlates:UpdateConfig("nameplates", "debuffs",     "showstacks",       "0")
  ShaguPlates:UpdateConfig("nameplates", "debuffs",     "position",         "BOTTOM")

  ShaguPlates:UpdateConfig("abuttons",   nil,           "enable",           "1")
  ShaguPlates:UpdateConfig("abuttons",   nil,           "position",         "bottom")
  ShaguPlates:UpdateConfig("abuttons",   nil,           "showdefault",      "0")
  ShaguPlates:UpdateConfig("abuttons",   nil,           "rowsize",          "6")
  ShaguPlates:UpdateConfig("abuttons",   nil,           "spacing",          "2")
  ShaguPlates:UpdateConfig("abuttons",   nil,           "hideincombat",     "1")

  ShaguPlates:UpdateConfig("screenshot", nil,           "interval",         "0")
  ShaguPlates:UpdateConfig("screenshot", nil,           "levelup",          "0")
  ShaguPlates:UpdateConfig("screenshot", nil,           "pvprank",          "0")
  ShaguPlates:UpdateConfig("screenshot", nil,           "faction",          "0")
  ShaguPlates:UpdateConfig("screenshot", nil,           "battleground",     "0")
  ShaguPlates:UpdateConfig("screenshot", nil,           "hk",               "0")
  ShaguPlates:UpdateConfig("screenshot", nil,           "loot",             "0")
  ShaguPlates:UpdateConfig("screenshot", nil,           "hideui",           "0")
  ShaguPlates:UpdateConfig("screenshot", nil,           "caption",          "0")
  ShaguPlates:UpdateConfig("screenshot", nil,           "caption_font",     "Interface\\AddOns\\tDF\\fonts\\BigNoodleTitling.ttf")
  ShaguPlates:UpdateConfig("screenshot", nil,           "caption_size",     "22")

  ShaguPlates:UpdateConfig("gm",         nil,           "disable",          "1")
  ShaguPlates:UpdateConfig("gm",         nil,           "server",           "elysium")

  ShaguPlates:UpdateConfig("questlog",   nil,           "showQuestLevels",  "0")
  ShaguPlates:UpdateConfig("thirdparty", nil,           "chatbg",           "1")
  ShaguPlates:UpdateConfig("thirdparty", nil,           "showmeter",        "0")
  ShaguPlates:UpdateConfig("thirdparty", "dpsmate",     "skin",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "dpsmate",     "dock",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "shagudps",    "skin",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "shagudps",    "dock",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "swstats",     "skin",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "swstats",     "dock",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "ktm",         "skin",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "ktm",         "dock",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "twt",         "skin",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "twt",         "dock",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "wim",         "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "healcomm",    "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "sortbags",    "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "bag_sort",    "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "mrplow",      "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "bcs",         "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "crafty",      "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "clevermacro", "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "flightmap",   "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "sheepwatch",  "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "totemtimers", "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "theorycraft", "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "supermacro",  "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "atlasloot",   "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "myroleplay",  "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "druidmana",   "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "druidbar",    "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "ackis",       "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "bcepgp",      "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "noteit",      "enable",           "1")
  ShaguPlates:UpdateConfig("thirdparty", "recount",     "skin",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "recount",     "dock",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "omen",        "skin",             "0")
  ShaguPlates:UpdateConfig("thirdparty", "omen",        "dock",             "0")

  ShaguPlates:UpdateConfig("position",   nil,           nil,                nil)
  ShaguPlates:UpdateConfig("disabled",   nil,           nil,                nil)
end

function ShaguPlates:MigrateConfig()
  -- migrating to new fonts (1.5 -> 1.6)
  if checkversion(1, 6, 0) then
    -- migrate font_default
    if ShaguPlates_config.global.font_default == "arial" then
      ShaguPlates_config.global.font_default = "Myriad-Pro"
    elseif ShaguPlates_config.global.font_default == "homespun" then
      ShaguPlates_config.global.font_default = "Homespun"
    elseif ShaguPlates_config.global.font_default == "diediedie" then
      ShaguPlates_config.global.font_default = "DieDieDie"
    end

    -- migrate font_square
    if ShaguPlates_config.global.font_square == "arial" then
      ShaguPlates_config.global.font_square = "Myriad-Pro"
    elseif ShaguPlates_config.global.font_square == "homespun" then
      ShaguPlates_config.global.font_square = "Homespun"
    elseif ShaguPlates_config.global.font_square == "diediedie" then
      ShaguPlates_config.global.font_square = "DieDieDie"
    end

    -- migrate font_combat
    if ShaguPlates_config.global.font_combat == "arial" then
      ShaguPlates_config.global.font_combat = "Myriad-Pro"
    elseif ShaguPlates_config.global.font_combat == "homespun" then
      ShaguPlates_config.global.font_combat = "Homespun"
    elseif ShaguPlates_config.global.font_combat == "diediedie" then
      ShaguPlates_config.global.font_combat = "DieDieDie"
    end
  end

  -- migrating to new loot config section (> 2.0.5)
  if checkversion(2, 0, 5) then
    if ShaguPlates_config.appearance.loot and ShaguPlates_config.appearance.loot.autoresize then
      ShaguPlates_config.loot.autoresize = ShaguPlates_config.appearance.loot.autoresize
      ShaguPlates_config.appearance.loot.autoresize = nil
      ShaguPlates_config.appearance.loot = nil
    end
  end

  -- migrating to new unitframes (> 2.5)
  if checkversion(2, 5, 0) then
    -- migrate clickcast settings
    if ShaguPlates_config.unitframes.raid.clickcast_ctrl then
      ShaguPlates_config.unitframes.clickcast = ShaguPlates_config.unitframes.raid.clickcast
      ShaguPlates_config.unitframes.clickcast_shift = ShaguPlates_config.unitframes.raid.clickcast_shift
      ShaguPlates_config.unitframes.clickcast_alt = ShaguPlates_config.unitframes.raid.clickcast_alt
      ShaguPlates_config.unitframes.clickcast_ctrl = ShaguPlates_config.unitframes.raid.clickcast_ctrl

      ShaguPlates_config.unitframes.raid.clickcast = "0"
      ShaguPlates_config.unitframes.raid.clickcast_shift = nil
      ShaguPlates_config.unitframes.raid.clickcast_alt = nil
      ShaguPlates_config.unitframes.raid.clickcast_ctrl = nil
    end

    -- migrate buffsizes
    if ShaguPlates_config.unitframes.buff_size then
      ShaguPlates_config.unitframes.player.buffsize = ShaguPlates_config.unitframes.buff_size
      ShaguPlates_config.unitframes.target.buffsize = ShaguPlates_config.unitframes.buff_size
      ShaguPlates_config.unitframes.buff_size = nil
    end

    -- migrate debuffsizes
    if ShaguPlates_config.unitframes.debuff_size then
      ShaguPlates_config.unitframes.player.debuffsize = ShaguPlates_config.unitframes.debuff_size
      ShaguPlates_config.unitframes.target.debuffsize = ShaguPlates_config.unitframes.debuff_size
      ShaguPlates_config.unitframes.debuff_size = nil
    end
  end

  -- migrating to new fontnames (> 2.6)
  if checkversion(2, 6, 0) then
    -- migrate font_combat
    if ShaguPlates_config.global.font_square then
      ShaguPlates_config.global.font_unit = ShaguPlates_config.global.font_square
      ShaguPlates_config.global.font_square = nil
    end
  end


  -- migrating old to new font layout (> 3.0.0)
  if checkversion(3, 0, 0) then
    -- migrate font_default
    if not strfind(ShaguPlates_config.global.font_default, "\\") then
      ShaguPlates_config.global.font_default = "Interface\\AddOns\\tDF\\fonts\\" .. ShaguPlates_config.global.font_default .. ".ttf"
    end

    -- migrate font_unit
    if not strfind(ShaguPlates_config.global.font_unit, "\\") then
      ShaguPlates_config.global.font_unit = "Interface\\AddOns\\tDF\\fonts\\" .. ShaguPlates_config.global.font_unit .. ".ttf"
    end

    -- migrate font_combat
    if not strfind(ShaguPlates_config.global.font_combat, "\\") then
      ShaguPlates_config.global.font_combat = "Interface\\AddOns\\tDF\\fonts\\" .. ShaguPlates_config.global.font_combat .. ".ttf"
    end
  end

  -- migrating old to new unitframe texts (> 3.0.0)
  if checkversion(3, 0, 0) then
    local unitframes = { "player", "target", "focus", "group", "grouptarget", "grouppet", "raid", "ttarget", "pet", "ptarget", "fallback" }

    for _, unitframe in pairs(unitframes) do
      if ShaguPlates_config.unitframes[unitframe].txtleft then
        ShaguPlates_config.unitframes[unitframe].txthpleft = ShaguPlates_config.unitframes[unitframe].txtleft
        ShaguPlates_config.unitframes[unitframe].txtleft = nil
      end
      if ShaguPlates_config.unitframes[unitframe].txtcenter then
        ShaguPlates_config.unitframes[unitframe].txthpcenter = ShaguPlates_config.unitframes[unitframe].txtcenter
        ShaguPlates_config.unitframes[unitframe].txtcenter = nil
      end
      if ShaguPlates_config.unitframes[unitframe].txtright then
        ShaguPlates_config.unitframes[unitframe].txthpright = ShaguPlates_config.unitframes[unitframe].txtright
        ShaguPlates_config.unitframes[unitframe].txtright = nil
      end
    end
  end

  -- migrating animation_speed (> 3.1.2)
  if checkversion(3, 1, 2) then
    if tonumber(ShaguPlates_config.unitframes.animation_speed) >= 13 then
      ShaguPlates_config.unitframes.animation_speed = "13"
    elseif tonumber(ShaguPlates_config.unitframes.animation_speed) >= 8 then
      ShaguPlates_config.unitframes.animation_speed = "8"
    elseif tonumber(ShaguPlates_config.unitframes.animation_speed) >= 5 then
      ShaguPlates_config.unitframes.animation_speed = "5"
    elseif tonumber(ShaguPlates_config.unitframes.animation_speed) >= 3 then
      ShaguPlates_config.unitframes.animation_speed = "3"
    elseif tonumber(ShaguPlates_config.unitframes.animation_speed) >= 2 then
      ShaguPlates_config.unitframes.animation_speed = "2"
    elseif tonumber(ShaguPlates_config.unitframes.animation_speed) >= 1 then
      ShaguPlates_config.unitframes.animation_speed = "1"
    else
      ShaguPlates_config.unitframes.animation_speed = "5"
    end
  end

  -- migrating rangecheck interval (> 3.2.2)
  if checkversion(3, 2, 2) then
    if tonumber(ShaguPlates_config.unitframes.rangechecki) <= 1 then
      ShaguPlates_config.unitframes.rangechecki = "2"
    end
  end

  -- migrating legacy buff/debuff naming (> 3.5.0)
  if checkversion(3, 5, 0) then
    local unitframes = { "player", "target", "focus", "group", "grouptarget", "grouppet", "raid", "ttarget", "pet", "ptarget", "fallback" }

    for _, unitframe in pairs(unitframes) do
      local entry = ShaguPlates_config.unitframes[unitframe]
      if entry.buffs and entry.buffs == "hide" then entry.buffs = "off" end
      if entry.debuffs and entry.debuffs == "hide" then entry.debuffs = "off" end
    end
  end

  -- migrating glow settings (> 3.5.1)
  if checkversion(3, 5, 0) then
    local common = { "player", "target", "ttarget", "pet", "ptarget", "tttarget"}
    for _, unitframe in pairs(common) do
      if ShaguPlates_config.appearance.infight.group == "1" then
        ShaguPlates_config.unitframes[unitframe].glowcombat = "1"
        ShaguPlates_config.unitframes[unitframe].glowaggro = "1"
      elseif ShaguPlates_config.appearance.infight.group == "0" then
        ShaguPlates_config.unitframes[unitframe].glowcombat = "0"
        ShaguPlates_config.unitframes[unitframe].glowaggro = "0"
      end
    end

    if ShaguPlates_config.appearance.infight.group == "1" then
      ShaguPlates_config.unitframes["group"].glowcombat = "1"
      ShaguPlates_config.unitframes["group"].glowaggro = "1"
    elseif ShaguPlates_config.appearance.infight.group == "0" then
      ShaguPlates_config.unitframes["group"].glowcombat = "0"
      ShaguPlates_config.unitframes["group"].glowaggro = "0"
    end
  end

  -- migrating old buff settings (> 3.6.1)
  if checkversion(3, 6, 1) then
    ShaguPlates_config.buffs.weapons =  ShaguPlates_config.global.hidewbuff == "1" and "0" or "1"
    ShaguPlates_config.buffs.buffs   =  ShaguPlates_config.global.hidebuff  == "1" and "0" or "1"
    ShaguPlates_config.buffs.debuffs =  ShaguPlates_config.global.hidebuff  == "1" and "0" or "1"
  end

  -- migrating default debuffbar color settings (> 3.16)
  if checkversion(3, 16, 0) then

    if ShaguPlates_config.buffbar.pdebuff.color == ".1,.1,.1,1" then
      ShaguPlates_config.buffbar.pdebuff.color = ".8,.4,.4,1"
    end

    if ShaguPlates_config.buffbar.tdebuff.color == ".1,.1,.1,1" then
      ShaguPlates_config.buffbar.tdebuff.color   =  ".8,.4,.4,1"
    end
  end

  -- migrate buff/debuff position settings (> 3.19)
  if checkversion(3, 19, 0) then
    local unitframes = { "player", "target", "focus", "group", "grouptarget", "grouppet", "raid", "ttarget", "pet", "ptarget", "fallback" }

    for _, unitframe in pairs(unitframes) do
      local entry = ShaguPlates_config.unitframes[unitframe]
      if entry.buffs and entry.buffs == "top" then entry.buffs = "TOPLEFT" end
      if entry.buffs and entry.buffs == "bottom" then entry.buffs = "BOTTOMLEFT" end
      if entry.debuffs and entry.debuffs == "top" then entry.debuffs = "TOPLEFT" end
      if entry.debuffs and entry.debuffs == "bottom" then entry.debuffs = "BOTTOMLEFT" end
    end
  end

  -- migrating actionbar settings (> 3.19)
  if checkversion(3, 19, 0) then

    local migratebars = {
      ["pfBarActionMain"] = "pfActionBarMain",
      ["pfBarBottomLeft"] = "pfActionBarTop",
      ["pfBarBottomRight"] = "pfActionBarLeft",
      ["pfBarTwoRight"] = "pfActionBarVertical",
      ["pfBarRight"] = "pfActionBarRight",
      ["pfBarShapeshift"] = "pfActionBarStances",
      ["pfBarPet"] = "pfActionBarPet",
    }

    -- migrate bar positions and scaling
    for oldname, newname in pairs(migratebars) do
      if ShaguPlates_config.position[oldname] then
        ShaguPlates_config.position[newname] = ShaguPlates.api.CopyTable(ShaguPlates_config.position[oldname])
        ShaguPlates_config.position[oldname] = nil
      end
    end

    -- migrate global settings to bar specifics
    for i=1,12 do
      if ShaguPlates_config.bars.icon_size then
        ShaguPlates_config.bars["bar"..i].icon_size = ShaguPlates_config.bars.icon_size
      end

      if ShaguPlates_config.bars.background then
        ShaguPlates_config.bars["bar"..i].background = ShaguPlates_config.bars.background
      end

      if ShaguPlates_config.bars.showmacro then
        ShaguPlates_config.bars["bar"..i].showmacro = ShaguPlates_config.bars.showmacro
      end

      if ShaguPlates_config.bars.showkeybind then
        ShaguPlates_config.bars["bar"..i].showkeybind = ShaguPlates_config.bars.showkeybind
      end

      if ShaguPlates_config.bars.hide_time then
        ShaguPlates_config.bars["bar"..i].hide_time = ShaguPlates_config.bars.hide_time
      end
    end

    ShaguPlates_config.bars.icon_size = nil
    ShaguPlates_config.bars.background = nil
    ShaguPlates_config.bars.showmacro = nil
    ShaguPlates_config.bars.showkeybind = nil
    ShaguPlates_config.bars.hide_time = nil

    if ShaguPlates_config.bars.hide_actionmain then
      ShaguPlates_config.bars.bar1.autohide = ShaguPlates_config.bars.hide_actionmain
      ShaguPlates_config.bars.hide_actionmain = nil
    end

    if ShaguPlates_config.bars.hide_bottomleft then
      ShaguPlates_config.bars.bar6.autohide = ShaguPlates_config.bars.hide_bottomleft
      ShaguPlates_config.bars.hide_bottomleft = nil
    end

    if ShaguPlates_config.bars.hide_bottomright then
      ShaguPlates_config.bars.bar5.autohide = ShaguPlates_config.bars.hide_bottomright
      ShaguPlates_config.bars.hide_bottomright = nil
    end

    if ShaguPlates_config.bars.hide_right then
      ShaguPlates_config.bars.bar3.autohide = ShaguPlates_config.bars.hide_right
      ShaguPlates_config.bars.hide_right = nil
    end

    if ShaguPlates_config.bars.hide_tworight then
      ShaguPlates_config.bars.bar4.autohide = ShaguPlates_config.bars.hide_tworight
      ShaguPlates_config.bars.hide_tworight = nil
    end

    if ShaguPlates_config.bars.hide_shapeshift then
      ShaguPlates_config.bars.bar11.autohide = ShaguPlates_config.bars.hide_shapeshift
      ShaguPlates_config.bars.hide_shapeshift = nil
    end

    if ShaguPlates_config.bars.hide_pet then
      ShaguPlates_config.bars.bar12.autohide = ShaguPlates_config.bars.hide_pet
      ShaguPlates_config.bars.hide_pet = nil
    end

    if ShaguPlates_config.bars.actionmain and ShaguPlates_config.bars.actionmain.formfactor then
      ShaguPlates_config.bars.bar1.formfactor = ShaguPlates_config.bars.actionmain.formfactor
      ShaguPlates_config.bars.actionmain.formfactor = nil
    end

    if ShaguPlates_config.bars.bottomleft and ShaguPlates_config.bars.bottomleft.formfactor then
      ShaguPlates_config.bars.bar6.formfactor = ShaguPlates_config.bars.bottomleft.formfactor
      ShaguPlates_config.bars.bottomleft.formfactor = nil
    end

    if ShaguPlates_config.bars.bottomright and ShaguPlates_config.bars.bottomright.formfactor then
      ShaguPlates_config.bars.bar5.formfactor = ShaguPlates_config.bars.bottomright.formfactor
      ShaguPlates_config.bars.bottomright.formfactor = nil
    end

    if ShaguPlates_config.bars.right and ShaguPlates_config.bars.right.formfactor then
      ShaguPlates_config.bars.bar3.formfactor = ShaguPlates_config.bars.right.formfactor
      ShaguPlates_config.bars.right.formfactor = nil
    end

    if ShaguPlates_config.bars.tworight and ShaguPlates_config.bars.tworight.formfactor then
      ShaguPlates_config.bars.bar4.formfactor = ShaguPlates_config.bars.tworight.formfactor
      ShaguPlates_config.bars.tworight.formfactor = nil
    end

    if ShaguPlates_config.bars.shapeshift and ShaguPlates_config.bars.shapeshift.formfactor then
      ShaguPlates_config.bars.bar11.formfactor = ShaguPlates_config.bars.shapeshift.formfactor
      ShaguPlates_config.bars.shapeshift.formfactor = nil
    end

    if ShaguPlates_config.bars.pet and ShaguPlates_config.bars.pet.formfactor then
      ShaguPlates_config.bars.bar12.formfactor = ShaguPlates_config.bars.pet.formfactor
      ShaguPlates_config.bars.pet.formfactor = nil
    end
  end

  -- migrate xp-showalways (> 4.0.2)
  if checkversion(4, 0, 2) and ShaguPlates_config.panel.xp.showalways then
    ShaguPlates_config.panel.xp.xp_always = ShaguPlates_config.panel.xp.showalways
    ShaguPlates_config.panel.xp.rep_always = ShaguPlates_config.panel.xp.showalways
    ShaguPlates_config.panel.xp.showalways = nil
  end

  -- migrate dispell indicators into seperate options (> 4.6.1)
  if checkversion(4, 6, 1) and ShaguPlates_config.unitframes.debuffs_class then
    local unitframes = { "player", "target", "focus", "group", "grouptarget", "grouppet", "raid", "ttarget", "pet", "ptarget", "fallback", "tttarget" }
    for _, unitframe in pairs(unitframes) do
      ShaguPlates_config.unitframes[unitframe].debuff_ind_class = ShaguPlates_config.unitframes.debuffs_class
    end
    ShaguPlates_config.unitframes.debuffs_class = nil
  end

  -- migrate buff indicators into seperate options (> 4.6.2)
  if checkversion(4, 6, 2) and ShaguPlates_config.unitframes.show_hots then
    local unitframes = { "player", "target", "focus", "group", "grouptarget", "grouppet", "raid", "ttarget", "pet", "ptarget", "fallback", "tttarget" }
    local options = { "show_hots", "all_hots", "show_procs", "show_totems", "all_procs", "indicator_time", "indicator_stacks", "indicator_size" }

    for _, unitframe in pairs(unitframes) do
      for _, option in pairs(options) do
        ShaguPlates_config.unitframes[unitframe][option] = ShaguPlates_config.unitframes[option]
      end
    end

    for _, option in pairs(options) do
      ShaguPlates_config.unitframes[option] = nil
    end
  end

  -- use same powerbar texture as for health (> 5.2.10)
  if checkversion(5, 2, 10) then
    local unitframes = { "player", "target", "focus", "group", "grouptarget", "grouppet", "raid", "ttarget", "pet", "ptarget", "fallback", "tttarget" }
    for _, unitframe in pairs(unitframes) do
      ShaguPlates_config.unitframes[unitframe].pbartexture = ShaguPlates_config.unitframes[unitframe].bartexture
    end
  end

  ShaguPlates_config.version = ShaguPlates.version.string
end
