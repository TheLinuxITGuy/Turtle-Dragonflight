    local restyle = CreateFrame("Frame", nil, UIParent)
    local addonpath = "Interface\\AddOns\\Turtle-Dragonflight"
	local customfont = addonpath .. "\\fonts\\Prototype.ttf"
    local _G = tDFUI.GetGlobalEnv()

    function restyle:buttons()
        local function style(button)
            if not button then return end        

            local hotkey = _G[button:GetName().."HotKey"]
            if hotkey then
                local font, size, outline = customfont, 12, "OUTLINE"
                hotkey:SetFont(font, size, outline)
            end

            local macro = _G[button:GetName().."Name"]  
            if macro then
                local font, size, outline = customfont, 12, "OUTLINE"
                macro:SetFont(font, size, outline)   
            end

            local count = _G[button:GetName()..'Count']
            if count then
                local font, size, outline = customfont, 14, "OUTLINE"
                count:SetFont(font, size, outline)   
            end
        end
        
        for i = 1, 24 do
            local button = _G['BonusActionButton'..i]
            if button then
                style(button)
            end
        end

        for i = 1, 12 do
            for _, button in pairs(
                    {
                    _G['ActionButton'..i],
                    _G['MultiBarRightButton'..i],
                    _G['MultiBarLeftButton'..i],
                    _G['MultiBarBottomLeftButton'..i],
                    _G['MultiBarBottomRightButton'..i],
                }
            ) do
                style(button)
            end        
        end 

        for i = 1, 10 do
            for _, button in pairs(
                {
                    _G['ShapeshiftButton'..i],
                    _G['PetActionButton'..i]
                }
            ) do
                style(button)
            end
        end
    end

restyle:buttons()
