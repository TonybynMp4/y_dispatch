import { useEffect } from "react";
import testCalls from "@/data/calls";

function generateCalls(setRecentCalls: Function) {
    useEffect(() => {
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
    }, [])
}

export default generateCalls;