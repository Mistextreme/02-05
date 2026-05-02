local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local cooldowns = {}
local activeJobs = {} -- [source] = jobData

function NotifyPlayer(xPlayer, msg, type)
    if Config.Notify.resource == 'esx' then
        xPlayer.showNotification(msg, type)
    elseif Config.Notify.resource and GetResourceState(Config.Notify.resource) == 'started' then
        TriggerClientEvent('distortionz_notify:Send', xPlayer.source, {
            title = Config.Notify.title,
            message = msg,
            type = type or 'info',
            length = Config.Notify.defaultLength
        })
    else
        xPlayer.showNotification(msg)
    end
end

ESX.RegisterServerCallback('distortionz_trucking:startJob', function(source, cb, cargoId)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb({ success = false, message = 'Player not found.' })
        return
    end

    if Config.RequiredJob and xPlayer.job.name ~= Config.RequiredJob then
        cb({ success = false, message = 'You are not allowed to do this job.' })
        return
    end

    local identifier = xPlayer.identifier
    if cooldowns[identifier] and Config.Cooldown > 0 then
        local timeLeft = Config.Cooldown * 60 - (os.time() - cooldowns[identifier])
        if timeLeft > 0 then
            cb({ success = false, message = 'You must wait ' .. math.floor(timeLeft / 60) .. ' minute(s) before starting again.' })
            return
        end
    end

    local cargo = nil
    if cargoId then
        for _, c in ipairs(Config.Cargo) do
            if c.id == cargoId then
                cargo = c
                break
            end
        end
    else
        local totalWeight = 0
        for _, c in ipairs(Config.Cargo) do
            totalWeight = totalWeight + c.weight
        end
        local rand = math.random(1, totalWeight)
        local cumulative = 0
        for _, c in ipairs(Config.Cargo) do
            cumulative = cumulative + c.weight
            if rand <= cumulative then
                cargo = c
                break
            end
        end
    end

    if not cargo then
        cb({ success = false, message = 'No cargo available.' })
        return
    end

    local dropoff = Config.Dropoffs[math.random(1, #Config.Dropoffs)]
    cooldowns[identifier] = os.time()

    local jobData = {
        cargoId = cargo.id,
        cargoLabel = cargo.label,
        weight = cargo.weight,
        basePay = cargo.basePay,
        damagePenalty = cargo.damagePenalty,
        dropoff = dropoff,
        started = os.time()
    }
    activeJobs[source] = jobData

    cb({
        success = true,
        job = jobData
    })
end)

ESX.RegisterServerCallback('distortionz_trucking:finishJob', function(source, cb, isDamaged, trailerHealth)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb({ success = false, message = 'Player not found.' })
        return
    end

    local jobData = activeJobs[source]
    if not jobData then
        cb({ success = false, message = 'No active job found.' })
        return
    end

    local pay = jobData.basePay
    if isDamaged then
        pay = math.floor(pay * jobData.damagePenalty)
        NotifyPlayer(xPlayer, 'You received a reduced payment due to trailer damage.', 'warning')
    end

    xPlayer.addMoney(pay)

    -- Police alert
    if Config.Police.enabled then
        local cops = 0
        local xPlayers = ESX.GetPlayers()
        for _, playerId in ipairs(xPlayers) do
            local xTarget = ESX.GetPlayerFromId(playerId)
            if xTarget and xTarget.job.name and table.includes(Config.Police.alertJobs, xTarget.job.name) then
                cops = cops + 1
            end
        end
        if cops >= Config.Police.minCops then
            local coords = GetEntityCoords(GetPlayerPed(source)) -- client coords needed; we'll use Dropoff from jobData
            TriggerClientEvent('distortionz_trucking:policeAlert', -1, {
                message = 'A trucking delivery has been completed at ' .. jobData.dropoff,
                coords = jobData.dropoff
            })
        end
    end

    activeJobs[source] = nil

    cb({
        success = true,
        payment = pay
    })
end)

-- Clean up active jobs when player disconnects
AddEventHandler('esx:playerDropped', function(playerId)
    activeJobs[playerId] = nil
end)

-- Helper table.includes
function table.includes(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then return true end
    end
    return false
end