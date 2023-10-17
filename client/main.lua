local classes = { Lang:t('classes.compact'), Lang:t('classes.sedan'), Lang:t('classes.suv'), Lang:t('classes.coupe'), Lang:t('classes.muscle'), Lang:t('classes.sports_classic'), Lang:t('classes.sports'), Lang:t('classes.super'), Lang:t('classes.motorcycle'), Lang:t('classes.offroad'), Lang:t('classes.industrial'), Lang:t('classes.utility'), Lang:t('classes.van'), Lang:t('classes.service'), Lang:t('classes.military'), Lang:t('classes.truck') }
local blips, radiuses, DispatchDisabled = {}, {}, false

-- Send Locales to NUI
RegisterNUICallback('GetLocales', function(data, cb)
    local locales = json.decode(LoadResourceFile(GetCurrentResourceName(), "locales/" .. GetConvar("qb_locale", "en") .. ".json"))
    locales.accept = "[" .. Config.AcceptDispatchKey .. "]" .. locales.accept
    locales.deny = "[" .. Config.DenyDispatchKey.. "]" .. locales.deny
    cb(locales)
end)

-- waits for the call to be removed before changing the table
RegisterNuiCallback('RemoveCall', function(_, cb)
    TriggerServerEvent('qbx-dispatch:server:RemoveCall')
    cb('ok')
end)

--#region Functions
--#region Getter Functions

--- returns the vehicle's data ( model, class, name, plate, NetId, speed, color, n° of doors)
---@param vehicle number
---@return table
function GetVehicleData(vehicle)
    local Data = {}
    Data.class = classes[GetVehicleClass(vehicle)]
    Data.plate = GetVehicleNumberPlateText(vehicle)
    Data.id = NetworkGetNetworkIdFromEntity(vehicle)
    Data.speed = GetEntitySpeed(vehicle)
    Data.name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    Data.name = Data.name == 'NULL' and exports.qbx_core:GetVehiclesByName().Vehicles[model].name or Data.name

    local primary, secondary = GetVehicleColours(vehicle)
    local color1, color2 = Lang:t('colors.' .. primary), Lang:t('colors.' .. secondary)
    Data.color = ((color1 and color2) and (color2 .. " & " .. color1)) or (color1 and color1) or (color2 and color2) or Lang:t('general.unknown')

    local doorcount = 0
    local doors = { 'door_dside_f', 'door_pside_f', 'door_dside_r', 'door_pside_r' }
    for i = 1, #doors do
        if GetEntityBoneIndexByName(vehicle, doors[i]) ~= -1 then doorcount = doorcount + 1 end
    end
    Data.doors = doorcount >= 2 and Lang:t('general.' .. doorcount .. '_door')
    return Data
end

--- returns the player's gender
---@return string
function GetGender()
    return tostring(QBX.PlayerData.charinfo.gender)
end

--- returns the heading of the player
---@return string
function GetHeading()
    local heading = GetEntityHeading(cache.ped)
    if (heading >= 315 or heading < 45) then
        return Lang:t('general.north')
    elseif (heading >= 45 and heading < 135) then
        return Lang:t('general.west')
    elseif (heading >= 135 and heading < 225) then
        return Lang:t('general.south')
    else
        return Lang:t('general.east')
    end
end

local WeaponClasses = {
    [2685387236] = Lang:t('WeaponClasses.melee'),
    [416676503] = Lang:t('WeaponClasses.gun'),
    [-95776620] = Lang:t('WeaponClasses.submachinegun'),
    [860033945] = Lang:t('WeaponClasses.shotgun'),
    [970310034] = Lang:t('WeaponClasses.assaultrifle'),
    [1159398588] = Lang:t('WeaponClasses.lightmachinegun'),
    [3082541095] = Lang:t('WeaponClasses.sniper'),
    [2725924767] = Lang:t('WeaponClasses.heavyweapon'),
    [1548507267] = Lang:t('WeaponClasses.throwables'),
    [4257178988] = Lang:t('WeaponClasses.misc'),
}

--- Returns the Class of a weapon (e.g. Melee, Handguns, Shotguns, etc.)
---@param SelectedWeapon number
---@return string
function GetWeaponClass(SelectedWeapon)
    return WeaponClasses[GetWeapontypeGroup(SelectedWeapon)] or Lang:t('general.unknown')
end

