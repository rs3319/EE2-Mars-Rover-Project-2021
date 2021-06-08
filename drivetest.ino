int PosX;
int PosY;
void setup() {
  // put your setup code here, to run once:
Serial1.begin(9600);
Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
PosX += 10;
PosY += 10;
if(Serial1.available()){
  String Status = Serial1.readStringUntil('\n');
  Serial.print(Status);
}
String ToWrite = (String)PosX +","+ (String)PosY + ",0,0";
Serial1.write(ToWrite);
}
