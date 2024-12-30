import { TCall } from "@/types";
import { useEffect, useRef, useState } from "react";
import { ScrollArea } from "@/components/shadcn/ui/scroll-area"
import SearchBar from "../shadcn/searchbar";
import Call from "./call"
import { useCalls } from "./callsContext";
import { filterCalls } from "@/utils/filterCalls";

type Props = {
}

function onKeyUp(calls: TCall[], setCallsShown: Function, event: React.KeyboardEvent<HTMLInputElement>) {
    if (event.key === 'Enter') {
        filterCalls(calls, setCallsShown, event)
    }
}

function CallList({ }: Props) {
    const searchRef = useRef<HTMLInputElement>(null)
    const calls = useCalls();
    const [callsShown, setCallsShown] = useState<TCall[]>(calls)

    useEffect(() => {
        if (searchRef.current) {
            filterCalls(calls, setCallsShown, { target: searchRef.current } as React.ChangeEvent<HTMLInputElement>)
        }
    }, [calls])

    return (
        <>
            <SearchBar searchRef={searchRef} className="mx-4 mb-2" inputClassName="h-[2em] my-0" placeHolder="Search" onkeyup={(e) => onKeyUp(calls, setCallsShown, e)} onchange={(e) => filterCalls(calls, setCallsShown, e)} />
            <ScrollArea className="ml-4 mr-1 pr-3" style={{ height: "calc(100% - 2em - 1rem)" }}>
                {
                    callsShown.map((call, index) => (
                        <Call hasContextMenu={true} key={call.id} call={call} />
                    ))
                }
            </ScrollArea>
        </>
    )
}

export default CallList