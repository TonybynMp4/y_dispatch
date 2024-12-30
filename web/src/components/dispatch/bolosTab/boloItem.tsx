import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/shadcn/ui/card";
import { TBOLO } from "@/types";
import { CarIcon, UserIcon } from "lucide-react";

type Props = {
    bolo: TBOLO;
}

function BoloItem({ bolo }: Props) {
    let typeStyle = "bg-green-500/40";

    switch (bolo.priority) {
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
        <Card className={typeStyle + " rounded-[0.75rem] mb-2"}>
            <CardHeader className="p-2 pt-4 pb-0">
                <CardTitle className="ml-2 text-l flex items-center gap-2">
                    {
                        bolo.type === 0 ?
                        <UserIcon/>
                        :
                        <CarIcon/>
                    }
                    {
                        bolo.target
                    }
                </CardTitle>
                <CardDescription className="flex justify-between w-100%">
                </CardDescription>
            </CardHeader>
            <CardContent className="p-4 pt-1">
                {
                    bolo.description
                }
            </CardContent>
        </Card>
    )
}

export default BoloItem;