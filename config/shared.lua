return {
    -- Jobs that uses the dispatch system
    dispatchJobs = {
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
                radiusColour = color of the blip, (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
                sprite = sprite of the blip, (https://docs.fivem.net/game-references/blips/)
                color = color of the blip, (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
                scale = scale of the blip,
                length = 60 * time the blip will be displayed (in seconds),
                offset = {
                    min = minimum distance to offset the blip,
                    max = maximum distance to offset the blip (make sure it's not bigger than the radius)
                },
                flash = does the blip flash or not
            },
            sound = {
                ref = soundset of the sound (https://wiki.rage.mp/index.php?title=Sounds),
                name = name of the sound,
                playOnPed = boolean -- plays the sound on the ped for everyone to hear
            },
        }
     ]]
        ["carjack"] = {
            tencode = '10-59',
            title = locale('title.carjack'),
            description = locale('tencodes.carjack'),
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
            title = locale('title.vehicletheft'),
            description = locale('tencodes.vehicletheft'),
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
            title = locale('title.speedradar'),
            description = locale('tencodes.speedradar'),
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
            title = locale('title.driveby'),
            description = locale('tencodes.driveby'),
            name = locale('tencodes.driveby'),
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
            title = locale('title.shooting'),
            description = locale('tencodes.shooting'),
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
            title = locale('title.fight'),
            description = locale('tencodes.fight'),
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
            title = locale('title.death'),
            description = locale('tencodes.death'),
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
        ["backup"] = {
            tencode = '10-20',
            title = locale('title.backup'),
            description = locale('tencodes.backup'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 50.0,
                sprite = 875,
                color = 29,
                scale = 1.5,
                length = 60 * 2,
                offset = {
                    min = 5,
                    max = 30
                },
                flash = true
            },
            sound = {
                name = "security_scanner_beep_os",
                ref = "dlc_xm_heists_fm_uc_sounds",
                playOnPed = true
            }
        },
        ["pol99"] = {
            tencode = '10-99',
            title = locale('title.pol99'),
            description = locale('tencodes.pol99'),
            jobs = { jobs = { 'police', 'sheriff' }, types = { 'leo' } },
            blip = {
                radius = 100.0,
                sprite = 792,
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
                name = "Fail",
                ref = "dlc_xm_silo_laser_hack_sounds",
                playOnPed = true
            }
        },
        ["ems99"] = {
            tencode = '10-99',
            title = locale('title.ems99'),
            description = locale('tencodes.ems99'),
            jobs = { jobs = { 'police', 'sheriff', 'ambulance' }, types = { 'leo' } },
            blip = {
                radius = 100.0,
                sprite = 792,
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
                name = "Fail",
                ref = "dlc_xm_silo_laser_hack_sounds",
                playOnPed = true
            }
        },
        ["911call"] = {
            tencode = '911',
            title = locale('title.911call'),
            description = locale('tencodes.911call'),
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
            title = locale('title.912call'),
            description = locale('tencodes.912call'),
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
            title = locale('title.storerobbery'),
            description = locale('tencodes.storerobbery'),
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
            title = locale('title.bankrobbery'),
            description = locale('tencodes.bankrobbery'),
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
            title = locale('title.paletorobbery'),
            description = locale('tencodes.paletorobbery'),
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
            title = locale('title.pacificrobbery'),
            description = locale('tencodes.pacificrobbery'),
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
            title = locale('title.prisonbreak'),
            description = locale('tencodes.prisonbreak'),
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
            title = locale('title.jewelryrobbery'),
            description = locale('tencodes.jewelryrobbery'),
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
            title = locale('title.houserobbery'),
            description = locale('tencodes.houserobbery'),
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
            title = locale('title.suspicioushandoff'),
            description = locale('tencodes.suspicioushandoff'),
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
            title = locale('tencodes.carboosting'),
            description = locale('tencodes.carboosting'),
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
            title = locale('title.explosion'),
            description = locale('tencodes.explosion'),
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
            title = locale('title.drugrun'),
            description = locale('tencodes.drugrun'),
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
            title = locale('title.truckrobbery'),
            description = locale('tencodes.truckrobbery'),
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
