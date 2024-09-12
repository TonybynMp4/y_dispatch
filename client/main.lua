local classes = { locale('classes.compact'), locale('classes.sedan'), locale('classes.suv'), locale('classes.coupe'),
    locale('classes.muscle'), locale('classes.sports_classic'), locale('classes.sports'), locale('classes.super'),
    locale('classes.motorcycle'), locale('classes.offroad'), locale('classes.industrial'), locale('classes.utility'),
    locale('classes.van'), locale('classes.service'), locale('classes.military'), locale('classes.truck') }
local blips, radiuses, DispatchDisabled = {}, {}, false
local config = require 'config.client'
local tenCodes = require 'config.shared'.tenCodes
local playerState = LocalPlayer.state

--#region Functions
local fightAntiSpam = false
local function fight(ped)
    if ped ~= cache.ped then return end

    if CheckJob(config.events.fight.jobwhitelist, QBX.PlayerData.job) and QBX.PlayerData.job.onduty then return end

    fightAntiSpam = true
    exports.y_dispatch:Fight()
    SetTimeout(30 * 1000, function() -- Wait 30 seconds to avoid spam.
        fightAntiSpam = false
    end)
end

local shotsfiredAntiSpam = false
local function shotfired(ped)
    if ped ~= cache.ped then return end
    if IsPedCurrentWeaponSilenced(ped) and math.random() <= 0.98 then return end
    -- 2% chance to trigger the event if the weapon is silenced, ( real life weapons are not 100% silent ;c )

    if CheckJob(config.events.shotsfired.jobwhitelist, QBX.PlayerData.job) and QBX.PlayerData.job.onduty then return end

    shotsfiredAntiSpam = true
    if cache.vehicle then
        exports.y_dispatch:DriveBy()
    else
        exports.y_dispatch:Shooting()
    end
    SetTimeout(30 * 1000, function() -- Wait 30 seconds to avoid spam.
        shotsfiredAntiSpam = false
    end)
end

--- Checks if the player's job is in the jobs table
---@param jobs any
---@param playerjob any
---@return boolean
function CheckJob(jobs, playerjob)
    if jobs.jobs or jobs.types then
        if not jobs.jobs then goto skipjobs end
        for _, v in pairs(jobs.jobs) do
            if playerjob.name == v then
                return true
            end
        end
        ::skipjobs::
        if not jobs.types then goto skiptypes end
        for _, v in pairs(jobs.types) do
            if playerjob.type == v then
                return true
            end
        end
        ::skiptypes::
    else
        for _, v in pairs(jobs) do
            if playerjob.name == v then
                return true
            end
        end
    end
    return false
end

