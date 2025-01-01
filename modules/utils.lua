local dispatchJobs = require 'config.shared'.dispatchJobs

---@alias playerJob table

---@param playerJobs playerJob | playerJob[]
---@return table | false
local function GetPlayerDispatchPermissions(playerJobs)
    if not playerJobs then return false end
    local permissions = {
        dispatch = false,
        bolos = false,
        bracelets = false,
        panic = false
    }

    if not playerJobs.name then
        for _, job in pairs(playerJobs) do
            if dispatchJobs[job] then
                permissions.dispatch = true
                permissions.bolos = dispatchJobs[job].bolos
                permissions.bracelets = dispatchJobs[job].bracelets
                permissions.panic = dispatchJobs[job].panic
            end
        end
    else
        if dispatchJobs[playerJobs] then
            permissions.dispatch = true
            permissions.bolos = dispatchJobs[playerJobs].bolos
            permissions.bracelets = dispatchJobs[playerJobs].bracelets
            permissions.panic = dispatchJobs[playerJobs].panic
        end
    end

    return permissions
end

return {
    GetPlayerDispatchPermissions = GetPlayerDispatchPermissions
}