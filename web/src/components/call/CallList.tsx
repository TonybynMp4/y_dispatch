import { TCall } from "@/types";
import { useEffect, useState } from "react";
import { ScrollArea } from "@/components/shadcn/ui/scroll-area"
import SearchBar from "../shadcn/searchbar";
import Call from "./call"
import { useCalls } from "./callsContext";
import { filterCalls } from "./filterCalls";

type Props = {
}

function CallList({ }: Props) {
    const calls = useCalls();
    const [callsShown, setCallsShown] = useState<TCall[]>(calls);
    const [search, setSearch] = useState<string>('')

    useEffect(() => {
        filterCalls(calls, setCallsShown, search)
    }, [calls, search]);

    return (
        <>
            <SearchBar className="mx-4 mb-2" inputClassName="h-[2em] my-0" placeHolder="Search" onkeyup={
                (e: React.KeyboardEvent<HTMLInputElement>) => (e.key === 'Enter') && setSearch((e.target as HTMLInputElement).value)
            } onchange={(e) => setSearch(e.target.value)} />
            <ScrollArea className="ml-4 mr-1 pr-3" style={{ height: "calc(100% - 2em - 1rem)" }}>
                {
                    callsShown.map((call) => (
                        <Call hasContextMenu={true} key={call.id} call={call} />
                    ))
                }
            </ScrollArea>
        </>
    );
}

export default CallList