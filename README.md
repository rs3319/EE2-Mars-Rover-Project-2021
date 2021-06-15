# EE2-Mars-Rover-Project-2021
Documentation and source code for the EE2 Mars Rover Group Project 2021. The aim of this project is to design and build an autonomous rover system that could be used in a remote location without direct supervision. The rover has a processing unit that is capable to receive movement commands and send status data. In doing this it needs to detect and avoid obstacles in its working area. Over time the rover should be able to build a map of its local working area (including those obstacles) on an offsite data store. A charging station will be also designed and implemented to charge the batteries used to power up the rover.

## Submodules

### [Vision](https://github.com/rs3319/EE2-Mars-Rover-Project-2021/tree/main/DE10_LITE_D8M_VIP_16)

### [Control](https://github.com/rs3319/EE2-Mars-Rover-Project-2021/tree/main/ESP32Files)
1.Download the ESP32 Board package onto the Arduino IDE.   
2.Enter WiFi SSID and password into lines 30-31.  
3. (Optional) Set line 53 to true to enable pathfinding.  
4. Upload the code onto the ESP32 and connect mount the device on the FPGA, then connect wires to the Arduino. (Lines 11-19 detail how they are meant to be connected)  
### [Command](https://github.com/rs3319/EE2-Mars-Rover-Project-2021/tree/main/webpagesServer)
### [Drive](https://github.com/rs3319/EE2-Mars-Rover-Project-2021/tree/main/Drive)
