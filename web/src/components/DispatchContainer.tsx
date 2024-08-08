import { useState } from "react"
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
    return (
        <>
        <Switch checked={showDispatch} onCheckedChange={() => setShowDispatch(!showDispatch)}/>
        <main className="w-[20vw] min-w-[330px] h-[95vh] absolute top-[2.5vh] right-[1vw]">
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