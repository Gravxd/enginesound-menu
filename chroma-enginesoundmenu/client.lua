local DisplayLabels = {}
for k, v in pairs(Config.EngineSounds) do
    DisplayLabels[#DisplayLabels + 1] = k
end

local function Notify(msg, type)
    -- you can edit this to whatever you want, by default it uses ox_lib notifications
    lib.notify({
        title = 'chroma-enginesoundmenu',
        description = msg,
        type = type,
        position = 'center-right',
    })
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