import { TCall } from "@/types";
import { useNuiEvent } from "@/utils/useNuiEvent";
import Call from "./call"
import { useCalls, useCallsDispatch } from "./callsContext";

type Props = {}

function RecentCallList({ }: Props) {
    const recentCalls = useCalls();
    const setRecentCalls = useCallsDispatch();

    useNuiEvent<TCall>("addCall", (call) => {
        setRecentCalls({ type: 'addCall', call: call});
    })

    return (
        <>
            <div className="p-2 pr-4" style={{ height: "calc(100vh - 2em - 0.5rem)", overflow: "hidden" }}>
                {
                    recentCalls.map((mappedCall, index) => (
                        <Call key={index} call={mappedCall} shouldAnimate={true} />
                    ))
                }
            </div>
        </>
    )
}

export default RecentCallList