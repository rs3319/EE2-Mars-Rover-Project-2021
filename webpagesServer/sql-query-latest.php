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
        else if(test_input($_GET["database"]) == "position"){
        $sql = "SELECT PositionX,PositionY from ESP32DriveReadings WHERE id=(SELECT max(id) FROM ESP32DriveReadings)";
        $result = $conn->query($sql);
        $row = $result->fetch_assoc();
        echo "X: ".$row["PositionX"].", Y: ".$row["PositionY"];    
            
        }else if(test_input($_GET["database"]) == "speed"){
        $sql = "SELECT Speed from ESP32DriveReadings WHERE id=(SELECT max(id) FROM ESP32DriveReadings)";
        $result = $conn->query($sql);
        $row = $result->fetch_assoc();
        echo $row["Speed"];    
            
        }else if (test_input($_GET["database"]) == "commands"){
        $sql = "SELECT id,command,param1,param2 from ESP32Commands WHERE command_timestamp=(SELECT min(command_timestamp) FROM ESP32Commands)";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
        $row = $result->fetch_assoc();
        echo $row["command"].",".$row["param1"].",".$row["param2"];   
        $sql = "DELETE FROM ESP32Commands WHERE id=".$row["id"];
        $conn->query($sql);
        }else{
        echo "nil";
        } 
        }
        $conn->close();
    }
}
function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}
?>
