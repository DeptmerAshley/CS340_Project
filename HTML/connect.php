<?php
$servername = "classmysql.engr.oregonstate.edu";
$username = "cs340_ashledep";
$password = "3889";
$dbname = "cs340_ashledep";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $training = $_POST['training'];

    $sql = "INSERT INTO Coaches (name, email, trainingComplete) VALUES ('$name', '$email', '$training')";

    if ($conn->query($sql) === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

$conn->close();
?>

<a href="coaches.html">Back to Coaches Page</a>