--- Returns the street at coords
---@param coords vector3
---@return string
function GetStreet(coords)
    return GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
end

--- Returns the zone at coords
---@param coords vector3
---@return string
function GetZone(coords)
    return GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
end

--- Returns the location (street + zone) at coords
---@param coords vector3
---@return string
function GetLocation(coords)
	return GetStreet(coords) .. ", " .. GetZone(coords)
end
--#endregion Getter Functions

local fightAntiSpam = false
local function fight(ped)
    if ped ~= cache.ped then return end

    if CheckJob(Config.Events.fight.jobwhitelist, QBX.PlayerData.job) and QBX.PlayerData.job.onduty then return end

    fightAntiSpam = true
    exports.qbx_dispatch:Fight()
    SetTimeout(30 * 1000, function() -- Wait 30 seconds to avoid spam.
        fightAntiSpam = false
    end)
end

local shotsfiredAntiSpam = false
local function shotfired(ped)
    if ped ~= cache.ped then return end
    if IsPedCurrentWeaponSilenced(ped) and math.random() <= 0.98 then return end
    -- 2% chance to trigger the event if the weapon is silenced, ( real life weapons are not 100% silent ;c )

    if CheckJob(Config.Events.shotsfired.jobwhitelist, QBX.PlayerData.job) and QBX.PlayerData.job.onduty then return end

    shotsfiredAntiSpam = true
    if cache.vehicle then
        exports.qbx_dispatch:DriveBy()
    else
        exports.qbx_dispatch:Shooting()
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

