import { TDispatchUnit } from "@/types";
import { useDroppable } from "@dnd-kit/core";
import { SortableContext, verticalListSortingStrategy } from "@dnd-kit/sortable";
import DraggableUnit from "../unit";

type Props = {
    unassignedUnits: TDispatchUnit[];
};

function UnassignedUnits({ unassignedUnits }: Props) {
    const { setNodeRef } = useDroppable({
        id: 'unassignedUnits',
        data: {
            accepts: ['unit'],
        },
    });

    return (
        <div ref={setNodeRef} className="w-full h-96 bg-green-800">
            Unassigned Units
            <SortableContext strategy={verticalListSortingStrategy} items={unassignedUnits}>
                {unassignedUnits.map((unit, index) => (
                    <DraggableUnit key={index} unit={unit} />
                ))}
            </SortableContext>
        </div>
    );
}

export default UnassignedUnits;