fetch("http://worldtimeapi.org/api/timezone/Europe/Budapest")
    .then(response => {
        return response.json();
    }    )
    .then(data => {
        console.log(data);
    });