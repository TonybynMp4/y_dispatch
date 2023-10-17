let locales = {};

fetch(`https://${GetParentResourceName()}/GetLocales`, {
    method: 'POST',
}).then(data => data.json()).then(data => {
    locales = data;
});

document.addEventListener('DOMContentLoaded', () => {
    window.addEventListener('message', function (event) {
        if (event.data.type == "AddCall") {
            NewCall(event.data.id, event.data.data.length, event.data.data);
        } else if (event.data.type == "RemoveCall") {
            RemoveCall();
        };
    });
});

// returns the locale for a given path (like in the core's lang:t)
function locale(localeindex, args) {
    if (!locales || !locales[localeindex]) return localeindex;
    let locale = locales[localeindex];
    if (args) {
        Object.keys(args).forEach(function (key) {
            locale = locale.replace('${' + key + '}', args[key]);
        });
    }
    return locale;
}

function NewCall(Id, length, data) {
    const callElement = document.createElement('div');
    callElement.classList.add('dispatch-call');
    callElement.setAttribute('id', Id);
    let callInnerHTML = `
            <div class="top-bar">
                <div class="top-bar-id">#${Id}</div>
                <div class="top-bar-code type-${data.type}">${data.tencode}</div>
                <div class="top-bar-name">${data.title}</div>
            </div>
                <div class="informations-holder">
                <div class="information"><span class="fas fa-stopwatch" style="margin-right: .5vh;"></span> ${locale('justnow')}</div>
                <div class="information"><span class="fas fa-road" style="margin-right: .5vh;"></span> ${locale('distance', {distance: data.distance})}</div>
    `

    if (data.location || data.heading) {
        let style = `margin-right: .5vh;`
        callInnerHTML += `<div class="position information">`
        if (data.location) {
            callInnerHTML += `<span class="fas fa-map-pin" style="${style}"></span> ${data.location}`
        }
        if (data.heading) {
            if (data.location) { style += ` margin-left: 2vh;` }
            callInnerHTML += `<span class="fas fa-compass" style="${style}"></span> ${data.heading}`
        }
        callInnerHTML += `</div>`
    }

    if (data.speed) {
        callInnerHTML += `<div class="information"><span class="fas fa-gauge-simple-high" style="margin-right: .5vh;"></span> ${data.speed}</div>`
    }

    if (data.camId) {
        callInnerHTML += `<div class="information"><span class="fas fa-video" style="margin-right: .5vh;"></span> #${data.camId}</div>`
    }

    if (data.weapon || data.automatic || data.weaponclass) {
        let style = `margin-right: .5vh;`
        callInnerHTML += `<div class="weapon information">`
        if (data.weapon) {
            callInnerHTML += `<span class="fas fa-gun" style="${style}"></span> ${data.weapon}`
        }
        if (data.weaponclass) {
            if (data.weapon) { style += ` margin-left: 2vh;` }
            callInnerHTML += `<span class="fas fa-paperclip" style="${style}"></span> ${data.weaponclass}`
        }
        if (data.automatic) {
            if (data.weapon || !data.weaponclass) { style += ` margin-left: 2vh;` }
            callInnerHTML += `<span class="fab fa-blackberry" style="${style}"></span> ${locale('automatic')}`
        }
        callInnerHTML += `</div>`
    }

    if (data.model || data.class || data.color || data.plate || data.doors) {
        let style = `margin-right: .5vh;`
        callInnerHTML += `<div class="vehicle information">`
        if (data.model) {
            callInnerHTML += `<span class="fas fa-car" style="${style}"></span> ${data.model}`
        }
        if (data.class) {
            if (data.model) { style += ` margin-left: 2vh;` }
            callInnerHTML += `<span class="fas fa-keyboard" style="${style}"></span> ${data.class}`
        }
        if (data.plate) {
            if (data.model || !data.class) { style += ` margin-left: 2vh;` }
            callInnerHTML += `<span class="fas fa-keyboard" style="${style}"></span> ${data.plate}`
        }
        callInnerHTML += `</div>`
        if (data.doors) {
            callInnerHTML += `<div class="information"><span class="fas fa-door-open" style="margin-right: .5vh;"></span> ${data.doors}</div>`
        }
        if (data.color) {
            callInnerHTML += `<div class="information"><span class="fas fa-palette" style="margin-right: .5vh;"></span> ${data.color}</div>`
        }
    }

    if (data.callsign) {
        callInnerHTML += `<div class="information"><span class="fas fa-id-card-clip" style="margin-right: .5vh;"></span> ${data.callsign}</div>`
    }

    if (data.name || data.number) {
        let style = `margin-right: .5vh;`
        callInnerHTML += `<div class="person information">`
        if (data.number) {
            callInnerHTML += `<span class="fas fa-mobile-alt" style="${style}"></span> ${data.number}`
        }
        if (data.name) {
            if (data.number) { style += ` margin-left: 2vh;` }
            callInnerHTML += `<span class="far fa-id-badge" style="${style}"></span> ${data.name}`
        }
        callInnerHTML += `</div>`
    }

    if (typeof data.gender == 'number') {
        const icon = data.gender === 1 && "fas fa-venus" || "fas fa-mars"
        const gender = data.gender === 1 && 'Female' || 'Male'
        callInnerHTML += `<div class="information"><span class="${icon}" style="margin-right: .5vh;"></span> ${gender}</div>`
    }

    if (data.information) {
        callInnerHTML += `<div class="information"><span class="fas fa-comment-dots" style="margin-right: .5vh;"></span> ${data.information}</div>`
    }

    callInnerHTML += `</div>`

    callElement.innerHTML = callInnerHTML;
    document.getElementById("dispatch-container").appendChild(callElement);

    length = length * 1000 || (data.type == 1 && 15000) || (data.type == 2 && 10000) || 8000

    UpdateCalls();

    setTimeout(() => {
        document.getElementById(Id).classList.add("removing");

        setTimeout(() => {
            document.getElementById(Id).remove();
            UpdateCalls();
        }, 1500);
    }, length);
};

function UpdateCalls() {
    const calls = document.getElementsByClassName('dispatch-call')
    if (calls.length == 0) return;
    Object.keys(calls).forEach(function(call, index) {
        if (index == 0) return;
        const callButtons = call.getElementsByClassName('call-buttons')[0];
        if (callButtons) {
            callButtons.remove();
        }
    });
    if (calls[0].getElementsByClassName("call-buttons").length != 0) return;
    calls[0].getElementsByClassName("informations-holder")[0].insertAdjacentHTML('afterend', `
        <div class="call-buttons">
            <div class="call-button call-button-accept">
                <div class="call-button-text">${locale('accept') || 'Accept'}</div>
            </div>
            <div class="call-button call-button-deny">
                <div class="call-button-text">${locale('deny') || 'Deny'}</div>
            </div>
        </div>
    `);
}

function RemoveCall() {
    const calls = document.getElementsByClassName('dispatch-call')
    if (calls.length == 0) return;
    if (calls[0].classList.contains("animate__slideOutRight")) return;
    calls[0].classList.add("animate__slideOutRight");

    setTimeout(() => {
        calls[0].remove();
        UpdateCalls();
        fetch(`https://${GetParentResourceName()}/RemoveCall`, {
            method: 'POST'
        })
    }, 1000);
}