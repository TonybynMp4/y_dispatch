import { TDispatchGroup, TDispatchGroupsActions } from "@/types";
import { useDroppable } from "@dnd-kit/core";
import { SortableContext, verticalListSortingStrategy } from "@dnd-kit/sortable";
import Group from "./Group";

type Props = {
    dispatchGroups: TDispatchGroup[];
    setDispatchGroups: React.Dispatch<TDispatchGroupsActions>;
};

function DispatchGroups({ dispatchGroups, setDispatchGroups }: Props) {
    const { setNodeRef } = useDroppable({
        id: 'dispatchGroups',
        data: {
            accepts: ['group'],
        },
    });

    return (
        <div ref={setNodeRef} className="w-full bg-red-700">
            Dispatch Groups
            <SortableContext strategy={verticalListSortingStrategy} items={dispatchGroups}>
                {dispatchGroups.map((group, index) => (
                    <Group key={index} {...group} />
                ))}
            </SortableContext>
        </div>
    );
}

export default DispatchGroups;