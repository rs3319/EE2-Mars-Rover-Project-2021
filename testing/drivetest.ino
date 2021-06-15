#include <HardwareSerial.h>
#include <string>
// DRIVE
void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
Serial1.begin(9600,SERIAL_8N1);
}

void loop() {
  // put your main code here, to run repeatedly:

Serial.println("Reading");
if(Serial1.available()){
  //String Status = Serial1.readStringUntil('\n');
  std::string Status = Serial1.readStringUntil('\n').c_str();
  //std::string Status = Serial1.readStringUntil(';').c_str();
  Serial.println(Status.c_str());
}
Serial.println("Writing");
String ToWrite = "Hello from Drive";
Serial1.println(ToWrite);
delay(1000);
}
