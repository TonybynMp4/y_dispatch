return {
    acceptDispatchKey = 'Y',
    denyDispatchKey = 'N',
    useMPH = false, -- Use MPH instead of KMH
    onlyOnDuty = true, -- Only display calls when on duty
    allowAnonText = true, -- Requires useNpwd = true, Allow anonymous Texts to 911/912 (start the text with: "anon [...]")

    -- These need to be tested and might spam the dispatch
    events = {
        fight = {
            enabled = true,
            jobwhitelist = {
                'police',
                'sheriff',
            },
        },
        shotsfired = {
            enabled = true,
            jobwhitelist = {},
        },
    }
}