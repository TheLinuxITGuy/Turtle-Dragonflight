--creates a global print function
function print(txt)
  local text = DEFAULT_CHAT_FRAME:AddMessage(txt)
  return text
end

print("|cff008000Turtle |cff1974d2Dragonflight |cffffffffloaded. Welcome " .. UnitName("player") .. "!")