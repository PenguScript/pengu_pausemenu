let id = 1;
const uiElements = {};

document.addEventListener("DOMContentLoaded", function () {
    const container = document.getElementById("container");


    window.addEventListener('message', (event) => {
        if (event.data.type === "show") {
            container.classList.add("fade")

        } else if (event.data.type === "hide") {
            container.classList.remove("fade")
        } else if (event.data.type === "openLink") {
            window.invokeNative("openUrl", event.data.link);

        }
    });
});


document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") {
        fetch(`https://pengu_pausemenu/menuEvent`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
    
            },
            body: JSON.stringify({
                type: 'exit'
            })
        })
        console.log('escape hit')
    }
});

function menuClicked(type) {
    fetch(`https://pengu_pausemenu/menuEvent`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',

        },
        body: JSON.stringify({
            'type': type
        })
    })
}