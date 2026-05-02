-- This is your app id used by WLabs Tablet.
-- Change this for your own app name so it does not conflict with other resources.
local APP_KEY = 'wlabs_test'

local function registerTabletApp()
    -- The export exists in the WLabs tablet, if the tablet script isn't started first this will not work.
    -- Returning false lets the startup thread retry instead of throwing errors or not starting at all.
    if GetResourceState('wlabs-tablet') ~= 'started' then
        return false
    end

    -- RegisterApp tells WLabs Tablet how to show this app in the app store and which page/icon to load when the player launches it.
    return exports['wlabs-tablet']:RegisterApp({
        -- Stable internal id. Use lowercase and underscores.
        key = APP_KEY,

        -- This is what displays in the tablet. "Test App" is the apps name, so make this whatever you want your app to be called.
        label = 'Test App',
        description = 'An example of a custom app for WLabs Tablet.',

        -- Visible app page loaded when the player opens the app.
        -- Format: https://cfx-nui-YOUR_RESOURCE_NAME/path/to/file.html
        -- Example: if your resource is "wlabs-spooky", and your html file in the html folder is called "tablet.html", use:
        -- https://cfx-nui-wlabs-spooky/html/tablet.html
        ui = 'https://cfx-nui-wlabs-tablet-example-app/html/tablet.html',

        -- App icon used by the tablet.
        -- This follows the same format as ui, but points to your icon file.
        icon = 'https://cfx-nui-wlabs-tablet-example-app/html/icons/hello.svg',

        -- Helps the tablet know which resource owns this app.
        -- This should match your resource folder name.
        resource = 'wlabs-tablet-example-app',

        -- true means the app uses the full tablet app area.
        fullscreen = true,

        -- Optional app accent colors. Replace these with whatever colors you want.
        gradient = { '#2563eb', '#14b8a6' }
    })
end

CreateThread(function()
    -- Resource startup order can vary, this basically retries every 500ms until the tablet is ready to register the app.
    while not registerTabletApp() do
        Wait(500)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    -- This is basically a fail safe, if the tablet is restarted for whatever reason, the custom app will still register.
    if resourceName == 'wlabs-tablet' then
        Wait(500)
        registerTabletApp()
    end
end)

RegisterNUICallback('testApp', function(data, cb)
    -- NUI callbacks receive JSON from the browser as a Lua table.
    -- The reason for this is to stop exploiters, this specific callback is just a message so it can't really be exploited, but this is a good practice.
    local name = type(data) == 'table' and tostring(data.name or '') or ''

    if name == '' then
        name = 'developer'
    end

    -- cb sends a JSON response back to the fetch() call in html/app.js.
    cb({
        ok = true,
        message = ('Welcome, %s. Your custom tablet app is talking to Lua.'):format(name)
    })
end)
