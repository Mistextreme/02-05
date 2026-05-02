fx_version 'cerulean'

game 'gta5'

lua54 'yes'

name 'wlabs-tablet-example-app'
author 'W-Labs'
description 'Tiny open-source custom app example for WLabs Tablet.'
version '1.0.0'

-- WLabs Tablet must be running before this example can register itself.
dependency 'wlabs-tablet'

-- FiveM requires each NUI resource to declare a top-level ui_page.
-- This section is important, this intentionally points to a hidden page, not the visible app page.
-- WLabs Tablet loads html/tablet.html later inside its own tablet iframe, if your custom app ui covers the entire screen and doesn't display in the tablet, it's because the ui_page is pointing to the wrong file.
ui_page 'html/nui.html'

files {
    'html/nui.html',
    'html/tablet.html',
    'html/style.css',
    'html/app.js',
    'html/icons/hello.svg'
}

escrow_ignore {
    '*',
    '**/*'
}

client_script 'client/main.lua'

dependency '/assetpacks'