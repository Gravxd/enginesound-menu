RegisterCommand("enginesound", function(source, args, rawCommand)
    TriggerClientEvent("Chroma:EngineSounds:OpenMenu", source)
end, true)

RegisterServerEvent("Chroma:EngineSounds:ChangeEngineSound", function(data)

    local entity = NetworkGetEntityFromNetworkId(data.net)
    if not DoesEntityExist(entity) then return end

    Entity(entity).state['enginesound'] = data.sound

end)