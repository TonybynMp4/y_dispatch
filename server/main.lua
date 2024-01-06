local calls = {}
local config = require 'config/server'
local tenCodes = require 'config/shared'.tenCodes
local dispatchJobs = require 'config/shared'.dispatchJobs

if config.versionCheck then
	lib.versionCheck('TonybynMp4/qbx_dispatch')
end

RegisterServerEvent("qbx_dispatch:server:AddCall", function(info)
    local data = not info.TenCode and info or info.data
    data.time = os.time() * 1000
    local callId = #calls + 1
    local call = {
        source = source,
        id = callId,
        UnitsResponding = {},
        UnitsNotResponding = {},
        DispatcherResponses = {},
        time = data.time,
        data = data
    }
	calls[callId] = call
    TriggerClientEvent('qbx_dispatch:client:AddCall', -1, data, callId)
    if not info.TenCode then
        TriggerClientEvent("qbx_dispatch:client:AddBlip", -1, data.coords, tenCodes[data.tencodeid], callId)
    else
        TriggerClientEvent("qbx_dispatch:client:AddBlip", -1, data.coords, info.TenCode, callId)
    end
end)

lib.addCommand('mutedispatch', {help = Lang:t('commands.mutedispatch')}, function(source, _)
    Player(source).state:set('dispatchMuted', not Player(source).state.dispatchMuted, true)
    exports.qbx_core:Notify(source, Lang:t('success.dispatch' .. ((Player(source).state.dispatchMuted and 'Muted') or 'Unmuted')), 'inform')
    exports.qbx_core:Save(source)
end)

lib.addCommand('disabledispatch', {help = Lang:t('commands.disabledispatch')}, function(source, _)
    local job = exports.qbx_core:GetPlayer(source).PlayerData.job
    if not dispatchJobs.Types[job.type] or not dispatchJobs.Jobs[job.name] then return end

    TriggerClientEvent('qbx_dispatch:client:DisableDispatch', source)
end)

exports('GetCalls', function() return calls end)

lib.callback.register('qbx_dispatch:server:addUnit', function(_, id, unitid, unit)
    if not calls[id] then return end
    calls[id].UnitsResponding[unitid] = unit
    return calls[id].UnitsResponding
end)

lib.callback.register('qbx_dispatch:server:removeUnit', function(_, id, unitid)
    if not calls[id] then return end
    if not calls[id].UnitsResponding[unit] then return end
    calls[id].UnitsResponding[unitid] = nil
    return calls[id].UnitsResponding
end)

if config.useNpwd and GetResourceState('npwd') == 'started' then
    exports.npwd:onMessage('911', function(ctx)
        if ctx then
            TriggerClientEvent('qbx_dispatch:NPWD:Text911', ctx.source, ctx.data.message)
        end
    end)

    exports.npwd:onMessage('912', function(ctx)
        if ctx then
            TriggerClientEvent('qbx_dispatch:NPWD:Text912', ctx.source, ctx.data.message)
        end
    end)
end

RegisterNetEvent('qbx_dispatch:server:RemoveCall', function()
    if not calls then return end
    for i = #calls, 1, -1 do
        if calls[i].UnitsNotResponding[source] ~= true then
            calls[i].UnitsNotResponding[source] = true
            break
        end
    end
end)

lib.callback.register('qbx_dispatch:server:GetLastCall', function(source)
    for i = #calls, 1, -1 do
        if not calls[i].UnitsNotResponding[source] then
            return {blipid = calls[i].id}
        end
    end
end)