import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/shadcn/ui/tabs";
import DispatchTab from "./dispatch/dispatchTab/Dispatch";
import BraceletList from "./dispatch/braceletsTab/BraceletList";
import CallList from "./call/CallList";

import calls from "@/data/calls";
import bracelets from "@/data/bracelets";
import BoloList from "./dispatch/bolosTab/boloList";

type Props = {
    isCivilian: boolean;
    playerGroups: string[];
    groupsLabels: { [key: string]: string };
}

function Dispatch({ isCivilian, playerGroups, groupsLabels }: Props) {
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
                <CallList showSearch={true} calls={calls} />
            </TabsContent>
            <TabsContent style={{height: "calc(100% - 3rem)"}} value="dispatch">
                <DispatchTab playerGroups={playerGroups} groupsLabels={groupsLabels} />
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