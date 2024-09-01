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
    animationDuration?: number;
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
    assignedGroup?: number;
}

type TDispatchUnitActions = {
    type: 'addUnit' | 'removeUnit';
    unit?: TDispatchUnit;
    id: number;
}

type TDispatchGroup = {
    id: string;
    label: string;
    units: TDispatchUnit[];
}

export type { TPlayerGroup, TPlayerGroups, TCallDetails, TCall, TCallsAction, TBracelet, TDispatchUnit, TDispatchUnitActions, TDispatchGroup }