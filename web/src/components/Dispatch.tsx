import { useEffect } from "react";
import { TCall, TPlayerGroups } from "@/types";

import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/shadcn/ui/tabs";
import DispatchTab from "./dispatch/dispatchTab/Dispatch";
import BraceletList from "./dispatch/braceletsTab/BraceletList";
import CallList from "./call/callList";
import BoloList from "./dispatch/bolosTab/boloList";

import { CallsProvider, useCallsDispatch } from "./call/callsContext";

import { isEnvBrowser } from "@/utils/misc";
import { useNuiEvent } from "@/utils/useNuiEvent";
import { fetchNui } from "@/utils/fetchNui";

import bracelets from "@/data/bracelets";
import testCalls from "@/data/calls";

type Props = {
    isCivilian: boolean;
    playerGroups: TPlayerGroups;
}

function Dispatch({ isCivilian, playerGroups }: Props) {
    const defaultCalls = isEnvBrowser() ? testCalls : [];
    const setCalls = useCallsDispatch();

    useNuiEvent<TCall>("addCall", (call) => setCalls({ type: 'addCall', call: call }));

    useEffect(() => {
        if (!isEnvBrowser()) fetchNui<TCall[]>("getAllCalls").then((calls) => {
            setCalls({ type: 'addCall', calls: calls });
        })
    }, [])

    return (
        <Tabs defaultValue="history" className="rounded-[1rem] w-full h-full bg-secondary/75">
            <TabsList className="rounded-t-[1rem] h-10 w-full justify-evenly overflow-hidden">
                <TabsTrigger className="rounded" value="history">Call History</TabsTrigger>
                <TabsTrigger className="rounded" value="dispatch">Dispatch</TabsTrigger>
                {
                    isCivilian ? null :
                    <>
                        <TabsTrigger className="rounded" value="bolo">BOLO</TabsTrigger>
                        <TabsTrigger className="rounded" value="bracelets">Bracelets</TabsTrigger>
                    </>
                }
            </TabsList>
            <TabsContent style={{height: "calc(100% - 3rem)"}} value="history">
                <CallsProvider Calls={defaultCalls}>
                    <CallList />
                </CallsProvider>
            </TabsContent>
            <TabsContent style={{height: "calc(100% - 3rem)"}} value="dispatch">
                <DispatchTab playerGroups={playerGroups} />
            </TabsContent>
            {
                isCivilian ? null :
            <>
                <TabsContent style={{height: "calc(100% - 3rem)"}} value="bolo">
                    <BoloList />
                </TabsContent>
                <TabsContent style={{height: "calc(100% - 3rem)"}} value="bracelets">
                    <BraceletList bracelets={bracelets} />
                </TabsContent>
            </>
            }
        </Tabs>
    )
}

export default Dispatch