--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Dragonflight.
]]

--creates a global print function
function print(txt)
  local text = DEFAULT_CHAT_FRAME:AddMessage(txt)
  return text
end

print("|cff008000Turtle |cff1974d2Dragonflight |cffffffffloaded. Welcome " .. UnitName("player") .. "!")

--adds scroll up and down to chat
local scrollspeed = 1
local function ChatOnMouseWheel()
  if arg1 > 0 then
    if IsShiftKeyDown() then
      this:ScrollToTop()
    else
      for i=1, scrollspeed do
        this:ScrollUp()
      end
    end
  elseif arg1 < 0 then
    if IsShiftKeyDown() then
      this:ScrollToBottom()
    else
      for i=1, scrollspeed do
        this:ScrollDown()
      end
    end
  end
end

  -- enable sticky chat types
  ChatTypeInfo.WHISPER.sticky = 1
  ChatTypeInfo.OFFICER.sticky = 1
  ChatTypeInfo.RAID_WARNING.sticky = 1
  ChatTypeInfo.CHANNEL.sticky = 1
  -- repeat message without pressing <alt>
  ChatFrameEditBox:SetAltArrowKeyMode(false)

-- loop over all chat windows
for i=1, NUM_CHAT_WINDOWS do
  local chatFrame = getglobal("ChatFrame"..i)
  if chatFrame then
    -- enable mouse wheel scrolling
    chatFrame:EnableMouseWheel(true)
    chatFrame:SetScript("OnMouseWheel", ChatOnMouseWheel)
  end
end

  --[[
  for i=1, NUM_CHAT_WINDOWS do
    -- enable mouse wheel scrolling
    ChatFrame1:EnableMouseWheel(true)
    ChatFrame1:SetScript("OnMouseWheel", ChatOnMouseWheel)
  end

  ]]