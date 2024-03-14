fx_version 'cerulean'
game 'gta5'

shared_script '@ox_lib/init.lua'
lua54 'yes'

client_scripts {
    'config.lua',
    'client.lua',
}

server_scripts {
    'server.lua',
}

dependency 'ox_lib'

author 'Grav'
version '1.1'
description 'Engine sound menu that syncs to other players'