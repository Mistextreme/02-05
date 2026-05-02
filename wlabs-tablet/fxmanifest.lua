fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'wlabs-tablet'
author 'W-Labs'
description 'A Qbox tablet made by Williee, I hope you enjoy this unique take on a Fivem tablet.'
version '1.0.0'

escrow_ignore {
    'config.lua',
    'README.md'
}

dependencies {
    'ox_lib',
    'oxmysql'
}

nui_callback_strict_mode 'true'
ui_page 'html/build/index.html'

files {
    'html/build/**/*'
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/utils.lua',
    'config.lua',
    'shared/framework.lua'
}

client_scripts {
    'shared/camera_defaults.lua',
    'client/main.lua',
    'client/camera.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'shared/camera_defaults.lua',
    'server/camera_upload.lua',
    'server/main.lua'
}

dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'