import { useState } from 'react';

import ActionBar from './actionBar';
type groupsLabels = {
    [key: string]: string
}
type Props = {
    playerGroups: string[],
    groupsLabels: groupsLabels
}

function DispatchTab({ playerGroups, groupsLabels }: Props) {
    const [currentGroup, setCurrentGroup] = useState(playerGroups[0]);

    return (
        <>
            <ActionBar groupsLabels={groupsLabels} currentGroup={currentGroup} setCurrentGroup={setCurrentGroup} />
        </>
    )
};

export default DispatchTab