tDF = {}
tDF.utils = {}
tDF.utils.create_button = function(name,
    parent_frame,
    anchor,
    w,
    h,
    normal_tx,
    pushed_tx,
    highlight_tx,
    normal_txc,
    pushed_txc,
    highlight_txc,
    offset_x,
    offset_y,
    f_OnEnter,
    f_OnLeave,
    f_OnClick)
    local frame = CreateFrame("Button", name, parent_frame, "UIPanelButtonTemplate")
    frame:SetWidth(w)
    frame:SetHeight(h)
    frame:SetPoint(anchor, parent_frame, offset_x, offset_y)
    frame:SetText("")

    if normal_txc then
        frame:SetNormalTexture(normal_tx)
        local NormalTexture = frame:GetNormalTexture()
        NormalTexture:SetTexCoord(normal_txc[1], normal_txc[2], normal_txc[3], normal_txc[4])
    else
        local NormalTexture = frame:CreateTexture()
        NormalTexture:SetTexture(normal_tx)
        NormalTexture:SetAllPoints(frame)
        frame:SetNormalTexture(NormalTexture)
    end

    if pushed_txc then
        frame:SetPushedTexture(pushed_tx)
        local PushedTexture = frame:GetPushedTexture()
        PushedTexture:SetTexCoord(pushed_txc[1], pushed_txc[2], pushed_txc[3], pushed_txc[4])
    else
        local PushedTexture = frame:CreateTexture()
        PushedTexture:SetTexture(pushed_tx)
        PushedTexture:SetAllPoints(frame)
        frame:SetPushedTexture(PushedTexture)
    end

    if highlight_txc then
        frame:SetHighlightTexture(highlight_tx)
        local HighlightTexture = frame:GetHighlightTexture()
        HighlightTexture:SetTexCoord(highlight_txc[1], highlight_txc[2], highlight_txc[3], highlight_txc[4])
    else
        local HighlightTexture = frame:CreateTexture()
        HighlightTexture:SetTexture(pushed_tx)
        HighlightTexture:SetAllPoints(frame)
        frame:SetHighlightTexture(HighlightTexture)
    end

    frame:SetScript("OnEnter", f_OnEnter)
    frame:SetScript("OnLeave", f_OnLeave)
    frame:SetScript("OnClick", f_OnClick)
    return frame
end

