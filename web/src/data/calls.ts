import { TCall } from '../types'

const calls: TCall[] = [
    {
        title: 'Vol de véhicule à main armée',
        tenCode: '10-62',
        callType: 0,
        details: {
            distance: 3842,
            location: 'Fort Zancudo Approach Road',
            heading: 'North-West',
            phone: '123-456-7890',
            weapon: 'Pistol',
            automatic: 'Automatic',
            weaponclass: 'Class 2',
        }
    },
    {
        title: 'Fleeca Bank Robbery',
        tenCode: '10-91',
        callType: 0,
        details: {
            location: 'Great Ocean Highway',
            camId: '123',
            information: 'Bank robbery in progress. Suspects are armed and dangerous. Use caution.'
        }
    },
    {
        title: 'Suspicious vehicle',
        tenCode: '10-28',
        callType: 0,
        details: {
            location: 'Strawberry Ave',
            speed: '194.5 Km/h',
            model: 'Sultan',
            class: 'Sport',
            color: 'Red',
            plate: 'ABC123',
            doors: '2 Doors',
        }
    },
    {
        title: 'Suspicious vehicle',
        tenCode: '10-28',
        callType: 0,
        details: {
            location: 'Strawberry Ave',
            name: 'John Doe',
            gender: 'Male',
            information: 'Please help, someone is constantly shouting at his wife or something i don\'t fucking know.'

        }
    },
    {
        title: 'Level 1 Backup Request',
        tenCode: '10-35',
        callType: 0,
        details: {
            location: 'Strawberry Ave',
            callsign: '224',
        }
    },
    {
        title: 'Suspicious person',
        tenCode: '10-15',
        callType: 0,
        details: {
            location: 'Strawberry Ave',
            phone: '098-765-4321',
        }
    },
    {
        title: 'Suspicious vehicle',
        tenCode: '10-28',
        callType: 0,
        details: {
            location: 'Strawberry Ave',
            phone: '321-654-0987',
        }
    },
    {
        title: 'Suspicious vehicle',
        tenCode: '10-28',
        callType: 0,
        details: {
            location: 'Strawberry Ave',
            phone: '890-123-4567',
        }
    },
]

export default calls