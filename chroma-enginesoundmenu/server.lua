RegisterCommand("enginesound", function(source, args, rawCommand)
    if Config.HasPermission(source) then
        TriggerClientEvent("Chroma:EngineSounds:OpenMenu", source)
    else
        Config.Notify(source, 'You do not have permission to use this command!', 'error')
    end
end, false)

RegisterServerEvent("Chroma:EngineSounds:ChangeEngineSound", function(data)

    if not Config.HasPermission(source) then
        return Config.BanPlayer(source)
    end

    local entity = NetworkGetEntityFromNetworkId(data.net)
    if not DoesEntityExist(entity) then return end
    Entity(entity).state['vehdata:sound'] = data.sound
    
end)

CreateThread(function()
    
    if Config.CheckForUpdates then

        -- https://github.com/Blumlaut/FiveM-Resource-Version-Check-Thing/
        updatePath = "/Gravxd/enginesound-menu" -- your git user/repo path
        resourceName = "^6chroma-enginesoundmenu" -- the resource name
        
        local function checkVersion(err,responseText, headers)
            curVersion = LoadResourceFile(GetCurrentResourceName(), "version.txt") -- make sure the "version" file actually exists in your resource root!
            if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
                print("\n"..resourceName.." ^1is outdated, please update it from:\n^3https://github.com/Gravxd/enginesound-menu/releases/latest\n^1For support or issues, please visit ^3https://discord.gg/chromalabs^7")
            else
                print("\n"..resourceName.." ^2is up to date, and has been loaded - enjoy!\nFor support or issues, please visit ^3https://discord.gg/chromalabs^7")
            end
        end
        
        PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/main/chroma-enginesoundmenu/version.txt", checkVersion, "GET")

    else
        print("\n^6chroma-enginesoundmenu ^2has been loaded - enjoy! ^1[VERSION CHECK DISABLED]\n^2For support or issues, please visit ^3https://discord.gg/chromalabs^7")
    end

end)
