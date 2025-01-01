local Utils = require 'modules.utils'

lib.callback.register('y_dispatch:server:getAllBOLOs', function(source)
    local bolos = MySQL.Sync.fetchAll('SELECT * FROM dispatch_bolos WHERE active = 1')
    if not bolos then return false end

    return bolos
end)

---@param source number
---@param bolo BOLO
---@return BOLO | false
lib.callback.register('y_dispatch:server:createBolo', function(source, bolo)
    if not bolo then return false end

    local PlayerData = exports.qbx_core:GetPlayer(source).PlayerData

    -- check if the creator has the permission to create a bolo
    if not Utils.GetPlayerDispatchPermissions(PlayerData.job).bolos then
        return false
    end

    if not type(bolo.type) == 'number' or not type(bolo.priority) == 'number' or not type(bolo.target) == 'string' or not type(bolo.description) == 'string' then
        return false
    end

    if (not bolo.type == 0 or not bolo.type == 1) or (not bolo.priority >= 0 or not bolo.priority <= 2) then
        return false
    end

    --TODO: add logs

    local newBolo = MySQL.insert.await([[
        INSERT INTO dispatch_bolos (type, target, description, priority)
        VALUES (:type, :target, :description, :priority)
    ]], {
        type = bolo.type,
        target = bolo.target,
        description = bolo.description,
        priority = bolo.priority
    })

    lib.print.debug('New BOLO created', newBolo)

    return newBolo
end)

lib.callback.register('y_dispatch:server:deleteBolo', function(source, id)
    if not id then return false end

    local PlayerData = exports.qbx_core:GetPlayer(source).PlayerData

    -- check if the creator has the permission to delete a bolo
    if not Utils.GetPlayerDispatchPermissions(PlayerData.job).bolos then
        return false
    end

    --TODO: add logs

    local result = MySQL.update.await('UPDATE dispatch_bolos SET active = 0 WHERE id = :id', {
        id = id
    })

    lib.print.debug('BOLO deleted', result)

    return result
end)

lib.callback.register('y_dispatch:server:updateBolo', function(source, data)
    if not data then return false end

    local PlayerData = exports.qbx_core:GetPlayer(source).PlayerData

    -- check if the creator has the permission to update a bolo
    if not Utils.GetPlayerDispatchPermissions(PlayerData.job).bolos then
        return false
    end


    --TODO: add logs

    local result = MySQL.update.await([[
        UPDATE dispatch_bolos
        SET
            type = COALESCE(:type, type),
            target = COALESCE(:target, target),
            description = COALESCE(:description, description),
            priority = COALESCE(:priority, priority),
            active = COALESCE(:active, active)
        WHERE id = :id
    ]], {
        id = data.id,
        type = data.type,
        target = data.target,
        description = data.description,
        priority = data.priority,
        active = data.active
    })

    lib.print.debug('BOLO updated', result)

    return result
end)