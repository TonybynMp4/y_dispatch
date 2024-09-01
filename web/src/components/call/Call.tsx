import { TCall } from "@/types";
import { ContextMenu, ContextMenuContent, ContextMenuItem, ContextMenuSub, ContextMenuSubContent, ContextMenuSubTrigger, ContextMenuTrigger } from "../shadcn/ui/context-menu";
import CallCard from "./callCard";
import { useCallsDispatch } from "./callsContext";

type CallProps = {
    call: TCall;
    hasContextMenu?: boolean;
    shouldAnimate?: boolean;
}

function Call({ hasContextMenu, call, shouldAnimate }: CallProps) {
    const callsDispatch = useCallsDispatch();

    return (
        <>
            {
                hasContextMenu ?
                    <ContextMenu>
                        <ContextMenuTrigger>
                            <CallCard shouldAnimate={shouldAnimate} call={call} />
                        </ContextMenuTrigger>
                        <ContextMenuContent>
                            <ContextMenuItem onSelect={() => {callsDispatch({ type: 'removeCall', callId: call.id })}}>
                                Remove Call
                            </ContextMenuItem>
                            <ContextMenuSub>
                                <ContextMenuSubTrigger>Set call priority</ContextMenuSubTrigger>
                                <ContextMenuSubContent>
                                    <ContextMenuItem onSelect={() => {callsDispatch({ type: 'updateCall', callId: call.id, newPriority: 3 })}}>
                                        High
                                    </ContextMenuItem>
                                    <ContextMenuItem onSelect={() => {callsDispatch({ type: 'updateCall', callId: call.id, newPriority: 2 })}}>
                                        Medium
                                    </ContextMenuItem>
                                    <ContextMenuItem onSelect={() => {callsDispatch({ type: 'updateCall', callId: call.id, newPriority: 1 })}}>
                                        Low
                                    </ContextMenuItem>
                                    <ContextMenuItem onSelect={() => {callsDispatch({ type: 'updateCall', callId: call.id, newPriority: 0 })}}>
                                        None
                                    </ContextMenuItem>
                                </ContextMenuSubContent>
                            </ContextMenuSub>
                        </ContextMenuContent>
                    </ContextMenu> : <CallCard shouldAnimate={shouldAnimate} call={call} />
            }
        </>
    )
}

export default Call