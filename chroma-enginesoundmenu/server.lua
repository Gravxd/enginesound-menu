local function HasPermission(src)
    -- your permission function here - you can integrate your framework for jobs/perms etc
    return IsPlayerAceAllowed(src, 'enginesoundmenu')
end

RegisterCommand("enginesound", function(source, args, rawCommand)
    if HasPermission(source) then
        TriggerClientEvent("Chroma:EngineSounds:OpenMenu", source)
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0 },
            multiline = true,
            args = { "[ERROR]", "You don't have permission to use this command." } -- updated to let the player know they dont have permission
        })
    end
end, false)

RegisterServerEvent("Chroma:EngineSounds:ChangeEngineSound", function(data)

    local entity = NetworkGetEntityFromNetworkId(data.net)
    if not DoesEntityExist(entity) then return end

    Entity(entity).state['vehdata:sound'] = data.sound

end)
