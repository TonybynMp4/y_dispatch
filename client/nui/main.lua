local config = require 'config.client'

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
---@param permission? table
local function toggleDispatch(shouldShow, permission)
    if shouldShow and (IsNuiFocused() or not LocalPlayer.state.isLoggedIn) then
        return
    end
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('showDispatch', {show = shouldShow, permission = permission})
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

        toggleDispatch(true, GetPlayerPermissions(QBX.PlayerData.job).dispatch)
    end
})

RegisterNUICallback('hideDispatch', function(_, cb)
    toggleDispatch(false)
    cb({})
end)

-- Send Locales to NUI
RegisterNUICallback('GetLocales', function(data, cb)
    local locales = {
        justnow = locale('ui.justnow'),
        distance = locale('ui.distance'),
        automatic = locale('ui.automatic'),
        accept = "[" .. config.acceptDispatchKey .. "] " .. locale('ui.accept'),
        deny = "[" .. config.denyDispatchKey .. "] " .. locale('ui.deny')
    }

    cb(locales)
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