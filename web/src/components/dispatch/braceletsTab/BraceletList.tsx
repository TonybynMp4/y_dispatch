import { TBracelet } from "@/types";
import { useState } from "react";
import SearchBar from "@/components/shadcn/searchbar";
import { ScrollArea } from "@/components/shadcn/ui/scroll-area"
import { filterBracelets, onKeyUp } from "./braceletFilter";
import BraceletCard from "./BraceletCard"
import { isEnvBrowser } from "@/utils/misc";
import debugBracelets from "@/data/bracelets";

type Props = {
}

function BraceletList({ }: Props) {
    const bracelets: TBracelet[] = isEnvBrowser() ? debugBracelets : [];
    const [braceletsShown, setBraceletsShown] = useState(bracelets);

    return (
        <>
            <SearchBar placeHolder="Search" className="mx-4 h-[3rem] mb-2" inputClassName="h-[2em] my-0" onkeyup={(e) => onKeyUp(bracelets, setBraceletsShown, e)} onchange={(e) => filterBracelets(bracelets, setBraceletsShown, e)} />
            <ScrollArea className="ml-4 mr-1 pr-3" style={{height: "calc(100% - 3em - 1rem)"}}>
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