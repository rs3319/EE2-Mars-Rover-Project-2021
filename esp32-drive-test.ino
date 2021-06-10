int DriveRX = 16; 
int DriveTX = 17;
void setup() {
  // put your setup code here, to run once:
Serial.begin(115200);
Serial1.begin(9600,SERIAL_8N1,DriveRX,DriveTX);

}

void loop() {
  // put your main code here, to run repeatedly:
Serial.println("Reading");
if(Serial1.available()){
  String ReadData = Serial1.readStringUntil('\n');
  Serial.println("Recieved: " + ReadData);
}
Serial.println("Writing");
Serial1.println("Hello esp");
//Serial1.print("Hello esp;");
delay(1000);
}
