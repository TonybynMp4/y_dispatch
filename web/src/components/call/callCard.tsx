import CallDetails from "./Details";
import { Badge } from "../shadcn/ui/badge";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "../shadcn/ui/card";
import { TCall } from "@/types";

type Props = {
    call: TCall;
    index: number;
}

function CallCard({call, index}: Props) {
    return (
        <Card className="bg-secondary/75 rounded-[0.75rem] mb-4">
            <CardHeader className="p-4 pb-1">
                <div className="align-middle flex">
                    <div>
                        <Badge className="h-[2em] self-center bg-slate-500 mr-1 text-nowrap">#{index + 1}</Badge>
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