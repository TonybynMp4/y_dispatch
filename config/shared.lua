return {
    -- Jobs that uses the dispatch system & their rights
    -- the "dispatch" key is what lets you use the dispatch system at all
    -- the "bolos" key is what lets you see and use the BOLOs tab
    --TODO: the "bracelets" key is what lets you see and use the bracelets tab
    --TODO: the "panic" key is what lets you use the panic button
    ---@type dispatchJobs
    dispatchJobs = {
        jobs = {
            police = {
                dispatch = true,
                bolos = true,
                bracelets = true,
                panic = true
            },
            sheriff = {
                dispatch = true,
                bolos = true,
                bracelets = true,
                panic = true
            },
            ambulance = {
                dispatch = true,
                bolos = true,
                panic = true,
            },
        },
        types = {
            leo = {
                dispatch = true,
                bolos = true,
                bracelets = true,
                panic = true
            },
            medic, ems = {
                dispatch = true,
                bolos = true,
                panic = true,
            },
        }
    },
}
