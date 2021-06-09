#include <HardwareSerial.h>

void setup() {
  // put your setup code here, to run once:
Serial1.begin(9600);
Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
Serial.println("Reading");
if(Serial1.available()){
  String Status = Serial1.readStringUntil('\n');
  Serial.println("Read: " + Status);
}
Serial.println("Writing");
String ToWrite = "Hello";
Serial1.println(ToWrite);
}
