int DriveRX = 16; 
int DriveTX = 17;
void setup() {
  // put your setup code here, to run once:
Serial.begin(115200);
Serial1.begin(9600,SERIAL_8N1,DriveRX,DriveTX);

}

void loop() {
  // put your main code here, to run repeatedly:
if(Serial1.available()){
  String ReadData = Serial1.readStringUntil('\n');
  Serial.print(ReadData);
}
Serial1.println("fw,10,10");
}
