<?php
$servername = "localhost";
$dbname = "id16895048_esp32_readings";
$username = "id16895048_esp32admin";
$password = "-=guqufcaC00e(zM";
$api_key_value = "EXAMPLEKEY2000";
$conn = new mysqli($servername,$username,$password,$dbname);
$sql = "SELECT Color,AVG(X) AS X,AVG(Y) AS Y from ((SELECT * from ESP32PingPong where Color=\"Red\" order by reading_time DESC LIMIT 5) UNION (SELECT * from ESP32PingPong where Color=\"Blue\" order by reading_time DESC LIMIT 5) UNION (SELECT * from ESP32PingPong where Color=\"Green\" order by reading_time DESC LIMIT 5) UNION (SELECT * from ESP32PingPong where Color=\"Yellow\" order by reading_time DESC LIMIT 5) UNION (SELECT * from ESP32PingPong where Color=\"Pink\" order by reading_time DESC LIMIT 5)) AS t group by Color";
$result = $conn->query($sql);
 $data = array();
 while($row = $result->fetch_assoc()){
    $data[] = $row;
}
$result->close();

echo json_encode($data);

?>