local function acceptdispatch()
    -- get the most recent call
    local call = lib.callback.await('qbx-dispatch:server:GetLastCall', false)
    if not call then return end
    -- set a route to the location (not the gps marker)
    SetBlipRoute(blips[call.blipid], true)
    SetBlipRouteColour(blips[call.blipid], 60)
    repeat
        Wait(500)
    until(#(GetEntityCoords(cache.ped) - GetBlipCoords(blips[call.blipid])) <= 50)
        SetBlipRoute(blips[call.blipid], false)
end

--#endregion Functions
--#region Events

--- Adds a call to the NUI
---@param Data table
---@param CallId number
RegisterNetEvent('qbx-dispatch:client:AddCall', function(Data, CallId)
    if DispatchDisabled then return end
    if not Data or not LocalPlayer.state.isLoggedIn then return end
    if Data.jobs and not CheckJob(Data.jobs, QBX.PlayerData.job) then return end
    if Config.OnlyOnDuty and not QBX.PlayerData.job.onduty then return end
    if not Data.coords then return end
    if Data.speed then Data.speed = (Config.UseMPH and math.ceil(Data.speed * 2.236936) .. " Mph") or (math.ceil(Data.speed * 3.6) .. " Km/h") end
    Data.distance = math.round(#(GetEntityCoords(cache.ped) - Data.coords))
    SendNUIMessage({
        type = "AddCall",
        id = CallId,
        data = Data,
    })

    local sound = Config.TenCodes[Data.tencodeid].sound
    if QBX.PlayerData.metadata.mutedispatch or not sound then return end
    if not sound.custom then PlaySound(-1, sound.name, sound.ref, false, false, true) return end
    TriggerServerEvent("InteractSound_SV:PlayOnSource", sound.name, sound.volume or 0.25) -- For Custom Sounds
end)

--- Adds a blip to the map
---@param coords vector3
---@param data table
---@param CallId number
RegisterNetEvent("qbx-dispatch:client:AddBlip", function(coords, data, CallId)
    if DispatchDisabled then return end
    if not data?.jobs or not CheckJob(data?.jobs, QBX.PlayerData.job) then return end
    if not (not Config.OnlyOnDuty or QBX.PlayerData.job.onduty) then return end
    local alpha = 255
    local radiusAlpha = 128
    local blip, radius
    local sprite, colour, scale = data.blip.sprite or 161, data.blip.color or 84, data.blip.scale or 1.0
    if data.blip.offset then
        local offsetx, offsety = math.random(data.blip.offset.min, data.blip.offset.max), math.random(data.blip.offset.min, data.blip.offset.max)
        radius = data.blip.radius and AddBlipForRadius(coords.x + offsetx, coords.y + offsety, coords.z, data.blip.radius)
        blip = AddBlipForCoord(coords.x + offsetx, coords.y + offsety, coords.z)
        blips[CallId] = blip
        radiuses[CallId] = radius
    else
        radius = data.blip.radius and AddBlipForRadius(coords.x, coords.y, coords.z, data.radius)
        blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        blips[CallId] = blip
        radiuses[CallId] = radius
    end

    SetBlipFlashes(blip, data.blip.flash or false)
    SetBlipSprite(blip, sprite)
    SetBlipHighDetail(blip, true)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, colour)
    SetBlipAlpha(blip, alpha)
    SetBlipAsShortRange(blip, false)
    SetBlipCategory(blip, 2)
    SetBlipColour(radius, colour)
    SetBlipAlpha(radius, radiusAlpha)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(data.tencode .. ' - ' .. data.description)
    EndTextCommandSetBlipName(blip)
    while radiusAlpha ~= 0 do
        Wait(((data.blip.length and data.blip.length or 10) * 1000)/128)
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
    if fightAntiSpam then return end
    fight(ped)
end)

AddEventHandler('CEventShockingGunshotFired', function(_, ped, _)
    if not Config.Events.shotsfired then return end
    if shotsfiredAntiSpam then return end
    shotfired(ped)
end)

--- Removes a blip from the map
---@param CallId number
RegisterNetEvent("qbx-dispatch:client:RemoveBlip", function(CallId)
	RemoveBlip(blips[CallId])
	RemoveBlip(radius2[CallId])
    radiuses[CallId] = nil
    blips[CallId] = nil
end)

--- Clears all blips from the map
RegisterNetEvent("qbx-dispatch:client:ClearBlips", function()
	for _, v in pairs(blips) do
		RemoveBlip(v)
	end
	for _, v in pairs(radiuses) do
		RemoveBlip(v)
	end
    radiuses = {}
    blips = {}
	exports.qbx_core:Notify(Lang:t('success.clearedblips'), "success")
end)

--- Disables the dispatch
RegisterNetEvent("qbx-dispatch:client:DisableDispatch", function()
    DispatchDisabled = not DispatchDisabled
    exports.qbx_core:Notify(DispatchDisabled and Lang:t('success.disableddispatch') or Lang:t('success.enableddispatch'), "success")
end)

--- Sends a message to the dispatch when someone send a message to 911 (NPWD)
RegisterNetEvent('qbx-dispatch:NPWD:Text911', function(message)
    local msg = message
    if string.len(msg) <= 0 then exports.qbx_core:Notify(Lang:t('error.nomessage'), 'error') return end
    if exports['qbx-policejob']:IsHandcuffed() then exports.qbx_core:Notify(Lang:t('error.handcuffed'), 'error') return end
    if exports.npwd:isPhoneDisabled() then exports.qbx_core:Notify(Lang:t('error.disabledphone'), 'error') return end

    local anonymous = (((Config.AllowAnonText and string.split(message, " ")[1] == "anon") and true) or false)
    if anonymous then message = string.gsub(message, "anon ", "") end
    EmergencyCall(message, 911, anonymous)
end)

--- Sends a message to the dispatch when someone send a message to 912 (NPWD)
RegisterNetEvent('qbx-dispatch:NPWD:Text912', function(message)
    local msg = message
    if string.len(msg) <= 0 then exports.qbx_core:Notify(Lang:t('error.nomessage'), 'error') return end
    if exports['qbx-policejob']:IsHandcuffed() then exports.qbx_core:Notify(Lang:t('error.handcuffed'), 'error') return end
    if exports.npwd:isPhoneDisabled() then exports.qbx_core:Notify(Lang:t('error.disabledphone'), 'error') return end

    local anonymous = (((Config.AllowAnonText and string.split(message, " ")[1] == "anon") and true) or false)
    if anonymous then message = string.gsub(message, "anon ", "") end
    EmergencyCall(message, 912, anonymous)
end)
--#endregion Events

--#region Keybinds
--- Accepting and denying calls
lib.addKeybind({
    name = 'acceptdispatch',
    description = Lang:t('general.acceptdispatchcall'),
    defaultKey = Config.AcceptDispatchKey,
    onPressed = acceptdispatch
})

lib.addKeybind({
    name = 'denydispatch',
    description = Lang:t('general.denydispatchcall'),
    defaultKey = Config.DenyDispatchKey,
    onPressed = function()
        SendNUIMessage({type = 'RemoveCall'})
    end
})
---
--#endregion Keybinds