local __SpellButton_OnClick = SpellButton_OnClick
function SpellButton_OnClick(drag) 
   if CRAP.clickcast then
      local button = (IsControlKeyDown() and 'CTRL-' or '') .. (IsShiftKeyDown() and 'SHIFT-' or '') .. arg1
      local name, rank = GetSpellName(SpellBook_GetSpellID(this:GetID()), 'BOOKTYPE_SPELL')
      local spell = IsAltKeyDown() and name or (name .. '(' .. rank .. ')')
      
      if name == 'Attack' then
         CRAP_Config['CLICKCAST_DATA'][button] = nil

         DEFAULT_CHAT_FRAME:AddMessage('Button \'' .. button .. '\' has been unbound.')
      else
         CRAP_Config['CLICKCAST_DATA'][button] = spell

         DEFAULT_CHAT_FRAME:AddMessage('Spell \'' .. spell .. '\' bound to button \'' .. button .. '\'.')
      end

      this:SetChecked("false");
   else
      __SpellButton_OnClick(drag)
   end
end