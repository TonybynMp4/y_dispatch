import { TPlayerGroups } from "@/types"
import { useNuiEvent } from "@/utils/useNuiEvent"
import { isEnvBrowser } from "@/utils/misc"
import { fetchNui } from "@/utils/fetchNui"
import { useEffect, useState } from "react"
import Dispatch from "./Dispatch"
import RecentCallList from "./call/RecentCallList"
import { Switch } from "./shadcn/ui/switch"

const testPlayerGroups: TPlayerGroups = [
    {name: "police", label: "LSPD"},
    {name: "sheriff", label: "LSSD"},
    {name: "bennys", label: "Benny's"}
]

function DispatchContainer() {
    const isBrowser = isEnvBrowser();
    const [showDispatch, setShowDispatch] = useState(false)
    const [playerGroups, setPlayerGroups] = useState<TPlayerGroups>(isBrowser ? testPlayerGroups : [])

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

        if (!isBrowser) fetchNui<TPlayerGroups>("getPlayerGroups").then(setPlayerGroups);

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
                        <Dispatch isCivilian={false} playerGroups={playerGroups} />
                        :
                        <RecentCallList />
                }
            </main>
        </>
    )
}

export default DispatchContainer