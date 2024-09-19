import { TCall } from '../types'

const testCalls: TCall[] = [
    {
        id: 1,
        title: 'Vol de véhicule à main armée',
        tenCode: '10-62',
        callType: 0,
        callDuration: 7500,
        details: {
            distance: 3842,
            location: 'Fort Zancudo Approach Road',
            heading: 'North-West',
            vehicle: {
                speed: '194.5 Km/h',
                model: 'Sultan',
                class: 'Sport',
                color: 'Red',
                plate: 'ABC123',
                doors: '2 Doors',
            },
            person: {
                name: 'John Doe',
                callsign: '224',
                gender: 'Homme',
                phone: '123-456-7890',
            },
            weapon: {
                weaponName: 'Pistol',
                weaponclass: 'Class 2',
            },
            information: 'Vehicle theft in progress. Suspects are armed and dangerous. Use caution.'
        }
    },
    {
        id: 2,
        title: 'Fleeca Bank Robbery',
        tenCode: '10-91',
        callType: 1,
        details: {
            location: 'Great Ocean Highway',
            camId: '123',
            information: 'Bank robbery in progress. Suspects are armed and dangerous. Use caution.'
        }
    },
    {
        id: 3,
        title: 'Suspicious vehicle',
        tenCode: '10-28',
        callType: 2,
        callDuration: 3000,
        details: {
            location: 'Strawberry Ave',
            vehicle: {
                speed: '194.5 Km/h',
                model: 'Sultan',
                class: 'Sport',
                color: 'Red',
                plate: 'ABC123',
                doors: '2 Doors',
            }
        }
    },
    {
        id: 4,
        title: 'Suspicious vehicle',
        tenCode: '10-28',
        callType: 0,
        details: {
            location: 'Strawberry Ave',
            person: {
                name: 'John Doe',
                gender: 'Male',
            },
            information: 'Please help, someone is constantly shouting at his wife or something i don\'t fucking know.'

        }
    },
    {
        id: 5,
        title: 'Level 1 Backup Request',
        tenCode: '10-35',
        callType: 0,
        details: {
            location: 'Strawberry Ave',
            person: {
                callsign: '224',
            }
        }
    },
    {
        id: 6,
        title: 'Suspicious person',
        tenCode: '10-15',
        callType: 0,
        details: {
            location: 'Strawberry Ave',
            person: {
                phone: '098-765-4321',
                callsign: '224',
            }
        }
    },
]

export default testCalls