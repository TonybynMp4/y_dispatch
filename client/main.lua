QBCore = exports['qbx-core']:GetCoreObject()

local blips, radiuses, DispatchDisabled = {}, {}, false
--#region Functions
--#region Getter Functions

---@param vehicle number
---@return table
function GetVehicleData(vehicle)
    local Data = {}
    local classes = { Lang:t('classes.compact'), Lang:t('classes.sedan'), Lang:t('classes.suv'), Lang:t('classes.coupe'),
        Lang:t('classes.muscle'), Lang:t('classes.sports_classic'), Lang:t('classes.sports'), Lang:t('classes.super'),
        Lang:t('classes.motorcycle'), Lang:t('classes.offroad'), Lang:t('classes.industrial'), Lang:t('classes.utility'),
        Lang:t('classes.van'), Lang:t('classes.service'), Lang:t('classes.military'), Lang:t('classes.truck') }
    Data.class = classes[GetVehicleClass(vehicle)]
    Data.plate = GetVehicleNumberPlateText(vehicle)
    Data.name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    Data.id = NetworkGetNetworkIdFromEntity(vehicle)
    if Data.name == 'NULL' then Data.name = QBCore.Shared.Vehicles[model].name end
    local color1, color2 = GetVehicleColours(vehicle)
    local color = Lang:t('general.unknown')
    if color1 then
        if Lang:t('colors.' .. tostring(color1)) and Lang:t('colors.' .. tostring(color2)) then
            color = Lang:t('colors.' .. tostring(color2)) .. " & " .. Lang:t('colors.' .. tostring(color1))
        elseif Lang:t('colors.' .. tostring(color1)) then
            color = Lang:t('colors.' .. tostring(color1))
        elseif Lang:t('colors.' .. tostring(color2)) then
            color = Lang:t('colors.' .. tostring(color2))
        end
    end
    Data.color = color
    local doorcount = 0
    local doors = { 'door_dside_f', 'door_pside_f', 'door_dside_r', 'door_pside_r' }
    for i = 1, #doors do
        if GetEntityBoneIndexByName(vehicle, doors[i]) ~= -1 then doorcount = doorcount + 1 end
    end
    Data.doors = doorcount >= 2 and Lang:t('general.' .. doorcount .. '_door')
    return Data
end

---@return string
function GetGender()
    local PlayerData = QBCore.Functions.GetPlayerData()
    return PlayerData.charinfo.gender
end

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

---@param coords vector3
---@return string
function GetStreet(coords)
    return GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
end

---@param coords vector3
---@return string
function GetZone(coords)
    return GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
end

---@param coords vector3
---@return string
function GetLocation(coords)
	return GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z)) .. ", " .. GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
end
--#endregion Getter Functions

function CheckJob(jobs, playerjob)
    for _, v in pairs(jobs) do
        if playerjob == v then
            return true
        end
    end
end

--#endregion Functions
--#region Events

---@param Data table
---@param CallId number
RegisterNetEvent('qbx-dispatch:client:AddCall', function(Data, CallId)
    if DispatchDisabled then return end
    if not Data or not LocalPlayer.state.isLoggedIn then return end
    local PlayerData = QBCore.Functions.GetPlayerData()
    if Data.jobs and not CheckJob(Data.jobs, PlayerData.job.name) then return end
    if not Config.OnlyOnDuty or PlayerData.job.onduty then
        if Data.coords then
            SendNUIMessage({
                type = "AddCall",
                id = CallId,
                data = Data,
            })
            local sound = Config.TenCodes[Data.tencodeid].sound
    if PlayerData.metadata.mutedispatch or not sound then return end
    if not sound.custom then PlaySound(-1, sound.name, sound.ref, false, false, true) return end
    TriggerServerEvent("InteractSound_SV:PlayOnSource", sound.name, sound.volume or 0.25) -- For Custom Sounds
        end
    end
end)

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

---@param CallId number
RegisterNetEvent("qbx-dispatch:client:RemoveBlip", function(CallId)
	RemoveBlip(blips[CallId])
	RemoveBlip(radius2[CallId])
    radiuses[CallId] = nil
    blips[CallId] = nil
end)


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

RegisterNetEvent("qbx-dispatch:client:DisableDispatch", function()
    DispatchDisabled = not DispatchDisabled
    TriggerClientEvent('QBCore:Notify', source, DispatchDisabled and Lang:t('success.disableddispatch') or Lang:t('success.enableddispatch'), "success")
end)
--#endregion Events