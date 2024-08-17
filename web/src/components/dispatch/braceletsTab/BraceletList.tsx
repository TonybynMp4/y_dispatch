import { TBracelet } from "@/types";
import { useState } from "react";
import SearchBar from "@/components/shadcn/searchbar";
import { ScrollArea } from "@/components/shadcn/ui/scroll-area"
import { filterBracelets, onKeyUp } from "./braceletFilter";
import BraceletCard from "./BraceletCard"

type Props = {
    bracelets: TBracelet[];
}

function BraceletList({ bracelets }: Props) {
    const [braceletsShown, setBraceletsShown] = useState(bracelets)

    return (
        <>
            <SearchBar placeHolder="Search" className="mb-2" inputClassName="h-[2em] my-0" onkeyup={(e) => onKeyUp(bracelets, setBraceletsShown, e)} onchange={(e) => filterBracelets(bracelets, setBraceletsShown, e)} />
            <ScrollArea className="p-2 pr-4" style={{height: "calc(100% - 2em - 0.5rem)"}}>
                {
                    !bracelets || braceletsShown.length === 0 ? <h1 className="mt-8 text-center text-2xl">No active bracelets</h1> :
                    braceletsShown.map((bracelet, index) => (
                        <BraceletCard key={index} firstname={bracelet.firstname} lastname={bracelet.lastname} phone={bracelet.phone} />
                    ))
                }
            </ScrollArea>
        </>
    )
}

export default BraceletList;