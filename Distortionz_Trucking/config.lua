Config = {}

Config.Script = {
    name = 'Distortionz Trucking',
    version = '1.0.9'
}

Config.Debug = false

-- Notification system settings
-- Set resource to 'esx' to use ESX.ShowNotification, otherwise use a custom resource
Config.Notify = {
    resource = 'esx',          -- 'distortionz_notify' or 'esx' or false
    title = 'Trucking',
    defaultLength = 5000
}

Config.VersionCheck = {
    enabled = true,
    url = 'https://raw.githubusercontent.com/Distortionzz/Distortionz_Trucking/main/version.json'
}

-- Job settings for ESX (nil = no job requirement)
Config.RequiredJob = nil       -- e.g. 'trucker'

Config.Depot = {
    coords = vec4(925.45, -2245.30, 30.47, 358.0),
    model = 's_m_y_construct_01',
    blip = {
        sprite = 477,
        colour = 2,
        scale = 0.8,
        label = 'Distortionz Trucking'
    }
}

Config.Spawn = {
    truck = vec4(924.32, -2270.51, 29.35, 352.77),
    trailer = vec4(922.56, -2288.79, 29.22, 358.0)
}

Config.Vehicles = {
    truck = 'phantom',
    trailer = 'trailers2'
}

Config.Cargo = {
    {
        id = 'food',
        label = 'Food Supplies',
        weight = 50,
        basePay = 350,
        damagePenalty = 0.7
    },
    {
        id = 'electronics',
        label = 'Electronics',
        weight = 30,
        basePay = 600,
        damagePenalty = 0.5
    },
    {
        id = 'hazmat',
        label = 'Hazardous Materials',
        weight = 15,
        basePay = 950,
        damagePenalty = 0.4
    },
    {
        id = 'classified',
        label = 'Classified Freight',
        weight = 5,
        basePay = 1500,
        damagePenalty = 0.3
    }
}

Config.Dropoffs = {
    vector3(1197.21, -3253.86, 6.03),
    vector3(2661.61, 3287.67, 55.24),
    vector3(156.14, -3007.95, 6.04),
    vector3(-451.69, -2693.92, 6.00),
    vector3(-1524.73, 876.75, 7.02),
    vector3(-303.48, 2822.66, 43.37),
    vector3(393.97, 3582.06, 33.29),
    vector3(-717.68, 5805.62, 16.97)
}

Config.Police = {
    enabled = true,
    alertJobs = { 'police' },
    alertDistance = 400,
    minCops = 0
}

Config.Cooldown = 0   -- Cooldown in minutes (0 = disabled)

Config.DamageThreshold = 700   -- trailer health below this triggers penalty