import CallDetails from "./details";
import { Badge } from "../shadcn/ui/badge";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "../shadcn/ui/card";
import { TCall } from "@/types";
import { cn } from "@/lib/utils";
import { useEffect, useState } from "react";
import { useCallsDispatch } from "./callsContext";

type Props = {
    call: TCall;
    shouldAnimate?: boolean;
}

function CallCard({ call, shouldAnimate }: Props) {
    const callsDispatch = useCallsDispatch();
    const [animation, setAnimation] = useState<string>(shouldAnimate ? "animate-slideIn" : "");
    let typeStyle = "bg-secondary/50";

    useEffect(() => {
        if (shouldAnimate && callsDispatch) {
            const enterTimeout = setTimeout(() => {
                setAnimation("");

                const lifeTimeout = setTimeout(() => {
                    setAnimation("animate-slideOut");

                    const removeTimeout = setTimeout(() => {
                        callsDispatch({ type: 'removeCall', callId: call.id });
                        return () => clearTimeout(removeTimeout);
                    }, 900);
                    return () => clearTimeout(lifeTimeout);
                }, call.animationDuration ? call.animationDuration : 5000);
            }, 1000);

            return () => clearTimeout(enterTimeout);
        }
    }, [])

    switch (call.callType) {
        case 1:
            typeStyle = "bg-green-500/40";
            break;
        case 2:
            typeStyle = "bg-orange-600/40";
            break;
        case 3:
            typeStyle = "bg-destructive/75";
            break;
    }

    return (
        <Card className={cn(typeStyle, animation, "rounded-[0.75rem] mb-4")}>
            <CardHeader className="p-4 pb-1">
                <div className="align-middle flex">
                    <div>
                        <Badge className="h-[2em] self-center bg-slate-500 mr-1 text-nowrap">#{call.id}</Badge>
                        <Badge className="h-[2em] self-center bg-cyan-500 text-nowrap">{call.tenCode || '10-00'}</Badge>
                    </div>
                    <CardTitle className="ml-2">
                        {call.title}
                    </CardTitle>
                </div>
                <CardDescription className="flex justify-between w-100%">
                    <span>
                        à {call.details.distance} mètres
                    </span>
                    <span>
                        Il y a 12 secondes
                    </span>
                </CardDescription>
            </CardHeader>
            <CardContent className="p-4 pt-1">
                <CallDetails details={call.details} />
            </CardContent>
        </Card>
    )
}

export default CallCard