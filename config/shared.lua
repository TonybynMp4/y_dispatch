return {
    dispatchJobs = { -- Jobs that uses the dispatch system
        Jobs = {
            police = true,
            sheriff = true,
            ambulance = true
        },
        Types = {
            leo = true,
            medic = true,
            ems = true
        }
    },
    tenCodes = {
        --[[
        ["TenCodeId"] = {
            tencode = '10-Code',
            title = 'Title of the call',
            description = 'name of the blip', (10-code - name)
            jobs = {
                jobs = {
                    jobs that can see the call (i.e. {'police', 'sheriff'})
                },
                types = {
                    job types that can see the call (i.e. {'leo', 'mechanic'})
                }
                -- or strings
                'police',
                'sheriff',
            },
            blip = {
                radius = radius of the zone, ( 0 = no zone)
                sprite = sprite of the blip, (https://docs.fivem.net/game-references/blips/)
                color = color of the blip,
                scale = scale of the blip,
                length = 60 * time the blip will be displayed (in seconds),
                offset = {
                    min = minimum distance to offset the blip,
                    max = maximum distance to offset the blip (make sure it's not bigger than the radius)
                },
                flash = does the blip flash or not
            },
            sound = {
                ref = ref of the sound (https://pastebin.com/A8Ny8AHZ),
                name = name of the sound (https://pastebin.com/A8Ny8AHZ or name of the sound's filename if custom),
                custom = custom sound file (Interact-Sound)
                volume = if custom sound, volume of the sounds (0.0 - 1.0) default 0.25
            },
        }
     ]]
        ["carjack"] = {
            tencode = '10-59',
            title = Lang:t('title.carjack'),
            description = Lang:t('tencodes.carjack'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 595,
                color = 60,
                scale = 1.5,
                length = 60 * 2,
                flash = false,
                offset = false,
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["vehicletheft"] = {
            tencode = '10-59',
            title = Lang:t('title.vehicletheft'),
            description = Lang:t('tencodes.vehicletheft'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 595,
                color = 60,
                scale = 1.5,
                length = 60 * 2,
                offset = false,
                flash = false
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["speedradar"] = {
            tencode = '10-55',
            title = Lang:t('title.speedradar'),
            description = Lang:t('tencodes.speedradar'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 326,
                color = 84,
                scale = 1.5,
                length = 60 * 10,
                offset = false,
                flash = true
            },
        },
        ["driveby"] = {
            tencode = '10-31',
            title = Lang:t('title.driveby'),
            description = Lang:t('tencodes.driveby'),
            name = Lang:t('tencodes.driveby'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                sprite = 119,
                radius = 120.0,
                color = 1,
                scale = 0,
                length = 60 * 2,
                flash = false,
                offset = {
                    min = 20,
                    max = 100
                },
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["shooting"] = {
            tencode = '10-31',
            title = Lang:t('title.shooting'),
            description = Lang:t('tencodes.shooting'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 120.0,
                sprite = 110,
                color = 1,
                scale = 1.0,
                length = 60 * 2,
                flash = false,
                offset = {
                    min = 20,
                    max = 100
                },
            },
            sound = {
                ref = "GTAO_FM_Events_Soundset",
                name = "Lose_1st",
            }
        },
        ["fight"] = {
            tencode = '10-30',
            title = Lang:t('title.fight'),
            description = Lang:t('tencodes.fight'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 80.0,
                color = 69,
                scale = 1.0,
                length = 60 * 2,
                sprite = 685,
                offset = {
                    min = 20,
                    max = 50
                },
                flash = false
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["death"] = {
            tencode = '10-30',
            title = Lang:t('title.death'),
            description = Lang:t('tencodes.death'),
            jobs = { jobs = { 'ambulance' } },
            blip = {
                radius = 100,
                sprite = 126,
                color = 3,
                scale = 1.5,
                length = 60 * 2,
                offset = {
                    min = 20,
                    max = 50
                },
                flash = false
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["pol99"] = {
            tencode = '10-99',
            title = Lang:t('title.pol99'),
            description = Lang:t('tencodes.pol99'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 100.0,
                sprite = 526,
                color = 1,
                scale = 1.5,
                length = 60 * 2,
                offset = {
                    min = 20,
                    max = 50
                },
                flash = false
            },
            sound = {
                name = "panic", -- Comes with qbox's Interact-Sound
                custom = true,
                volume = 0.2
            }
        },
        ["ems99"] = {
            tencode = '10-99',
            title = Lang:t('title.ems99'),
            description = Lang:t('tencodes.ems99'),
            jobs = { jobs = { 'police', 'sheriff', 'ambulance' }, types = { 'leo' } },
            blip = {
                radius = 100.0,
                sprite = 526,
                color = 3,
                scale = 1.5,
                length = 60 * 2,
                offset = {
                    min = 20,
                    max = 50
                },
                flash = false
            },
            sound = {
                name = "panic", -- Comes with qbox's Interact-Sound
                custom = true,
                volume = 0.2
            }
        },
        ["911call"] = {
            tencode = '911',
            title = Lang:t('title.911call'),
            description = Lang:t('tencodes.911call'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 480,
                color = 1,
                scale = 1.5,
                length = 60 * 5,
                offset = false,
                flash = false
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["912call"] = {
            tencode = '912',
            title = Lang:t('title.912call'),
            description = Lang:t('tencodes.912call'),
            jobs = { jobs = { 'ambulance' } },
            blip = {
                radius = 0,
                color = 3,
                scale = 1.5,
                length = 60 * 2,
                sprite = 480,
                offset = false,
                flash = false
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["storerobbery"] = {
            tencode = '10-40',
            title = Lang:t('title.storerobbery'),
            description = Lang:t('tencodes.storerobbery'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 52,
                color = 1,
                scale = 1.5,
                length = 60 * 2,
                offset = false,
                flash = false
            },
            sound = {
                name = "Event_Start_Text",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["bankrobbery"] = {
            tencode = '10-91',
            title = Lang:t('title.bankrobbery'),
            description = Lang:t('tencodes.bankrobbery'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 500,
                color = 2,
                scale = 1.5,
                length = 60 * 2,
                offset = false,
                flash = false
            },
            sound = {
                name = "Event_Start_Text",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["paletorobbery"] = {
            tencode = '10-91',
            title = Lang:t('title.paletorobbery'),
            description = Lang:t('tencodes.paletorobbery'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 500,
                color = 12,
                scale = 1.5,
                length = 60 * 2,
                offset = false,
                flash = false
            },
            sound = {
                name = "Event_Start_Text",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["pacificrobbery"] = {
            tencode = '10-93',
            title = Lang:t('title.pacificrobbery'),
            description = Lang:t('tencodes.pacificrobbery'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 500,
                color = 5,
                scale = 1.5,
                length = 60 * 2,
                offset = false,
                flash = false
            },
            sound = {
                name = "Event_Start_Text",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["prisonbreak"] = {
            tencode = '10-94',
            title = Lang:t('title.prisonbreak'),
            description = Lang:t('tencodes.prisonbreak'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 189,
                color = 59,
                scale = 1.5,
                length = 60 * 2,
                offset = false,
                flash = false
            },
            sound = {
                name = "Event_Start_Text",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["jewelryrobbery"] = {
            tencode = '10-92',
            title = Lang:t('title.jewelryrobbery'),
            description = Lang:t('tencodes.jewelryrobbery'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 434,
                color = 5,
                scale = 1.5,
                length = 60 * 2,
                offset = false,
                flash = false
            },
            sound = {
                name = "Event_Start_Text",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["houserobbery"] = {
            tencode = '10-37',
            title = Lang:t('title.houserobbery'),
            description = Lang:t('tencodes.houserobbery'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 40,
                color = 5,
                scale = 1.5,
                length = 60 * 2,
                offset = false,
                flash = false
            },
            sound = {
                name = "Event_Start_Text",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["suspicioushandoff"] = {
            tencode = '10-60',
            title = Lang:t('title.suspicioushandoff'),
            description = Lang:t('tencodes.suspicioushandoff'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 250.0,
                sprite = 469,
                color = 52,
                scale = 0,
                length = 60 * 2,
                offset = {
                    min = 20,
                    max = 100
                },
                flash = false
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["carboosting"] = {
            tencode = '10-58',
            title = Lang:t('tencodes.carboosting'),
            description = Lang:t('tencodes.carboosting'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 595,
                color = 60,
                scale = 1.5,
                length = 60 * 2,
                offset = false,
                flash = false
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["explosion"] = {
            tencode = '10-80',
            title = Lang:t('title.explosion'),
            description = Lang:t('tencodes.explosion'),
            jobs = { jobs = { 'police', 'sheriff', 'ambulance' }, types = { 'leo' } },
            blip = {
                radius = 0,
                sprite = 436,
                color = 1,
                scale = 1.5,
                length = 60 * 2,
                offset = false,
                flash = false
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["DrugRun"] = {
            tencode = '10-61',
            title = Lang:t('title.drugrun'),
            description = Lang:t('tencodes.drugrun'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 120.0,
                sprite = 469,
                color = 52,
                scale = 1,
                length = 60 * 2,
                offset = {
                    min = 20,
                    max = 100
                },
                flash = false
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
        ["TruckRobbery"] = {
            tencode = '10-90',
            title = Lang:t('title.truckrobbery'),
            description = Lang:t('tencodes.truckrobbery'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 120.0,
                sprite = 67,
                color = 38,
                scale = 1,
                length = 60 * 2,
                offset = {
                    min = 20,
                    max = 100
                },
                flash = false
            },
            sound = {
                name = "Lose_1st",
                ref = "GTAO_FM_Events_Soundset",
            }
        },
    }
}
