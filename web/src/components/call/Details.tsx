import { TCallDetails } from "@/types";
import { MapPin, Compass, Gauge, Keyboard, Phone, Cctv, IdCard, Info, ChartNoAxesGantt, Icon, CarFront, FileQuestion, Palette, DoorClosed, Contact2, PersonStanding } from "lucide-react";
import { crosshair2 } from '@lucide/lab';
type TCallDetailsProps = {
    details: TCallDetails;
}

const iconClassNames = "align-middle inline mb-1"

function Details({ details }: TCallDetailsProps) {
    return (
        <>
        {(details.location || details.heading) &&
            <p className="flex">
                {details.location &&
                    <span className={details.heading && "basis-2/3"}>
                        <MapPin height="1em" color="white" className={iconClassNames} />{details.location}
                    </span>
                }
                {details.heading &&
                    <span className="basis-1/3">
                        <Compass height="1em" color="white" className={iconClassNames} />{details.heading}
                    </span>
                }
            </p>
        }
        {details.camId &&
            <p><Cctv height="1em" className={iconClassNames} />{details.camId}</p>
        }
        {(details.vehicle) &&
            <p className="flex">
                { details.vehicle.speed &&
                    <span className="basis-1/2">
                        <Gauge height="1em" color="white" className={iconClassNames} />{details.vehicle.speed}
                    </span>
                }
                {details.vehicle.plate &&
                    <span className="basis-1/2">
                        <Keyboard height="1em" color="white" className={iconClassNames} />{details.vehicle.plate}
                    </span>
                }
            </p>
        }
        {(details.vehicle) &&
            <p className="flex">
                { details.vehicle.model &&
                    <span className="basis-1/4">
                        <CarFront height="1em" stroke="white" className={iconClassNames} />{details.vehicle.model}
                    </span>
                }
                {details.vehicle.color &&
                    <span className="basis-1/4">
                        <Palette height="1em" stroke="white" className={iconClassNames} />{details.vehicle.color}
                    </span>
                }
                {details.vehicle.doors &&
                    <span className="basis-1/4">
                        <DoorClosed height="1em" stroke="white" className={iconClassNames} />{details.vehicle.doors}
                    </span>
                }
                {details.vehicle.class &&
                    <span className="basis-1/4">
                        <FileQuestion height="1em" color="white" className={iconClassNames} />{details.vehicle.class}
                    </span>
                }
            </p>
        }
        {(details.weapon) &&
            <p className="flex">
                { details.weapon.weaponName &&
                    <span className="basis-1/2">
                        <Icon height="1em" stroke="white" className={iconClassNames} iconNode={crosshair2} />{details.weapon.weaponName}
                    </span>
                }
                {details.weapon.weaponclass &&
                    <span className="basis-1/2">
                        <ChartNoAxesGantt height="1em" color="white" className={iconClassNames} />{details.weapon.weaponclass}
                    </span>
                }
            </p>
        }
        {(details.person) &&
            <p className="flex">
                {details.person.callsign &&
                    <span className="basis-1/3">
                        <Contact2 height="1em" className={iconClassNames} />{details.person.callsign}
                    </span>
                }
                {details.person.name &&
                    <span className="basis-1/3">
                        <IdCard height="1em" className={iconClassNames} />{details.person.name}
                    </span>
                }
                {details.person.gender &&
                    <span className="basis-1/3">
                        <PersonStanding height="1em" className={iconClassNames} />{details.person.gender}
                    </span>
                }
            </p>
        }
        {details.person?.phone &&
            <p>
                <Phone height="1em" className={iconClassNames} />{details.person.phone}
            </p>
        }
        {details.information &&
            <p><Info height="1em" className={iconClassNames} />{details.information}</p>
        }
        </>
    )
}

export default Details