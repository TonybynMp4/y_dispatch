import SearchBar from '@/components/shadcn/searchbar';
import { filterBolos } from './boloFilter';
import { Button } from '@/components/shadcn/ui/button';
import { ArrowDown10, ArrowDownAZ, ArrowDownZA, UserRoundPlus } from 'lucide-react';
import { Separator } from '@/components/shadcn/ui/separator';
import { CollapsibleTrigger } from '@/components/shadcn/ui/collapsible';
import { useEffect, useState } from 'react';

type Props = {
    setFilteredBolos: Function;
    bolos: any;
    sortDirection: string | null;
    setSortDirection: Function;
}

function BolosHeader({
    setFilteredBolos,
    bolos,
    sortDirection,
    setSortDirection
}: Props) {
    const [search, setSearch] = useState<string>('')

    useEffect(() => {
        filterBolos(bolos, setFilteredBolos, search)
    }, [search, bolos])

    return (
        <div className="h-[5rem]">
            <h1 className="text-xl mb-2 text-center font-bold">BOLO List</h1>
            <div className="flex items-center align-middle px-4 gap-4 h-[2rem]">
                <Button className="bg-transparent w-[3rem] h-[2rem] m-0 p-0 hover:bg-muted" onClick={() =>
                    setSortDirection(sortDirection === "asc" ? "desc" : sortDirection === "desc" ? null : "asc")
                }>
                    {sortDirection === "asc" ? (
                        <ArrowDownAZ className="text-foreground" />
                    ) : sortDirection === "desc" ? (
                        <ArrowDownZA className="text-foreground" />
                    ) : (
                        <ArrowDown10 className="text-foreground" />
                    )}
                </Button>
                <Separator orientation="vertical" />
                <CollapsibleTrigger asChild>
                    <Button className="bg-transparent w-[3rem] h-[2rem] m-0 p-0 hover:bg-muted">
                        <UserRoundPlus size={24} className='cursor-pointer text-foreground'/>
                    </Button>
                </CollapsibleTrigger>
                <Separator orientation="vertical" />
                <SearchBar placeHolder="Search" className="w-full" inputClassName="h-[2rem] my-0 " onkeyup={
                    (e: React.KeyboardEvent<HTMLInputElement>) => (e.key === 'Enter') && setSearch((e.target as HTMLInputElement).value)
                } onchange={
                    (e: React.ChangeEvent<HTMLInputElement>) => setSearch(e.target.value)
                } />
            </div>
        </div>
    )
}

export default BolosHeader