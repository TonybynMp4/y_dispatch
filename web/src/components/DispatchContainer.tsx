import { TDispatchPermissions, TLocale, TPlayerGroups } from "@/types"
import { useNuiEvent } from "@/utils/useNuiEvent"
import { isEnvBrowser } from "@/utils/misc"
import { fetchNui } from "@/utils/fetchNui"
import { useEffect, useState } from "react"
import Dispatch from "./dispatch"
import RecentCallList from "./call/recentCallList"
import { Switch } from "./shadcn/ui/switch"
import { CallsProvider } from "./call/callsContext"
import { Locales } from "@/utils/locale"
import { testPlayerGroups, debugPermissions } from "@/data/dispatchData"

type showDispatch = {
    show: boolean,
    permissions?: TDispatchPermissions | false
}

function DispatchContainer() {
    const isBrowser = isEnvBrowser();
    const [showDispatch, setShowDispatch] = useState(false)
    const [playerGroups, setPlayerGroups] = useState<TPlayerGroups>(isBrowser ? testPlayerGroups : [])
    const [dispatchPermissions, setPermissions] = useState<TDispatchPermissions>(isBrowser ? debugPermissions : {dispatch: false, bolo: false, bracelet: false})

    if (isBrowser) document.body.classList.add("bg-background");

    useNuiEvent<showDispatch>("showDispatch", ({ show, permissions }) => {
        if (!show) return setShowDispatch(false);

        if (permissions) setPermissions({
            dispatch: permissions.dispatch || false,
            bolo: permissions.bolo || false,
            bracelet: permissions.bracelet || false
        });

        setShowDispatch(true);
    });

    useNuiEvent<{locale: TLocale}>("setupLocales", ({ locale }) => {
        if (!locale) return;
        for (const key in locale) Locales[key] = locale[key];
    });

    // Handle pressing escape/backspace
    useEffect(() => {
        // Only attach listener when we are visible
        if (!showDispatch) return;

        const keyHandler = (e: KeyboardEvent) => {
            if (["Escape"].includes(e.code)) {
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
            <main className={"w-[30vw] min-w-[330px] h-[95vh] absolute top-[2.5vh] right-[1vw] "}>
                {
                    showDispatch ?
                        <Dispatch dispatchPermissions={dispatchPermissions} playerGroups={playerGroups} />
                        :
                        <CallsProvider Calls={[]}>
                            <RecentCallList />
                        </CallsProvider>

                }
            </main>
        </>
    )
}

export default DispatchContainer