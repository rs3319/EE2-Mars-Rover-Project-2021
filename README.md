# EE2-Mars-Rover-Project-2021
Documentation and source code for the EE2 Mars Rover Group Project 2021. The aim of this project is to design and build an autonomous rover system that could be used in a remote location without direct supervision. The rover has a processing unit that is capable to receive movement commands and send status data. In doing this it needs to detect and avoid obstacles in its working area. Over time the rover should be able to build a map of its local working area (including those obstacles) on an offsite data store. A charging station will be also designed and implemented to charge the batteries used to power up the rover. The rover system comprises of 6 sub-systems:

1. Energy Subsystem

The energy subsystem will provide the rover with charged batteries using solar panels. The main tasks in this subsystem are:

• Charge batteries.
• Battery charge profile design.
• Battery charge status estimation.
• Battery balancing algorithm.
• PV MMPT algorithm.
• System Integration and Test.
• Rover range estimation
• Prevent explosion/melt.

2. Drive Subsystem

The drive subsystem allows the movement of the rover. It contains the rover frame, the motors and the optical flow sensor. The main tasks in the drive subsystem are:

• Speed control.
• Direction control.
• Turning method.
• Distance measurement.

3. Vision Subsystem

The vision subsystem allows the rover to detect and avoid obstacles to achieve its target destination. The main tasks of the vision subsystem are:

• Use on-board vision to identify obstructions and objects of interest. 
o Move the robot around the terrain according to instructions from the remote 
commander, including:
✓ Avoiding obstructions
✓ Closed loop monitoring of position.
✓ Sending commands to the motor control.

4. Control Subsystem

In this subsystem ESP32 microcontroller is used to communicate with all the subsystems via  different communication protocols. The ESP32 has a unique IP address and is used as an access point. The main tasks of the control subsystem are:

• Communicate in both directions with the motors.
• Communicate with the FPGA.
• Receive commands from the command subsystem.
• Send rover status to the command subsystem.
• Receive Energy status from the charging station.

5. Command Subsystem
This subsystem allows the remote control of the rover by connecting to the control subsystem, 
which is accessible via a web browser/mobile app.

The main task of this subsystem is:

• Create a web or mobile dashboard to control the rover remotely and receive information from 
the different subsystems.

6. Integration Subsystem

The integration task brings the whole rover together in one place and requires the connection and integration of all the other modules. The integration student will have access to a second set of other hardware kits to allow the design work to be replicated without shipping equipment between students to make a complete functional rover. The main objectives are:

• Developing the central processor of the rover ensuring correct functionality of all the systems 
together
• Managing communications between the onboard rover systems and the cloud command 
processes
• Build, maintain and assist in debugging the other modules.
• Testing and proving of the full rover system with the aid of the other students remotely.
