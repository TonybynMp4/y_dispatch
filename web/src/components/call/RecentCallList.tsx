import { TCall, TCallsAction } from "@/types";
import { useNuiEvent } from "@/utils/useNuiEvent";
import Call from "./call"
import { useCalls, useCallsDispatch } from "./callsContext";
import testCalls from "@/data/calls"
import { isEnvBrowser } from "@/utils/misc";
import { useEffect } from "react";

type Props = {}

function addtestcalls(setRecentCalls: React.Dispatch<TCallsAction>) {
    let i = 0;
    let id = 1;
    const interval = setInterval(() => {
        if (i >= testCalls.length) i = 0;
        const call = testCalls[i];
        call.id = id;

        setRecentCalls({ type: 'addCall', call: call });
        i++;
        id++;
    }, 2000);

    return () => clearInterval(interval);
}

function RecentCallList({ }: Props) {
    const recentCalls = useCalls();
    const setRecentCalls = useCallsDispatch();

    useEffect(() => {
        if (isEnvBrowser()) {
            addtestcalls(setRecentCalls);
        }
    }, [])

    useNuiEvent<TCall>("addCall", (call) => {
        setRecentCalls({ type: 'addCall', call: call});
    })

    return (
        <>
            <div className="p-2 pr-4" style={{ height: "calc(100vh - 2em - 0.5rem)", overflow: "hidden" }}>
                {
                    recentCalls.map((mappedCall) => (
                        <Call key={mappedCall.id} call={mappedCall} shouldAnimate={true} />
                    ))
                }
            </div>
        </>
    )
}

export default RecentCallList