<?php
$dbname = "id16895048_esp32_readings";
$username = "id16895048_esp32admin";
$password = "-=guqufcaC00e(zM";
$api_key_value = "EXAMPLEKEY2000";
$api_key = $command = $param1 = $param2 = "";
if ($_SERVER["REQUEST_METHOD"] == "POST"){
    $api_key = test_input($_POST["api_key"]);
	if($api_key == $api_key_value) {
        $command = test_input($_POST["name"]);
        $param1 = test_input($_POST["param1"]);
        $param2 = test_input($_POST["param2"]);
        $conn = new mysqli($servername,$username,$password,$dbname);
        if($conn->connect_error){
			echo "dead";
			die("Connection failed: " . $conn->connect_error);
        } 
        $sql = "INSERT INTO ESP32Commands (Command,param1,param2) VALUES ('" . $command . "','" . $param1 . "','" . $param2 . "')";
        if ($conn->query($sql) === TRUE) {
            echo "New Command record created successfully";
        } 
        else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }

}
}
function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}
?>