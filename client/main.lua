QBCore = exports['qbx-core']:GetCoreObject()

local classes = { Lang:t('classes.compact'), Lang:t('classes.sedan'), Lang:t('classes.suv'), Lang:t('classes.coupe'), Lang:t('classes.muscle'), Lang:t('classes.sports_classic'), Lang:t('classes.sports'), Lang:t('classes.super'), Lang:t('classes.motorcycle'), Lang:t('classes.offroad'), Lang:t('classes.industrial'), Lang:t('classes.utility'), Lang:t('classes.van'), Lang:t('classes.service'), Lang:t('classes.military'), Lang:t('classes.truck') }
local blips, radiuses, DispatchDisabled = {}, {}, false

-- Send Locales to NUI
RegisterNUICallback('GetLocales', function(data, cb)
    cb(LoadResourceFile(GetCurrentResourceName(), "locales/" .. GetConvar("ox:locales", "en") .. ".json"))
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
    Data.name = Data.name == 'NULL' and QBCore.Shared.Vehicles[model].name or Data.name

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
    local PlayerData = QBCore.Functions.GetPlayerData()
    return PlayerData.charinfo.gender
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

--- Checks if the player's job is in the jobs table
---@param jobs any
---@param playerjob any
---@return boolean
function CheckJob(jobs, playerjob)
    for _, v in pairs(jobs) do
        if playerjob == v then
            return true
        end
    end
end

--#endregion Functions
--#region Events

--- Adds a call to the NUI
---@param Data table
---@param CallId number
RegisterNetEvent('qbx-dispatch:client:AddCall', function(Data, CallId)
    if DispatchDisabled then return end
    if not Data or not LocalPlayer.state.isLoggedIn then return end
    local PlayerData = QBCore.Functions.GetPlayerData()
    if Data.jobs and not CheckJob(Data.jobs, PlayerData.job.name) then return end
    if Config.OnlyOnDuty and not PlayerData.job.onduty then return end
    if not Data.coords then return end

    if Data.speed then Data.speed = (Config.UseMPH and math.ceil(Data.speed * 2.236936) .. " Mph") or (math.ceil(Data.speed * 3.6) .. " Km/h") end

    SendNUIMessage({
        type = "AddCall",
        id = CallId,
        data = Data,
    })

    local sound = Config.TenCodes[Data.tencodeid].sound
    if PlayerData.metadata.mutedispatch or not sound then return end
    if not sound.custom then PlaySound(-1, sound.name, sound.ref, false, false, true) return end
    TriggerServerEvent("InteractSound_SV:PlayOnSource", sound.name, sound.volume or 0.25) -- For Custom Sounds
end)

--- Adds a blip to the map
---@param coords vector3
---@param data table
---@param CallId number
RegisterNetEvent("qbx-dispatch:client:AddBlip", function(coords, data, CallId)
    if DispatchDisabled then return end
    local PlayerData = QBCore.Functions.GetPlayerData()
    if not data.jobs and not CheckJob(data.jobs, PlayerData.job.name) then return end
    if not (not Config.OnlyOnDuty or PlayerData.job.onduty) then return end
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
	QBCore.Functions.Notify(Lang:t('success.clearedblips'), "success")
end)

--- Disables the dispatch
RegisterNetEvent("qbx-dispatch:client:DisableDispatch", function()
    DispatchDisabled = not DispatchDisabled
    QBCore.Functions.Notify(DispatchDisabled and Lang:t('success.disableddispatch') or Lang:t('success.enableddispatch'), "success")
end)

-- Sends a message to the dispatch when someone send a message to 911 (NPWD)
RegisterNetEvent('qbx-dispatch:NPWD:Text911', function(message)
    local msg = message
    if string.len(msg) <= 0 then QBCore.Functions.Notify(Lang:t('error.nomessage'), 'error') return end
    if exports['qbx-policejob']:IsHandcuffed() then QBCore.Functions.Notify(Lang:t('error.handcuffed'), 'error') return end
    if exports.npwd:isPhoneDisabled() then QBCore.Functions.Notify(Lang:t('error.disabledphone'), 'error') return end

    local anonymous = (((Config.AllowAnonText and string.split(message, " ")[1] == "anon") and true) or false)
    if anonymous then message = string.gsub(message, "anon ", "") end
    EmergencyCall(message, 911, anonymous)
end)

-- Sends a message to the dispatch when someone send a message to 912 (NPWD)
RegisterNetEvent('qbx-dispatch:NPWD:Text912', function(message)
    local msg = message
    if string.len(msg) <= 0 then QBCore.Functions.Notify(Lang:t('error.nomessage'), 'error') return end
    if exports['qbx-policejob']:IsHandcuffed() then QBCore.Functions.Notify(Lang:t('error.handcuffed'), 'error') return end
    if exports.npwd:isPhoneDisabled() then QBCore.Functions.Notify(Lang:t('error.disabledphone'), 'error') return end

    local anonymous = (((Config.AllowAnonText and string.split(message, " ")[1] == "anon") and true) or false)
    if anonymous then message = string.gsub(message, "anon ", "") end
    EmergencyCall(message, 912, anonymous)
end)
--#endregion Events