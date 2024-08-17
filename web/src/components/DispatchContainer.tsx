import { useNuiEvent } from "@/utils/useNuiEvent"
import { isEnvBrowser } from "@/utils/misc"
import { fetchNui } from "@/utils/fetchNui"
import { useEffect, useState } from "react"
import Dispatch from "./Dispatch"
import CallList from "./call/CallList"
import { Switch } from "./shadcn/ui/switch"
import calls from "@/data/calls"

const playerGroups = ['police', 'sheriff', 'bennys']

const groupsLabels: { [key: string]: string } = {
    police: "LSPD",
    sheriff: "LSSD",
    bennys: "Benny's"
}

function DispatchContainer() {
    const [showDispatch, setShowDispatch] = useState(false)
    const isBrowser = isEnvBrowser();

    if (isBrowser) document.body.classList.add("bg-background");

    useNuiEvent<boolean>("showDispatch", setShowDispatch);

    // Handle pressing escape/backspace
    useEffect(() => {
        // Only attach listener when we are visible
        if (!showDispatch) return;

        const keyHandler = (e: KeyboardEvent) => {
            if (["Backspace", "Escape"].includes(e.code)) {
                if (!isBrowser) fetchNui("hideDispatch");
                else setShowDispatch(!showDispatch);
            }
        };

        window.addEventListener("keydown", keyHandler);

        const groups = fetchNui("getGroups");

        return () => window.removeEventListener("keydown", keyHandler);
    }, [showDispatch]);

    return (
        <>
            {
                isBrowser &&
                <Switch checked={showDispatch} onCheckedChange={() => setShowDispatch(!showDispatch)} />
            }
            <main className={"w-[20vw] min-w-[330px] h-[95vh] absolute top-[2.5vh] right-[1vw] "}>
                {
                    showDispatch ?
                        <Dispatch isCivilian={false} playerGroups={playerGroups} groupsLabels={groupsLabels} ></Dispatch>
                        :
                        <CallList showSearch={false} calls={calls} />
                }
            </main>
        </>
    )
}

export default DispatchContainer