<?php
$servername = "localhost";
$dbname = "id16895048_esp32_readings";
$username = "id16895048_esp32admin";
$password = "-=guqufcaC00e(zM";
$api_key_value = "EXAMPLEKEY2000";
if ($_SERVER["REQUEST_METHOD"] == "GET"){
    $api_key = test_input($_GET["api_key"]);
	if($api_key == $api_key_value) {
        $conn = new mysqli($servername,$username,$password,$dbname);
        if($conn->connect_error){
			echo "dead";
			die("Connection failed: " . $conn->connect_error);
        } 
        if (test_input($_GET["database"]) == "energy"){
            
        $sql = "SELECT BatteryLevel from ESP32EnergyReadings WHERE id=(SELECT max(id) FROM ESP32EnergyReadings)";
        $result = $conn->query($sql);
        $row = $result->fetch_assoc();
        echo $row["BatteryLevel"];
        }
    }
    $conn->close();
}
function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}
?>
