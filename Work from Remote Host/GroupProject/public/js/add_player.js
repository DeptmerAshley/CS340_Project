let addplayerForm = document.getElementById('add-player-form-ajax');

addplayerForm.addEventListener("submit", function (e) {

    e.preventDefault();

    let inputName = document.getElementById("input-name");
    let inputEmail = document.getElementById("input-email");
    let inputBirthday = document.getElementById("input-birthday");

    let nameValue = inputName.value;
    let emailValue = inputEmail.value;
    let birthdayValue = inputBirthday.value;

    let data = {
        name: nameValue,
        email: emailValue,
        birthday: birthdayValue
    }

    // Setup our AJAX request
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", "/add-player-ajax", true);
    xhttp.setRequestHeader("Content-type", "application/json");

    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 200) {

            // Add the new data to the table
            addRowToTable(xhttp.response);

            // Clear the input fields for another transaction
            inputName.value = '';
            inputEmail.value = '';
            inputBirthday.value = '';
        }
        else if (xhttp.readyState == 4 && xhttp.status != 200) {
            console.log("There was an error with the input.")
        }
    }

    xhttp.send(JSON.stringify(data));

})


addRowToTable = (data) => {

    // Get a reference to the current table on the page and clear it out.
    let currentTable = document.getElementById("players-table");

    // Get the location where we should insert the new row (end of table)
    let newRowIndex = currentTable.rows.length;

    // Get a reference to the new row from the database query (last object)
    let parsedData = JSON.parse(data);
    let newRow = parsedData[parsedData.length - 1]

    let row = document.createElement("TR");
    let idCell = document.createElement("TD");
    let nameCell = document.createElement("TD");
    let emailCell = document.createElement("TD");
    let birthdayCell = document.createElement("TD");

    let deleteCell = document.createElement("TD");

    idCell.innerText = newRow.playerID;
    nameCell.innerText = newRow.name;
    emailCell.innerText = newRow.email;
    birthdayCell.innerText = newRow.birthday;

    deleteCell = document.createElement("button");
    deleteCell.innerHTML = "Delete";
    deleteCell.onclick = function(){
        deleteplayer(newRow.id);
    };

    row.appendChild(idCell);
    row.appendChild(nameCell);
    row.appendChild(emailCell);
    row.appendChild(birthdayCell);
    row.appendChild(deleteCell);

    row.setAttribute('data-value', newRow.playerID);
    
    // Add the row to the table
    currentTable.appendChild(row);
}