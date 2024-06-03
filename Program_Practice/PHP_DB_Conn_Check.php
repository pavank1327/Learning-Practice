<?php
$servername = "PAVAN_K\SQLEXPRESS";
$username = "PAVAN_K\Pavan";
$password = "Lovaraj";
$dbname = "PavanK";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
} else {
    echo "Connected successfully";
}

// Close connection
mysqli_close($conn);
?>