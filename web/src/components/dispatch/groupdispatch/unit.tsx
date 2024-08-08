import { TDispatchUnit } from "@/types";
import { useSortable } from "@dnd-kit/sortable";
import { CSS } from '@dnd-kit/utilities';

type Props = {
    unit: TDispatchUnit;
};

function DraggableUnit({ unit }: Props) {
    const {
        attributes,
        listeners,
        setNodeRef,
        transform,
        transition
    } = useSortable({ id: unit.id, data: {type: 'unit'} });

    const style = {
        transform: CSS.Transform.toString(transform),
        transition
    };

    return (
        <div className="p-4 m-2 bg-blue-500" ref={setNodeRef} style={style} {...attributes} {...listeners}>
            Unit {unit.callsign} - {unit.name}
        </div>
    );
}

export default DraggableUnit;