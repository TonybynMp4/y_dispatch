import CallDetails from "./Details";
import { Badge } from "../shadcn/ui/badge";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "../shadcn/ui/card";
import { TCall, TRecentCallsAction } from "@/types";
import { cn } from "@/lib/utils";
import { useEffect, useState } from "react";

type Props = {
    call: TCall;
    shouldAnimate?: boolean;
    setCalls?: React.Dispatch<TRecentCallsAction>;
}

function CallCard({ call, shouldAnimate, setCalls }: Props) {
    const [animation, setAnimation] = useState<string>(shouldAnimate ? "animate-slideIn" : "");
    let typeStyle = "bg-secondary/50";

    useEffect(() => {
        if (shouldAnimate && setCalls) {
            const enterTimeout = setTimeout(() => {
                setAnimation("");

                const lifeTimeout = setTimeout(() => {
                    setAnimation("animate-slideOut");

                    const removeTimeout = setTimeout(() => {
                        setCalls({ type: 'removeCall', callId: call.id });
                        clearTimeout(removeTimeout);
                    }, 1000);
                    clearTimeout(lifeTimeout);
                }, call.animationDuration || 5000);
            }, 1000);

            return () => {
                clearTimeout(enterTimeout);
            }
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