local ESX = nil
local PlayerData = {}
local jobActive = false
local currentJob = nil
local truck = nil
local trailer = nil
local blip = nil
local isDamaged = false
local damageAnnounced = false
local started = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(100)
    end

    PlayerData = ESX.GetPlayerData()
    ESX.PlayerData = PlayerData

    SpawnDepotPed()
    CreateDepotBlip()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function Notify(msg, type, length)
    if Config.Notify.resource == 'esx' then
        ESX.ShowNotification(msg, type or 'info', length or Config.Notify.defaultLength)
    elseif Config.Notify.resource and GetResourceState(Config.Notify.resource) == 'started' then
        TriggerEvent('distortionz_notify:Send', {
            title = Config.Notify.title,
            message = msg,
            type = type or 'info',
            length = length or Config.Notify.defaultLength
        })
    else
        ESX.ShowNotification(msg)
    end
end

function SpawnDepotPed()
    local hash = GetHashKey(Config.Depot.model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(0) end
    local ped = CreatePed(4, hash, Config.Depot.coords.x, Config.Depot.coords.y, Config.Depot.coords.z, Config.Depot.coords.w, false, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports['ox_target']:addLocalEntity(ped, {
        {
            name = 'trucking_job',
            icon = 'fas fa-truck',
            label = 'Start Trucking Job',
            onSelect = function()
                OpenJobMenu()
            end,
            canInteract = function()
                if Config.RequiredJob and PlayerData.job and PlayerData.job.name ~= Config.RequiredJob then return false end
                return not jobActive
            end
        }
    })
end

function CreateDepotBlip()
    local blip = AddBlipForCoord(Config.Depot.coords.x, Config.Depot.coords.y, Config.Depot.coords.z)
    SetBlipSprite(blip, Config.Depot.blip.sprite)
    SetBlipColour(blip, Config.Depot.blip.colour)
    SetBlipScale(blip, Config.Depot.blip.scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Depot.blip.label)
    EndTextCommandSetBlipName(blip)
end

function OpenJobMenu()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        cargoOptions = Config.Cargo
    })
end

RegisterNUICallback('startJob', function(data, cb)
    SetNuiFocus(false, false)
    if jobActive then
        Notify('You already have an active job.', 'error')
        cb('ok')
        return
    end
    ESX.TriggerServerCallback('distortionz_trucking:startJob', function(result)
        if result and result.success then
            currentJob = result.job
            jobActive = true
            isDamaged = false
            damageAnnounced = false
            started = false
            SpawnVehiclesAndStart()
        else
            Notify(result.message or 'Could not start job.', 'error')
        end
        cb('ok')
    end, data.cargoId)
end)

RegisterNUICallback('closeMenu', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

function SpawnVehiclesAndStart()
    local truckModel = GetHashKey(Config.Vehicles.truck)
    local trailerModel = GetHashKey(Config.Vehicles.trailer)

    RequestModel(truckModel)
    while not HasModelLoaded(truckModel) do Citizen.Wait(0) end
    RequestModel(trailerModel)
    while not HasModelLoaded(trailerModel) do Citizen.Wait(0) end

    truck = CreateVehicle(truckModel, Config.Spawn.truck.x, Config.Spawn.truck.y, Config.Spawn.truck.z, Config.Spawn.truck.w, true, false)
    SetVehicleNumberPlateText(truck, "TRUCK")
    SetEntityAsMissionEntity(truck, true, true)

    trailer = CreateVehicle(trailerModel, Config.Spawn.trailer.x, Config.Spawn.trailer.y, Config.Spawn.trailer.z, Config.Spawn.trailer.w, true, false)
    SetVehicleNumberPlateText(trailer, "CGO")
    SetEntityAsMissionEntity(trailer, true, true)

    AttachVehicleToTrailer(truck, trailer, 1.0)

    SetVehicleEngineOn(truck, true, true, false)
    SetVehicleEngineOn(trailer, true, true, false)

    TaskWarpPedIntoVehicle(PlayerPedId(), truck, -1)

    blip = AddBlipForCoord(currentJob.dropoff.x, currentJob.dropoff.y, currentJob.dropoff.z)
    SetBlipSprite(blip, 478)
    SetBlipColour(blip, 1)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Delivery Point')
    EndTextCommandSetBlipName(blip)

    SendNUIMessage({
        action = 'showHUD',
        job = {
            cargoLabel = currentJob.cargoLabel,
            weight = currentJob.weight,
            basePay = currentJob.basePay,
            damagePenalty = currentJob.damagePenalty,
            dropoff = currentJob.dropoff
        }
    })

    started = true

    Citizen.CreateThread(function()
        while jobActive do
            Wait(1000)
            if trailer and DoesEntityExist(trailer) then
                local health = GetEntityHealth(trailer)
                local maxHealth = GetEntityMaxHealth(trailer)
                local healthPercent = (health / maxHealth) * 100
                if healthPercent < Config.DamageThreshold and not damageAnnounced then
                    isDamaged = true
                    damageAnnounced = true
                    Notify('Trailer damaged! Penalty will be applied.', 'warning')
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while jobActive do
            Wait(0)
            DrawMarker(1, currentJob.dropoff.x, currentJob.dropoff.y, currentJob.dropoff.z - 1.0, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 1.0, 255, 255, 0, 100, false, false, 2, false, nil, nil, false)
            if #(GetEntityCoords(PlayerPedId()) - currentJob.dropoff) < 5.0 then
                if IsControlJustPressed(0, 38) then -- E key
                    FinishJob()
                end
            end
        end
    end)
end

function FinishJob()
    if not jobActive then return end

    local trailerHealth = nil
    if trailer and DoesEntityExist(trailer) then
        trailerHealth = GetEntityHealth(trailer)
    end

    ESX.TriggerServerCallback('distortionz_trucking:finishJob', function(result)
        if result.success then
            Notify('Delivery complete! You earned $' .. result.payment, 'success')
            SendNUIMessage({ action = 'hideHUD' })
        else
            Notify(result.message or 'Delivery failed.', 'error')
        end
        CleanUpJob()
    end, isDamaged, trailerHealth)
end

function CleanUpJob()
    jobActive = false
    currentJob = nil
    isDamaged = false
    damageAnnounced = false
    started = false

    if truck and DoesEntityExist(truck) then
        DeleteEntity(truck)
    end
    if trailer and DoesEntityExist(trailer) then
        DeleteEntity(trailer)
    end
    if blip then
        RemoveBlip(blip)
        blip = nil
    end
    truck = nil
    trailer = nil
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        CleanUpJob()
    end
end)