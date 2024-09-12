local internalId = 0
-- yes i only support the old way, fuck qbox and their shitty "API"
local coreJobs = lib.load('@qbx_core.shared.jobs')


---@type table<string, jobCall[]>
local Calls = {}

exports('GetCalls', function() return Calls end)

---@param recipients number | number[]
---@param call jobCallData
local function sendCallToClients(recipients, call)
    ---@diagnostic disable-next-line: param-type-mismatch
    TriggerClientEvent('y_dispatch:client:AddCall', recipients, call)
    ---@diagnostic disable-next-line: param-type-mismatch
    TriggerClientEvent('y_dispatch:client:PlaySound', recipients, call.data.sound.ref, call.data.sound.name)
    ---@diagnostic disable-next-line: param-type-mismatch
    TriggerClientEvent("y_dispatch:client:AddBlip", recipients)
end

--TODO: get the players that are in the job(s)
-- (probably will wait for y_core and the job system, can't be bothered to figure out qbox's awful solution)
---@param jobs dispatchCallJobs
local function getCallRecipient(jobs)
    return -1
end


--TODO: core export cauz that should be a thing
local function getJobsFromTypes(types, jobs)
    jobs = jobs or {}

    for jobname, content in pairs(coreJobs) do
        if content.type and types[content.type] then
            jobs[#jobs+1] = jobname
        end
    end

    return jobs
end

local function calculateBlipOffset(offset)
    if offset and not offset.min or not offset.max then
        return lib.print.warn(("Dispatch Call: %s is misconfigured, ensure that it has both a min and a max value (Integers). current configuration: min: %s max: %s"):format(call.data.title, call.data.blip.offset.min, call.data.blip.offset.max))
    end

    local offsetX = offset and math.random(offset.min, offset.max)
    local offsetY = offset and math.random(offset.min, offset.max)

    return { x = offsetX, y = offsetY }
end

---@param callData dispatchCall
function AddCall(callData)
    ---@type jobCall
    local call = {
        internalId = internalId,
        source = source,
        time = os.time(),
        unitsIgnoring = {},
        data = {
            code = callData.code,
            title = callData.title,
            description = callData.description,
            details = callData.details,
            blip = {
                radius = callData.blip.radius,
                offset = callData.blip.offset and calculateBlipOffset(callData.blip.offset),
                sprite = callData.blip.sprite,
                color = callData.blip.color,
                scale = callData.blip.scale,
                length = callData.blip.length,
                flash = callData.blip.flash,
            },
            sound = callData.sound,
        },
    }

    local jobs = callData.jobs
    -- if jobs is a list of types, convert it to a list of jobs
    if jobs.types then
        jobs = getJobsFromTypes(callData.jobs.types, callData.jobs.jobs)
    elseif jobs.jobs then
        -- if you decided to not specify types, but use the subtable for jobs, just use that
        jobs = jobs.jobs
    end

    for job in pairs(jobs) do
        if not Calls[job] then Calls[job] = {} end
        Calls[job][#Calls[job] + 1] = call
    end

    local recipients = call.data.sound.playOnPed and -1 or getCallRecipient(jobs)
    sendCallToClients(recipients, call)
end

RegisterServerEvent("y_dispatch:server:AddCall", AddCall)

-- takes in a list of calls and filters out the ones that are duplicates
---@param calls table<string, jobCall[]>
---@return jobCall[]
local function filterDuplicateCalls(calls)
    local filteredCalls = {}

    for _, callList in pairs(calls) do
        for _, call in pairs(callList) do
            if not filteredCalls[call.internalId] then
                filteredCalls[call.internalId] = call
            end
        end
    end

    return filteredCalls
end

local function sortFilteredCalls(calls)
    table.sort(calls, function(a, b) return a.time < b.time end)
    return calls
end

lib.callback.register('y_dispatch:server:GetLastCall', function(source, jobs)
    local calls = {}
    for job in pairs(jobs) do
        if not Calls[job] then goto continue end
        if #Calls[job] == 0 then goto continue end

        calls[job] = Calls[job][#Calls[job]]
        ::continue::
    end

    calls = filterDuplicateCalls(calls)
    if not calls then return false end
    calls = sortFilteredCalls(calls)

    local call = calls[#calls]
    return call
end)

lib.callback.register('y_dispatch:server:GetRecentCalls', function(source, jobs)
    local recentCalls = {}
    local currentTimestamp = os.time()
    for i = #Calls, 1, -1 do
        print(currentTimestamp, Calls[i].time, currentTimestamp - Calls[i].time, (currentTimestamp - Calls[i].time) / (10^3))
        if (currentTimestamp - Calls[i].time) / (10^3) > 30 then
            break
        end

        recentCalls[#recentCalls + 1] = {blipid = Calls[i].id}
    end
    return false
end)

lib.callback.register('y_dispatch:server:GetAllCalls', function(source, jobs)
    local calls = {}
    for job in pairs(jobs) do
        for i = #Calls, 1, -1 do
            if Calls[i].data.jobs[job] then
                calls[#calls + 1] = {blipid = Calls[i].id}
            end
        end
    end

    return calls
end)

RegisterNetEvent('y_dispatch:server:RemoveCall', function()
    if not calls then return end
    for i = #calls, 1, -1 do
        if not calls[i].UnitsNotResponding[source] then
            calls[i].UnitsNotResponding[source] = true
            break
        end
    end
end)