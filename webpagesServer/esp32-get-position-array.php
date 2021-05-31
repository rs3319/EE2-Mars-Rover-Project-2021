<?php
                $servername = "localhost";
                $dbname = "id16895048_esp32_readings";
                $username = "id16895048_esp32admin";
                $password = "-=guqufcaC00e(zM";
                $conn = new mysqli($servername,$username,$password,$dbname);
                $sql = "SELECT PositionX, PositionY from ESP32DriveReadings";
                $result = $conn->query($sql);
                $data = array();
                while($row = $result->fetch_assoc()){
                   $data[] = $row;
                }
                $result->close();

                echo json_encode($data);
                
?>