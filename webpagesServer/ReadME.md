hello,

1.esp-log-PP.php
PHP script called by the Mars Rover whenever an obstacle is sighted to log it's position and color in the 'ESP32PingPong' Database.

2. esp-log-data.php
PHP script called by the Mars Rover every second to log it's current position, speed, yaw and battery life to the 'ESP32DriveReadings' 
and 'ESP32EnergyReadings' databases.

3. esp-post-command.php
PHP Script called by the front end which appends commands to the remote database to be fetched at a later time by the Mars Rover. If 
the script is called with the name parameter being 'clear' it will delete all commands in the database.

4. esp32-get-energy-array.php
PHP Script called by the front end when visualizing the battery life chart. Queries the 50 latest energy readings.

5.esp32-get-ping-pong.php
PHP Script called by the front end when rendering the terrain map of obstacles. Queries the latest 5 readings of each obstacle. color and
returns the average x,y coordinates of each obstacle grouped by color.

6.esp32-get-position-array.php
PHP Script called by the front end when rendering the rover path. Returns all the received coordinates of the rover accross its life-cycle

7.index.php 
The main front-end user interface. 
        Uses esp32-get-energy-array.php to visualize the battery life chart using the google chart tools.
        Uses esp32-get-position-array.php to visualize the rover path using google chart tools.
        Uses esp32-get-ping-pong.php to visualize the terrian map of obstacles using google chart tools.
        Uses esp-post-command to queue up commands into the remote database.
        Uses sql-query-latest.php to get the latest readings of position,speed,yaw and battery life
        
8. sql-position-plot.php , sql-terrain-map.php, sql_energy_chart.php
Used to visualize the path of the rover, the terrain map of obstacles, and the battery life chart respectively. 
Code was moved to index.php so these files aren't in use anymore. 

9. sql-query-latest.php
Used by both the Mars Rover and the front end. The front end uses the script to obstain the latest readings of position,speed, yaw and battery life.
The mars rover uses the script to extract the earliest command which has not been performed yet. After which, the command will be
deleted from the database to avoid repeating the commmaand.
