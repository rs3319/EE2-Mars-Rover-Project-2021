int PosX = 0;
int PosY = 0;
void setup() {
  // put your setup code here, to run once:
Serial1.begin(9600);
Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
PosX += 10;
PosY += 10;
Serial.println("Reading");
if(Serial1.available()){
  String Status = Serial1.readStringUntil('\n');
  Serial.println(Status);
}
Serial.println("Writing");
String ToWrite = (String)PosX +","+ (String)PosY + ",0,0";
Serial1.println(ToWrite);
}