tDF.utils.create_castbar = function(unitstr, name, parent, anchor, x, y, w, h, font_mod)
    local font_size_mod = font_mod or 0
    local UnitCastingInfo = tDFUI.UnitCastingInfo
    local UnitChannelInfo = tDFUI.UnitChannelInfo

    castbar = CreateFrame("StatusBar", name, parent)
    castbar:SetPoint(anchor, parent, anchor, x, y)
    castbar:SetStatusBarTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\Castbar\\Timers.tga")
    castbar:SetStatusBarColor(1, .8, 0, 1)
    castbar:SetWidth(w)
    castbar:SetHeight(h)
    castbar.unitstr = unitstr
    --castbar:Hide()

    castbar.bg = castbar:CreateTexture(nil, "BACKGROUND")
    castbar.bg:SetTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\Castbar\\CastingBarFrame-BG")
    castbar.bg:SetWidth(w*1.015)
    castbar.bg:SetHeight(h*2.2)
    --castbar.bg:SetPoint("TOPLEFT", castbar, "TOPLEFT", -1, h*0.26)
    castbar.bg:SetPoint("TOPLEFT", castbar, "TOPLEFT", 1, 0)
    castbar.bg:SetPoint("TOPRIGHT", castbar, "TOPRIGHT", -1, 0)
    
    castbar.bg2 = castbar:CreateTexture(nil, "BACKGROUND")
    castbar.bg2:SetTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\Castbar\\CastingBarFrame-BG2")
    castbar.bg2:SetWidth(w*1.015)
    castbar.bg2:SetHeight(h*1.2)
    castbar.bg2:SetAllPoints(true)

    castbar.spark = castbar:CreateTexture(nil, "OVERLAY")
    castbar.spark:SetTexture("Interface\\AddOns\\Turtle-Dragonflight\\img\\Castbar\\CastingBarSpark")
    castbar.spark:SetWidth(h*1.33)
    castbar.spark:SetHeight(h*1.33)
    castbar.spark:SetBlendMode("ADD")

    castbar.backdrop = CreateFrame("Frame", "BORDER", castbar)
    castbar.backdrop:SetFrameStrata("MEDIUM")
    castbar.backdrop:SetPoint("TOPLEFT", castbar, "TOPLEFT", -1, h*0.1)
    castbar.backdrop:SetPoint("BOTTOMRIGHT", castbar, "BOTTOMRIGHT", 0, h*-0.1)
    castbar.backdrop:SetBackdrop({
      bgFile = "Interface\\AddOns\\Turtle-Dragonflight\\img\\Castbar\\CastingBarFrame2.tga"
    })
    if tDFUI.DarkMode then
        castbar.backdrop:SetBackdropColor( .3, .3, .3, .9)
    end

    castbar.text = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
    castbar.text:SetPoint("CENTER", castbar, "CENTER", 0, -h)
    local font, size, opts = castbar.text:GetFont()
    castbar.text:SetFont(font, size - font_size_mod, opts)
    castbar.text:SetTextColor(1,1,1)

    castbar.timerText = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
    castbar.timerText:SetPoint("CENTER", castbar, "CENTER", 0, 0)
    castbar.timerText:SetFont(font, size - font_size_mod, opts)
    castbar.timerText:SetTextColor(1,1,1)

    if unitstr == "player" then
        castbar.lag = castbar:CreateTexture(nil, "OVERLAY")
        castbar.lag:SetPoint("TOPRIGHT", castbar, "TOPRIGHT", -2, -1)
        castbar.lag:SetPoint("BOTTOMRIGHT", castbar, "BOTTOMRIGHT", -1, 1)
        castbar.lag:SetTexture(1,.2,.2,.4)
        castbar.lag:Hide()

        castbar.lagText = castbar:CreateFontString(nil, "HIGH", "GameFontNormal")
        castbar.lagText:SetPoint("RIGHT", castbar, "RIGHT", -2, -h)
        castbar.lagText:SetFont(font, size - font_size_mod - 3, opts)
        castbar.lagText:SetTextColor(1,1,1)
        castbar.lagText:Hide()
    end

    castbar.texture = CreateFrame("Frame", nil, castbar)
    castbar.texture:SetPoint("RIGHT", castbar, "LEFT", -2, 0)
    castbar.texture:SetHeight(20)
    castbar.texture:SetWidth(20)

    castbar.texture.icon = castbar.texture:CreateTexture(nil, "BACKGROUND")
    castbar.texture.icon:SetPoint("CENTER", 0, 0)
    castbar.texture.icon:SetWidth(16)
    castbar.texture.icon:SetHeight(16)
    castbar.texture:SetBackdrop({
      edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
      tile = true, tileSize = 8, edgeSize = 12,
      insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })

    castbar:SetScript("OnUpdate", function()
        local channel = nil
        local name = this.unitstr and UnitName(this.unitstr) or nil
        local query = this.unitstr or nil
        if not name then return end
        -- try to read cast and guid from SuperWoW (except for self casts)
        if tDFUI.superwow_active and this.unitstr and not UnitIsUnit(this.unitstr, 'player') then
            local _, guid = UnitExists(this.unitstr)
            query = guid or query
        end

        local cast, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitCastingInfo(query)
        if not cast then
            -- scan for channel spells if no cast was found
            channel, nameSubtext, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(query)
            cast = channel
        end

        if not cast then this:SetAlpha(0) return end
        this:SetAlpha(1)
        local duration = endTime - startTime
        local max = duration / 1000
        local cur = GetTime() - startTime / 1000

        if channel then cur = max + startTime/1000 - GetTime() end

        cur = cur > max and max or cur
        cur = cur < 0 and 0 or cur

        local rem = max - cur
        rem = string.format("%.1f".."s", rem)

        this:Show()
        this:SetMinMaxValues(0, duration / 1000)
        this:SetValue(cur)

        local percent = cur / max
        local x = this:GetWidth()*percent
        this.spark:SetPoint("CENTER", this, "LEFT", x, 0)

        this.text:SetText(cast)
        this.timerText:SetText(rem)
        if this.lagText then
            local _, _, lag = GetNetStats()
            local width = castbar:GetWidth() / (duration/1000) * (lag/1000)
            this.lag:SetWidth(math.min(castbar:GetWidth(), width))
            this.lagText:SetText(lag .. "ms")
        end

        if texture and this.unitstr == "target" then
            this.texture.icon:SetTexture(texture)
            this.texture:Show()
            this.texture.icon:Show()
        else
            this.texture:Hide()
            this.texture.icon:Hide()
        end

    end)

    return castbar
end