type TPlayerGroup = {
    name: string;
    label: string;
};

type TPlayerGroups = TPlayerGroup[];

type TCallDetails = {
    distance?: number;
    heading?: string;
    location?: string;
    camId?: string;
    weapon?: {
        weaponName?: string;
        weaponclass?: string;
    };
    vehicle?: {
        model?: string;
        class?: string;
        color?: string;
        plate?: string;
        doors?: string;
        speed?: string;
    }
    person?: {
        callsign?: string;
        name?: string;
        gender?: string;
        phone?: string;
    }
    information?: string;
};

type TCall = {
    id: number;
    tenCode: string;
    title: string;
    callType: number;
    callDuration?: number;
    details: TCallDetails;
}

type TCallsAction = {
    type: 'addCall' | 'removeCall' | 'updateCall' | 'setCalls';
    call?: TCall;
    calls?: TCall[];
    callId?: number;
    newPriority?: number;
}

type TBracelet = {
    firstname: string;
    lastname: string;
    phone: string;
}

type TDispatchUnit = {
    id: number;
    name: string;
    callsign?: string;
    squadId?: number;
    squadIndex?: number;
}

type TDispatchUnitActions = {
    id: number;
    type: 'addUnit' | 'moveUnit' | 'removeUnit' | 'updateIndex';
    unitId?: number;
    squadId?: number;
}

type TDispatchSquad = {
    id: number;
    label: string;
    status?: number;
}

type TDispatchSquadActions = {
    type: 'addSquad' | 'removeSquad' | 'setStatus' | 'setLabel' | 'updateSquadOrder';
    squadId: number;
    status?: number;
    label?: string;
}

type TBOLO = {
    id: number;
    target: string;
    description: string;
    priority: number; // 0 = low, 1 = medium, 2 = high
    type: number; // 0 = person, 1 = vehicle
}

export type {
    TPlayerGroup,
    TPlayerGroups,
    TCallDetails,
    TCall,
    TCallsAction,
    TBracelet,
    TDispatchUnit,
    TDispatchUnitActions,
    TDispatchSquad,
    TDispatchSquadActions,
    TBOLO
}