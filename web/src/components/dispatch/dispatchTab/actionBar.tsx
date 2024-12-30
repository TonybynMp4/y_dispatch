import { TPlayerGroup, TPlayerGroups } from '@/types';
import { Popover, PopoverContent, PopoverTrigger } from '@/components/shadcn/ui/popover';
import { Command, CommandEmpty, CommandGroup, CommandItem, CommandList } from '@/components/shadcn/ui/command';
import { Button } from '@/components/shadcn/ui/button';
import { ChevronsUpDown, Check } from 'lucide-react';
import { Input } from '@/components/shadcn/ui/input';
import { useState } from 'react';

type Props = {
    playerGroups: TPlayerGroups,
    currentGroup: string,
    setCurrentGroup: Function
}

function getCommandItems(playerGroups: TPlayerGroups, currentGroup: string, setCurrentGroup: Function, setOpen: Function) {
    return playerGroups ? playerGroups.map((group: TPlayerGroup) => {
        return (
            <CommandItem key={group.name} onSelect={() => { setCurrentGroup(group.name); setOpen(false); }}>
                {currentGroup === group.name ? <Check className="h-4 w-4 mr-2" /> : <span className="w-4 mr-2" />}
                {group.label}
            </CommandItem>
    )
    }) : null;
}

const playerCallsigns: { [key: string]: string } = {
    police: "24",
    bennys: "25",
};

function ActionBar({ playerGroups, currentGroup, setCurrentGroup }: Props) {
    const [open, setOpen] = useState(false);

    return (
        <div className="h-12 bg-secondary w-full inline-flex items-center">
            <Popover open={open} onOpenChange={setOpen}>
                <PopoverTrigger asChild>
                    <Button variant="outline" role="combobox" aria-expanded={open} className="ml-4 w-[8em] rounded-[0.5em] justify-between">
                        {playerGroups ? playerGroups.find((group) => group.name === currentGroup)?.label : 'No groups'}
                        <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                    </Button>
                </PopoverTrigger>
                <PopoverContent className="w-[200px] p-0" align='start'>
                    <Command>
                        <CommandList>
                            <CommandEmpty>No group found.</CommandEmpty>
                            <CommandGroup>
                                {getCommandItems(playerGroups, currentGroup, setCurrentGroup, setOpen)}
                            </CommandGroup>
                        </CommandList>
                    </Command>
                </PopoverContent>
            </Popover>
            <Input type="text" placeholder="Matricule" className="w-[6em] rounded-[0.5em] ml-2" defaultValue={playerCallsigns[currentGroup] || ''} />
        </div>
    )
}

export default ActionBar;