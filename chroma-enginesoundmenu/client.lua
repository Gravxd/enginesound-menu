local DisplayLabels = {}
for k, _ in pairs(Config.EngineSounds) do
    DisplayLabels[#DisplayLabels + 1] = k
end

local Index = 1
local Favourites = {}

local function loadFavourites()
    local jsonFavourites = GetResourceKvpString('favouriteEngineSounds')
    if jsonFavourites then
        Favourites = json.decode(jsonFavourites)
    end
end

local function saveFavourites()
    SetResourceKvp('favouriteEngineSounds', json.encode(Favourites))
end

loadFavourites()

local function showEngineSoundMenu()
    lib.setMenuOptions('engine_sound_menu',
        {
            label = 'Change Engine Sound',
            icon = 'arrows-up-down-left-right',
            values = DisplayLabels,
            defaultIndex = Index,
            close = Config.CloseOnSelect
        },
        1)
    lib.showMenu('engine_sound_menu')
end

local function showRemoveFavouritesMenu()
    local removeOptions = {}
    for fav, _ in pairs(Favourites) do
        table.insert(removeOptions, { label = fav, icon = 'trash' })
    end

    lib.registerMenu({
        id = 'remove_favourites_menu',
        title = 'Remove from Favourites',
        position = Config.MenuPosition,
        options = removeOptions
    }, function(selected)
        local soundToRemove = removeOptions[selected].label
        Favourites[soundToRemove] = nil
        saveFavourites()
        Config.Notify('Engine sound removed from favourites!', 'success')
        if next(Favourites) == nil then
            Config.Notify('You have no more favourites!', 'info')
            showEngineSoundMenu()
        else
            showRemoveFavouritesMenu()
        end
    end)

    lib.showMenu('remove_favourites_menu')
end

local function showFavouritesMenu()
    if next(Favourites) == nil then
        Config.Notify('You don\'t have any favourites!', 'error')
        return
    end

    local favouriteOptions = {}
    for fav, _ in pairs(Favourites) do
        table.insert(favouriteOptions, { label = fav, icon = 'star' })
    end
    table.insert(favouriteOptions, { label = 'Remove from Favourites', icon = 'trash' })

    lib.registerMenu({
        id = 'favourites_menu',
        title = 'Favourites',
        position = Config.MenuPosition,
        options = favouriteOptions
    }, function(selected)
        local selectedFav = favouriteOptions[selected].label
        if selectedFav == 'Remove from Favourites' then
            showRemoveFavouritesMenu()
        else
            if not cache.vehicle or cache.seat ~= -1 then
                return Config.Notify('You need to be driving a vehicle to use this!', 'error')
            end

            TriggerServerEvent('Chroma:EngineSounds:ChangeEngineSound', {
                net = VehToNet(cache.vehicle),
                sound = Config.EngineSounds[selectedFav]
            })

            Config.Notify(string.format('Engine sound changed to: %s', selectedFav), 'success')
            if not Config.CloseOnSelect then
                lib.showMenu('favourites_menu')
            end
        end
    end)

    lib.showMenu('favourites_menu')
end

lib.registerMenu({
    id = 'engine_sound_menu',
    title = 'Engine Sound Menu',
    position = Config.MenuPosition,
    onSideScroll = function(_, scrollIndex)
        Index = scrollIndex
    end,
    options = {
        { label = 'Change Engine Sound', icon = 'arrows-up-down-left-right', values = DisplayLabels },
        { label = 'Add to Favourites', icon = 'heart' },
        { label = 'View Favourites', icon = 'star' }
    }
}, function(selected, scrollIndex)
    if selected == 1 then
        if not cache.vehicle or cache.seat ~= -1 then
            return Config.Notify('You need to be driving a vehicle to use this!', 'error')
        end

        TriggerServerEvent('Chroma:EngineSounds:ChangeEngineSound', {
            net = VehToNet(cache.vehicle),
            sound = Config.EngineSounds[DisplayLabels[scrollIndex]]
        })

        Config.Notify(string.format('Engine sound changed to: %s', DisplayLabels[scrollIndex]), 'success')
        if Config.CloseOnSelect then
            lib.hideMenu('engine_sound_menu')
        end
    elseif selected == 2 then
        local soundName = DisplayLabels[Index]
        if not Favourites[soundName] then
            Favourites[soundName] = true
            saveFavourites()
            Config.Notify('Engine sound added to favourites!', 'success')
        else
            Config.Notify('This engine sound is already in your favourites!', 'error')
        end
        if not Config.CloseOnSelect then
            showEngineSoundMenu()
        end
    elseif selected == 3 then
        showFavouritesMenu()
    end
end)

RegisterNetEvent("Chroma:EngineSounds:OpenMenu", function()
    if not cache.vehicle or cache.seat ~= -1 then
        return Config.Notify('You need to be driving a vehicle to use this!', 'error')
    end
    showEngineSoundMenu()
end)

AddStateBagChangeHandler("vehdata:sound", nil, function(bagName, _, value)
    local entity = GetEntityFromStateBagName(bagName)
    if entity == 0 then return end
    ForceUseAudioGameObject(entity, value)
end)

lib.addKeybind({
    name = 'open_enginesound_menu',
    description = 'Open Engine Sound Menu',
    defaultKey = Config.Keybind,
    onPressed = function()
        ExecuteCommand('enginesound')
    end,
})

TriggerEvent('chat:addSuggestion', '/enginesound', 'Open the Engine Sound Menu!')
