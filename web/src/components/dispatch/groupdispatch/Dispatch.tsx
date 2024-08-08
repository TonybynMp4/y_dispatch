import { TDispatchGroup, TDispatchGroupsActions, TDispatchUnit, TDispatchUnitActions } from '@/types';
import { useReducer, useState } from 'react';
import { closestCenter, DndContext } from '@dnd-kit/core';
import { restrictToVerticalAxis } from '@dnd-kit/modifiers';
import ActionBar from './actionBar';
import UnassignedUnits from './units/unassignedUnits';
import DispatchGroups from './groups/dispatchGroups';
import { Button } from '@/components/shadcn/ui/button';

type groupsLabels = {
    [key: string]: string
}
type Props = {
    playerGroups: string[],
    groupsLabels: groupsLabels
}

const ActiveUnits: TDispatchUnit[] = [
    { id: 1, callsign: '24', name: 'Tony Hawk' },
    { id: 2, callsign: '25', name: 'Benny Hill' },
    { id: 3, callsign: '26', name: 'John Doe' },
    { id: 4, callsign: '27', name: 'Jane Doe' },
];

function unassignedUnitsReducer(state: TDispatchUnit[], action: TDispatchUnitActions) {
    switch (action.type) {
        case 'addUnit':
            return [...state, action.unit];
        case 'removeUnit':
            return state.filter(unit => unit.id !== action.id);
        default:
            return state;
    }
}

function dispatchGroupsReducer(state: TDispatchGroup[], action: TDispatchGroupActions) {
    switch (action.type) {
        case 'CreateGroup':
            return [...state, { id: state.length + 1, label: action.label, units: [] }];
        case 'DeleteGroup':
            return state.filter(group => group.id !== action.id);
        case 'AddUnit':
            return state.map(group => {
                if (group.id === action.id) {
                    return { ...group, units: [...group.units, action.unit] };
                }
                return group;
            });
        case 'RemoveUnit':
            return state.map(group => {
                if (group.id === action.id) {
                    return { ...group, units: group.units.filter(unit => unit.id !== action.unit.id) };
                }
                return group;
            });
        default:
            return state;
    }
}

function handleDragEnd(event: any, setUnits: React.Dispatch<TDispatchUnitActions>) {
}

function Dispatch({ playerGroups, groupsLabels }: Props) {
    const [currentGroup, setCurrentGroup] = useState(playerGroups[0]);
    const [unassignedUnits, setUnassignedUnits]: [TDispatchUnit[], React.Dispatch<TDispatchUnitActions>] = useReducer(unassignedUnitsReducer, ActiveUnits);
    const [dispatchGroups, setDispatchGroups] = useReducer(dispatchGroupsReducer, []);

    return (
        <>
            <ActionBar groupsLabels={groupsLabels} currentGroup={currentGroup} setCurrentGroup={setCurrentGroup} />
            {/* <h2 className=" text-2xl font-bold text-center mt-8">
                Selected Group: {groupsLabels[currentGroup]}
            </h2> */}
            <DndContext modifiers={[restrictToVerticalAxis]} collisionDetection={closestCenter} onDragEnd={(event) => handleDragEnd(event, setUnassignedUnits)} onDragOver={(event) => onDragOver(event, setUnassignedUnits, setDispatchGroups)}>
                <DispatchGroups dispatchGroups={dispatchGroups} setDispatchGroups={setDispatchGroups} />
                {/*
                    <draggable>
                        <Droppable>

                        </Droppable>
                    </draggable>
                */}
                <Button onClick={() => setDispatchGroups({ type: 'CreateGroup', label: 'New Group' })}>Create Group</Button>
                <UnassignedUnits unassignedUnits={unassignedUnits}/>
            </DndContext>
        </>
    )

    function onDragOver(event: any, setUnits: React.Dispatch<TDispatchUnitActions>, setDispatchGroups: React.Dispatch<TDispatchGroupsActions>) {
        const { active, over } = event;

        if (!active || !over) {
            return;
        }


        if (over.data?.current?.accepts?.includes(active.data.current.type)) {
            if (over.id === 'unassignedUnits') {
                setUnits({ type: 'addUnit', unit: active.data.current.unit });
                setDispatchGroups({ type: 'RemoveUnit', unit: active.data.current.unit, id: active.data.current.assignedGroup });
            } else {
                setDispatchGroups({ type: 'AddUnit', unit: active.data.current.unit, id: over.id });
                setUnits({ type: 'removeUnit', id: active.data.current.unit.id });
            }
        }

    }
};

export default Dispatch