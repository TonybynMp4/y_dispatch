import { Popover, PopoverContent, PopoverTrigger } from '@/components/shadcn/ui/popover';
import { Command, CommandEmpty, CommandGroup, CommandItem, CommandList } from '@/components/shadcn/ui/command';
import { Button } from '@/components/shadcn/ui/button';
import { ChevronsUpDown, Check } from 'lucide-react';
import { Input } from '@/components/shadcn/ui/input';
import { useState } from 'react';

type groupsLabels = {
    [key: string]: string
}

type Props = {
    groupsLabels: groupsLabels,
    currentGroup: string,
    setCurrentGroup: Function
}

function getCommandItems(groupsLabels: groupsLabels, currentGroup: string, setCurrentGroup: Function, setOpen: Function) {
    return Object.keys(groupsLabels).map((group) => {
        return (
            <CommandItem key={group} onSelect={() => {setCurrentGroup(group); setOpen(false);} }>
                {currentGroup === group ? <Check className="h-4 w-4 mr-2" /> : <span className="w-4 mr-2"/>}
                {groupsLabels[group]}
            </CommandItem>
        )
    })
}

const playerCallsigns: {[key: string]: string} = {
    police: "24",
    bennys: "25",
};

function ActionBar({ groupsLabels, currentGroup, setCurrentGroup }: Props) {
    const [open, setOpen] = useState(false);

    return <div className="h-12 bg-secondary w-full inline-flex items-center">
        <Popover open={open} onOpenChange={setOpen}>
            <PopoverTrigger asChild>
                <Button variant="outline" role="combobox" aria-expanded={open} className="ml-4 w-[8em] rounded-[0.5em] justify-between">
                    {groupsLabels[currentGroup]}
                    <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                </Button>
            </PopoverTrigger>
            <PopoverContent className="w-[200px] p-0">
                <Command>
                    <CommandList>
                        <CommandEmpty>No framework found.</CommandEmpty>
                        <CommandGroup>
                            {getCommandItems(groupsLabels, currentGroup, setCurrentGroup, setOpen)}
                        </CommandGroup>
                    </CommandList>
                </Command>
            </PopoverContent>
        </Popover>
        <Input type="text" placeholder="Matricule" className="w-[6em] rounded-[0.5em] ml-2" defaultValue={playerCallsigns[currentGroup] || ''} />
    </div>
}

export default ActionBar;