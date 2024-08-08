import { TCall } from "@/types";
import Call from "./Call"
import { ScrollArea } from "@/components/shadcn/ui/scroll-area"
import SearchBar from "../shadcn/searchbar";
import { useState } from "react";

type Props = {
    showSearch: boolean | undefined;
    calls: TCall[];
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


function CallList({ showSearch, calls }: Props) {
    const [callsShown, setCallsShown] = useState(calls)
    return (
        <>
            {showSearch &&
                <SearchBar className="mb-2" inputClassName="h-[2em] my-0" placeHolder="Search" onkeyup={(e) => onKeyUp(calls, setCallsShown, e)} onchange={(e) => filterCalls(calls, setCallsShown, e)} />
            }
            <ScrollArea className="p-2 pr-4" style={{ height: "calc(100% - 2em - 0.5rem)" }}>
                {
                    callsShown.map((call, index) => (
                        <Call hasContextMenu={true} key={index} call={call} index={calls.indexOf(call)} />
                    ))
                }
            </ScrollArea>
        </>
    )
}

export default CallList