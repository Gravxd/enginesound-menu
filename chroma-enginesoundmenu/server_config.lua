Config = {
    CheckForUpdates = true, -- will check github for updates (recommended)
    HasPermission = function(src)
        -- your permission function here - you can integrate your framework for jobs/perms etc
        return IsPlayerAceAllowed(src, 'enginesoundmenu')
    end,
    Notify = function(src, msg, type)
        -- you can edit this to whatever you want, by default it uses ox_lib notifications
        TriggerClientEvent("ox_lib:notify", src, {
            description = msg,
            title = 'chroma-enginesoundmenu',
            type = type,
            position = 'center-right',
        })
    end,
}