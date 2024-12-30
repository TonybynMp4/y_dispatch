import SearchBar from '@/components/shadcn/searchbar';
import { filterBolos, onKeyUp } from './boloFilter';
import { Button } from '@/components/shadcn/ui/button';
import { ArrowDown10, ArrowDownAZ, ArrowDownZA, UserRoundPlus } from 'lucide-react';
import { useRef, useState } from 'react';
import { Input } from '@/components/shadcn/ui/input';
import { Separator } from '@/components/shadcn/ui/separator';
import { CollapsibleTrigger } from '@/components/shadcn/ui/collapsible';

type Props = {
    setFilteredBolos: Function;
    setBolos: Function;
    bolos: any;
    sortDirection: string | null;
    setSortDirection: Function;
}

function Header({
    setFilteredBolos,
    setBolos,
    bolos,
    sortDirection,
    setSortDirection
}: Props) {

    return (
        <div className="h-[5rem]">
            <h1 className="text-xl mb-2 text-center font-bold">BOLO List</h1>
            <div className="flex items-center align-middle px-4 gap-4 h-[2rem]">
                <Button className="bg-transparent h-min w-min m-0 p-0 hover:bg-transparent" onClick={() =>
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
                <CollapsibleTrigger>
                    <UserRoundPlus size={24} className='cursor-pointer text-foreground'/>
                </CollapsibleTrigger>
                <Separator orientation="vertical" />
                <SearchBar placeHolder="Search" className="w-full" inputClassName="h-[2rem] my-0 " onkeyup={(e) => onKeyUp(bolos, setFilteredBolos, e)} onchange={(e) => filterBolos(bolos, setFilteredBolos, e)} />
            </div>
        </div>
    )
}

export default Header