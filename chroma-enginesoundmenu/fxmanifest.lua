fx_version 'cerulean'
game 'gta5'

shared_script '@ox_lib/init.lua'
lua54 'yes'

client_scripts {
    'client_config.lua',
    'client.lua',
}

server_scripts {
    'server_config.lua',
    'server.lua',
}

dependency 'ox_lib'

author 'Grav'
version '1.4'
description 'Engine sound menu that syncs to other players'