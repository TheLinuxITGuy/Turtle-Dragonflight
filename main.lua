local _G = _G or getfenv(0)

SLASH_RELOAD1 = '/rl'
function SlashCmdList.RELOAD(msg, editbox) ReloadUI() end

message = function(msg)
  DEFAULT_CHAT_FRAME:AddMessage("|cffffff00" .. ( msg or "nil" ))
end
print = message

error = function(msg)
  DEFAULT_CHAT_FRAME:AddMessage("|cffff0000".. (msg or "nil" ))
end
seterrorhandler(error)

tDFUI = CreateFrame("Frame")
tDFUI.mods = {}

 -- load translation tables
 tDFUI.L = (tDFUI_locale[GetLocale()] or tDFUI_locale["enUS"])
 tDFUI.T = (tDFUI_translation[GetLocale()] or tDFUI_translation["enUS"])

 -- use table index key as translation fallback
 tDFUI.T = setmetatable(tDFUI.T, { __index = function(tab,key)
   local value = tostring(key)
   rawset(tab, key, value)
   return value
 end})

 tDFUI:RegisterEvent("VARIABLES_LOADED")
 tDFUI:SetScript("OnEvent", function()

   -- load current expansion
  local expansion = tDFUI:GetExpansion()

  -- initialize empty config
  if not tDFUI_config then tDFUI_config = {} end

  -- read all registered mods
  for title, mod in pairs(tDFUI.mods) do
    -- write initial default config
    if not tDFUI_config[title] then
      tDFUI_config[title] = mod.enabled and 1 or 0
    end

    -- load enabled mods
    if mod.expansions[expansion] and tDFUI_config[title] == 1 then
      mod:enable()
    end
  end
end)

tDFUI.register = function(self, mod)
  tDFUI.mods[mod.title] = mod
  return tDFUI.mods[mod.title]
end
