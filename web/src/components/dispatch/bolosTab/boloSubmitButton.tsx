import { Button } from "@/components/shadcn/ui/button";
import { LoaderIcon } from "lucide-react";
import { useFormStatus } from "react-dom";

function BoloSubmitButton() {
    const { pending } = useFormStatus();

    return (
        <Button type="submit" disabled={pending}>
        {pending ?
            <>
                <LoaderIcon className="animate-spin" />
                Submitting...
            </>
        : "Submit"}
    </Button>
    );
}

export default BoloSubmitButton;