local function acceptDispatch()
    -- get the most recent call
    local call = lib.callback.await('y_dispatch:server:GetLastCall')
    if not call then return end
    -- set a route to the location (not the gps marker)
    SetBlipRoute(blips[call.blipid], true)
    SetBlipRouteColour(blips[call.blipid], 60)
    local time = GetGameTimer()
    repeat
        Wait(500)
    until (#(GetEntityCoords(cache.ped) - GetBlipCoords(blips[call.blipid])) <= 50) or (GetGameTimer() - time >= 1000 * 60 * 15) -- arrived there or 15 minutes
    SetBlipRoute(blips[call.blipid], false)
end

--#endregion Functions
--#region Events

--- Adds a call to the NUI
---@param Data table
---@param CallId number
RegisterNetEvent('y_dispatch:client:AddCall', function(Data, CallId)
    if not Data or not playerState.isLoggedIn then return end
    if not Data.coords then return end

    if DispatchDisabled then return end
    if Data.jobs and not CheckJob(Data.jobs, QBX.PlayerData.job) then return end
    if config.onlyOnDuty and not QBX.PlayerData.job.onduty then return end

    if Data.speed then Data.speed = (config.useMPH and math.ceil(Data.speed * 2.236936) .. " Mph") or
        (math.ceil(Data.speed * 3.6) .. " Km/h") end
    Data.distance = qbx.math.round(#(GetEntityCoords(cache.ped) - Data.coords))

    SendNUIMessage({
        type = "AddCall",
        id = CallId,
        data = Data,
    })
end)

RegisterNetEvent('y_dispatch:client:PlaySound', function(tencodeid, jobs, coords)
    local sound = tenCodes[tencodeid].sound
    if not sound then return end

    if not sound.playOnPed then
        if playerState.dispatchMuted or DispatchDisabled then return end
        if jobs then
            if not CheckJob(jobs, QBX.PlayerData.job) then return end
            if config.onlyOnDuty and not QBX.PlayerData.job.onduty then return end
        end
    end

    qbx.playAudio({ source = sound.playOnPed and coords, audioName = sound.name, audioRef = sound.ref })
end)

--- Adds a blip to the map
---@param coords vector3
---@param data table
---@param CallId number
RegisterNetEvent("y_dispatch:client:AddBlip", function(coords, data, CallId)
    if DispatchDisabled then return end
    if not data?.jobs or not CheckJob(data?.jobs, QBX.PlayerData.job) then return end
    if not (not config.onlyOnDuty or QBX.PlayerData.job.onduty) then return end
    local alpha = 255
    local radiusAlpha = 128
    local blip, radius
    local sprite, color, scale = data.blip.sprite or 161, data.blip.color or 84, data.blip.scale or 1.0

    --TODO: AddBlipForRadius and AddBlipForCoord do the "same" thing, you can supposedly add the sprite to the radius.
    -- simplify it into just blips and use the correct native depending on data.blip.offset
    if data.blip.offset then
        radius = data.blip.radius and
            AddBlipForRadius(coords.x + offsetx, coords.y + offsety, coords.z, data.blip.radius)
        blip = AddBlipForCoord(coords.x + offsetx, coords.y + offsety, coords.z)
        blips[CallId] = blip
        radiuses[CallId] = radius
    else
        radius = data.blip.radius and AddBlipForRadius(coords.x, coords.y, coords.z, data.radius)
        blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        blips[CallId] = blip
        radiuses[CallId] = radius
    end

    -- TODO: TEST WTF DOES THAT DOOOO??????
    -- PulseBlip(blip)
    -- SetBlipBright(blip, true)
    -- SetBlipCategory(blip, 2)
    --SetBlipFade(blip, 1, 1) -- could replace dumb alpha while loops????
    -- SetBlipSecondaryColour(blip, r, g, b)

    -- TODO: difference?
    -- SetBlipFlashesAlternate(blip, true)
    -- SetBlipFlashes(blip, true)

    SetBlipFlashes(blip, data.blip.flash or false)
    SetBlipSprite(blip, sprite)
    SetBlipHighDetail(blip, true)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, color)
    SetBlipAlpha(blip, alpha)
    SetBlipAsShortRange(blip, false)
    SetBlipCategory(blip, 2)
    SetBlipColour(radius, data.radiusColor or color)
    SetBlipAlpha(radius, radiusAlpha)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(data.tencode .. ' - ' .. data.description)
    EndTextCommandSetBlipName(blip)
    while radiusAlpha ~= 0 do
        Wait(((data.blip.length and data.blip.length or 10) * 1000) / 128)
        radiusAlpha = radiusAlpha - 1
        alpha = alpha - 1
        SetBlipAlpha(radius, radiusAlpha)
        SetBlipAlpha(blip, alpha)
        if radiusAlpha == 0 then
            RemoveBlip(radius)
            RemoveBlip(blip)
            return
        end
    end
end)

RegisterNetEvent('CEventMeleeAction', function(_, ped)
    if not config.events.fight.enabled then return end
    if fightAntiSpam then return end
    fight(ped)
end)

AddEventHandler('CEventShockingGunshotFired', function(_, ped, _)
    if not config.events.shotsfired.enabled then return end
    if shotsfiredAntiSpam then return end
    shotfired(ped)
end)

--- Removes a blip from the map
---@param CallId number
RegisterNetEvent("y_dispatch:client:RemoveBlip", function(CallId)
    RemoveBlip(blips[CallId])
    RemoveBlip(radius2[CallId])
    radiuses[CallId] = nil
    blips[CallId] = nil
end)

--- Clears all blips from the map
RegisterNetEvent("y_dispatch:client:ClearBlips", function()
    for _, v in pairs(blips) do
        RemoveBlip(v)
    end
    for _, v in pairs(radiuses) do
        RemoveBlip(v)
    end
    radiuses = {}
    blips = {}
    exports.qbx_core:Notify(locale('success.clearedblips'), "success")
end)

--- Disables the dispatch
RegisterNetEvent("y_dispatch:client:DisableDispatch", function()
    DispatchDisabled = not DispatchDisabled
    exports.qbx_core:Notify(DispatchDisabled and locale('success.disabledDispatch') or locale('success.enabledDispatch'),
        "success")
end)

--- Sends a message to the dispatch when someone send a message to 911 (NPWD)
RegisterNetEvent('y_dispatch:NPWD:Text911', function(message)
    local msg = message
    if string.len(msg) <= 0 then
        exports.qbx_core:Notify(locale('error.nomessage'), 'error')
        return
    end
    if exports.qbx_policejob:IsHandcuffed() then
        exports.qbx_core:Notify(locale('error.handcuffed'), 'error')
        return
    end
    if exports.npwd:isPhoneDisabled() then
        exports.qbx_core:Notify(locale('error.disabledphone'), 'error')
        return
    end

    local anonymous = (((config.allowAnonText and string.split(message, " ")[1] == "anon") and true) or false)
    if anonymous then message = string.gsub(message, "anon ", "") end
    EmergencyCall(message, 911, anonymous)
end)

--- Sends a message to the dispatch when someone send a message to 912 (NPWD)
RegisterNetEvent('y_dispatch:NPWD:Text912', function(message)
    local msg = message
    if string.len(msg) <= 0 then
        exports.qbx_core:Notify(locale('error.nomessage'), 'error')
        return
    end
    if exports.qbx_policejob:IsHandcuffed() then
        exports.qbx_core:Notify(locale('error.handcuffed'), 'error')
        return
    end
    if exports.npwd:isPhoneDisabled() then
        exports.qbx_core:Notify(locale('error.disabledphone'), 'error')
        return
    end

    local anonymous = (((config.allowAnonText and string.split(message, " ")[1] == "anon") and true) or false)
    if anonymous then message = string.gsub(message, "anon ", "") end
    EmergencyCall(message, 912, anonymous)
end)
--#endregion Events

--#region Keybinds
--- Accepting and denying calls
lib.addKeybind({
    name = 'acceptdispatch',
    description = locale('general.acceptdispatchcall'),
    defaultKey = config.acceptDispatchKey,
    onPressed = acceptDispatch
})

lib.addKeybind({
    name = 'denydispatch',
    description = locale('general.denydispatchcall'),
    defaultKey = config.denyDispatchKey,
    onPressed = function()
        SendNUIMessage({ type = 'RemoveCall' })
    end
})
---
--#endregion Keybinds