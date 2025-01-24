import { TBOLO, TBoloAction } from '@/types';
import { fetchNui } from "@/utils/fetchNui";
import { isEnvBrowser } from "@/utils/misc";
import { useNuiEvent } from "@/utils/useNuiEvent";
import { useEffect, useReducer, useState } from "react";
import BoloItem from './boloItem';
import { ScrollArea } from '@/components/shadcn/ui/scroll-area';
import BolosHeader from './bolosHeader';
import { Collapsible, CollapsibleContent } from '@/components/shadcn/ui/collapsible';
import BoloForm from './boloForm';
import debugBolos from '@/data/bolos';

function boloReducer(state: TBOLO[], { type, bolo, bolos }: TBoloAction): TBOLO[] {
    if (!bolo && !bolos) return state;

    switch (type) {
        case 'addBolo':
            if (!bolo) return state;

            if (isEnvBrowser() && !bolo.id) bolo.id = state.length + 1;

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

function BoloList() {
    const [bolos, setBolos] = useReducer(boloReducer, isEnvBrowser() ? debugBolos : []);

    useNuiEvent("addBolo", (bolo: TBOLO) => setBolos({ type: 'addBolo', bolo }));
    useEffect(() => {
        if (!isEnvBrowser()) fetchNui<TBOLO[]>("getAllBOLOs").then((bolos) => {
            if (!bolos) return
            setBolos({ type: 'setBolos', bolos });
        })
    }, [])

    const [filteredBolos, setFilteredBolos] = useState(bolos);
    const [sortDirection, setSortDirection] = useState<null | "asc" | "desc">(null);
    const [isFormOpen, setIsOpen] = useState(false)

    return (
        <>
            <Collapsible open={isFormOpen} onOpenChange={setIsOpen}>
                <BolosHeader setFilteredBolos={setFilteredBolos} bolos={bolos} sortDirection={sortDirection} setSortDirection={setSortDirection} />
                <CollapsibleContent className="px-4 h-[15rem]">
                    <BoloForm setBolos={setBolos} setIsOpen={setIsOpen} />
                </CollapsibleContent>
            </Collapsible>

            <ScrollArea className="ml-4 mr-1 pr-3 mt-2" style={{ height: "calc(100% - " + (isFormOpen ? "20rem" : "5rem") + " - 1.5rem)" }}>
                {
                    filteredBolos.length == 0 ? <p className="text-center">No BOLOs</p> :
                        filteredBolos.sort((a, b) =>
                            sortDirection === "asc" ? a.target.localeCompare(b.target) :
                            sortDirection === "desc" ? b.target.localeCompare(a.target) :
                            b.id - a.id
                        ).map(bolo => <BoloItem key={bolo.id} bolo={bolo} />)
                }
            </ScrollArea>

        </>
    );
}

export default BoloList;