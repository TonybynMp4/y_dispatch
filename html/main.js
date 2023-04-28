let locales = {};

fetch(`https://${GetParentResourceName()}/GetLocales`, {
    method: 'POST',
}).then(data => data.json()).then(data => {
    locales = JSON.parse(data);
});

$(document).ready(() => {
    window.addEventListener('message', function (event) {
        if (event.data.type == "AddCall") {
            NewCall(event.data.id, event.data.data.length, event.data.data);
        };
    });
});

// returns the locale for a given path (like in LUA)
function locale(localeindex) {
    return locales[localeindex];
}

function NewCall(Id, length, data) {
    let Call = `
        <div class="dispatch-call ${Id} animate__animated">
            <div class="top-bar">
                <div class="top-bar-id">#${Id}</div>
                <div class="top-bar-code type-${data.type}">${data.tencode}</div>
                <div class="top-bar-name">${data.title}</div>
            </div>
                <div class="informations-holder">
                    <div class="information"><span class="fas fa-stopwatch" style="margin-right: .5vh;"></span> ${locale('justnow')}
                </div>
    `

    if (data.location || data.heading){
        let style = `margin-right: .5vh;`
        Call += `<div class="position information">`
        if (data.location) {
            Call += `<span class="fas fa-map-pin" style="${style}"></span> ${data.location}`
        }
        if (data.heading) {
            if (data.location) { style += ` margin-left: 2vh;` }
            Call += `<span class="fas fa-compass" style="${style}"></span> ${data.heading}`
        }
        Call += `</div>`
    }

    if (data.speed) {
        Call += `<div class="information"><span class="fas fa-gauge-simple-high" style="margin-right: .5vh;"></span> ${data.speed}</div>`
    }

    if (data.camId) {
        Call += `<div class="information"><span class="fas fa-video" style="margin-right: .5vh;"></span> #${data.camId}</div>`
    }

    if (data.weapon || data.automatic || data.weaponclass) {
        let style = `margin-right: .5vh;`
        Call += `<div class="weapon information">`
        if (data.weapon) { // need to find a *good* way to get the weapon name from the hash
            Call += `<span class="fas fa-gun" style="${style}"></span> ${data.weapon}`
        }
        if (data.weaponclass) {
            if (data.weapon) { style += ` margin-left: 2vh;` }
            Call += `<span class="fas fa-paperclip" style="${style}"></span> ${data.weaponclass}`
        }
        if (data.automatic) {
            if (data.weapon || !data.weaponclass) { style += ` margin-left: 2vh;` }
            Call += `<span class="fab fa-blackberry" style="${style}"></span> ${locale('automatic')}`
        }
        Call += `</div>`
    }

    if (data.model || data.class || data.color || data.plate || data.doors) {
        let style = `margin-right: .5vh;`
        Call += `<div class="vehicle information">`
        if (data.model) {
            Call += `<span class="fas fa-car" style="${style}"></span> ${data.model}`
        }
        if (data.class) {
            if (data.model) { style += ` margin-left: 2vh;` }
            Call += `<span class="fas fa-keyboard" style="${style}"></span> ${data.class}`
        }
        if (data.plate) {
            if (data.model || !data.class) { style += ` margin-left: 2vh;` }
            Call += `<span class="fas fa-keyboard" style="${style}"></span> ${data.plate}`
        }
        Call += `</div>`
        if (data.doors) {
            Call += `<div class="information"><span class="fas fa-door-open" style="margin-right: .5vh;"></span> ${data.doors}</div>`
        }
        if (data.color) {
            Call += `<div class="information"><span class="fas fa-palette" style="margin-right: .5vh;"></span> ${data.color}</div>`
        }
    }

    if (data.callsign) {
        Call += `<div class="information"><span class="fas fa-id-card-clip" style="margin-right: .5vh;"></span> ${data.callsign}</div>`
    }

    if (data.name || data.number) {
        let style = `margin-right: .5vh;`
        Call += `<div class="person information">`
        if (data.number) {
            Call += `<span class="fas fa-mobile-alt" style="${style}"></span> ${data.number}`
        }
        if (data.name) {
            if (data.number) { style += ` margin-left: 2vh;` }
            Call += `<span class="far fa-id-badge" style="${style}"></span> ${data.name}`
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
        Call += `<div class="information"><span class="${icon}" style="margin-right: .5vh;"></span> ${gender}</div>`
    }

    if (data.information) {
        Call += `<div class="information"><span class="fas fa-comment-dots" style="margin-right: .5vh;"></span> ${data.information}</div>`
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