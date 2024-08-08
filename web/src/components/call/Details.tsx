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
        {(details.speed || details.plate) &&
            <p className="flex">
                { details.speed &&
                    <span className="basis-1/2">
                        <Gauge height="1em" color="white" className={iconClassNames} />{details.speed}
                    </span>
                }
                {details.plate &&
                    <span className="basis-1/2">
                        <Keyboard height="1em" color="white" className={iconClassNames} />{details.plate}
                    </span>
                }
            </p>
        }
        {(details.weapon || details.weaponclass) &&
            <p className="flex">
                { details.weapon &&
                    <span className="basis-1/2">
                        <Icon height="1em" stroke="white" className={iconClassNames} iconNode={crosshair2} />{details.weapon}
                    </span>
                }
                {details.weaponclass &&
                    <span className="basis-1/2">
                        <ChartNoAxesGantt height="1em" color="white" className={iconClassNames} />{details.weaponclass}
                    </span>
                }
            </p>
        }
        {(details.model || details.class || details.color || details.doors) &&
            <p className="flex">
                { details.model &&
                    <span className="basis-1/4">
                        <CarFront height="1em" stroke="white" className={iconClassNames} />{details.model}
                    </span>
                }
                {details.color &&
                    <span className="basis-1/4">
                        <Palette height="1em" stroke="white" className={iconClassNames} />{details.color}
                    </span>
                }
                {details.doors &&
                    <span className="basis-1/4">
                        <DoorClosed height="1em" stroke="white" className={iconClassNames} />{details.doors}
                    </span>
                }
                {details.class &&
                    <span className="basis-1/4">
                        <FileQuestion height="1em" color="white" className={iconClassNames} />{details.class}
                    </span>
                }
            </p>
        }
        {(details.name || details.callsign) &&
            <p className="flex">
                {details.callsign &&
                    <span className="basis-1/3">
                        <Contact2 height="1em" className={iconClassNames} />{details.callsign}
                    </span>
                }
                {details.name &&
                    <span className="basis-1/3">
                        <IdCard height="1em" className={iconClassNames} />{details.name}
                    </span>
                }
                {details.gender &&
                    <span className="basis-1/3">
                        <PersonStanding height="1em" className={iconClassNames} />{details.gender}
                    </span>
                }
            </p>
        }
        {details.phone &&
            <p>
                <Phone height="1em" className={iconClassNames} />{details.phone}
            </p>
        }
        {details.information &&
            <p><Info height="1em" className={iconClassNames} />{details.information}</p>
        }
        </>
    )
}

/*
        if (data.callsign) {
            callInnerHTML += `<div class="information"><span class="fas fa-id-card-clip" style="margin-right: .5vh;"></span> ${data.callsign}</div>`
        }

        if (typeof data.gender == 'number') {
            const icon = data.gender === 1 && "fas fa-venus" || "fas fa-mars"
            const gender = data.gender === 1 && 'Female' || 'Male'
            callInnerHTML += `<div class="information"><span class="${icon}" style="margin-right: .5vh;"></span> ${gender}</div>`
        }

        if (data.information) {
            callInnerHTML += `<div class="information"><span class="fas fa-comment-dots" style="margin-right: .5vh;"></span> ${data.information}</div>`
        }
*/

export default Details