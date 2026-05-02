fx_version 'cerulean'
game 'gta5'

name 'wlabs-shops'
description 'Cart based shops with Cash/Bank checkout.'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
}

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    'config.lua',
    'client.lua',
}

server_scripts {
    'config.lua',
    'server.lua',
}

dependencies {
    'ox_lib',
    'ox_inventory',
    'ox_target',
}

escrow_ignore {
    'config.lua',
    'README.md'
}

lua54 'yes'

dependency '/assetpacks'