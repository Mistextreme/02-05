local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local cooldowns = {}

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

    -- Cooldown check
    local identifier = xPlayer.identifier
    if cooldowns[identifier] and Config.Cooldown > 0 then
        local timeLeft = Config.Cooldown * 60 - (os.time() - cooldowns[identifier])
        if timeLeft > 0 then
            cb({ success = false, message = 'You must wait ' .. math.floor(timeLeft / 60) .. ' minute(s) before starting again.' })
            return
        end
    end

    -- Determine cargo
    local cargo = nil
    if cargoId then
        for _, c in ipairs(Config.Cargo) do
            if c.id == cargoId then
                cargo = c
                break
            end
        end
    else
        -- Random weighted selection
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

    -- Pick random dropoff
    local dropoff = Config.Dropoffs[math.random(1, #Config.Dropoffs)]

    cooldowns[identifier] = os.time()

    cb({
        success = true,
        job = {
            cargoId = cargo.id,
            cargoLabel = cargo.label,
            weight = cargo.weight,
            basePay = cargo.basePay,
            damagePenalty = cargo.damagePenalty,
            dropoff = dropoff
        }
    })
end)

ESX.RegisterServerCallback('distortionz_trucking:finishJob', function(source, cb, isDamaged, trailerHealth)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb({ success = false, message = 'Player not found.' })
        return
    end

    -- We need the job data stored on server side during this session
    -- Since callbacks are not persistent, we'll pass job data from client originally but we don't have it.
    -- However the client can send the job data; but the prompt requires to preserve functionality.
    -- Simpler: the server callback needs to verify the job was valid. We can store active jobs per player.
    -- Let's add a server-side storage for active jobs.

    -- For this conversion, we'll use a temporary server-side job table keyed by player ID.
end)

-- We need to store active job data per player to validate finish.
-- Let's restructure: server creates job, stores data, then on finish callback uses that.
-- I'll adjust the server script accordingly.

-- Full server.lua with proper job storage:
