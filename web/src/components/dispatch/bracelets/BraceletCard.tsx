import { Card, CardHeader, CardTitle, CardContent } from "@/components/shadcn/ui/card";
import { Phone, Info } from "lucide-react";
import { TBracelet } from "@/types";

const iconClassNames = "align-middle inline mb-1"

function BraceletCard({firstname, lastname, phone}: TBracelet) {
    return(
        <Card className="bg-secondary/75 rounded-[0.75rem] mb-4">
            <CardHeader className="p-4 pb-1">
                <CardTitle>
                    {lastname} {firstname}
                </CardTitle>
            </CardHeader>
            <CardContent className="p-4 pt-1">
                <p><Phone height="1em" fill="white" color="none" className={iconClassNames} />{phone}</p>
                <p>
                    <Info height="1em" className={iconClassNames} />
                    En attente de jugement
                </p>
            </CardContent>
        </Card>
    )
}

export default BraceletCard;