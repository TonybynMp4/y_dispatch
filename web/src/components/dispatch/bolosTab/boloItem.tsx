import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/shadcn/ui/card";
import { TBOLO } from "@/types";
import { CarIcon, UserIcon } from "lucide-react";

type Props = {
    bolo: TBOLO;
}

function BoloItem({ bolo }: Props) {
    let typeStyle = "border-secondary/40";

    switch (bolo.priority) {
        case 1:
            typeStyle = "border-orange-400/50";
            break;
        case 2:
            typeStyle = "border-destructive";
            break;
    }

    return (
        <Card className={typeStyle + " border-2 bg-secondary/40 rounded-[0.75rem] mb-2"}>
            <CardHeader className="p-2 pt-4 pb-0">
                <CardTitle className="ml-2 text-l flex items-center gap-2">
                    {
                        bolo.type ?
                        <CarIcon/>
                        :
                        <UserIcon/>
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
                    bolo.description || "No information provided."
                }
            </CardContent>
        </Card>
    )
}

export default BoloItem;