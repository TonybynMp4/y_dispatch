local config = require 'config.client'
local Utils = require 'modules.utils'

---@param action string The action you wish to target
---@param data any The data you wish to send along with this action
function SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

SendReactMessage('setupLocales', {
    locale = lib.GetLocales().ui
})

---@param shouldShow boolean
---@param permissions? table | false
local function toggleDispatch(shouldShow, permissions)
    if shouldShow and (IsNuiFocused() or not LocalPlayer.state.isLoggedIn) then
        return
    end
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('showDispatch', {show = shouldShow, permissions = permissions})
end

lib.addKeybind({
    name = 'showDispatch',
    description = locale('general.showDispatch'),
    defaultKey = config.showDispatchKey,
    onPressed = function()
        -- prevent dispatch from opening if another resource is using NUI
        if IsNuiFocused() then
            return
        end

        toggleDispatch(true, Utils.GetPlayerDispatchPermissions(QBX.PlayerData.job))
    end
})

RegisterNUICallback('hideDispatch', function(_, cb)
    toggleDispatch(false)
    cb({})
end)

-- waits for the call to be removed before changing the table
RegisterNuiCallback('RemoveCall', function(_, cb)
    TriggerServerEvent('y_dispatch:server:RemoveCall')
    cb('ok')
end)

---@param _ any
---@param cb function
RegisterNuiCallback('getPlayerGroups', function(_, cb)
    local groups = {
        {name = QBX.PlayerData.job.name, label = PlayerData.job.label}
    }
    cb(groups)
end)

RegisterNuiCallback('getRecentCalls', function(_, cb)
    local calls = lib.callback.await('y_dispatch:server:GetRecentCalls')
    cb(calls)
end)

RegisterNuiCallback('getAllCalls', function(_, cb)
    local calls = lib.callback.await('y_dispatch:server:GetCalls')

    cb(calls)
end)