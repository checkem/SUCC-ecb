-- parent
-- append to target
-- borders
-- colors

    local menu = CreateFrame('Frame', 'SUCC_ecbOptions', UIParent)
    menu:SetWidth(270) menu:SetHeight(300)
    menu:SetPoint('CENTER', UIParent)
    menu:SetBackdrop({bgFile   = [[Interface\Tooltips\UI-Tooltip-Background]],
                      edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
    				  insets   = {left = 11, right = 12, top = 12, bottom = 11}})
    menu:SetBackdropColor(0, 0, 0, .7)
    menu:SetBackdropBorderColor(1, 1, 1)
    menu:SetMovable(true)
    menu:RegisterForDrag'LeftButton'
    menu:EnableMouse(true)
    menu:SetScript('OnDragStart', function() menu:StartMoving() end)
    menu:SetScript('OnDragStop', function() menu:StopMovingOrSizing() menu:SetUserPlaced(false) end)
    menu:Hide()

    menu.header = menu:CreateTexture(nil, 'ARTWORK')
    menu.header:SetWidth(256) menu.header:SetHeight(64)
    menu.header:SetPoint('TOP', menu, 0, 12)
    menu.header:SetTexture[[Interface\DialogFrame\UI-DialogBox-Header]]
    menu.header:SetVertexColor(1, 1, 1)
    menu.header.t = menu:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    menu.header.t:SetPoint('TOP', menu.header, 0, -14)
    menu.header.t:SetText'SUCC-ecb options'

    menu.close = CreateFrame('Button', nil, menu, 'UIPanelButtonTemplate')
    menu.close:SetWidth(100) menu.close:SetHeight(25)
    menu.close:SetText'Close'
    menu.close:SetPoint('BOTTOM', menu, 0, 20)
    menu.close:SetScript('OnClick', function() menu:Hide() end)

    local dimensions = function()
        local dim, nam = this:GetValue(), this:GetName()
        if nam == 'width' then
            SUCC_ecb:SetWidth(dim)
            SetCVar('width', dim)
            menu.wLabel:SetText(dim)
        elseif nam == 'height' then
            SUCC_ecb:SetHeight(dim)
            SetCVar('height', dim)
            menu.hLabel:SetText(dim)
        elseif nam == 'iconPos' then
            TargetFrame.cast.icon:ClearAllPoints()
            SetCVar('iconPos', dim)
            if dim == 0 then
                TargetFrame.cast.icon:SetPoint('RIGHT', TargetFrame.cast, 'LEFT', -8, 0)
            else
                TargetFrame.cast.icon:SetPoint('LEFT', TargetFrame.cast, 'RIGHT', 8, 0)
            end
        elseif nam == 'namePos' then
            TargetFrame.cast.text:ClearAllPoints()
            SetCVar('namePos', dim)
            if dim == 0 then
                TargetFrame.cast.text:SetPoint('TOPLEFT', TargetFrame.cast, 'BOTTOMLEFT', 2, -5)
            elseif dim == 1 then
                TargetFrame.cast.text:SetPoint('LEFT', TargetFrame.cast, 2, 0)
            else
                TargetFrame.cast.text:SetPoint('BOTTOMLEFT', TargetFrame.cast, 'TOPLEFT', 2, 5)
            end
        else
            TargetFrame.cast.timer:ClearAllPoints()
            SetCVar('timePos', dim)
            if dim == 0 then
                TargetFrame.cast.timer:SetPoint('TOPRIGHT', TargetFrame.cast, 'BOTTOMRIGHT', -1, -5)
            elseif dim == 1 then
                TargetFrame.cast.timer:SetPoint('RIGHT', TargetFrame.cast, -1, 1)
            else
                TargetFrame.cast.timer:SetPoint('BOTTOMRIGHT', TargetFrame.cast, 'TOPRIGHT', -1, 5)
            end
        end
    end

    local setCoord = function()
        SUCC_ecb:ClearAllPoints()
        local crd = this:GetNumber()
        if this:GetName() == 'xCoord' then
            SetCVar('x', crd)
            SUCC_ecb:SetPoint('CENTER', crd, tonumber(GetCVar('y')))
        else
            SetCVar('y', crd)
            SUCC_ecb:SetPoint('CENTER', tonumber(GetCVar('x')), crd)
        end
        this:ClearFocus()
    end

    local lockBar = function()
        if menu.lock:GetChecked() == 1 then
            SUCC_ecb:EnableMouse(false)
        else
            SUCC_ecb:EnableMouse(true)
        end
    end

    local toggleIcon = function()
        if menu.icon:GetChecked() == 1 then
            SetCVar('icon', 1)
            TargetFrame.cast.icon:Show()
        else
            SetCVar('icon', 0)
            TargetFrame.cast.icon:Hide()
        end
    end

    menu.width = CreateFrame('Slider', 'width', menu, 'OptionsSliderTemplate')
    menu.width:SetWidth(200)
    menu.width:SetHeight(20)
    menu.width:SetPoint('TOPLEFT', menu, 'TOPLEFT', 35, -45)
    menu.width:SetMinMaxValues(100, 400)
    menu.width:SetValue(GetCVar('width') or 200)
    menu.width:SetValueStep(1)
    menu.width:SetScript('OnValueChanged', dimensions)
    getglobal(menu.width:GetName()..'Low'):SetText'100'
    getglobal(menu.width:GetName()..'High'):SetText'400'
    getglobal(menu.width:GetName()..'Text'):SetText'Change the width of the castbar'

    menu.wLabel = menu:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.wLabel:SetPoint('TOP', menu.width, 'BOTTOM', 0, 3)
    menu.wLabel:SetTextHeight(10)
    menu.wLabel:SetWidth(60)
    menu.wLabel:SetText(GetCVar('width') or '200')

    menu.height = CreateFrame('Slider', 'height', menu, 'OptionsSliderTemplate')
    menu.height:SetWidth(200)
    menu.height:SetHeight(20)
    menu.height:SetPoint('TOP', menu.width, 0, -55)
    menu.height:SetMinMaxValues(2, 100)
    menu.height:SetValue(GetCVar('height') or 10)
    menu.height:SetValueStep(1)
    menu.height:SetScript('OnValueChanged', dimensions)
    getglobal(menu.height:GetName()..'Low'):SetText'2'
    getglobal(menu.height:GetName()..'High'):SetText'100'
    getglobal(menu.height:GetName()..'Text'):SetText'Change the height of the castbar'

    menu.hLabel = menu:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.hLabel:SetPoint('TOP', menu.height, 'BOTTOM', 0, 3)
    menu.hLabel:SetTextHeight(10)
    menu.hLabel:SetWidth(60)
    menu.hLabel:SetText(GetCVar('height') or '10')

    menu.xLabel = menu:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.xLabel:SetPoint('TOPLEFT', menu.height, 'BOTTOMLEFT', 0, -25)
    menu.xLabel:SetWidth(15)
    menu.xLabel:SetText('X:')

    menu.xCoord = CreateFrame('EditBox', 'xCoord', menu, 'InputBoxTemplate')
    menu.xCoord:SetWidth(40)
    menu.xCoord:SetHeight(10)
    menu.xCoord:SetPoint('LEFT', menu.xLabel, 'RIGHT', 5, 0)
    menu.xCoord:SetText(GetCVar('x') or '0')
    menu.xCoord:SetAutoFocus(false)
    menu.xCoord:SetScript('OnEnterPressed', setCoord)

    menu.yLabel = menu:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.yLabel:SetPoint('LEFT', menu.xCoord, 'RIGHT', 10, 0)
    menu.yLabel:SetWidth(15)
    menu.yLabel:SetText('Y:')

    menu.yCoord = CreateFrame('EditBox', 'yCoord', menu, 'InputBoxTemplate')
    menu.yCoord:SetWidth(40)
    menu.yCoord:SetHeight(10)
    menu.yCoord:SetPoint('LEFT', menu.yLabel, 'RIGHT', 5, 0)
    menu.yCoord:SetText(GetCVar('y') or '0')
    menu.yCoord:SetAutoFocus(false)
    menu.yCoord:SetScript('OnEnterPressed', setCoord)

    menu.lLabel = menu:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.lLabel:SetPoint('LEFT', menu.yCoord, 'RIGHT', 10, 0)
    menu.lLabel:SetWidth(35)
    menu.lLabel:SetText('Lock:')

    menu.lock = CreateFrame('CheckButton', 'SUCC_ecbLock', menu, 'UICheckButtonTemplate')
    menu.lock:SetHeight(25)
    menu.lock:SetWidth(25)
    menu.lock:SetPoint('LEFT', menu.lLabel, 'RIGHT', 3, 0)
    menu.lock:SetChecked()
    menu.lock:SetScript('OnClick', lockBar)

    menu.iLabel = menu:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.iLabel:SetPoint('TOPLEFT', menu.xLabel, 'BOTTOMLEFT', 0, -25)
    menu.iLabel:SetWidth(65)
    menu.iLabel:SetText('Show icon:')

    menu.icon = CreateFrame('CheckButton', 'SUCC_ecbLock', menu, 'UICheckButtonTemplate')
    menu.icon:SetHeight(25)
    menu.icon:SetWidth(25)
    menu.icon:SetPoint('LEFT', menu.iLabel, 'RIGHT', 3, 0)
    menu.icon:SetChecked(GetCVar('icon') == '1')
    menu.icon:SetScript('OnClick', toggleIcon)

    menu.iconPos = CreateFrame('Slider', 'iconPos', menu, 'OptionsSliderTemplate')
    menu.iconPos:SetWidth(104)
    menu.iconPos:SetHeight(20)
    menu.iconPos:SetPoint('LEFT', menu.icon, 'RIGHT', 3, 0)
    menu.iconPos:SetMinMaxValues(0, 1)
    menu.iconPos:SetValue(GetCVar('iconPos') or 0)
    menu.iconPos:SetValueStep(1)
    menu.iconPos:SetScript('OnValueChanged', dimensions)
    getglobal(menu.iconPos:GetName()..'Low'):SetText'left'
    getglobal(menu.iconPos:GetName()..'High'):SetText'right'
    getglobal(menu.iconPos:GetName()..'Text'):SetText'Icon Position'

    menu.namePos = CreateFrame('Slider', 'namePos', menu, 'OptionsSliderTemplate')
    menu.namePos:SetWidth(95)
    menu.namePos:SetHeight(20)
    menu.namePos:SetPoint('TOPLEFT', menu.iLabel, 'BOTTOMLEFT', 0, -25)
    menu.namePos:SetMinMaxValues(0, 2)
    menu.namePos:SetValue(GetCVar('namePos') or 0)
    menu.namePos:SetValueStep(1)
    menu.namePos:SetScript('OnValueChanged', dimensions)
    getglobal(menu.namePos:GetName()..'Low'):SetText'Bottom'
    getglobal(menu.namePos:GetName()..'High'):SetText'Top'
    getglobal(menu.namePos:GetName()..'Text'):SetText'Name position'

    menu.timePos = CreateFrame('Slider', 'timePos', menu, 'OptionsSliderTemplate')
    menu.timePos:SetWidth(95)
    menu.timePos:SetHeight(20)
    menu.timePos:SetPoint('LEFT', menu.namePos, 'RIGHT', 10, 0)
    menu.timePos:SetMinMaxValues(0, 2)
    menu.timePos:SetValue(GetCVar('timePos') or 0)
    menu.timePos:SetValueStep(1)
    menu.timePos:SetScript('OnValueChanged', dimensions)
    getglobal(menu.timePos:GetName()..'Low'):SetText'Bottom'
    getglobal(menu.timePos:GetName()..'High'):SetText'Top'
    getglobal(menu.timePos:GetName()..'Text'):SetText'Time position'

    menu:SetScript('OnHide', function() menu.lock:SetChecked(true) lockBar() end)

    SLASH_SUCC_ECB1 = '/succecb'
    SlashCmdList['SUCC_ECB'] = function(arg)
        if menu:IsShown() then menu:Hide() else menu:Show() end
    end
