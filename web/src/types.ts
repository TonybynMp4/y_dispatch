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
    tenCode: string;
    title: string;
    callType: number;
    details: TCallDetails;
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
    id?: number;
}

type TDispatchGroup = {
    id: number;
    label: string;
    units: TDispatchUnit[];
}

type TDispatchGroupsActions = {
    type: 'CreateGroup' | 'DeleteGroup' | 'AddUnit' | 'RemoveUnit';
    unit?: TDispatchUnit;
    id?: number;
}

export type { TCall, TCallDetails, TBracelet, TDispatchUnit, TDispatchUnitActions, TDispatchGroup, TDispatchGroupsActions };