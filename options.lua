-- parent
-- append to target
-- borders
-- colors
    RegisterCVar('width', 200)
    RegisterCVar('height', 10)
    RegisterCVar('x', 0)
    RegisterCVar('y', 0)
    -- RegisterCVar('border', nil)
    -- RegisterCVar('color', nil)

    local menu = CreateFrame('Frame', 'SUCC_ecbOptions', UIParent)
    menu:SetWidth(260) menu:SetHeight(220)
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
    menu:SetScript('OnDragStop', function() menu:StopMovingOrSizing() end)
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
        if this:GetName() == 'width' then
            SUCC_ecb:SetWidth(this:GetValue())
            SetCVar('width', this:GetValue())
        else
            SUCC_ecb:SetHeight(this:GetValue())
            SetCVar('height', this:GetValue())
        end
    end

    local setCoord = function()
        if this:GetName() == 'xCoord' then
            SetCVar('x', this:GetNumber())
            SUCC_ecb:SetPoint('CENTER', this:GetNumber(), tonumber(GetCVar('y')))
        else
            SetCVar('y', this:GetNumber())
            SUCC_ecb:SetPoint('CENTER', tonumber(GetCVar('x')), this:GetNumber())
        end
        this:ClearFocus()
    end

    menu.width = CreateFrame('Slider', 'width', menu, 'OptionsSliderTemplate')
    menu.width:SetWidth(200)
    menu.width:SetHeight(20)
    menu.width:SetPoint('TOP', menu, 0, -45)
    menu.width:SetMinMaxValues(20, 300)
    menu.width:SetValue(GetCVar('width') or 200)
    menu.width:SetValueStep(1)
    menu.width:SetScript('OnValueChanged', dimensions)
    getglobal(menu.width:GetName()..'Low'):SetText'20'
    getglobal(menu.width:GetName()..'High'):SetText'300'
    getglobal(menu.width:GetName()..'Text'):SetText'Change the width of the castbar'

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

    menu.xLabel = menu:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.xLabel:SetPoint('TOPLEFT', menu.height, 'BOTTOMLEFT', 0, -25)
    menu.xLabel:SetWidth(15)
    menu.xLabel:SetText('X:')

    menu.xCoord = CreateFrame('EditBox', 'xCoord', menu, 'InputBoxTemplate')
    menu.xCoord:SetWidth(75)
    menu.xCoord:SetHeight(10)
    menu.xCoord:SetPoint('LEFT', menu.xLabel, 'RIGHT', 5, 0)
    menu.xCoord:SetAutoFocus(false)
    menu.xCoord:SetScript('OnEnterPressed', setCoord)

    menu.yCoord = CreateFrame('EditBox', 'yCoord', menu, 'InputBoxTemplate')
    menu.yCoord:SetWidth(75)
    menu.yCoord:SetHeight(10)
    menu.yCoord:SetPoint('TOPRIGHT', menu.height, 'BOTTOMRIGHT', 0, -25)
    menu.yCoord:SetAutoFocus(false)
    menu.yCoord:SetScript('OnEnterPressed', setCoord)

    menu.yLabel = menu:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.yLabel:SetPoint('RIGHT', menu.yCoord, 'LEFT', -5, 0)
    menu.yLabel:SetWidth(15)
    menu.yLabel:SetText('Y:')

    SLASH_SUCC_ECB1 = '/succecb'
    SlashCmdList['SUCC_ECB'] = function(arg)
        if menu:IsShown() then menu:Hide() else menu:Show() end
    end