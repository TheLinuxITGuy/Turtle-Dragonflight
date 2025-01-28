local _G = tDFUI.GetGlobalEnv()
local T = tDFUI.T

local module = tDFUI:register({
    title = T["Bag Search"],
    description = T["Adds a search box to the backpack for searching your bags, keyring and bank. Press Esc or Tab to finish searching."],
    expansions = { ["vanilla"] = true, ["tbc"] = nil },
    category = T["Tooltip & Items"],
    enabled = nil,
})

module.enable = function(self)
    local search = CreateFrame("Frame", nil, ContainerFrame1)
	search:SetPoint("BOTTOMLEFT", ContainerFrame1Item15, "TOPLEFT", 3, 2)
    search:SetPoint("BOTTOMRIGHT", ContainerFrame1Item13, "TOP", -20, 2)
    search:SetHeight(20)

    search.text = search:CreateFontString(nil, "HIGH", "GameTooltipTextSmall")
	local font, size = search.text:GetFont()

	search.edit = CreateFrame("EditBox", nil, search, "InputBoxTemplate")
    search.edit:SetMaxLetters(14)
	search.edit:SetAllPoints(search)
    search.edit:SetFont(font, size, "OUTLINE")
    search.edit:SetAutoFocus(false)
    search.edit:SetText(T["Search"])
    search.edit:SetTextColor(1,1,1,1)

    search.button = CreateFrame("Button", nil, search.edit)
    search.button:EnableMouse(true)
    search.button:SetWidth(28)
    search.button:SetHeight(28)
    search.button:SetPoint("LEFT", search.edit, "RIGHT", -4, -1)

    search.icon = search.edit:CreateTexture(nil, "OVERLAY")
    search.icon:SetAllPoints(search.button)
    search.icon:SetTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
    search.icon:Hide()

    local function buttons(alpha)
        -- bags & keyring
        for i = 1, 12 do
            local frame = _G["ContainerFrame"..i]
            if frame then
                local name = frame:GetName()
                local id = frame:GetID()
                for i = 1, MAX_CONTAINER_ITEMS do
                    local button = _G[name.."Item"..i]
                    local link = GetContainerItemLink(id, button:GetID())
                    if button and link then
                        button:SetAlpha(alpha)
                    end
                end
            end
        end

        -- bank
        if BankFrame:IsVisible() then
            for i = 1, 28 do
                local button = _G["BankFrameItem"..i]
                local link = GetContainerItemLink(-1, i)
                if button and link then
                    button:SetAlpha(alpha)
                end
            end
        end
    end

    local function searchBags()
        -- bags & keyring
        for i = 1, 12 do
            local frame = _G["ContainerFrame"..i]
            if frame then
                local name = frame:GetName()
                local id = frame:GetID()
                for i = 1, MAX_CONTAINER_ITEMS do
                    local button = _G[name.."Item"..i]
                    local link = GetContainerItemLink(id, button:GetID())
                    if button and button:IsShown() and link then
                        local _, _, istring  = string.find(link, "|H(.+)|h")
                        local name = GetItemInfo(istring)
                        if strfind(strlower(name), strlower(string.gsub(this:GetText(), "([^%w])", "%%%1"))) then
                            button:SetAlpha(1)
                        end
                    end
                end
            end
        end

        -- bank
        if BankFrame:IsVisible() then
            for i = 1, 28 do
                local button = _G["BankFrameItem"..i]
                local link = GetContainerItemLink(-1, i)
                if button and link then
                    local _, _, istring = string.find(link, "|H(.+)|h")
                    local name = GetItemInfo(istring)
                    if strfind(strlower(name), strlower(string.gsub(this:GetText(), "([^%w])", "%%%1"))) then
                        button:SetAlpha(1)
                    end
                end
            end
        end
    end

    local function reset()
        search.edit:SetText(T["Search"])
        buttons(1)
        search.icon:Hide()
    end

    search.edit:SetScript("OnEditFocusGained", function()
        search.edit:SetText("")
    end)

    search.edit:SetScript("OnEditFocusLost", function()
        reset()
    end)

    search.edit:SetScript("OnTabPressed", function()
        search.edit:ClearFocus()
        reset()
    end)

    search.button:SetScript("OnClick", function()
        search.edit:ClearFocus()
        reset()
    end)

    search.edit:SetScript("OnTextChanged", function()
        if this:GetText() == T["Search"] then return end
        buttons(.25)
        searchBags()
        if not search.icon:IsVisible() then
            search.icon:Show()
        end
    end)

    search:SetScript("OnShow", function()
        if ContainerFrame1:GetID() == 0 then
            -- Backpack
            search.edit:Show()
        else
            search.edit:Hide()
        end
    end)
end