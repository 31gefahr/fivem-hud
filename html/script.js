window.addEventListener('message', function(event) {
    let data = event.data;

    if (data.type === "updateBasics") {
        document.getElementById('player-id').innerText = "#" + (data.id || 0);
        document.getElementById('bank-amount').innerText = (data.bank || 0).toLocaleString();
        document.getElementById('cash-amount').innerText = (data.cash || 0).toLocaleString();
        document.getElementById('job-name').innerText = data.job;
    }

    if (data.type === "updateStatus") {
        document.getElementById('main-hud').style.display = data.show ? "block" : "none";
        setValue('health-val', data.health);
        setValue('armor-val', data.armor);
        setValue('hunger-val', data.hunger);
        setValue('thirst-val', data.thirst);
        setValue('stamina-val', data.stamina);
    }

    if (data.type === "updateCarHud") {
        let carHud = document.getElementById('car-hud');
        if (data.show) {
            carHud.style.display = "flex";
            document.getElementById('speed-val').innerText = data.speed;
            document.getElementById('gear-val').innerText = data.gear === 0 ? "R" : (data.gear === 1 && data.speed === 0 ? "N" : data.gear);
            document.getElementById('fuel-fill').style.height = data.fuel + "%";
            let offset = 283 - (data.rpm * 283);
            document.getElementById('rpm-circle').style.strokeDashoffset = offset;
        } else {
            carHud.style.display = "none";
        }
    }
});

function setValue(id, val) {
    let element = document.getElementById(id);
    if (element) element.innerText = Math.round(val) + "%";
}