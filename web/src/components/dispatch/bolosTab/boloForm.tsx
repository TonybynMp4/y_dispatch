import { useRef } from "react";
import { Input } from "@/components/shadcn/ui/input";
import { Label } from "@/components/shadcn/ui/label";
import { Checkbox } from "@/components/shadcn/ui/checkbox";
import { Textarea } from "@/components/shadcn/ui/textarea";
import { fetchNui } from "@/utils/fetchNui";
import { TBOLO } from "@/types";
import { isEnvBrowser } from "@/utils/misc";
import BoloSubmitButton from "./boloSubmitButton";

function BoloFormContent() {
    return (
        <>
            <Input type="text" name="target" placeholder="Target" />
            <Textarea name="description" placeholder="Description" />
            <div className="flex justify-between">
                <div className="flex flex-col align-baseline space-y-2">
                    <Label htmlFor="priority">Priority:</Label>
                    <div className="flex items-center space-x-2 ml-4">
                        <input type="radio" name="priority" value="0" id="low" defaultChecked />
                        <Label htmlFor="low">Low</Label>
                    </div>
                    <div className="flex items-center space-x-2 ml-4">
                        <input type="radio" name="priority" value="1" id="medium" />
                        <Label htmlFor="medium">Normal</Label>
                    </div>
                    <div className="flex items-center space-x-2 ml-4">
                        <input type="radio" name="priority" value="2" id="high" />
                        <Label htmlFor="high">Most Wanted</Label>
                    </div>
                </div>
                <div className="flex justify-between flex-col space-y-4 mr-8">
                    <div className="flex items-center space-x-2 mt-2">
                        <Checkbox name="boloType" id="boloType" value="1" />
                        <Label htmlFor="boloType">Is a Vehicle?</Label>
                    </div>
                    <BoloSubmitButton />
                </div>
            </div>
        </>
    );
}

function onSubmit(formData: FormData, setBolos: Function, setIsOpen: Function) {
    const target = formData.get("target");
    const description = formData.get("description") || "";
    const priority = formData.get("priority");
    const type = formData.get("boloType") || 0;

    if (!target || !priority) return;

    if (!isEnvBrowser()) {
        fetchNui<TBOLO>("addBolo", {
            target: target.toString(),
            description: description.toString(),
            priority: Number(priority),
            type: Number(type),
        }).then((bolo) => {
            if (!bolo) return;

            setBolos({
                type: "addBolo",
                bolo: bolo,
            });
        });
    } else {
        setBolos({
            type: "addBolo",
            bolo: {
                target: target.toString(),
                description: description.toString(),
                priority: Number(priority),
                type: Number(type),
            },
        });
    }

    setIsOpen(false);
}

type Props = {
    setBolos: Function;
    setIsOpen: Function;
};

function BoloForm({ setBolos, setIsOpen }: Props) {
    const formRef = useRef<HTMLFormElement>(null);
    return (
        <form ref={formRef}
            action={async (FormData) => onSubmit(FormData, setBolos, setIsOpen)}
            className="space-y-4">
            <BoloFormContent />
        </form>
    );
}

export default BoloForm;
