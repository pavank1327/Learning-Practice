-- PHP

<?php
$servername = "PAVAN_K\SQLEXPRESS";
$username = "PAVAN_K\Pavan";
$password = "Lovaraj";
$dbname = "PavanK";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$id = $_POST["id"];
$name = $_POST["name"];
$date1 = $_POST["date1"];
$value1 = $_POST["value1"];
$date2 = $_POST["date2"];
$value2 = $_POST["value2"];

$sql = "INSERT INTO Details (id, name, date1, value1, date2, value2)
        VALUES ('$id', '$name', '$date1', '$value1', '$date2', '$value2')";

if ($conn->query($sql) === TRUE) {
  echo "Data inserted successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>




