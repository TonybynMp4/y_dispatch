import { TBOLO } from '@/types';
import { fetchNui } from "@/utils/fetchNui";
import { isEnvBrowser } from "@/utils/misc";
import { useNuiEvent } from "@/utils/useNuiEvent";
import { useEffect, useReducer, useState } from "react";
import BoloItem from './boloItem';
import { ScrollArea } from '@/components/shadcn/ui/scroll-area';
import Header from './header';
import { Collapsible, CollapsibleContent } from '@/components/shadcn/ui/collapsible';
import BoloForm from './boloForm';

type BoloAction = {
    type: 'addBolo' | 'setBolos' | 'removeBolo' | 'updateBolo';
    bolo?: TBOLO;
    bolos?: TBOLO[];
}

function boloReducer(state: TBOLO[], { type, bolo, bolos }: BoloAction): TBOLO[] {
    if (!bolo && !bolos) return state;

    switch (type) {
        case 'addBolo':
            if (!bolo) return state;

            return [...state, bolo]
        case 'setBolos':
            if (!bolos) return state;
            return bolos
        case 'removeBolo':
            if (!bolo) return state;
            return state.filter(bolo => bolo.id !== bolo.id)
        case 'updateBolo':
            if (!bolo) return state;

            return state.map(bolo => bolo.id === bolo.id ? bolo : bolo)
        default:
            console.error(`Unknown BOLO action type: ${type}`);

            return state
    }
}

const testBolos: TBOLO[] = [
    { id: 1, target: "John Doe", description: "Wanted for crdtfvgbhnj,k", type: 0, priority: 0 },
    { id: 2, target: "Winter Peyton", description: "Wanted for crdtfvgbhnj,k", type: 0, priority: 2 },
    { id: 3, target: "Reese Kronos", description: "Mandat d'arret", type: 0, priority: 0 },
    { id: 4, target: "A EWC478KA", description: "Buffalo STX Bleue", type: 1, priority: 3 },
    { id: 5, target: "Z John Doe", description: "Wanted for crdtfvgbhnj,k", type: 0, priority: 0 },
    { id: 6, target: "John Doe", description: "Wanted for crdtfvgbhnj,k", type: 1, priority: 0 },
    { id: 7, target: "John Doe", description: "Wanted for crdtfvgbhnj,k", type: 0, priority: 0 },
    { id: 8, target: "John Doe", description: "Wanted for crdtfvgbhnj,k", type: 1, priority: 0 },
    { id: 9, target: "John Doe", description: "Wanted for crdtfvgbhnj,k", type: 0, priority: 0 },
    { id: 10, target: "John Doe", description: "Wanted for crdtfvgbhnj,k", type: 1, priority: 0 },
];

function BoloList() {
    const [bolos, setBolos] = useReducer(boloReducer, testBolos);

    useNuiEvent("addBolo", (bolo: TBOLO) => setBolos({ type: 'addBolo', bolo }));
    useEffect(() => {
        if (!isEnvBrowser()) fetchNui<TBOLO[]>("getAllBOLOs").then((bolos) => {
            if (!bolos) return
            setBolos({ type: 'setBolos', bolos });
        })
    }, [])

    const [filteredBolos, setFilteredBolos] = useState(bolos);
    const [sortDirection, setSortDirection] = useState<null | "asc" | "desc">(null);

    useEffect(() => {
        if (sortDirection)
            setFilteredBolos([...filteredBolos].sort((a, b) =>
            sortDirection === "asc" ? a.target.localeCompare(b.target) : b.target.localeCompare(a.target)
        ))
        else
        setFilteredBolos([...bolos])
    }, [sortDirection, bolos])
    const [isFormOpen, setIsOpen] = useState(false)

    return (
        <>
            <Collapsible open={isFormOpen} onOpenChange={setIsOpen}>
                <Header setFilteredBolos={setFilteredBolos} setBolos={setBolos} bolos={bolos} sortDirection={sortDirection} setSortDirection={setSortDirection} />
                <CollapsibleContent className="px-4 h-[15rem]">
                    <BoloForm setBolos={setBolos} />
                </CollapsibleContent>
            </Collapsible>

            <ScrollArea className="ml-4 mr-1 pr-3 mt-2" style={{ height: "calc(100% - " + (isFormOpen ? "20rem" : "5rem") + " - 1.5rem)" }}>
                {
                    filteredBolos.length == 0 ? <p className="text-center">No BOLOs</p> :
                        filteredBolos.map(bolo => <BoloItem key={bolo.id} bolo={bolo} />)
                }
            </ScrollArea>

        </>
    );
}

export default BoloList;