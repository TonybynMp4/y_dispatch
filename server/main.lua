local config = require 'config.server'
local dispatchJobs = require 'config.shared'.dispatchJobs

if config.versionCheck then
	lib.versionCheck('TonybynMp4/y_dispatch')
end

lib.addCommand('mutedispatch', {help = locale('commands.mutedispatch')}, function(source, _)
    Player(source).state:set('dispatchMuted', not Player(source).state.dispatchMuted, true)
    exports.qbx_core:Notify(source, locale('success.dispatch' .. ((Player(source).state.dispatchMuted and 'Muted') or 'Unmuted')), 'inform')
    exports.qbx_core:Save(source)
end)

lib.addCommand('disabledispatch', {help = locale('commands.disabledispatch')}, function(source, _)
    local job = exports.qbx_core:GetPlayer(source).PlayerData.job
    if not dispatchJobs.Types[job.type] or not dispatchJobs.Jobs[job.name] then return end

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