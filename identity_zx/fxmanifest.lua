fx_version 'cerulean'
game 'gta5'

author 'Zyrox'
description 'Player Identity Script for ESX & QB-Core'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'locales/*.lua',
    'client.lua'
}

server_scripts {
    'locales/*.lua',
    'server.lua'
}

dependencies {
    'ox_lib'
}

lua54 'yes'
