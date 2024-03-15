local function HasPermission(src)
    -- your permission function here - you can integrate your framework for jobs/perms etc
    return IsPlayerAceAllowed(src, 'enginesoundmenu')
end

local function Notify(src, msg, type)
    -- you can edit this to whatever you want, by default it uses ox_lib notifications
    TriggerClientEvent("ox_lib:notify", src, {
        description = msg,
        title = 'chroma-enginesoundmenu',
        type = type,
        position = 'center-right',
    })
end

RegisterCommand("enginesound", function(source, args, rawCommand)
    if HasPermission(source) then
        TriggerClientEvent("Chroma:EngineSounds:OpenMenu", source)
    else
        Notify(source, 'You do not have permission to use this command!', 'error')
    end
end, false)

RegisterServerEvent("Chroma:EngineSounds:ChangeEngineSound", function(data)

    local entity = NetworkGetEntityFromNetworkId(data.net)
    if not DoesEntityExist(entity) then return end

    Entity(entity).state['vehdata:sound'] = data.sound

end)
