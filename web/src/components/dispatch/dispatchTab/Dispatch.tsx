import { TPlayerGroups } from '@/types';
import { useState } from 'react';
import ActionBar from './actionBar';

type Props = {
    playerGroups: TPlayerGroups;
}

function DispatchTab({ playerGroups }: Props) {
    const [currentGroup, setCurrentGroup] = useState(playerGroups[0].name);

    return (
        <>
            <ActionBar playerGroups={playerGroups} currentGroup={currentGroup} setCurrentGroup={setCurrentGroup} />
        </>
    )
};

export default DispatchTab