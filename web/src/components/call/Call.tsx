import { TCall, TRecentCallsAction } from "@/types";
import { ContextMenu, ContextMenuContent, ContextMenuItem, ContextMenuTrigger } from "../shadcn/ui/context-menu";
import CallCard from "./callCard";

type CallProps = {
    call: TCall;
    hasContextMenu?: boolean;
    shouldAnimate?: boolean;
    setCalls?: React.Dispatch<TRecentCallsAction>;
}

function Call({ hasContextMenu, call, shouldAnimate, setCalls }: CallProps) {
    return (
        <>
        {
            hasContextMenu ?
            <ContextMenu>
                <ContextMenuTrigger>
                    <CallCard shouldAnimate={shouldAnimate} call={call} setCalls={setCalls} />
                </ContextMenuTrigger>
                <ContextMenuContent>
                    <ContextMenuItem>Profile</ContextMenuItem>
                    <ContextMenuItem>Billing</ContextMenuItem>
                    <ContextMenuItem>Team</ContextMenuItem>
                    <ContextMenuItem>Subscription</ContextMenuItem>
                </ContextMenuContent>
            </ContextMenu> : <CallCard shouldAnimate={shouldAnimate} call={call} setCalls={setCalls} />
        }
        </>
    )
}

export default Call