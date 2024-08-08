function deleteCoach(coachID) {
    let data = {
        id: coachID
    };

    var xhttp = new XMLHttpRequest();
    xhttp.open("DELETE", "/delete-person-ajax", true);
    xhttp.setRequestHeader("Content-type", "application/json");

    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 204) {
            deleteRow(coachID);
        }
        else if (xhttp.readyState == 4 && xhttp.status != 204) {
            console.log("There was an error with the input.")
        }
    }
    xhttp.send(JSON.stringify(data));
}

function deleteRow(coachID){
    let table = document.getElementById("coaches-table");
    for (let i = 0, row; row = table.rows[i]; i++) {
        if (table.rows[i].getAttribute("data-value") == coachID) {
            table.deleteRow(i);
            break;
        }
    }
}
