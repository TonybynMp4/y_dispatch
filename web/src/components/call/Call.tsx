import { TCall } from "@/types";
import { ContextMenu, ContextMenuContent, ContextMenuItem, ContextMenuTrigger } from "../shadcn/ui/context-menu";
import CallCard from "./callCard";

type CallProps = {
    call: TCall;
    index: number;
    hasContextMenu?: boolean;
}

function Call({ hasContextMenu, call, index }: CallProps) {
    return (
        <>
        {
            hasContextMenu ?
            <ContextMenu>
                <ContextMenuTrigger>
                    <CallCard call={call} index={index} />
                </ContextMenuTrigger>
                <ContextMenuContent>
                    <ContextMenuItem>Profile</ContextMenuItem>
                    <ContextMenuItem>Billing</ContextMenuItem>
                    <ContextMenuItem>Team</ContextMenuItem>
                    <ContextMenuItem>Subscription</ContextMenuItem>
                </ContextMenuContent>
            </ContextMenu> : <CallCard call={call} index={index} />
        }
        </>
    )
}

export default Call