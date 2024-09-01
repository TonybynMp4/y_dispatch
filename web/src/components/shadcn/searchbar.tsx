import { Input } from "./ui/input";

type Props = {
    searchRef: React.RefObject<HTMLInputElement>;
    placeHolder: string | undefined;
    onchange: (e: React.ChangeEvent<HTMLInputElement>) => void;
    onkeyup?: (e: React.KeyboardEvent<HTMLInputElement>) => void;
    className?: string;
    inputClassName?: string;
}

function SearchBar({searchRef, placeHolder, onchange, onkeyup, className, inputClassName }: Props) {
    return (
        <div className={"relative flex items-center " + className}>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor"
            strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"
            className="absolute left-5 h-4 w-4 text-muted-foreground">
                <circle cx="11" cy="11" r="8"></circle><path d="m21 21-4.3-4.3"></path>
            </svg>
            <Input ref={searchRef} onKeyUp={onkeyup} onChange={onchange} className={"h-[2.5%] w-full p-4 pl-[2.5rem] text-l m-[2.5%] "  + inputClassName} placeholder={placeHolder || "Search"} />
        </div>
    );
}

export default SearchBar;