import { TCall } from "@/types";
import { useNuiEvent } from "@/utils/useNuiEvent";
import Call from "./call"
import { useCalls, useCallsDispatch } from "./callsContext";
import generateCalls from "@/utils/generateCalls";
import { isEnvBrowser } from "@/utils/misc";

type Props = {}

function RecentCallList({ }: Props) {
    const recentCalls = useCalls();
    const setRecentCalls = useCallsDispatch();

    if (isEnvBrowser()) {
        generateCalls(setRecentCalls);
    }

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