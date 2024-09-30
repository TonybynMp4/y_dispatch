lib.callback.register('y_dispatch:server:getAllBOLOs', function(source)
    local bolos = MySQL.Sync.fetchAll('SELECT * FROM dispatch_bolos')
    if not bolos then return false end

    return bolos
end)

---@param source number
---@param data
---@return boolean
lib.callback.register('y_dispatch:server:createBolo', function(source, data)
    if not data then return false end

    local PlayerData = exports.qbx_core:GetPlayer(source).PlayerData

    -- check if the creator has the permission to create a bolo
    if not HasDispatchEnabledGroup(PlayerData.job) then
        return false
    end

    --TODO: add logs

    return MySQL.insert.await([[
        INSERT INTO dispatch_bolos (type, target, description, priority)
        VALUES (:type, :target, :description, :priority)
    ]], {
        type = data.type,
        target = data.target,
        description = data.description,
        priority = data.priority
    })
end)

lib.callback.register('y_dispatch:server:deleteBolo', function(source, id)
    if not id then return false end

    local PlayerData = exports.qbx_core:GetPlayer(source).PlayerData

    -- check if the creator has the permission to delete a bolo
    if not HasDispatchEnabledGroup(PlayerData.job) then
        return false
    end

    --TODO: add logs

    return MySQL.Sync.execute('DELETE FROM dispatch_bolos WHERE id = ?', {id})
end)

lib.callback.register('y_dispatch:server:updateBolo', function(source, data)
    if not data then return false end

    local PlayerData = exports.qbx_core:GetPlayer(source).PlayerData

    -- check if the creator has the permission to update a bolo
    if not HasDispatchEnabledGroup(PlayerData.job) then
        return false
    end


    --TODO: add logs
    return MySQL.update.await([[
        UPDATE dispatch_bolos
        SET type = :type, target = :target, description = :description, priority = :priority
        WHERE id = :id
    ]], {
        id = data.id,
        type = data.type,
        target = data.target,
        description = data.description,
        priority = data.priority,
    })
end)