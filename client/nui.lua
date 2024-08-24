local config = require 'config.client'

---@param action string The action you wish to target
---@param data any The data you wish to send along with this action
function SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

local function toggleDispatch(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('showDispatch', shouldShow)
end

lib.addKeybind({
    name = 'showDispatch',
    description = locale('general.showDispatch'),
    defaultKey = config.showDispatchKey,
    onPressed = function()
        toggleDispatch(true)
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

---comment
---@param _ any
---@param cb function
RegisterNuiCallback('getPlayerGroups', function(_, cb)
    local groups = {
        {name = QBX.PlayerData.job.name, label = PlayerData.job.label}
    }
    cb(groups)
end)

RegisterNuiCallback('getRecentCalls', function(_, cb)
    cb()
end)

RegisterNuiCallback('getAllCalls', function(_, cb)
    local calls = lib.callback.await('y_dispatch:server:GetCalls')

    cb(calls)
end)