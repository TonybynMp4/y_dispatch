import { TDispatchGroup } from "@/types";
import { useDroppable } from "@dnd-kit/core";
import { SortableContext, verticalListSortingStrategy } from "@dnd-kit/sortable";
import DraggableUnit from "../unit";

type Props = TDispatchGroup;

function Group({ id, label, units }: Props) {
    const { setNodeRef } = useDroppable({
        id: 'dispatchGroup' + id,
        data: {
            accepts: ['unit'],
        },
    });

    return (
        <div ref={setNodeRef} className="w-full bg-black p-2">
            {label}
            <div className="bg-yellow-400 min-h-[6em]">
                <SortableContext strategy={verticalListSortingStrategy} items={units}>
                    {units.map((unit, index) => (
                        <DraggableUnit key={index} unit={unit} />
                    ))}
                </SortableContext>
            </div>
        </div>
    );
}

export default Group;