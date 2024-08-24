import { TCall } from "@/types";
import { useEffect, useState } from "react";
import { useNuiEvent } from "@/utils/useNuiEvent";
import { fetchNui } from "@/utils/fetchNui";
import { ScrollArea } from "@/components/shadcn/ui/scroll-area"
import SearchBar from "../shadcn/searchbar";
import Call from "./Call"
import testCalls from "@/data/calls"
import { isEnvBrowser } from "@/utils/misc";

type Props = {
    showSearch: boolean | undefined;
}

function filterCalls(calls: TCall[], setCallsShown: Function, event: React.ChangeEvent<HTMLInputElement> | React.KeyboardEvent<HTMLInputElement>) {
    if ((event.target as HTMLInputElement).value === '') {
        setCallsShown(calls)
        return
    }

    const search = (event.target as HTMLInputElement).value.toLowerCase()
    setCallsShown(calls.filter(call => call.title.toLowerCase().includes(search) || (call.tenCode && call.tenCode.includes(search)) || (calls.indexOf(call) + 1).toString().includes(search)))
}

function onKeyUp(calls: TCall[], setCallsShown: Function, event: React.KeyboardEvent<HTMLInputElement>) {
    if (event.key === 'Enter') {
        filterCalls(calls, setCallsShown, event)
    }
}

function CallList({ showSearch }: Props) {
    const [calls, setCalls] = useState<TCall[]>(isEnvBrowser() ? testCalls : [])
    const [callsShown, setCallsShown] = useState<TCall[]>([])

    useNuiEvent<TCall>("addCall", (call) => setCalls([...calls, call]))

    useEffect(() => {
        if (!isEnvBrowser()) fetchNui<TCall[]>("getRecentCalls").then(setCalls)
    }, [])

    return (
        <>
            {showSearch &&
                <SearchBar className="mb-2" inputClassName="h-[2em] my-0" placeHolder="Search" onkeyup={(e) => onKeyUp(calls, setCallsShown, e)} onchange={(e) => filterCalls(calls, setCallsShown, e)} />
            }
            <ScrollArea className="p-2 pr-4" style={{ height: "calc(100% - 2em - 0.5rem)" }}>
                {
                    callsShown.map((call, index) => (
                        <Call hasContextMenu={true} key={index} call={call} />
                    ))
                }
            </ScrollArea>
        </>
    )
}

export default CallList