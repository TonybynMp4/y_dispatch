$(document).ready(() => {
    window.addEventListener('message', function (event) {
        if (event.data.type == "AddCall") {
            NewCall(event.data.id, event.data.data.length, event.data.data);
        };
    });
});

function GetTime(time) {
    let date = new Date(time);

    let hours = date.getHours();
    let minutes = date.getMinutes();

    if (hours < 10) {
        hours = "0" + hours;
    }

    if (minutes < 10) {
        minutes = "0" + minutes;
    }

    let nowDate = new Date();
    let nowHours = nowDate.getHours();
    let nowMinutes = nowDate.getMinutes();

    if (nowHours < 10) {
        nowHours = "0" + nowHours;
    }

    if (nowMinutes < 10) {
        nowMinutes = "0" + nowMinutes;
    }

    let now = Date.now();
    let difference = now - time;

    if (difference < 60000) {
        let seconds = Math.floor(difference / 1000);
        if (seconds < 1) {
            return `just now`;
        } else {
            return `${seconds} seconds ago`;
        }
    } else if (difference < 3600000) {
        let minutes = Math.floor(difference / 60000);
        return `${minutes} minutes ago`;
    } else if (difference < 43200000) {
        return `today at ${hours}:${minutes}`;
    } else if (difference < 86400000) {
        return `yesterday at ${hours}:${minutes}`;
    } else {
        return `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()} at ${hours}:${minutes}`;
    }
}

function NewCall(Id, length, data) {
    let Call = `
        <div class="dispatch-call ${Id} animate__animated">
            <div class="top-bar">
                <div class="top-bar-id">#${Id}</div>
                <div class="top-bar-code type-${data.type}">${data.tencode}</div>
                <div class="top-bar-name">${data.title}</div>
            </div>
                <div class="informations-holder">`

    if (data.time) {
        Call += `
        <div class="information">
        <span class="fas fa-stopwatch" style="margin-right: .5vh;"></span>${GetTime(data.time)}
        </div>`
    }

    if (data.location || data.heading){
        Call += `<div class="position information">`
        if (data.location) {
            Call += `<span class="fas fa-map-pin" style="margin-right: .5vh;"></span>${data.location}`
        }
        if (data.heading) {
            Call += `<span class="fas fa-compass" style="margin-left: 2vh;  margin-right: .5vh;"></span>${data.heading}`
        }
        Call += `</div>`
    }

    if (data["camId"]) {
        Call += `<div class="information"><span class="fas fa-video" style="margin-right: .5vh;"></span>#${data.camId}</div>`
    }

    if (data.weapon || data.automatic || data.weaponclass) {
        Call += `<div class="weapon information">`
        if (data.weapon) {
            Call += `<span class="fas fa-gun" style="margin-right: .5vh;"></span>${data.weapon}`
        }
        if (data.weaponclass) {
            Call += `<span class="fas fa-paperclip" style="margin-left: 2vh; margin-right: .5vh;"></span>${data.weaponclass}`
        }
        if (data.automatic) {
            Call += `<span class="fab fa-blackberry" style="margin-left: 2vh; margin-right: .5vh;"></span>${data.automatic}`
        }
        Call += `</div>`
    }

    if (data.model || data.color || data.plate || data.doors) {
        Call += `<div class="vehicle information">`
        if (data.model) {
            Call += `<span class="fas fa-car" style="margin-right: .5vh;"></span>${data.model}`
            if (data.plate) {
                Call += `<span class="fas fa-keyboard" style="margin-left: 2vh; margin-right: .5vh;"></span>${data.plate}`
            }
        } else {
            if (data.plate) {
                Call += `<span class="fas fa-keyboard" style="margin-right: .5vh;"></span>${data.plate}`
            }
        }
        Call += `</div>`
        if (data.doors) {
            Call += `<div class="information"><span class="fas fa-door-open" style="margin-right: .5vh;"></span>${data.doors}</div>`
        }
        if (data.color) {
            Call += `<div class="information"><span class="fas fa-palette" style="margin-right: .5vh;"></span>${data.color}</div>`
        }
    }

    if (data.callsign) {
        Call += `<div class="information"><span class="fas fa-id-card-clip" style="margin-right: .5vh;"></span>${data.callsign}</div>`
    }

    if (data.name || data.number) {
        Call += `<div class="person information">`
        if (data.number) {
            Call += `<span class="fas fa-mobile-alt" style="margin-right: .5vh;"></span>${data.number}`
            if (data.name) {
                Call += `<span class="far fa-id-badge" style="margin-left: 2vh; margin-right: .5vh;"></span>${data.name}`
            }
        } else{
            if (data.name) {
                Call += `<span class="far fa-id-badge" style="margin-right: .5vh;"></span>${data.name}`
            }
        }
        Call += `</div>`
    }

    if (typeof data.gender == 'number') {
        icon = "fas fa-mars"
        gender = 'Male'
        if (data.gender === 1){
            icon = "fas fa-venus"
            gender = 'Female'
        }
        Call += `<div class="information"><span class="${icon}" style="margin-right: .5vh;"></span>${gender}</div>`
    }

    if (data.information) {
        Call += `<div class="information"><span class="fas fa-comment-dots" style="margin-right: .5vh;"></span>${data.information}</div>`
    }

    Call += `</div></div>`

    $(".dispatch-container").prepend(Call)

    length = length * 1000 || (data.type == 1 && 15000) || (data.type == 2 && 10000) || 8000

    $(`.${Id}`).addClass("animate__slideInRight");

    setTimeout(() => {
        $(`.${Id}`).addClass("animate__slideOutRight");

        setTimeout(() => {
            $(`.${Id}`).remove();
        }, 1500);

    }, length);
};