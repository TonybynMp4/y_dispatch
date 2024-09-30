local config = require 'config.server'
local dispatchJobs = require 'config.shared'.dispatchJobs

if config.versionCheck then
	lib.versionCheck('TonybynMp4/y_dispatch')
end

function HasDispatchEnabledGroup(playerJobs)
    if not playerJobs then return false end

    if playerJobs.name then
        if dispatchJobs.jobs[playerJobs.name].dispatch or dispatchJobs.types[playerJobs.type].dispatch then
            return true
        else
            return false
        end
    else
        for i = 1, #playerJobs do
            if dispatchJobs.jobs[playerJobs[i].name].dispatch or dispatchJobs.types[playerJobs[i].type].dispatch then
                return true
            end
        end
    end

    return false
end

lib.addCommand('mutedispatch', {help = locale('commands.mutedispatch')}, function(source, _)
    local PlayerData = exports.qbx_core:GetPlayer(source).PlayerData
    if HasDispatchEnabledGroup(PlayerData.job) then
        return exports.qbx_core:Notify(source, locale('error.noPermission'), 'error')
    end

    local playerState = Player(source).state
    Player(source).state:set('dispatchMuted', not playerState.dispatchMuted, true)
    exports.qbx_core:Notify(source, locale('success.dispatch' .. ((playerState.dispatchMuted and 'Muted') or 'Unmuted')), 'inform')
end)

lib.addCommand('disabledispatch', {help = locale('commands.disabledispatch')}, function(source, _)
    local job = exports.qbx_core:GetPlayer(source).PlayerData.job
    if not HasDispatchEnabledGroup(job) then
        return exports.qbx_core:Notify(source, locale('error.noPermission'), 'error')
    end

    TriggerClientEvent('y_dispatch:client:DisableDispatch', source)
end)

if config.useNpwd and GetResourceState('npwd') == 'started' then
    exports.npwd:onMessage('911', function(ctx)
        if ctx then
            TriggerClientEvent('y_dispatch:NPWD:Text911', ctx.source, ctx.data.message)
        end
    end)

    exports.npwd:onMessage('912', function(ctx)
        if ctx then
            TriggerClientEvent('y_dispatch:NPWD:Text912', ctx.source, ctx.data.message)
        end
    end)
end