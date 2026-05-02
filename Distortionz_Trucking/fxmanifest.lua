fx_version 'cerulean'
game 'gta5'

description 'Distortionz Trucking - ESX Conversion'
author 'Distortionzz'
version '1.0.9'

shared_scripts {
    '@es_extended/import.lua',
    'config.lua',
    'version_check.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

dependencies {
    'es_extended'
}