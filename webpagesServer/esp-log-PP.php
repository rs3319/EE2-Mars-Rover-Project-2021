<?php
$servername = "localhost";
$dbname = "id16895048_esp32_readings";
$username = "id16895048_esp32admin";
$password = "-=guqufcaC00e(zM";
$api_key_value = "EXAMPLEKEY2000";
$api_key = $color = $PPX = $PPY = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
	$api_key = test_input($_POST["api_key"]);
	if($api_key == $api_key_value) {
        $color = test_input($_POST["Color"]);
        $PPX = test_input($_POST["PosX"]);
        $PPY = test_input($_POST["PosY"]);
		$conn = new mysqli($servername,$username,$password,$dbname);
		if($conn->connect_error){
			echo "dead";
			die("Connection failed: " . $conn->connect_error);
        } 
    	$sql = "INSERT INTO ESP32PingPong (Color,X,Y) VALUES ('" . $color . "','" . $PPX . "','" . $PPY . "')";
        if ($conn->query($sql) === TRUE) {
            echo "New Drive record created successfully";
        } 
        else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }




        $conn->close();
    }
    else {
        echo "Wrong API Key provided.";
    }
}
else {
    echo "No data posted with HTTP POST.";
    echo $_SERVER["REQUEST_METHOD"];
}
function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

?>