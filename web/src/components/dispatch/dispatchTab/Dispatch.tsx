import { TDispatchSquad, TDispatchSquadActions, TDispatchUnit, TDispatchUnitActions, TPlayerGroups } from '@/types';
import { useReducer, useState } from 'react';
import ActionBar from './actionBar';
import { ScrollArea } from '@/components/shadcn/ui/scroll-area';
import { cn } from '@/lib/utils';
import { Popover, PopoverContent, PopoverTrigger } from '@/components/shadcn/ui/popover';
import { Button } from '@/components/shadcn/ui/button';
import { Check, ChevronsUpDown } from 'lucide-react';
import { Command, CommandEmpty, CommandGroup, CommandItem, CommandList } from '@/components/shadcn/ui/command';
import { Input } from '@/components/shadcn/ui/input';

type Props = {
    playerGroups: TPlayerGroups;
}

type Unit = TDispatchUnit;
type SquadGroup = TDispatchSquad;

function squadsReducer(
    state: SquadGroup[] | [],
    action: TDispatchSquadActions
) {
    switch (action.type) {
        case 'addSquad':
            return [
                ...state,
                {
                    id: state.length,
                    label: 'New Squad',
                },
            ];
        case 'removeSquad':
            return state.filter((squad) => squad.id !== action.squadId);
        case 'setStatus':
            if (action.status === undefined) return state;

            return state.map((squad) => {
                if (squad.id === action.squadId) {
                    return {
                        ...squad,
                        status: action.status,
                    };
                }
                return squad;
            });
        case 'setLabel':
            if (action.label === undefined) return state;

            return state.map((squad) => {
                let label = '';

                switch (action.label) {
                    case '': break;
                    case undefined: break;
                    case null: label = 'Squad ' + squad.id; break;
                    default: label = action.label;
                }

                if (squad.id === action.squadId) {
                    return {
                        ...squad,
                        label: label,
                    };
                }
                return squad;
            });
        case 'updateSquadOrder':
            return state;
        default:
            return state;
    }
}

function unitsReducer(
    state: Unit[] | [],
    action: TDispatchUnitActions
) {
    if (!action.unitId || !action.type) return state;

    switch (action.type) {
        case 'addUnit':
            return [
                ...state,
                {
                    id: state.length,
                    name: 'New Unit',
                },
            ];
        case 'moveUnit':
            if (!action.squadId) return state;
            return state.map((unit) => {
                if (unit.id === action.unitId) {
                    return {
                        ...unit,
                        squadId: action.squadId,
                    };
                }
                return unit;
            });
        case 'removeUnit':
            return state.filter((unit) => unit.id !== action.unitId);
        case 'updateIndex':
            return state;
        default:
            return state;
    }
}

const debugSquads: SquadGroup[] = [
    {
        id: 1,
        label: 'Squad 1',
        status: 0,
    },
    {
        id: 2,
        label: 'Squad 2',
        status: 1,
    },
    {
        id: 3,
        label: 'Squad 3',
        status: 2,
    },
];

const debugUnits: TDispatchUnit[] = [
    {
        id: 1,
        name: 'Unit 1',
    },
    {
        id: 2,
        name: 'Unit 2',
    },
    {
        id: 3,
        name: 'Unit 3',
        squadId: 2,
    },
    {
        id: 4,
        name: 'Unit 4',
        squadId: 2,
    },
    {
        id: 5,
        name: 'Unit 5',
    },
    {
        id: 6,
        name: 'Unit 6',
    },
];

function Unit({ unit }: { unit: Unit }) {
    return (
        <div className="my-2 p-2 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-200 hover:text-black">
            {
                unit.name
            }
        </div>
    )
}

