RegisterNuiCallback('getAllBOLOs', function(_, cb)
    local bolos = lib.callback.await('y_dispatch:server:getAllBOLOs')
    if not bolos then return cb({}) end

    cb(bolos)
end)

RegisterNuiCallback('addBolo', function(bolo, cb)
    local newBolo = lib.callback.await('y_dispatch:server:addBolo', bolo)
    if not newBolo then return cb({}) end

    cb(newBolo)
end)