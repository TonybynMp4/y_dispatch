local tenCodes = require('config.shared').tenCodes

local automatics = {
    -95776620,
    970310034,
    1159398588,
    584646201,
}

local function VehicleTheft(vehicle)
    local vehdata = GetVehicleData(vehicle)
    local data = {
        tencodeid = "vehicletheft",
        tencode = tenCodes["vehicletheft"].tencode,
        location = GetLocation(GetEntityCoords(vehicle)),
        model = vehdata.name,
        class = vehdata.class,
        plate = vehdata.plate,
        type = 0,
        color = vehdata.color,
        heading = qbx.getCardinalDirection(),
        coords = GetEntityCoords(vehicle),
        title = tenCodes["vehicletheft"].title,
        jobs = tenCodes["vehicletheft"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('VehicleTheft', VehicleTheft)

local function CarJacking(vehicle)
    local vehdata = GetVehicleData(vehicle)
    local data = {
        tencodeid = "carjack",
        tencode = tenCodes["carjack"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        model = vehdata.name,
        class = vehdata.class,
        plate = vehdata.plate,
        type = 0,
        color = vehdata.color,
        heading = qbx.getCardinalDirection(),
        coords = GetEntityCoords(cache.vehicle),
        title = tenCodes["carjack"].title,
        jobs = tenCodes["carjack"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('CarJacking', CarJacking)

local function speedradar(vehicle)
    local vehdata = GetVehicleData(vehicle)
    local data = {
        tencodeid = "speedradar",
        tencode = tenCodes["speedradar"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        model = vehdata.name,
        class = vehdata.class,
        plate = vehdata.plate,
        speed = vehdata.speed,
        type = 0,
        color = vehdata.color,
        heading = qbx.getCardinalDirection(),
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["speedradar"].title,
        jobs = tenCodes["speedradar"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end exports('speedradar', speedradar)

local function DriveBy(vehicle)
    vehicle = vehicle or cache.vehicle
    local vehdata = GetVehicleData(vehicle)
    local data =  {
        tencodeid = "driveby",
        tencode = tenCodes["driveby"].tencode,
        location = GetLocation(GetEntityCoords(vehicle)),
        model = vehdata.name,
        class = vehdata.class,
        plate = vehdata.plate,
        gender = GetGender(),
        weapon = math.random() <= 0.5 and exports.ox_inventory:getCurrentWeapon().label,
        weaponclass = GetWeaponClass(cache.weapon) or nil,
        automatic = math.random() <= 0.5 and (automatics[GetWeapontypeGroup(cache.weapon)] or automatics[cache.weapon])or false,
        doors = vehdata.doors,
        type = 0,
        color = vehdata.color,
        heading = qbx.getCardinalDirection(),
        coords = GetEntityCoords(vehicle),
        title = tenCodes["driveby"].title,
        jobs = tenCodes["driveby"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('DriveBy', DriveBy)

local function Shooting()
    local data = {
        tencodeid = "shooting",
        tencode = tenCodes["shooting"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        gender = GetGender(),
        weapon = math.random() <= 0.5 and exports.ox_inventory:getCurrentWeapon().label,
        weaponclass = GetWeaponClass(cache.weapon) or nil,
        type = 0,
        automatic = math.random() <= 0.5 and automatics[GetWeapontypeGroup(cache.weapon)] or false,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["shooting"].title,
        jobs = tenCodes["shooting"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('Shooting', Shooting)

local function Fight()
    local data = {
        tencodeid = "fight",
        tencode = tenCodes["fight"].tencode,
        firstStreet = locationInfo,
        gender = GetGender(),
        type = 0,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["fight"].title,
        jobs = tenCodes["fight"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('Fight', Fight)

local function InjuriedPerson()
    local data = {
        tencodeid = "death",
        tencode = tenCodes["death"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        gender = GetGender(),
        type = 2,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["death"].title,
        jobs = tenCodes["death"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('InjuriedPerson', InjuriedPerson)

function EmergencyCall(message, phonenumber, anonymous)
    local data = {
        tencodeid = phonenumber.."call",
        tencode = tenCodes[phonenumber.."call"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        gender = GetGender(),
        type = 0,
        coords = GetEntityCoords(cache.ped),
        name = not anonymous and QBX.PlayerData.charinfo.lastname .. " " .. QBX.PlayerData.charinfo.firstname,
        number = not anonymous and QBX.PlayerData.charinfo.phone,
        information = message,
        title = tenCodes[phonenumber.."call"].title,
        jobs = tenCodes[phonenumber.."call"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('EmergencyCall', EmergencyCall)

local function Code99(servicetype)
    local service
    if servicetype == 'police' then
        service = 'pol99'
    elseif servicetype == 'ambulance' then
        service = 'ems99'
    end
    if not service then return end
    local data = {
        tencodeid = service,
        tencode = tenCodes[service].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        name = QBX.PlayerData.charinfo.lastname .. " " .. QBX.PlayerData.charinfo.firstname,
        callsign = QBX.PlayerData.metadata.callsign,
        type = 1,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes[service].title,
        jobs = tenCodes[service].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('Code99', Code99)

local function DrugRun(vehicle)
    local vehdata = GetVehicleData(vehicle)
    local data = {
        tencodeid = "DrugRun",
        tencode = tenCodes["DrugRun"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        gender = GetPedGender(),
        model = vehdata.name,
        class = vehdata.class,
        plate = vehdata.plate,
        type = 0,
        color = vehdata.color,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["DrugRun"].title,
        jobs = tenCodes["DrugRun"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end exports('DrugRun', DrugRun)

local function CornerSelling()
    local data = {
        tencodeid = "suspicioushandoff",
        tencode = tenCodes["suspicioushandoff"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        gender = GetGender(),
        type = 0,
        coords = GetEntityCoords(PlayerPedId()),
        title = tenCodes["suspicioushandoff"].title,
        jobs = tenCodes["suspicioushandoff"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('CornerSelling', CornerSelling)

local function StoreRobbery(camId)
    local data = {
        tencodeid = "storerobbery",
        tencode = tenCodes["storerobbery"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        gender = GetGender(),
        camId = camId,
        type = 0,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["storerobbery"].title,
        jobs = tenCodes["storerobbery"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('StoreRobbery', StoreRobbery)

local function TruckRobbery(coords)
    local data = {
        tencodeid = "TruckRobbery",
        tencode = tenCodes["TruckRobbery"].tencode,
        location = GetLocation(coords),
        gender = GetGender(),
        type = 0,
        coords = coords,
        title = tenCodes["TruckRobbery"].title,
        jobs = tenCodes["TruckRobbery"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end exports('TruckRobbery', TruckRobbery)

local function FleecaBankRobbery(coords, camId)
    print('HEY')
    local data = {
        tencodeid = "bankrobbery",
        tencode = tenCodes["bankrobbery"].tencode,
        location = GetLocation(coords),
        gender = GetGender(),
        camId = camId or nil,
        type = 0,
        coords = coords,
        title = tenCodes["bankrobbery"].title,
        jobs = tenCodes["bankrobbery"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('FleecaBankRobbery', FleecaBankRobbery)

local function PaletoBankRobbery(camId)
    TriggerServerEvent("qbx_dispatch:server:AddCall",{
        tencodeid = "paletobankrobbery",
        tencode = tenCodes["paletobankrobbery"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        gender = GetGender(),
        camId = camId,
        type = 0,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["paletobankrobbery"].title,
        jobs = tenCodes["paletobankrobbery"].jobs
    })
end
exports('PaletoBankRobbery', PaletoBankRobbery)

local function PacificBankRobbery(camId)
    local data = {
        tencodeid = "pacificbankrobbery",
        tencode = tenCodes["pacificbankrobbery"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        gender = GetGender(),
        camId = camId,
        type = 0,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["pacificbankrobbery"].title,
        jobs = tenCodes["pacificbankrobbery"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('PacificBankRobbery', PacificBankRobbery)

local function JewelryRobbery(camId)
    local data = {
        tencodeid = "jewelryrobbery",
        tencode = tenCodes["JewelryRobbery"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        gender = GetGender(),
        camId = camId,
        type = 0,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["JewelryRobbery"].title,
        jobs = tenCodes["JewelryRobbery"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('JewelryRobbery', JewelryRobbery)

local function HouseRobbery()
    local data = {
        tencodeid = "houserobbery",
        tencode = tenCodes["houserobbery"].tencode,
        location = GetLocation(GetEntityCoords(cache.ped)),
        gender = GetGender(),
        type = 0,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["houserobbery"].title,
        jobs = tenCodes["houserobbery"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", data)
end
exports('HouseRobbery', HouseRobbery)

local function Explosion(coords)
    TriggerServerEvent("qbx_dispatch:server:AddCall",{
        tencodeid = "explosion",
        tencode = tenCodes["explosion"].tencode,
        location = GetLocation(coords),
        type = 0,
        coords = coords,
        title = tenCodes["explosion"].title,
        jobs = tenCodes["explosion"].jobs
    })
end
exports('Explosion', Explosion)

local function CarBoosting(vehicle)
    local vehData = GetVehicleData(vehicle)
    if not vehData then return end
    local Data = {
        tencode = tenCodes["carboosting"].tencode,
        tencodeid = "carboosting",
        location = GetLocation(GetEntityCoords(cache.ped)),
        heading = qbx.getCardinalDirection(),
        gender = GetGender(),
        model = vehData.name,
        class = vehdata.class,
        plate = vehData.plate,
        type = 0,
        color = vehData.color,
        coords = GetEntityCoords(cache.ped),
        title = tenCodes["carboosting"].title,
        jobs = tenCodes["carboosting"].jobs
    }
    TriggerServerEvent("qbx_dispatch:server:AddCall", Data)
end
exports('CarBoosting', CarBoosting)

-- Defaults to a normal police call
local function CustomCall(data)
    local coords = data.coords or vec3(0.0, 0.0, 0.0)
    local jobs = data.job or { 'police' }

    TriggerServerEvent("qbx_dispatch:server:AddCall", {
        data = {
            tencode = data.tencode or "NONE",
            tencodeid = data.tencodeid or nil,
            location = GetLocation(coords),
            gender = data.gender and GetPedGender() or nil,
            model = data.model or nil,
            class = data.class or nil,
            plate = data.plate or nil,
            type = data.type or 0,
            color = data.color or nil,
            camId = data.camId or nil,
            callsign = data.callsign or nil,
            name = data.name or nil,
            doors = data.doors or nil,
            heading = data.heading or nil,
            weapon = data.weapon or nil,
            weaponclass = data.weaponclass or nil,
            automatic = data.automatic or false,
            coords = {
                x = coords.x,
                y = coords.y,
                z = coords.z
            },
            title = data.title or "",
            jobs = jobs,
        },
        TenCode = {
            tencode = data.tencode or "NONE",
            description = data.description or "",
            jobs = jobs,
            blip = {
                radius = data.radius or 0,
                sprite = data.sprite or 1,
                color = data.color or 1,
                scale = data.scale or 0.5,
                length = data.length or 2,
                offset = data.offset or "false",
                flash = data.flash or "false"
            },
            sound = {
                name = data.sound.name or "Lose_1st",
                ref = data.sound.ref or "GTAO_FM_Events_Soundset"
    }}})
end
exports('CustomCall', CustomCall)