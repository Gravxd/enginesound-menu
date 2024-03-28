Config = {
    Keybind = "",                  -- E.G F7 ---> https://docs.fivem.net/docs/game-references/controls/
    MenuPosition = "bottom-right", -- bottom-right, bottom-left, top-right, top-left
    CloseOnSelect = false,         -- Will close the menu when you select an engine sound.
    Notify = function(msg, type)
        -- customise this notification function to whatever you desire - by default it uses ox_lib but you can edit this
        lib.notify({
            title = 'chroma-enginesoundmenu',
            description = msg,
            type = type,
            position = 'center-right',
        })
    end,
    EngineSounds = {
        -- Engine Sound Name/Label --> Hash of engine audio (what you'd normally put in vehicles.meta)
        ['BMW S63 4.4L V8'] = 's63b44',
    },
}
