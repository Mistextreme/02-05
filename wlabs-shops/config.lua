Config = Config or {}

Config.UI = Config.UI or {
    --  menu color for all shops
    accent = '#721635',
}

-- If true, items that don't fit in the player inventory are dropped on the ground.
-- If false, the purchase is denied if all items cannot fit.
Config.overflowdrop = false

-- If true, show blips for all shop locations at once.
-- If false, only the closest location per shop will be shown.
Config.showAllBlips = true

Config.Shops = {

    General = {
        name = 'Shop',
        label = '24/7 Supermarket',
        ui = { accent = '#2ecc71' }, -- Comment this line out if you want to use the global color above
        blip = { id = 52, colour = 0, scale = 0.8 },
        inventory = {
            { name = 'rolling_paper', price = 5 },
            { name = 'sandwich', price = 10 },
            { name = 'water_bottle', price = 10 },
            { name = 'bandage', price = 10 },
        },
        targets = {
            { ped = `a_f_y_indian_01`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(-3040.6, 584.04, 6.91), heading = 14.88, length = 0.7, width = 0.5, minZ = 7.91, maxZ = 8.31, distance = 3.0 },
            { ped = `a_m_m_salton_02`, scenario = 'WORLD_HUMAN_CLIPBOARD', loc = vec3(24.5, -1345.53, 28.5), heading = 273.0, length = 0.7, width = 0.5, minZ = 29.5, maxZ = 29.9, distance = 3.0 },
            { ped = `a_m_y_indian_01`, scenario = 'WORLD_HUMAN_AA_SMOKE', loc = vec3(-3243.99, 1000.13, 12.83), heading = 352.46, length = 0.7, width = 0.5, minZ = 12.83, maxZ = 13.23, distance = 3.0 },
            { ped = `a_m_m_salton_02`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(1728.72, 6416.88, 34.04), heading = 245.08, length = 0.7, width = 0.5, minZ = 35.04, maxZ = 35.44, distance = 3.0 },
            { ped = `a_m_y_indian_01`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(1959.21, 3741.61, 31.34), heading = 301.57, length = 0.7, width = 0.5, minZ = 31.34, maxZ = 31.74, distance = 3.0 },
            { ped = `a_m_y_indian_01`, scenario = 'WORLD_HUMAN_CLIPBOARD', loc = vec3(549.25, 2669.72, 41.16), heading = 99.39, length = 0.7, width = 0.5, minZ = 41.16, maxZ = 41.56, distance = 3.0 },
            { ped = `a_m_m_salton_02`, scenario = 'WORLD_HUMAN_AA_SMOKE', loc = vec3(2676.48, 3280.29, 54.24), heading = 335.08, length = 0.7, width = 0.5, minZ = 54.24, maxZ = 54.64, distance = 3.0 },
            { ped = `a_m_y_hippy_01`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(2555.58, 380.86, 107.62), heading = 356.67, length = 0.7, width = 0.5, minZ = 107.62, maxZ = 108.02, distance = 3.0 },
            { ped = `a_m_y_hippy_01`, scenario = 'WORLD_HUMAN_SMOKING', loc = vec3(372.96, 328.07, 102.57), heading = 253.73, length = 0.7, width = 0.5, minZ = 102.57, maxZ = 102.97, distance = 3.0 },
            { ped = `a_f_y_indian_01`, scenario = 'WORLD_HUMAN_CLIPBOARD', loc = vec3(-47.35, -1758.71, 28.42), heading = 45.05, length = 0.7, width = 0.5, minZ = 28.42, maxZ = 28.82, distance = 3.0 },
            { ped = `a_m_m_salton_02`, scenario = 'WORLD_HUMAN_AA_SMOKE', loc = vec3(-706.14, -914.55, 18.22), heading = 88.04, length = 0.7, width = 0.5, minZ = 18.22, maxZ = 18.62, distance = 3.0 },
            { ped = `a_m_y_hippy_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', loc = vec3(-1819.47, 793.45, 137.09), heading = 135.45, length = 0.7, width = 0.5, minZ = 137.09, maxZ = 137.49, distance = 3.0 },
            { ped = `a_m_o_soucent_03`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(1164.8, -323.58, 69.21), heading = 98.74, length = 0.7, width = 0.5, minZ = 68.21, maxZ = 68.61, distance = 3.0 },
            { ped = `a_m_m_salton_02`, scenario = 'WORLD_HUMAN_SMOKING', loc = vec3(1697.21, 4923.42, 41.06), heading = 324.71, length = 0.7, width = 0.5, minZ = 41.06, maxZ = 41.46, distance = 3.0 },
        },
    },

    Liquor = {
        name = 'Liquor Store',
        label = 'Liquor Store',
        ui = { accent = '#e67e22' }, -- orange
        blip = { id = 52, colour = 0, scale = 0.8 },
        inventory = {
            { name = 'beer', price = 25 },
            { name = 'whiskey', price = 25 },
            { name = 'vodka', price = 25 },
            { name = 'sandwich', price = 10 },
            { name = 'water_bottle', price = 10 },
            { name = 'bandage', price = 5 },
            { name = 'lighter', price = 15 },
        },
        targets = {
            { ped = `a_m_m_salton_02`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(-1221.58, -908.15, 11.33), heading = 35.49, length = 0.7, width = 0.5, minZ = 11.33, maxZ = 11.73, distance = 3.0 },
            { ped = `a_m_m_salton_02`, scenario = 'WORLD_HUMAN_CLIPBOARD', loc = vec3(-1486.59, -377.68, 39.16), heading = 139.51, length = 0.7, width = 0.5, minZ = 39.16, maxZ = 39.56, distance = 3.0 },
            { ped = `a_m_o_soucent_03`, scenario = 'WORLD_HUMAN_SMOKING', loc = vec3(-2966.39, 391.42, 14.04), heading = 87.48, length = 0.7, width = 0.5, minZ = 14.04, maxZ = 14.44, distance = 3.0 },
            { ped = `a_m_y_hippy_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', loc = vec3(1165.17, 2710.88, 37.16), heading = 179.43, length = 0.7, width = 0.5, minZ = 37.16, maxZ = 37.56, distance = 3.0 },
            { ped = `a_m_m_salton_02`, scenario = 'WORLD_HUMAN_SMOKING', loc = vec3(1134.2, -982.91, 45.42), heading = 277.24, length = 0.7, width = 0.5, minZ = 45.42, maxZ = 45.82, distance = 3.0 },
        },
    },

    Hardware = {
        name = 'Hardware',
        label = 'Hardware',
        ui = { accent = '#3498db' }, -- blue
        blip = { id = 402, colour = 0, scale = 0.8 },
        inventory = {
            { name = 'lockpick', price = 25 },
            { name = 'armor', price = 250 },
            { name = 'drill', price = 1000 },
            { name = 'plastic', price = 35 },
            { name = 'metalscrap', price = 35 },
            { name = 'copper', price = 35 },
            { name = 'aluminum', price = 35 },
            { name = 'iron', price = 35 },
            { name = 'steel', price = 35 },
            { name = 'rubber', price = 35 },
            { name = 'glass', price = 35 },
            { name = 'electronics', price = 35 },
            { name = 'copperwire', price = 35 },
            { name = 'leather', price = 35 },
            { name = 'capacitors', price = 35 },
            { name = 'lead', price = 35 },
            { name = 'cloth', price = 35 },
            { name = 'spring', price = 100 },
            { name = 'wood', price = 35 },
        },
        targets = {
            { ped = `s_m_m_gaffer_01`, scenario = 'WORLD_HUMAN_SMOKING', loc = vec3(44.37532, -1747.833, 28.49707), heading = 48.09, length = 0.7, width = 0.5, minZ = 28.49, maxZ = 28.89, distance = 3.0 },
            { ped = `s_m_m_gaffer_01`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(2748.379, 3472.595, 54.67552), heading = 249.88, length = 0.7, width = 0.5, minZ = 54.67, maxZ = 55.07, distance = 3.0 },
            { ped = `s_m_m_gaffer_01`, scenario = 'WORLD_HUMAN_STAND_IMPATIENT', loc = vec3(-421.758, 6135.586, 30.877), heading = 180.37, length = 0.7, width = 0.5, minZ = 30.87, maxZ = 31.27, distance = 3.0 },
        },
    },

    Ammunation = {
        name = 'Ammunation',
        label = 'Ammunation',
        ui = { accent = '#c0392b' }, -- red
        blip = { id = 110, colour = 0, scale = 0.8 },
        inventory = {
            { name = 'weapon_knife', price = 500 },
            { name = 'weapon_bat', price = 500 },
            { name = 'weapon_hatchet', price = 500 },
            { name = 'weapon_snspistol', price = 1500, requireWeaponLicense = true },  --required license works with ps-mdt, if using requireweaponlicense you must set license through the mdt, this will not work with just an item.
            { name = 'weapon_pistol', price = 2500, requireWeaponLicense = true },
            { name = 'weapon_combatpistol', price = 5000, requireWeaponLicense = true },
            { name = 'weapon_huntingrifle', price = 15000, requireWeaponLicense = true },
            { name = 'pistol_ammo', price = 50, requireWeaponLicense = true },
            { name = 'rifle_ammo', price = 75, requireWeaponLicense = true },
        },
        targets = {
            { ped = `a_m_y_stbla_02`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(-660.02, -936.72, 20.83), heading = 143.33, length = 0.8, width = 0.8, minZ = 21.83, maxZ = 22.23, distance = 3.0 },
            { ped = `a_m_m_mlcrisis_01`, scenario = 'WORLD_HUMAN_CLIPBOARD', loc = vec3(810.48, -2159.07, 28.62), heading = 0.94, length = 0.8, width = 0.8, minZ = 29.62, maxZ = 30.02, distance = 3.0 },
            { ped = `ig_josef`, scenario = 'WORLD_HUMAN_CLIPBOARD', loc = vec3(1696.15, 3760.46, 33.71), heading = 180.64, length = 0.8, width = 0.8, minZ = 34.71, maxZ = 35.11, distance = 3.0 },
            { ped = `a_m_y_stbla_02`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(-331.79, 6084.8, 30.45), heading = 221.25, length = 0.8, width = 0.8, minZ = 31.45, maxZ = 31.85, distance = 3.0 },
            { ped = `a_m_m_mlcrisis_01`, scenario = 'WORLD_HUMAN_CLIPBOARD', loc = vec3(250.11, -51.64, 68.94), heading = 18.08, length = 0.8, width = 0.8, minZ = 69.94, maxZ = 70.34, distance = 3.0 },
            { ped = `ig_josef`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(22.56, -1105.45, 29.8), heading = 157.52, length = 0.8, width = 0.8, minZ = 29.8, maxZ = 30.2, distance = 3.0 },
            { ped = `a_m_y_stbla_02`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(2565.67, 295.69, 107.73), heading = 315.41, length = 0.8, width = 0.8, minZ = 108.73, maxZ = 109.13, distance = 3.0 },
            { ped = `a_m_m_mlcrisis_01`, scenario = 'WORLD_HUMAN_CLIPBOARD', loc = vec3(-1119.22, 2699.52, 17.55), heading = 219.92, length = 0.8, width = 0.8, minZ = 18.55, maxZ = 18.95, distance = 3.0 },
            { ped = `ig_josef`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(840.13, -1032.18, 27.19), heading = 322.74, length = 0.8, width = 0.8, minZ = 28.19, maxZ = 28.59, distance = 3.0 },
            { ped = `a_m_y_stbla_02`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(-1304.11, -394.63, 35.7), heading = 75.32, length = 0.8, width = 0.8, minZ = 36.7, maxZ = 37.1, distance = 3.0 },
            { ped = `a_m_m_mlcrisis_01`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(-3173.61, 1088.27, 19.84), heading = 247.8, length = 0.8, width = 0.8, minZ = 20.84, maxZ = 21.24, distance = 3.0 },
        },
    },

    PoliceArmoury = {
        name = 'Police Armoury',
        label = 'Police Armoury',
        ui = { accent = '#34495e' },
        groups = { police = 0 }, --uses qb-core/qbx-core jobs, currently set to "police" job grade "0", this means anyone with the police job above grade 0 can purchase items.
        inventory = {
            { name = 'handcuffs', price = 10 },
            { name = 'cuffkeys', price = 1 },
            { name = 'heavyarmor', price = 50 },
            { name = 'radio', price = 25 },
            { name = 'weapon_flashlight', price = 25 },
            { name = 'empty_evidence_bag', price = 1 },
            { name = 'ifaks', price = 5 },
            { name = 'pistol_ammo', price = 1 },
            { name = 'smg_ammo', price = 5, grade = 4 }, --"grade = 4" locks this item so only officers with grade 4 AND above can purchase item.
            { name = 'shotgun_ammo', price = 10, grade = 4 },
            { name = 'rifle_ammo', price = 15, grade = 4 },
        },
        targets = {
            { ped = `s_m_y_cop_01`, scenario = 'WORLD_HUMAN_DRINKING', loc = vec3(472.83, -969.323, 22.936), heading = 79.015, length = 0.7, width = 0.5, minZ = 22.936, maxZ = 24.336, distance = 3.0 },
        },
    },
}
