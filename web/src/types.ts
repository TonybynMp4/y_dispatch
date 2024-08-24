type TPlayerGroup = {
    name: string;
    label: string;
};

type TPlayerGroups = TPlayerGroup[];

type TCallDetails = {
    distance?: number;
    heading?: string;
    phone?: string;
    location?: string;
    speed?: string;
    camId?: string;
    weapon?: string;
    automatic?: string;
    weaponclass?: string;
    model?: string;
    class?: string;
    color?: string;
    plate?: string;
    doors?: string;
    callsign?: string;
    name?: string;
    number?: string;
    gender?: string;
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

type TRecentCallsAction = {
    type: 'addCall' | 'removeCall';
    call?: TCall;
    callId?: number;
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

export type { TPlayerGroup, TPlayerGroups, TCallDetails, TCall, TRecentCallsAction, TBracelet, TDispatchUnit, TDispatchUnitActions, TDispatchGroup }