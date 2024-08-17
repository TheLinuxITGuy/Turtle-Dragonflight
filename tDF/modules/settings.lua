ShaguPlates:RegisterModule("gui", "vanilla:tbc", function ()
  local Reload, U, CreateConfig, CreateTabFrame, CreateArea, CreateGUIEntry, EntryUpdate

  -- "searchDB" gets populated when CreateConfig is called. The table holds
  -- information about the title, its parent buttons and the frame itself:
  --   searchDB[tostring(frame)][-1] = frame
  --                             [0] = caption
  --                           [1-X] = parent buttons
  local searchDB = {}

  do -- Core Functions/Variables
    function Reload()
      CreateQuestionDialog(T["Some settings need to reload the UI to take effect.\nDo you want to reload now?"], function()
        ShaguPlates.gui.settingChanged = nil
        ReloadUI()
      end)
    end

    U = setmetatable({}, { __index = function(tab,key)
      local ufunc
      if ShaguPlates[key] and ShaguPlates[key].UpdateConfig then
        ufunc = function() return ShaguPlates[key]:UpdateConfig() end
      elseif ShaguPlates.uf and ShaguPlates.uf[key] and ShaguPlates.uf[key].UpdateConfig then
        ufunc = function() return ShaguPlates.uf[key]:UpdateConfig() end
      end
      if ufunc then
        rawset(tab,key,ufunc)
        return ufunc
      end
    end})

    function EntryUpdate()
      -- detect and skip during dropdowns
      local focus = GetMouseFocus()
      if focus and focus.parent and focus.parent.menu then
        if this.over then
          this.tex:Hide()
          this.over = nil
        end
        return
      end

      if MouseIsOver(this) and not this.over then
        this.tex:Show()
        this.over = true
      elseif not MouseIsOver(this) and this.over then
        this.tex:Hide()
        this.over = nil
      end
    end

    function CreateConfig(ufunc, caption, category, config, widget, values, skip, named, type, expansion)
      local disabled = expansion and not strfind(expansion, ShaguPlates.expansion)
      if disabled and ShaguPlates_config.gui.showdisabled == "0" then return end

      -- this object placement
      if this.objectCount == nil then
        this.objectCount = 0
      elseif not skip then
        this.objectCount = this.objectCount + 1
        this.lineCount = 1
      end

      if skip then
        if this.lineCount == nil then
          this.lineCount = 1
        end

        if skip then
          this.lineCount = this.lineCount + 1
        end
      end

      if not caption then return end

      -- basic frame
      local frame = CreateFrame("Frame", nil, this)
      frame:SetWidth(this.parent:GetRight()-this.parent:GetLeft()-20)
      frame:SetHeight(22)
      frame:SetPoint("TOPLEFT", this, "TOPLEFT", 5, (this.objectCount*-23)-5)

      if not widget or (widget and widget ~= "button") then

        if widget ~= "header" then
          frame:SetScript("OnUpdate", EntryUpdate)
          frame.tex = frame:CreateTexture(nil, "BACKGROUND")
          frame.tex:SetTexture(1,1,1,.05)
          frame.tex:SetAllPoints()
          frame.tex:Hide()
        end

        if not ufunc and widget ~= "header" and C.gui.reloadmarker == "1" then
          caption = caption .. " [|cffffaaaa!|r]"
        end

        -- caption
        frame.caption = frame:CreateFontString("Status", "LOW", "GameFontWhite")
        frame.caption:SetFont(ShaguPlates.font_default, C.global.font_size)
        frame.caption:SetPoint("LEFT", frame, "LEFT", 3, 1)
        frame.caption:SetJustifyH("LEFT")
        frame.caption:SetText(caption)
      end

      if disabled then
        if frame.caption then
          frame.caption:SetText(caption .. " |cffff5555[" .. T["Only"] .. " " .. string.gsub(expansion, ":", "&") .. "]")
        end

        frame:SetAlpha(.5)
        return
      end

      if category == "CVAR" then
        category = {}
        category[config] = tostring(GetCVar(config))
        ufunc = function()
          SetCVar(this:GetParent().config, this:GetParent().category[config])
        end
      end

      if category == "GVAR" then
        category = {}
        category[config] = tostring(_G[config] or 0)

        local U = ufunc

        ufunc = function()
          UIOptionsFrame_Load()
          _G[config] = this:GetChecked() and 1 or nil
          UIOptionsFrame_Save()
          if U then
            U()
          end
        end
      end

      if category == "UVAR" then
        category = {}
        category[config] = _G[config]

        local U = ufunc

        ufunc = function()
          _G[config] = this:GetChecked() and "1" or "0"
          if U then
            U()
          end
        end
      end

      frame.category = category
      frame.config = config

      if widget == "color" then
        -- color picker
        frame.color = CreateFrame("Button", nil, frame)
        frame.color:SetWidth(24)
        frame.color:SetHeight(12)
        CreateBackdrop(frame.color)
        frame.color:SetPoint("RIGHT" , -5, 1)
        frame.color.prev = frame.color.backdrop:CreateTexture("OVERLAY")
        frame.color.prev:SetAllPoints(frame.color)

        local cr, cg, cb, ca = strsplit(",", category[config])
        if not cr or not cg or not cb or not ca then
          cr, cg, cb, ca = 1, 1, 1, 1
        end
        frame.color.prev:SetTexture(cr,cg,cb,ca)

        frame.color:SetScript("OnClick", function()
          local cr, cg, cb, ca = strsplit(",", category[config])
          if not cr or not cg or not cb or not ca then
            cr, cg, cb, ca = 1, 1, 1, 1
          end
          local preview = this.prev

          function ColorPickerFrame.func()
            local r,g,b = ColorPickerFrame:GetColorRGB()
            local a = 1 - OpacitySliderFrame:GetValue()

            r = round(r, 1)
            g = round(g, 1)
            b = round(b, 1)
            a = round(a, 1)

            preview:SetTexture(r,g,b,a)

            if not this:GetParent():IsShown() then
              category[config] = r .. "," .. g .. "," .. b .. "," .. a
              if ufunc then ufunc() else ShaguPlates.gui.settingChanged = true end
            end
          end

          function ColorPickerFrame.cancelFunc()
            preview:SetTexture(cr,cg,cb,ca)
          end

          ColorPickerFrame.opacityFunc = ColorPickerFrame.func
          ColorPickerFrame.element = this
          ColorPickerFrame.opacity = 1 - ca
          ColorPickerFrame.hasOpacity = 1
          ColorPickerFrame:SetColorRGB(cr,cg,cb)
          ColorPickerFrame:SetFrameStrata("DIALOG")
          ShowUIPanel(ColorPickerFrame)
        end)

        -- hide shadows on wrong stratas
        if frame.color.backdrop_shadow then
          frame.color.backdrop_shadow:Hide()
        end
      end

      if widget == "warning" then
        CreateBackdrop(frame, nil, true)
        frame:SetBackdropBorderColor(1,.5,.5)
        frame:SetHeight(50)
        frame:SetPoint("TOPLEFT", 25, this.objectCount * -35)
        this.objectCount = this.objectCount + 2
        frame.caption:SetJustifyH("CENTER")
        frame.caption:SetJustifyV("CENTER")
      end

      if widget == "header" then
        frame:SetBackdrop(nil)
        frame:SetHeight(40)
        this.objectCount = this.objectCount + 1
        frame.caption:SetJustifyH("LEFT")
        frame.caption:SetJustifyV("BOTTOM")
        frame.caption:SetTextColor(1,.8,0,1)
        frame.caption:SetAllPoints(frame)
      end

      -- use text widget (default)
      if not widget or widget == "text" then
        -- input field
        frame.input = CreateFrame("EditBox", nil, frame)
        CreateBackdrop(frame.input, nil, true)
        frame.input:SetTextInsets(5, 5, 5, 5)
        frame.input:SetTextColor(1,1,1,1)
        frame.input:SetJustifyH("RIGHT")

        frame.input:SetWidth(100)
        frame.input:SetHeight(18)
        frame.input:SetPoint("RIGHT" , -3, 0)
        frame.input:SetFontObject(GameFontNormal)
        frame.input:SetAutoFocus(false)
        frame.input:SetText(category[config])
        frame.input:SetScript("OnEscapePressed", function(self)
          this:ClearFocus()
        end)

        frame.input:SetScript("OnTextChanged", function(self)
          if ( type and type ~= "number" ) or tonumber(this:GetText()) then
            if this:GetText() ~= this:GetParent().category[this:GetParent().config] then
              this:GetParent().category[this:GetParent().config] = this:GetText()
              if ufunc then ufunc() else ShaguPlates.gui.settingChanged = true end
            end
            this:SetTextColor(1,1,1,1)
          else
            this:SetTextColor(1,.3,.3,1)
          end
        end)

        -- hide shadows on wrong stratas
        if frame.input.backdrop_shadow then
          frame.input.backdrop_shadow:Hide()
        end
      end

      -- use button widget
      if widget == "button" then
        frame.button = CreateFrame("Button", "pfButton", frame, "UIPanelButtonTemplate")
        CreateBackdrop(frame.button, nil, true)
        SkinButton(frame.button)
        frame.button:SetWidth(100)
        frame.button:SetHeight(20)
        frame.button:SetPoint("TOPRIGHT", -(this.lineCount-1) * 105, -5)
        frame.button:SetText(caption)
        frame.button:SetTextColor(1,1,1,1)
        frame.button:SetScript("OnClick", values)

        -- hide shadows on wrong stratas
        if frame.button.backdrop_shadow then
          frame.button.backdrop_shadow:Hide()
        end
      end

      -- use checkbox widget
      if widget == "checkbox" then
        -- input field
        frame.input = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
        frame.input:SetNormalTexture("")
        frame.input:SetPushedTexture("")
        frame.input:SetHighlightTexture("")
        CreateBackdrop(frame.input, nil, true)
        frame.input:SetWidth(14)
        frame.input:SetHeight(14)
        frame.input:SetPoint("RIGHT" , -5, 1)
        frame.input:SetScript("OnClick", function ()
          if this:GetChecked() then
            this:GetParent().category[this:GetParent().config] = "1"
          else
            this:GetParent().category[this:GetParent().config] = "0"
          end

          if ufunc then ufunc() else ShaguPlates.gui.settingChanged = true end
        end)

        if category[config] == "1" then frame.input:SetChecked() end

        -- hide shadows on wrong stratas
        if frame.input.backdrop_shadow then
          frame.input.backdrop_shadow:Hide()
        end
      end

      -- use dropdown widget
      if widget == "dropdown" and values then
        frame.input = CreateDropDownButton(nil, frame)
        frame.input:SetBackdrop(nil)
        frame.input.menuframe:SetParent(ShaguPlates.gui)

        frame.input:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
        frame.input:SetWidth(180)
        frame.input:SetMenu(function()
          local menu = {}

          for i, k in pairs(_G.type(values) == "function" and values() or values) do
            local entry = {}
            -- get human readable
            local value, text = strsplit(":", k)
            text = text or value

            entry.text = text
            entry.func = function()
              if category[config] ~= value then
                category[config] = value
                if ufunc then ufunc() else ShaguPlates.gui.settingChanged = true end
              end
            end

            if category[config] == value then
              frame.input.current = i
            end

            table.insert(menu, entry)
          end

          return menu
        end)

        frame.input:SetSelection(frame.input.current)
      end

      -- use list widget
      if widget == "list" then
        frame.del = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        SkinButton(frame.del)
        frame.del:SetWidth(16)
        frame.del:SetHeight(16)
        frame.del:SetPoint("RIGHT", -4, 0)
        frame.del:GetFontString():SetPoint("CENTER", 1, 0)
        frame.del:SetText("-")
        frame.del:SetTextColor(1,.5,.5,1)
        frame.del:SetScript("OnClick", function()
          local sel = frame.input:GetSelection()
          local newconf = ""
          for id, val in pairs({strsplit("#", category[config])}) do
            if id ~= sel then newconf = newconf .. "#" .. val end
          end
          category[config] = newconf
          if ufunc then ufunc() else ShaguPlates.gui.settingChanged = true end
          frame.input:UpdateMenu()
        end)

        frame.add = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        SkinButton(frame.add)
        frame.add:SetWidth(16)
        frame.add:SetHeight(16)
        frame.add:SetPoint("RIGHT", frame.del, "LEFT", -4, 0)
        frame.add:GetFontString():SetPoint("CENTER", 1, 0)
        frame.add:SetText("+")
        frame.add:SetTextColor(.5,1,.5,1)
        frame.add:SetScript("OnClick", function()
          CreateQuestionDialog(T["New entry:"], function()
            category[config] = category[config] .. "#" .. this:GetParent().input:GetText()
            if ufunc then ufunc() else ShaguPlates.gui.settingChanged = true end
            frame.input:UpdateMenu()
          end, false, true)
        end)

        frame.input = CreateDropDownButton(nil, frame)
        frame.input:SetBackdrop(nil)
        frame.input.menuframe:SetParent(ShaguPlates.gui)
        frame.input:SetPoint("RIGHT", frame.add, "LEFT", -2, 0)
        frame.input:SetWidth(140)
        frame.input:SetMenu(function()
          local menu = {}
          for i, val in pairs({strsplit("#", category[config])}) do
            table.insert(menu, { text = val })
          end
          return menu
        end)
      end

      return frame
    end

    local TabFrameOnClick = function()
      if this.area:IsShown() then
        return
      else
        -- hide all others
        for id, name in pairs(this.parent) do
          if type(name) == "table" and name.area and id ~= "parent" then
            name.area:Hide()
          end
        end
        this.area:Show()
      end
    end

    local width, height = 0, 20
    function CreateTabFrame(parent, title)
      if not parent.area.count then parent.area.count = 0 end

      local f = CreateFrame("Button", nil, parent.area)
      f:SetPoint("TOPLEFT", parent.area, "TOPLEFT", 0, -parent.area.count*height)
      f:SetPoint("BOTTOMRIGHT", parent.area, "TOPLEFT", width, -(parent.area.count+1)*height)
      f.parent = parent

      f:SetScript("OnMouseDown", TabFrameOnMouseDown)
      f:SetScript("OnClick", TabFrameOnClick)

      -- background
      f.bg = f:CreateTexture(nil, "BACKGROUND")
      f.bg:SetAllPoints()

      -- text
      f.text = f:CreateFontString(nil, "LOW", "GameFontWhite")
      f.text:SetFont(ShaguPlates.font_default, C.global.font_size)
      f.text:SetAllPoints()
      f.text:SetText(title)

      -- U element count
      parent.area.count = parent.area.count + 1

      return f
    end

    function CreateArea(parent, title, func)
      -- create drawarea
      local f = CreateFrame("Frame", nil, parent.area)
      f:SetPoint("TOPLEFT", parent.area, "TOPLEFT", width, 0)
      f:SetPoint("BOTTOMRIGHT", parent.area, "BOTTOMRIGHT", 0, 0)

      if not parent.firstarea then
        parent.firstarea = true
      else
        f:Hide()
      end

      f.button = parent[title]

      f.bg = f:CreateTexture(nil, "BACKGROUND")
      f.bg:SetTexture(1,1,1,.05)
      f.bg:SetAllPoints()

      f:SetScript("OnShow", function()
        this.indexed = true
        this.button.text:SetTextColor(1,1,1,1)
        this.button.bg:SetTexture(1,1,1,1)
        this.button.bg:SetGradientAlpha("HORIZONTAL", 0,0,0,0,  1,1,1,.05)
      end)

      f:SetScript("OnHide", function()
        this.button.text:SetTextColor(1,1,1,1)
        this.button.bg:SetTexture(0,0,0,0)
      end)

      -- are we a frame with contents?
      if func then
        f.scroll = CreateScrollFrame(nil, f)
        SetAllPointsOffset(f.scroll, f, 2)
        f.scroll.slider.thumb:SetTexture(1,1,1,.5)
        f.scroll.content = CreateScrollChild(nil, f.scroll)
        f.scroll.content.parent = f.scroll
        f.scroll.content:SetScript("OnShow", function()
          if not this.setup then
            func()
            this.setup = true
          end
        end)
      end

      return f
    end

    function CreateGUIEntry(parent, title, populate)
      -- create main menu if not yet exists
      if not ShaguPlates.gui.frames[parent] then
        ShaguPlates.gui.frames[parent] = CreateTabFrame(ShaguPlates.gui.frames, parent)
        if title then
          ShaguPlates.gui.frames[parent].area = CreateArea(ShaguPlates.gui.frames, parent, nil)
        else
          -- populate area when no submenus are given
          ShaguPlates.gui.frames[parent].area = CreateArea(ShaguPlates.gui.frames, parent, populate)
          return
        end
      end

      -- create submenus when title was given
      if title and not ShaguPlates.gui.frames[parent][title] then
        ShaguPlates.gui.frames[parent][title] = CreateTabFrame(ShaguPlates.gui.frames[parent], title)
        ShaguPlates.gui.frames[parent][title].area = CreateArea(ShaguPlates.gui.frames[parent], title, populate)
      end
    end
  end

  do -- GUI Frame
    -- main frame
    ShaguPlates.gui = CreateFrame("Frame", "pfConfigGUI", UIParent)
    ShaguPlates.gui:SetMovable(true)
    ShaguPlates.gui:EnableMouse(true)
    ShaguPlates.gui:SetWidth(512)
    ShaguPlates.gui:SetHeight(512)
    ShaguPlates.gui:SetFrameStrata("DIALOG")
    ShaguPlates.gui:SetPoint("CENTER", 0, 0)
    ShaguPlates.gui:Hide()

    ShaguPlates.gui:SetScript("OnShow",function()
      ShaguPlates.gui.settingChanged = ShaguPlates.gui.delaySettingChanged
      ShaguPlates.gui.delaySettingChanged = nil

      -- exit unlock mode
      if ShaguPlates.unlock and ShaguPlates.unlock:IsShown() then
        ShaguPlates.unlock:Hide()
      end

      -- exit hoverbind mode
      if ShaguPlates.hoverbind and ShaguPlates.hoverbind:IsShown() then
        ShaguPlates.hoverbind:Hide()
      end
    end)

    ShaguPlates.gui:SetScript("OnHide",function()
      if ColorPickerFrame and ColorPickerFrame:IsShown() then
        ColorPickerFrame:Hide()
      end

      if ShaguPlates.gui.settingChanged then
        ShaguPlates.gui:Reload()
      end
      ShaguPlates.gui:Hide()
    end)

    ShaguPlates.gui:SetScript("OnMouseDown",function()
      this:StartMoving()
    end)

    ShaguPlates.gui:SetScript("OnMouseUp",function()
      this:StopMovingOrSizing()
    end)

    CreateBackdrop(ShaguPlates.gui, nil, true, .85)
    CreateBackdropShadow(ShaguPlates.gui)
    table.insert(UISpecialFrames, "pfConfigGUI")

    -- make some locals available to thirdparty
    ShaguPlates.gui.Reload = Reload
    ShaguPlates.gui.CreateConfig = CreateConfig
    ShaguPlates.gui.CreateGUIEntry = CreateGUIEntry
    ShaguPlates.gui.UpdaterFunctions = U

    -- decorations
    ShaguPlates.gui.title = ShaguPlates.gui:CreateFontString("Status", "LOW", "GameFontNormal")
    ShaguPlates.gui.title:SetFontObject(GameFontWhite)
    ShaguPlates.gui.title:SetPoint("TOPLEFT", ShaguPlates.gui, "TOPLEFT", 8, -8)
    ShaguPlates.gui.title:SetJustifyH("LEFT")
    ShaguPlates.gui.title:SetFont(ShaguPlates.media["Fonts\\FRIZQT__.TTF"], 12)
    -- ShaguPlates.gui.title:SetText("|cffffcc00Shagu|rPlates")
    ShaguPlates.gui.title:SetText("|cff008000tDF |cff1974d2Plates")

    ShaguPlates.gui.version = ShaguPlates.gui:CreateFontString("Status", "LOW", "GameFontNormal")
    ShaguPlates.gui.version:SetFontObject(GameFontWhite)
    ShaguPlates.gui.version:SetPoint("LEFT", ShaguPlates.gui.title, "RIGHT", 0, 0)
    ShaguPlates.gui.version:SetJustifyH("LEFT")
    ShaguPlates.gui.version:SetFont(ShaguPlates.media["Fonts\\FRIZQT__.TTF"], 10)
    ShaguPlates.gui.version:SetText("|cff555555[|r" .. ShaguPlates.version.string.. "|cff555555]|r")

    ShaguPlates.gui.close = CreateFrame("Button", "pfQuestionDialogClose", ShaguPlates.gui)
    ShaguPlates.gui.close:SetPoint("TOPRIGHT", -7, -7)
    ShaguPlates.api.CreateBackdrop(ShaguPlates.gui.close)
    ShaguPlates.gui.close:SetHeight(10)
    ShaguPlates.gui.close:SetWidth(10)
    ShaguPlates.gui.close.texture = ShaguPlates.gui.close:CreateTexture("pfQuestionDialogCloseTex")
    ShaguPlates.gui.close.texture:SetTexture(ShaguPlates.media["img:close"])
    ShaguPlates.gui.close.texture:ClearAllPoints()
    ShaguPlates.gui.close.texture:SetAllPoints(ShaguPlates.gui.close)
    ShaguPlates.gui.close.texture:SetVertexColor(1,.25,.25,1)
    ShaguPlates.gui.close:SetScript("OnEnter", function ()
      this.backdrop:SetBackdropBorderColor(1,.25,.25,1)
    end)

    ShaguPlates.gui.close:SetScript("OnLeave", function ()
      ShaguPlates.api.CreateBackdrop(this)
    end)

    ShaguPlates.gui.close:SetScript("OnClick", function()
     this:GetParent():Hide()
    end)

    -- root layer
    ShaguPlates.gui.frames = {}
    ShaguPlates.gui.frames.area = CreateFrame("Frame", nil, ShaguPlates.gui)
    ShaguPlates.gui.frames.area:SetPoint("TOPLEFT", 7, -25)
    ShaguPlates.gui.frames.area:SetPoint("BOTTOMRIGHT", -7, 37)
    CreateBackdrop(ShaguPlates.gui.frames.area)

    -- reset
    ShaguPlates.gui.reset = CreateFrame("Button", nil, ShaguPlates.gui)
    ShaguPlates.gui.reset:SetPoint("TOPLEFT", ShaguPlates.gui.frames.area.backdrop, "BOTTOMLEFT", 0, -5)
    ShaguPlates.gui.reset:SetWidth(150)
    ShaguPlates.gui.reset:SetHeight(25)
    ShaguPlates.gui.reset:SetText(T["Load Defaults"])
    ShaguPlates.gui.reset:SetScript("OnClick", function()
      CreateQuestionDialog(T["Do you really want to reset |cffffaaaaEVERYTHING|r?"],
        function()
          _G["ShaguPlates_init"] = {}
          _G["ShaguPlates_config"] = {}
          _G["ShaguPlates_playerDB"] = {}
          _G["ShaguPlates_profiles"] = {}
          _G["ShaguPlates_cache"] = {}
          ShaguPlates:LoadConfig()
          this:GetParent():Hide()
          ShaguPlates.gui:Reload()
        end)
    end)
    SkinButton(ShaguPlates.gui.reset)

    -- save
    ShaguPlates.gui.save = CreateFrame("Button", nil, ShaguPlates.gui)
    ShaguPlates.gui.save:SetPoint("TOPRIGHT", ShaguPlates.gui.frames.area.backdrop, "BOTTOMRIGHT", 0, -5)
    ShaguPlates.gui.save:SetWidth(150)
    ShaguPlates.gui.save:SetHeight(25)
    ShaguPlates.gui.save:SetText(T["Save & Reload"])
    ShaguPlates.gui.save:SetScript("OnClick", function()
      ShaguPlates.gui:Hide()
    end)
    SkinButton(ShaguPlates.gui.save)
  end

  do -- DropDown Menus
    -- [[ Static Dropdowns ]] --
    ShaguPlates.gui.dropdowns = {
      ["languages"] = {
        -- "deDE:German",
        -- "enGB:British English",
        "enUS:English",
        "esES:Spanish",
        --"esMX:Spanish (Latin American)",
        "frFR:French",
        "koKR:Korean",
        "ruRU:Russian",
        "zhCN:Chinese (simplified; China)",
        "zhTW:Chinese (traditional; Taiwan)",
        -- http://wowprogramming.com/docs/api/GetLocale
      },
      ["fonts"] = {
        "Interface\\AddOns\\tDF\\fonts\\BigNoodleTitling.ttf:BigNoodleTitling",
        "Interface\\AddOns\\tDF\\fonts\\Continuum.ttf:Continuum",
        "Interface\\AddOns\\tDF\\fonts\\DieDieDie.ttf:DieDieDie",
        "Interface\\AddOns\\tDF\\fonts\\Expressway.ttf:Expressway",
        "Interface\\AddOns\\tDF\\fonts\\Homespun.ttf:Homespun",
        "Interface\\AddOns\\tDF\\fonts\\Hooge.ttf:Hooge",
        "Interface\\AddOns\\tDF\\fonts\\Myriad-Pro.ttf:Myriad-Pro",
        "Interface\\AddOns\\tDF\\fonts\\PT-Sans-Narrow-Bold.ttf:PT-Sans-Narrow-Bold",
        "Interface\\AddOns\\tDF\\fonts\\PT-Sans-Narrow-Regular.ttf:PT-Sans-Narrow-Regular"
      },
      ["border"] = {
        "-1:" .. T["Default"],
        "0:" .. T["None"],
        "1:1 " .. T["Pixel"],
        "2:2 " .. T["Pixel"],
        "3:3 " .. T["Pixel"],
        "4:4 " .. T["Pixel"],
        "5:5 " .. T["Pixel"],
      },
      ["fontstyle"] = {
        "NONE:" .. T["None"],
        "OUTLINE:" .. T["Outline"],
        "THICKOUTLINE:" .. T["Thick Outline"],
        "MONOCHROME:" .. T["Monochrome"],
      },
      ["spacing"] = {
        "0:0" .. T["None"],
        "1:1 " .. T["Pixel"],
        "2:2 " .. T["Pixel"],
        "3:3 " .. T["Pixel"],
        "4:4 " .. T["Pixel"],
        "5:5 " .. T["Pixel"],
        "6:6 " .. T["Pixel"],
        "7:7 " .. T["Pixel"],
        "8:8 " .. T["Pixel"],
        "9:9 " .. T["Pixel"],
      },
      ["scaling"] = {
        "0:" .. T["Off"],
        "4:" .. T["Huge (PixelPerfect)"],
        "5:" .. T["Large"],
        "6:" .. T["Medium"],
        "7:" .. T["Small"],
        "8:" .. T["Tiny (PixelPerfect)"],
      },
      ["orientation"] = {
        "HORIZONTAL:" .. T["Horizontal"],
        "VERTICAL:" .. T["Vertical"],
      },
      ["uf_animationspeed"] = {
        "1:" .. T["Instant"],
        "2:" .. T["Very Fast"],
        "3:" .. T["Fast"],
        "5:" .. T["Medium"],
        "8:" .. T["Slow"],
        "13:" .. T["Very Slow"],
      },
      ["xpanchors"] = {
        "__NONONIL__:" .. T["No Anchor"],
        "pfChatLeft:" .. T["Left Chat Frame"],
        "pfChatRight:" .. T["Right Chat Frame"],
        "pfActionBarMain:" .. T["Main Actionbar"],
        "pfActionBarTop:" .. T["Top Actionbar"],
        "pfActionBarLeft:" .. T["Left Actionbar"],
        "pfActionBarRight:" .. T["Right Actionbar"],
        "pfActionBarVertical:" .. T["Vertical Actionbar"],
        "pfExperienceBar:" .. T["Experience Bar"],
        "pfReputationBar:" .. T["Reputation Bar"],
        "pfPlayer:" .. T["Player Unitframe"],
        "pfMinimap:" .. T["Minimap"],
        "pfPanelMinimap:" .. T["Minimap Panel"],
      },
      ["uf_bartexture"] = {
        "Interface\\AddOns\\tDF\\img\\bar:ShaguPlates",
        "Interface\\AddOns\\tDF\\img\\bar_tukui:TukUI",
        "Interface\\AddOns\\tDF\\img\\bar_elvui:ElvUI",
        "Interface\\AddOns\\tDF\\img\\bar_gradient:Gradient",
        "Interface\\AddOns\\tDF\\img\\bar_striped:Striped",
        "Interface\\TargetingFrame\\UI-StatusBar:Wow Status",
        "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar:Wow Skill"
      },
      ["uf_rangecheckinterval"] = {
        "1:" .. T["Very Fast"],
        "2:" .. T["Fast"],
        "4:" .. T["Medium"],
        "8:" .. T["Slow"],
        "16:" .. T["Very Slow"],
      },
      ["uf_raidlayout"] = {
        "1x40:" .. "1x40",
        "2x20:" .. "2x20",
        "4x10:" .. "4x10",
        "5x8:" ..  "5x8",
        "8x5:" ..  "8x5",
        "10x4:" .. "10x4",
        "20x2:" .. "20x2",
        "40x1:" .. "40x1",
      },
      ["uf_powerbar_position"] = {
        "TOPLEFT:" .. T["Left"],
        "TOP:" .. T["Center"],
        "TOPRIGHT:" .. T["Right"]
      },
      ["uf_portrait_position"] = {
        "bar:" .. T["Healthbar Embedded"],
        "left:" .. T["Left"],
        "right:" .. T["Right"],
        "off:" .. T["Disabled"]
      },
      ["uf_buff_position"] = {
        "TOPLEFT:" .. T["Top Left"],
        "TOPRIGHT:" .. T["Top Right"],
        "BOTTOMLEFT:" .. T["Bottom Left"],
        "BOTTOMRIGHT:" .. T["Bottom Right"],
        "off:" .. T["Disabled"]
      },
      ["uf_debuff_indicator"] = {
        "0:" .. T["Disabled"],
        "1:" .. T["Legacy"],
        "2:" .. T["Glow"],
        "3:" .. T["Square"],
        "4:" .. T["Icon"]
      },
      ["uf_debuff_indicator_size"] = {
        ".10:10%",
        ".25:25%",
        ".35:35%",
        ".50:50%",
        ".65:65%",
        ".75:75%",
        ".90:90%",
      },
      ["percent_small"] = {
        "0:0%",
        ".05:5%",
        ".10:10%",
        ".15:15%",
        ".20:20%",
        ".25:25%",
        ".30:30%",
        ".35:35%",
        ".40:40%",
        ".45:45%",
        ".50:50%",
        ".55:55%",
        ".60:60%",
        ".65:65%",
        ".70:70%",
        ".75:75%",
        ".80:80%",
        ".85:85%",
        ".90:90%",
        ".95:95%",
        "1:100%",
      },
      ["uf_overheal"] = {
        "0:0%",
        "10:10%",
        "20:20%",
        "30:30%",
        "40:40%",
        "50:50%",
        "60:60%",
        "70:70%",
        "80:80%",
        "90:90%",
        "100:100%",
      },
      ["uf_layout"] = {
        "default:" .. T["Default"],
        "tukui:TukUI"
      },
      ["uf_color"] = {
        "0:" .. T["Class"],
        "1:" .. T["Custom"],
        "2:" .. T["Health"],
      },
      ["uf_texts"] = {
        "none:" .. T["Disable"],
        "unit:" .. T["Unit String"],
        "name:" .. T["Name"],
        "nameshort:" .. T["Name (Short)"],
        "level:" .. T["Level"],
        "class:" .. T["Class"],
        "namehealth:" .. T["Name | Health Missing"],
        "shortnamehealth:" .. T["Name (Short) | Health Missing"],
        "healthdyn:" .. T["Health - Auto"],
        "health:" .. T["Health - Current"],
        "healthmax:" .. T["Health - Max"],
        "healthperc:" .. T["Health - Percentage"],
        "healthmiss:" .. T["Health - Missing"],
        "healthminmax:" .. T["Health - Min/Max"],
        "powerdyn:" .. T["Mana - Auto"],
        "power:" .. T["Mana - Current"],
        "powermax:" .. T["Mana - Max"],
        "powerperc:" .. T["Mana - Percentage"],
        "powermiss:" .. T["Mana - Missing"],
        "powerminmax:" .. T["Mana - Min/Max"],
      },
      ["hpformat"] = {
        "percent:" .. T["Percent"],
        "cur:" .. T["Current HP"],
        "curperc:" .. T["Current HP | Percent"],
        "curmax:" .. T["Current HP - Max HP"],
        "curmaxs:" .. T["Current HP / Max HP"],
        "curmaxperc:" .. T["Current HP - Max HP | Percent"],
        "curmaxpercs:" .. T["Current HP / Max HP | Percent"],
        "deficit:" .. T["Deficit"],
      },
      ["panel_values"] = {
        "none:" .. T["Disable"],
        "time:" .. T["Clock"],
        "fps:" .. T["FPS & Ping"],
        "exp:" .. T["XP Percentage"],
        "gold:" .. T["Gold"],
        "friends:" .. T["Friends Online"],
        "guild:" .. T["Guild Online"],
        "durability:" .. T["Item Durability"],
        "zone:" .. T["Zone Name"],
        "combat:" .. T["Combat Timer"],
        "ammo:" .. T["Ammo Counter"],
        "soulshard:" .. T["Soulshard Counter"],
        "bagspace:" .. T["Bagspace"]
      },
      ["tooltip_position"] = {
        "bottom:" .. T["Bottom"],
        "chat:" .. T["Dodge"],
        "cursor:" .. T["Cursor"],
        "free:" .. T["Custom"]
      },
      ["tooltip_align"] = {
        "native:" .. T["Native"],
        "top:" .. T["Top"],
        "left:" .. T["Left"],
        "right:" .. T["Right"]
      },
      ["debuffposition"] = {
        "TOP:" .. T["Top"],
        "BOTTOM:" .. T["Bottom"],
      },
      ["gmserver_text"] = {
        "elysium:" .. T["Elysium Based Core"],
      },
      ["buffbarfilter"] = {
        "none:"      .. T["None"],
        "whitelist:" .. T["Whitelist"],
        "blacklist:" .. T["Blacklist"],
      },
      ["buffbarsort"] = {
        "asc:" .. T["Ascending"],
        "desc:" .. T["Descending"],
      },
      ["minimap_cords_position"] = {
        "topleft:" .. T["Top Left"],
        "topright:" .. T["Top Right"],
        "bottomleft:" .. T["Bottom Left"],
        "bottomright:" .. T["Bottom Right"],
        "off:" .. T["Disabled"]
      },
      ["positions"] = {
        "TOPLEFT:" .. T["Top Left"],
        "TOP:" .. T["Top"],
        "TOPRIGHT:" .. T["Top Right"],
        "LEFT:" .. T["Left"],
        "CENTER:" .. T["Center"],
        "RIGHT:" .. T["Right"],
        "BOTTOMLEFT:" .. T["Bottom Left"],
        "BOTTOM:" .. T["Bottom"],
        "BOTTOMRIGHT:" .. T["Bottom Right"],
      },
      ["actionbuttonanimations"] = {
        "none:" .. T["None"],
        "zoomfade:" .. T["Zoom & Fade"],
        "shrinkreturn:" .. T["Shrink & Return"],
        "elasticzoom:" .. T["Elastic Zoom"],
        "wobblezoom:" .. T["Wobble Zoom"],
      },
      ["animationmode"] = {
        "keypress:" .. T["On Key Press"],
        "statechange:" .. T["On State Change"]
      },
      ["actionbarbuttons"] = {
        "1","2","3","4","5","6","7","8","9","10","11","12"
      },
      ["addonbuttons_position"] = {
        "bottom:" .. T["Bottom"],
        "left:" .. T["Left"],
        "top:" .. T["Top"],
        "right:" .. T["Right"]
      },
      ["xp_position"] = {
        "BOTTOM:" .. T["Bottom"],
        "LEFT:" .. T["Left"],
        "TOP:" .. T["Top"],
        "RIGHT:" .. T["Right"]
      },
      ["textalign"] = {
        "LEFT:" .. T["Left"],
        "CENTER:" .. T["Center"],
        "RIGHT:" .. T["Right"],
      },
    }

    -- add locale dependent client fonts to the list
    if GetLocale() == "enUS" or GetLocale() == "frFR" or GetLocale() == "deDE" or GetLocale() == "ruRU" then
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\ARIALN.TTF:ARIALN")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\FRIZQT__.TTF:FRIZQT")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\MORPHEUS.TTF:MORPHEUS")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\SKURRI.TTF:SKURRI")
    elseif GetLocale() == "koKR" then
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\2002.TTF:2002")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\2002B.TTF:2002B")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\ARIALN.TTF:ARIALN")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\FRIZQT__.TTF:FRIZQT")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\K_Damage.TTF:K_Damage")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\K_Pagetext.TTF:K_Pagetext")
    elseif GetLocale() == "zhCN" then
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\ARIALN.TTF:ARIALN")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\FRIZQT__.TTF:FRIZQT")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\FZBWJW.TTF:FZBWJW")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\FZJZJW.TTF:FZJZJW")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\FZLBJW.TTF:FZLBJW")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\FZXHJW.TTF:FZXHJW")
      table.insert(ShaguPlates.gui.dropdowns.fonts, "Fonts\\FZXHLJW.TTF:FZXHLJW")
    end

    ShaguPlates.gui.dropdowns.loot_rarity = {}
    for i=0, getn(_G.ITEM_QUALITY_COLORS)-2  do
      local entry = string.format("%d:%s", i, string.format("%s%s%s", _G.ITEM_QUALITY_COLORS[i].hex, _G[string.format("ITEM_QUALITY%d_DESC",i)], FONT_COLOR_CODE_CLOSE))
      table.insert(ShaguPlates.gui.dropdowns.loot_rarity, entry)
    end

    ShaguPlates.gui.dropdowns.screenshot_battle = {
      "0:".._G.NONE,
      "1:"..T["Won"],
      "2:"..T["Ended"],
    }
    ShaguPlates.gui.dropdowns.screenshot_loot = {"0:".._G.NONE}
    for i=3, 5 do
      local entry = string.format("%d:%s", i, string.format("%s%s%s", _G.ITEM_QUALITY_COLORS[i].hex, _G[string.format("ITEM_QUALITY%d_DESC",i)], FONT_COLOR_CODE_CLOSE))
        table.insert(ShaguPlates.gui.dropdowns.screenshot_loot, entry)
    end
  end

  do -- Generate Config UI
    CreateGUIEntry(T["Nameplates"], nil, function()
      CreateConfig(nil, T["Use Blizzard Borders"], C.appearance.border, "force_blizz", "checkbox")
      CreateConfig(nil, T["Standard Text Font"], C.global, "font_unit", "dropdown", ShaguPlates.gui.dropdowns.fonts)
      CreateConfig(nil, T["Standard Text Font Size"], C.global, "font_unit_size")
      CreateConfig(nil, T["Menu Font"], C.global, "font_default", "dropdown", ShaguPlates.gui.dropdowns.fonts)
      CreateConfig(nil, T["Menu Font Size"], C.global, "font_size")
      CreateConfig(U["nameplates"], T["Font Style"], C.nameplates.name, "fontstyle", "dropdown", ShaguPlates.gui.dropdowns.fontstyle)
      CreateConfig(nil, T["Background Color"], C.appearance.border, "background", "color")
      CreateConfig(nil, T["Border Color"], C.appearance.border, "color", "color")
      CreateConfig(U["nameplates"], T["Border Size"], C.appearance.border, "nameplates", "dropdown", ShaguPlates.gui.dropdowns.border)
      CreateConfig(nil, T["Enable Pixel Perfect Borders"], C.appearance.border, "pixelperfect", "checkbox")
      CreateConfig(nil, T["Scale Border On HiDPI Displays"], C.appearance.border, "hidpi", "checkbox")

      CreateConfig(nil, T["Look & Feel"], nil, nil, "header")
      CreateConfig(U["nameplates"], T["Show On Hostile Units"], C.nameplates, "showhostile", "checkbox")
      CreateConfig(U["nameplates"], T["Show On Friendly Units"], C.nameplates, "showfriendly", "checkbox")
      CreateConfig(U["nameplates"], T["Draw Glow Around Target Nameplate"], C.nameplates, "targetglow", "checkbox")
      CreateConfig(U["nameplates"], T["Glow Color Around Target Nameplate"], C.nameplates, "glowcolor", "color")
      CreateConfig(U["nameplates"], T["Zoom Target Nameplate"], C.nameplates, "targetzoom", "checkbox")
      CreateConfig(U["nameplates"], T["Target Nameplate Zoom Factor"], C.nameplates, "targetzoomval", "dropdown", ShaguPlates.gui.dropdowns.percent_small)
      CreateConfig(U["nameplates"], T["Inactive Nameplate Alpha"], C.nameplates, "notargalpha","dropdown", ShaguPlates.gui.dropdowns.percent_small)
      CreateConfig(U["nameplates"], T["Nameplate Width"], C.nameplates, "width")
      CreateConfig(U["nameplates"], T["Enable Class Colors On Enemies"], C.nameplates, "enemyclassc", "checkbox")
      CreateConfig(U["nameplates"], T["Enable Class Colors On Friends"], C.nameplates, "friendclassc", "checkbox")
      CreateConfig(U["nameplates"], T["Enable Combo Point Display"], C.nameplates, "cpdisplay", "checkbox")
      CreateConfig(U["nameplates"], T["Enable Clickthrough"], C.nameplates, "clickthrough", "checkbox", nil, nil, nil, nil, "vanilla")
      CreateConfig(U["nameplates"], T["Enable Overlap"], C.nameplates, "overlap", "checkbox", nil, nil, nil, nil, "vanilla")
      CreateConfig(U["nameplates"], T["Enable Mouselook With Right Click"], C.nameplates, "rightclick", "checkbox", nil, nil, nil, nil, "vanilla")
      CreateConfig(U["nameplates"], T["Right Click Auto Attack Threshold"], C.nameplates, "clickthreshold", nil, nil, nil, nil, nil, "vanilla")
      CreateConfig(U["nameplates"], T["Replace Totems With Icons"], C.nameplates, "totemicons", "checkbox")

      CreateConfig(nil, T["Raid Icon"], nil, nil, "header")
      CreateConfig(U["nameplates"], T["Raid Icon Position"], C.nameplates, "raidiconpos", "dropdown", ShaguPlates.gui.dropdowns.positions)
      CreateConfig(U["nameplates"], T["Raid Icon X-Offset"], C.nameplates, "raidiconoffx")
      CreateConfig(U["nameplates"], T["Raid Icon Y-Offset"], C.nameplates, "raidiconoffy")
      CreateConfig(U["nameplates"], T["Raid Icon Size"], C.nameplates, "raidiconsize")

      CreateConfig(nil, T["Castbar"], nil, nil, "header")
      CreateConfig(U["nameplates"], T["Enable Castbars"], C.nameplates, "showcastbar", "checkbox")
      CreateConfig(U["nameplates"], T["Only Show Target Castbar"], C.nameplates, "targetcastbar", "checkbox")
      CreateConfig(U["nameplates"], T["Enable Spellname"], C.nameplates, "spellname", "checkbox")
      CreateConfig(U["nameplates"], T["Castbar Height"], C.nameplates, "heightcast")

      CreateConfig(nil, T["Debuffs"], nil, nil, "header")
      CreateConfig(U["nameplates"], T["Enable Debuffs"], C.nameplates, "showdebuffs", "checkbox")
      CreateConfig(U["nameplates"], T["Debuff Position"], C.nameplates.debuffs, "position", "dropdown", ShaguPlates.gui.dropdowns.debuffposition)
      CreateConfig(U["nameplates"], T["Estimate Debuffs"], C.nameplates, "guessdebuffs", "checkbox")
      CreateConfig(U["nameplates"], T["Debuff Icon Size"], C.nameplates, "debuffsize")
      CreateConfig(U["nameplates"], T["Show Debuff Stacks"], C.nameplates.debuffs, "showstacks", "checkbox")
      CreateConfig(U["nameplates"], T["Filter Mode"], C.nameplates.debuffs, "filter", "dropdown", ShaguPlates.gui.dropdowns.buffbarfilter)
      CreateConfig(U["nameplates"], T["Blacklist"], C.nameplates.debuffs, "blacklist", "list")
      CreateConfig(U["nameplates"], T["Whitelist"], C.nameplates.debuffs, "whitelist", "list")

      CreateConfig(nil, T["Outlines"], nil, nil, "header")
      CreateConfig(U["nameplates"], T["Blue Border On Friendly Players"], C.nameplates, "outfriendly", "checkbox")
      CreateConfig(U["nameplates"], T["Green Border On Friendly NPCs"], C.nameplates, "outfriendlynpc", "checkbox")
      CreateConfig(U["nameplates"], T["Yellow Border On Neutral Units"], C.nameplates, "outneutral", "checkbox")
      CreateConfig(U["nameplates"], T["Red Border On Enemy Units"], C.nameplates, "outenemy", "checkbox")
      CreateConfig(U["nameplates"], T["Border Around Target Unit"], C.nameplates, "targethighlight", "checkbox")
      CreateConfig(U["nameplates"], T["Border Color Around Target Unit"], C.nameplates, "highlightcolor", "color")

      CreateConfig(nil, T["Healthbar"], nil, nil, "header")
      CreateConfig(U["nameplates"], T["Healthbar Vertical Offset"], C.nameplates.health, "offset")
      CreateConfig(U["nameplates"], T["Healthbar Height"], C.nameplates, "heighthealth")
      CreateConfig(U["nameplates"], T["Healthbar Texture"], C.nameplates, "healthtexture", "dropdown", ShaguPlates.gui.dropdowns.uf_bartexture)
      CreateConfig(U["nameplates"], T["Show Health Points"], C.nameplates, "showhp", "checkbox")
      CreateConfig(U["nameplates"], T["Health Text Position"], C.nameplates, "hptextpos", "dropdown", ShaguPlates.gui.dropdowns.textalign)
      CreateConfig(U["nameplates"], T["Health Text Format"], C.nameplates, "hptextformat", "dropdown", ShaguPlates.gui.dropdowns.hpformat)
      CreateConfig(U["nameplates"], T["Hide Healthbar On Enemy NPCs"], C.nameplates, "enemynpc", "checkbox")
      CreateConfig(U["nameplates"], T["Hide Healthbar On Enemy Players"], C.nameplates, "enemyplayer", "checkbox")
      CreateConfig(U["nameplates"], T["Hide Healthbar On Neutral NPCs"], C.nameplates, "neutralnpc", "checkbox")
      CreateConfig(U["nameplates"], T["Hide Healthbar On Friendly NPCs"], C.nameplates, "friendlynpc", "checkbox")
      CreateConfig(U["nameplates"], T["Hide Healthbar On Friendly Players"], C.nameplates, "friendlyplayer", "checkbox")
      CreateConfig(U["nameplates"], T["Hide Healthbar On Critters"], C.nameplates, "critters", "checkbox")
      CreateConfig(U["nameplates"], T["Hide Healthbar On Totems"], C.nameplates, "totems", "checkbox")
      CreateConfig(U["nameplates"], T["Always Show On Units With Missing HP"], C.nameplates, "fullhealth", "checkbox")
      CreateConfig(U["nameplates"], T["Always Show On Target Units"], C.nameplates, "target", "checkbox")

      CreateConfig(nil, T["Health Point Estimation"], nil, nil, "header")
      CreateConfig(nil, T["Estimate Enemy Health Points"], C.global, "libhealth", "checkbox")
      CreateConfig(nil, T["Threshold To Trust Health Estimation"], C.global, "libhealth_hit", "dropdown", ShaguPlates.gui.dropdowns.uf_rangecheckinterval)
      CreateConfig(nil, T["Required Damage In Percent"], C.global, "libhealth_dmg", "dropdown", ShaguPlates.gui.dropdowns.percent_small)
      CreateConfig(nil, T["Abbreviate Numbers (4200 -> 4.2k)"], C.unitframes, "abbrevnum", "checkbox")

      CreateConfig(nil, T["Cooldown / Durations"], nil, nil, "header")
      CreateConfig(U["nameplates"], T["Show Milliseconds When Timer Runs Out"], C.appearance.cd, "milliseconds", "checkbox")
      CreateConfig(nil, T["Cooldown Color (Less than 3 Sec)"], C.appearance.cd, "lowcolor", "color")
      CreateConfig(nil, T["Cooldown Color (Seconds)"], C.appearance.cd, "normalcolor", "color")
      CreateConfig(nil, T["Cooldown Color (Minutes)"], C.appearance.cd, "minutecolor", "color")
      CreateConfig(nil, T["Cooldown Color (Hours)"], C.appearance.cd, "hourcolor", "color")
      CreateConfig(nil, T["Cooldown Color (Days)"], C.appearance.cd, "daycolor", "color")
      CreateConfig(nil, T["Cooldown Text Threshold"], C.appearance.cd, "threshold")
      CreateConfig(nil, T["Cooldown Text Font Size"], C.appearance.cd, "font_size")
      CreateConfig(nil, T["Cooldown Text Font Size (Blizzard Frames)"], C.appearance.cd, "font_size_blizz")
      CreateConfig(nil, T["Cooldown Text Font Size (Foreign Frames)"], C.appearance.cd, "font_size_foreign")
      CreateConfig(nil, T["Display Debuff Durations"], C.appearance.cd, "debuffs", "checkbox")
      CreateConfig(nil, T["Enable Durations On Blizzard Frames"], C.appearance.cd, "blizzard", "checkbox")
      CreateConfig(nil, T["Enable Durations On Foreign Frames"], C.appearance.cd, "foreign", "checkbox")
      CreateConfig(nil, T["Hide Foreign Cooldown Animations"], C.appearance.cd, "hideanim", "checkbox")
      CreateConfig(nil, T["Use Dynamic Font Size"], C.appearance.cd, "dynamicsize", "checkbox")

      CreateConfig(nil, T["Regional Settings"], nil, nil, "header")
      CreateConfig(nil, T["Language"], C.global, "language", "dropdown", ShaguPlates.gui.dropdowns.languages)
      CreateConfig(nil, T["Enable Region Compatible Font"], C.global, "force_region", "checkbox")

      CreateConfig(nil, T["Config UI Settings"], nil, nil, "header")
      CreateConfig(nil, T["Highlight Settings That Require Reload"], C.gui, "reloadmarker", "checkbox")
      CreateConfig(nil, T["Show Incompatible Config Entries"], C.gui, "showdisabled", "checkbox")
    end)
  end
end)
