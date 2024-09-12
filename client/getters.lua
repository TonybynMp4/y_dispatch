local WeaponClasses = {
    [2685387236] = locale('WeaponClasses.melee'),
    [416676503] = locale('WeaponClasses.gun'),
    [-95776620] = locale('WeaponClasses.submachinegun'),
    [860033945] = locale('WeaponClasses.shotgun'),
    [970310034] = locale('WeaponClasses.assaultrifle'),
    [1159398588] = locale('WeaponClasses.lightmachinegun'),
    [3082541095] = locale('WeaponClasses.sniper'),
    [2725924767] = locale('WeaponClasses.heavyweapon'),
    [1548507267] = locale('WeaponClasses.throwables'),
    [4257178988] = locale('WeaponClasses.misc'),
}

--- Returns the Class of a weapon (e.g. Melee, Handguns, Shotguns, etc.)
---@param SelectedWeapon number
---@return string
function GetWeaponClass(SelectedWeapon)
    return WeaponClasses[GetWeapontypeGroup(SelectedWeapon)] or locale('general.unknown')
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

---@param source any
---@param options dispatchCallDetails
---@return table
lib.callback.register('y_dispatch:server:GetCallDetails', function(source, options)
    local callDetails = {}

    if options.location then
        callDetails.location = GetStreet(coords) .. ", " .. GetZone(coords)
    end

    if options.person then
        callDetails.person = {}
        if options.person.gender then
            callDetails.person.gender = tostring(QBX.PlayerData.charinfo.gender)
        end
        if options.person.name then
            callDetails.person.name = QBX.PlayerData.charinfo.firstname .. " " .. QBX.PlayerData.charinfo.lastname
        end
        if options.person.callsign then
            callDetails.person.callsign = QBX.PlayerData.callsign
        end
        if options.person.phone then
            callDetails.person.phone = QBX.PlayerData.charinfo.phone
        end
    end

    if options.vehicle then
        local vehicle = cache.vehicle
        callDetails.vehicle = {}
        if options.vehicle.class then
            callDetails.class = classes[GetVehicleClass(vehicle)]
        end
        if options.vehicle.plate then
            callDetails.plate = qbx.getVehiclePlate(vehicle)
        end
        if options.vehicle.speed then
            callDetails.speed = GetEntitySpeed(vehicle)
        end
        if options.vehicle.model then
            local modelName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
            callDetails.name = modelName == 'NULL' and exports.qbx_core:GetVehiclesByName().Vehicles[model].name or modelName
        end
        if options.vehicle.color then
            local primary, secondary = GetVehicleColours(vehicle)
            local color1, color2 = locale('colors.' .. primary), locale('colors.' .. secondary)
            Data.color = ((color1 and color2) and (color2 .. " & " .. color1)) or (color1 and color1) or
                (color2 and color2) or
                locale('general.unknown')
        end
        if options.vehicle.doors then
            local doorcount = 0
            local doors = { 'door_dside_f', 'door_pside_f', 'door_dside_r', 'door_pside_r' }
            for i = 1, #doors do
                if GetEntityBoneIndexByName(vehicle, doors[i]) ~= -1 then doorcount = doorcount + 1 end
            end
            callDetails.vehicle.doors = doorcount >= 2 and locale('general.' .. doorcount .. '_door')
        end
    end

    return callDetails
end)