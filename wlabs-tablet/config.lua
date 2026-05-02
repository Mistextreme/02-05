Config = {}

Config.ItemName = 'tablet' -- Item spawn name when Config.UseItem is true (must match your inventory item)
Config.BootLogo = 'boot-logo.png' -- Name of boot screen logo, replace image with your own if you want
Config.EmailDomain = 'wlabs.com'-- Domain for mail
Config.UseItem = false -- True requires item to open tablet
Config.EnableOpenCommand = false -- Enable or disable command to open tablet
Config.OpenCommand = 'wtablet' -- Name of command to open tablet if enabled
Config.Keybind = {
    enabled = true, -- Enable or disable keybind
    defaultKey = 'F3', -- Keybind key
    description = 'Open Tablet' -- Keybind description
}

Config.Notification = 4500 -- Notification display time in ms

Config.Apps = {
    mail = true, -- Email app
    contacts = true, -- Contacts app
    camera = true, -- Camera app
    videocall = true, -- Video call app
    store = true, -- App store
    paint = true, -- Paint app
    gallery = true, -- Gallery app
    calc = true, -- Calculator
    calendar = true, -- Calendar
    settings = true, -- Settings
    Yap = true -- Yap social app
}

Config.DefaultApps = {
    'mail',
    'contacts',
    'camera',
    'videocall',
    'store',
    'gallery',
    'calc',
    'calendar',
    'settings'
}

--- Camera uploads: see README.md section "Camera uploads". Set Upload.method here; API keys go in server.cfg.
Config.Camera = {
    Upload = {
        method = 'fivemanage' -- 'fivemanage' or 'fivemerr' (cloud upload required)
    }
}

Config.CustomApps = {
}