function Squad({ squad, setSquads, units }: { squad: SquadGroup, setSquads: Function, units: Unit[] }) {
    const [open, setOpen] = useState(false);
    const status = ['Available', 'En Route', 'On Scene'];

    return (
        <div key={squad.id} className="min-h-16 border border-gray-300 rounded-md p-2 my-2">
            <div className="flex items-center justify-between">
                <div className="flex items-center w-[50%]">
                    <Input value={squad.label} onChange={(e) => { setSquads({ type: 'setLabel', squadId: squad.id, label: (e.target as HTMLInputElement).value }); }} onKeyDown={(e) => {
                        if (e.key === 'Enter') {
                            setSquads({ type: 'setLabel', squadId: squad.id, label: (e.target as HTMLInputElement).value || null });
                            (e.target as HTMLInputElement).blur();
                        }
                    }} />
                </div>
                <Popover open={open} onOpenChange={setOpen}>
                    <PopoverTrigger asChild>
                        <Button variant="outline" role="combobox" aria-expanded={open} className="ml-4 w-[8em] rounded-[0.5em] justify-between">
                            {squad.status === 0 ? 'Available' : squad.status === 1 ? 'En Route' : 'On Scene'}
                            <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                        </Button>
                    </PopoverTrigger>
                    <PopoverContent className="w-[200px] p-0">
                        <Command>
                            <CommandList>
                                <CommandEmpty>No group found.</CommandEmpty>
                                <CommandGroup>
                                    {status.map((status, index) => {
                                        return (
                                            <CommandItem key={status} onSelect={() => { setSquads({ type: 'setStatus', squadId: squad.id, status: index }); setOpen(false); }}>
                                                {squad.status === index ? <Check className="h-4 w-4 mr-2" /> : <span className="w-4 mr-2" />}
                                                {status}
                                            </CommandItem>
                                        )
                                    })}
                                </CommandGroup>
                            </CommandList>
                        </Command>
                    </PopoverContent>
                </Popover>
            </div>
            <div>
                {
                    units.map((unit) => {
                        return (
                            <Unit key={unit.id} unit={unit} />
                        )
                    })
                }
            </div>
        </div>

    )
}

function DispatchTab({ playerGroups }: Props) {
    const [currentGroup, setCurrentGroup] = useState(playerGroups ? playerGroups[0].name : '');
    const [squads, setSquads] = useReducer(squadsReducer, debugSquads);
    const [units, setUnits] = useReducer(unitsReducer, debugUnits);

    return (
        <>
            <ActionBar playerGroups={playerGroups} currentGroup={currentGroup} setCurrentGroup={setCurrentGroup} />
            <ScrollArea className="ml-4 mr-1 pr-3" style={{ height: "calc(100% - 2em - 1rem)" }}>
                <h2 className="text-center text-lg font-bold my-2">
                    Squads
                </h2>
                <div>
                    {
                        squads.map((squad) => {
                            return (
                                <Squad key={squad.id} squad={squad} setSquads={setSquads} units={units.filter((unit) => unit.squadId === squad.id)} />
                            )
                        })
                    }
                </div>

                <div className={cn("text-center p-2 border border-gray-300 rounded-md cursor-pointer hover:bg-gray-200", "hidden")}>
                    {/*
                        when dragging a unit, this div will be displayed at the bottom of the list of squads,
                        dropping the unit here creates a new squad & assigns it that unit.
                    */}
                    Create Squad
                </div>

                <h2 className="text-center text-lg font-bold my-2">
                    Unassigned Units
                </h2>
                <div>
                    {/*
                        Units that are not assigned to a squad are displayed here,
                        You can drag and drop them to a squad to assign them.

                        if you drag a squad to the unassigned units, it will remove the squad & put all units back to unassigned,
                        -- a unit --, it will move the unit to unassigned.
                    */}
                    {
                        units.filter((unit) => !unit.squadId).map((unit) => {
                            return (
                                <Unit key={unit.id} unit={unit} />
                            )
                        })
                    }
                </div>

            </ScrollArea>
        </>
    )
};

export default DispatchTab