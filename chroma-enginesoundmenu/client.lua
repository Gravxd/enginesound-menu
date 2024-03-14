local DisplayLabels = {}
for k, v in pairs(Config.EngineSounds) do
    DisplayLabels[#DisplayLabels + 1] = k
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
    if not cache.vehicle or cache.seat ~= -1 then return end
    TriggerServerEvent('Chroma:EngineSounds:ChangeEngineSound', {
        net = VehToNet(cache.vehicle),
        sound = Config.EngineSounds[DisplayLabels[scrollIndex]]
    })
end)

RegisterNetEvent("Chroma:EngineSounds:OpenMenu", function()
    if not cache.vehicle or cache.seat ~= -1 then return end
    lib.setMenuOptions('engine_sound_menu', { label = 'Change Engine Sound', icon = 'arrows-up-down-left-right', values = DisplayLabels, defaultIndex = Index }, 1)
    lib.showMenu('engine_sound_menu')
end)

AddStateBagChangeHandler("enginesound", nil, function(bagName, key, value)
    local entity = GetEntityFromStateBagName(bagName)
    if entity == 0 then return end

    ForceUseAudioGameObject(entity, value)
end)
