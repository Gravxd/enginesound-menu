local DisplayLabels = {}
for k, v in pairs(Config.EngineSounds) do
    DisplayLabels[#DisplayLabels + 1] = k
end

local function Notify(msg, type)
    if type == 1 then 
        TriggerEvent('chat:addMessage', msg)
    elseif type == 2 then 
        exports['okokNotify']:Alert("Chroma Engine Sound Menu", msg, 4500, type)
    elseif type == 3 then 
        lib.notify({
            title = 'chroma-enginesoundmenu',
            description = msg,
            type = type,
            position = 'center-right',
        })
    elseif type == 4 then 
        load(Config.customNotif)() -- execute the string as Lua code
    else 
        TriggerEvent('chat:addMessage', msg)
    end
end


local Index = 1
lib.registerMenu({
    id = 'engine_sound_menu',
    title = 'Engine Sound Menu',
    position = 'bottom-right',
    onSideScroll = function(selected, scrollIndex, args)
        Index = scrollIndex
    end,
    options = {
        { label = 'Change Engine Sound', icon = 'arrows-up-down-left-right', values = DisplayLabels },
    }
}, function(selected, scrollIndex, args)
    if not cache.vehicle or cache.seat ~= -1 then
        return Notify('You need to be driving a vehicle to use this!', 'error') 
    end
    
    TriggerServerEvent('Chroma:EngineSounds:ChangeEngineSound', {
        net = VehToNet(cache.vehicle),
        sound = Config.EngineSounds[DisplayLabels[scrollIndex]]
    })

    Notify(string.format('Engine sound changed to: %s', DisplayLabels[scrollIndex]), 'success')

end)

RegisterNetEvent("Chroma:EngineSounds:OpenMenu", function()
    if not cache.vehicle or cache.seat ~= -1 then
        return Notify('You need to be driving a vehicle to use this!', 'error') 
    end

    lib.setMenuOptions('engine_sound_menu', { label = 'Change Engine Sound', icon = 'arrows-up-down-left-right', values = DisplayLabels, defaultIndex = Index }, 1)
    lib.showMenu('engine_sound_menu')

end)

AddStateBagChangeHandler("vehdata:sound", nil, function(bagName, key, value)
    local entity = GetEntityFromStateBagName(bagName)
    if entity == 0 then return end

    ForceUseAudioGameObject(entity, value)
end)

local keybind = lib.addKeybind({
    name = 'open_enginesound_menu',
    description = 'Open Engine Sound Menu',
    defaultKey = Config.Keybind,
    onPressed = function(self)
        ExecuteCommand('enginesound')
    end,
})

TriggerEvent('chat:addSuggestion', '/enginesound', 'Open the Engine Sound Menu!')
