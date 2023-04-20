local QBCore = exports['qbx-core']:GetCoreObject()
local calls = {}

RegisterServerEvent("qbx-dispatch:server:AddCall", function(info)
    local data = not info.TenCode and info or info.data
    data.time = os.time() * 1000
    local callId = #calls + 1
    local call = {
        source = source,
        id = callId,
        UnitsResponding = {},
        DispatcherResponses = {},
        time = data.time,
    }
	calls[callId] = call
    table.insert( calls[callId], data )
    if data.automatic then data.automatic = Lang:t('general.automatic') end
    TriggerClientEvent('qbx-dispatch:client:AddCall', -1, data, callId)
    if not info.TenCode then
        TriggerClientEvent("qbx-dispatch:client:AddBlip", -1, data.coords, Config.TenCodes[data.tencodeid], callId)
    else
        TriggerClientEvent("qbx-dispatch:client:AddBlip", -1, data.coords, info.TenCode, callId)
    end
end)

QBCore.Commands.Add('mutedispatch', Lang:t('commands.mutedispatch'), {}, false, function(source, _)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.SetMetaData('mutedispatch', not Player.PlayerData.metadata['mutedispatch'])
    QBCore.Player.Save(source)
end)

QBCore.Commands.Add('disabledispatch', Lang:t('commands.disabledispatch'), {}, true, function(source, _)
    local job = QBCore.Functions.GetPlayer(source).PlayerData.job
    if not Config.DisptachJobs[job.name] then return end

    TriggerClientEvent('qbx-dispatch:client:DisableDispatch', source)
end)