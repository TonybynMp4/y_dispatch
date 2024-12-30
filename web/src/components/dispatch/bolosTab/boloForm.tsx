import { useFormStatus } from "react-dom";
import { Button } from "@/components/shadcn/ui/button.js";

function BoloFormContent() {
    const { pending } = useFormStatus();
    return (
        <>
            <input type="text" name="target" placeholder="Target" />
            <input type="text" name="description" placeholder="Description" />
            <Button type="submit" disabled={pending}>
                {pending ? "Submitting..." : "Submit"}
            </Button>
        </>
    );
}

function onSubmit(formData: FormData) {
   console.log("Form submitted with data:", formData);
}

type Props = {
    setBolos: Function;
};

function BoloForm({ setBolos }: Props) {
    return (
        <form action={onSubmit}>
            <BoloFormContent />
        </form>
    );
}

export default BoloForm;
