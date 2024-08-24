import { TCall, TRecentCallsAction } from "@/types";
import { useEffect, useReducer } from "react";
import { useNuiEvent } from "@/utils/useNuiEvent";
import { fetchNui } from "@/utils/fetchNui";
import { isEnvBrowser } from "@/utils/misc";
import Call from "./Call"

type Props = {}

function recentCallsReducer(state: TCall[], action: TRecentCallsAction): TCall[] {
    switch (action.type) {
        case 'addCall':
            if (!action.call) return state;
            if (state.find((call) => call.id === action.call?.id)) return state;

            return [...state, action.call];
        case 'removeCall':
            console.log("Removing call", action, action.callId);
            if (!action.callId) return state;

            return state.filter((call) => call.id !== action.callId);
        default:
            return state;
    }
}

function RecentCallList({ }: Props) {
    const [recentCalls, setRecentCalls] = useReducer(recentCallsReducer, []);

    useNuiEvent<TCall>("addCall", (call) => {
        setRecentCalls({ type: 'addCall', call: call});
    })

    useEffect(() => {
        if (!isEnvBrowser()) fetchNui<TCall[]>("getRecentCalls").then((calls) => {
            calls.forEach((call) => {
                setRecentCalls({ type: 'addCall', call: call });
            })
        })
    }, [])

    return (
        <>
            <div className="p-2 pr-4" style={{ height: "calc(100vh - 2em - 0.5rem)", overflow: "hidden" }}>
                {
                    recentCalls.map((mappedCall, index) => (
                        <Call key={index} call={mappedCall} shouldAnimate={true} setCalls={setRecentCalls} />
                    ))
                }
            </div>
        </>
    )
}

export default RecentCallList