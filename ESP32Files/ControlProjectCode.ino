#include <WiFi.h>
#include <Wire.h>
#include <HTTPClient.h>
#include <String>
#include <Arduino.h>
#include <math.h>
#include <sstream>
#include <iostream>
#include <deque>
//Initialize pins for communucation with drive, vision and energy
/*Pin Info:
 * IO16 - Arduino D9 Drive RX
 * IO17 - Arduino D8 Drive TX
 * IO19 - Arduino D5 Vision RX
 * 1018 - Arduino D6 Vision TX
 * IO21 - SDA Energy I2C Data
 * IO22 - SCL Energy 12C Clock
 * GND - GNDM
 */

int EnergySDA = 21;
int EnergySCL = 22;
int VisionRX = 19; 
int VisionTX = 18;
int DriveRX = 16; 
int DriveTX = 17;
bool mv = false;
bool Warning = false;
//Connect to internet
const char *ssid = "";
const char *password = "";
//AsyncWebServer server(81);
bool Drivebusy = false;
bool PathFinding = false;
//Params (RAW)
float EnergyStatus = 100;
std::string VisionStatus;
String DriveStatus;
std::deque<String> IQueue;
String CurrentCommand = "";
//Params (Decoded)
int Speed;
int prevX = 0;
int InitialX = 0;
int prevY = 0;
int distTravelled;
int PositionX = 0;
int PositionY = 0;
int yaw;
int ObjectX;
int ObjectY;
bool Turning = false;

//HTTP Params
const char* serverName = "http://esp32-mars-rover.000webhostapp.com/esp-log-data.php";
const char* PPScript = "http://esp32-mars-rover.000webhostapp.com/esp-log-PP.php";
String PostType = "";
String apiKeyValue = "EXAMPLEKEY2000";
const char* serverNameGET = "http://esp32-mars-rover.000webhostapp.com/sql-query-latest.php?api_key=EXAMPLEKEY2000&database=commands";

void setup() {
Serial.begin(115200);
//UART and I2C Pins
Serial1.begin(9600,SERIAL_8N1,DriveRX,DriveTX);
Serial2.begin(115200,SERIAL_8N1,VisionRX,VisionTX);
Wire.begin(EnergySDA,EnergySCL);


//Bind socket and connect to command

Serial.print("Connecting to Wifi...");
WiFi.mode(WIFI_STA);
WiFi.begin(ssid, password);
while(WiFi.status() != WL_CONNECTED){
  delay(1000);
}
Serial.println("Connected: "); Serial.print(WiFi.localIP());
}

void HandleWarning(){
  int x,y;
  Serial1.println("st,0,0");
  IQueue.push_front("tl,90,0");
  IQueue.push_front("fw,20,0");
  IQueue.push_front("tr,90,0");
  IQueue.push_front("fw,20,0");
  IQueue.push_front("tr,90,0");
  IQueue.push_front("fw,20,0");
  IQueue.push_front("tl,90,0");
  //Adjust for moved distance
  int xCorrect = CurrentCommand.substring(3,CurrentCommand.indexOf(',')+1).toInt()-(PositionX-InitialX);
  if(xCorrect > 0){
    IQueue.push_front("fw, "+(String)abs(xCorrect) +",0");
  }else{
    IQueue.push_front("rv, "+(String)abs(xCorrect) +",0");
  }
}

void processVision(unsigned int Vbuff[7]){
  int area_threshold = 0x8;
  int upper_threshold = 1;
  int midBound = 300;
  int threshold = area_threshold;
  int ball_d = 4;
  float focal_l = 800;
  int rover_l =  12;
  int centre_pixel = 320;
  int rw = abs((Vbuff[1] & 0x3FF)-(Vbuff[1] >> 19)); //fine
  int rh = abs((Vbuff[2] >> 19) - ((Vbuff[1] >> 10)&0x1FF)); //fine
  int rmid = abs((Vbuff[2] >> 19) + ((Vbuff[1] >> 10)&0x1FF))/2;
  int gw = abs((Vbuff[3] >> 19)-((Vbuff[2] >> 9)& 0x3FF)); //fine
  int gh = abs(((Vbuff[3] >> 10)&0x1FF) - (Vbuff[2] & 0x1FF)); //fine
  int gmid = abs(((Vbuff[3] >> 10)&0x1FF) - (Vbuff[2] & 0x1FF))/2;
  int bw = abs((Vbuff[0] & 0x3FF) - (Vbuff[3]&0x3FF)); //fine
  int bh = abs((Vbuff[4] >> 19) - ((Vbuff[0] >> 10)& 0x1FF)); //fine
  int bmid = abs((Vbuff[4] >> 19) + ((Vbuff[0] >> 10)& 0x1FF));
  int yw = abs((Vbuff[5] >> 19) - ((Vbuff[4] >> 9)& 0x3FF)); //fine
  int yh = abs(((Vbuff[5] >> 10)& 0x1FF) - (Vbuff[4] & 0x1FF)); //fine
  int ymid =  abs(((Vbuff[5] >> 10)& 0x1FF) + (Vbuff[4] & 0x1FF))/2;
  int pw = abs(((Vbuff[6] >> 9) & 0x3FF) - (Vbuff[5] & 0x3FF)); //fine
  int ph = abs((Vbuff[6] & 0x1FF) - (Vbuff[6] >> 19)); //fine
  int pmid = abs((Vbuff[6] & 0x1FF) + (Vbuff[6] >> 19))/2;
  
  float rdist = (((float)rw/rh > 0.3) && ((float)rw/rh < 2) && (rw < 500)) ? ((ball_d * focal_l / rw) ) : 0 ;
  float gdist = (((float)gw/gh > 0.3) && ((float)gw/gh < 2) && (gw < 500) ) ? ((ball_d * focal_l / gw) ) : 0;
  float bdist = (((float)bw/bh > 0.3) && ((float)bw/bh < 2) && (bw < 500)) ? ((ball_d * focal_l / bw) ) : 0;
  float ydist = (((float)yw/yh > 0.3) && ((float)yw/yh < 2) && (yw < 500) ) ? ((ball_d * focal_l / yw) ) : 0;
  float pdist = (((float)pw/ph > 0.3) && ((float)pw/ph < 2) && (pw < 500)) ? ((ball_d * focal_l / pw) ) : 0;
  int rpix = (Vbuff[1] >> 19) + rw/2;
  int gpix = ((Vbuff[2] >> 9)& 0x3FF) + gw/2;
  int bpix = (Vbuff[3]&0x3FF) + bw/2;
  int ypix = ((Vbuff[4] >> 9)& 0x3FF) + yw/2;
  int ppix = (Vbuff[5] & 0x3FF) + pw/2;
  /*
  int rdist = VisionStatus[0] >> 24;
  int gdist = ((VisionStatus[0] >> 16) & 0xFF);
  int bdist = ((VisionStatus[0] >> 8) & 0xFF);
  int ydist = VisionStatus[0] & 0xFF;
  int pdist = VisionStatus[1] >> 24;
  int rpix = (VisionStatus[1] >> 12) & 0x3FF;
  int gpix = VisionStatus[1] & 0x3FF;
  int bpix = VisionStatus[2] >> 22;
  int ypix = VisionStatus[2] >> 11 & 0x3FF;
  int ppix = VisionStatus[2] & 0x3FF;
  */
  int ppx,ppy; 
  float perp,pix,theta,psi,dx,dy,r;
  if(rdist > threshold && rmid <= midBound){
    // do dist and pix calculation to get ppx and ppy;
    perp = rdist;
    if(perp<10){
      Warning = true;
    }
    pix = rpix; 
    dx = ((pix-320)/320 * perp / 2); // uses the approximation that the ratio of perp:focal width is 1:1
    dy = perp;
    theta = atan(dx/dy); // we might have to check if we need atan or atan2 (consider quadrants?)
    psi = theta + yaw;
    r = sqrt(pow(dx,2)+pow(dy,2));
    ppx = PositionX + r*sin(psi);
    ppy = PositionY + r*cos(psi) + rover_l; 
    HTTPClient http;
    http.begin(PPScript);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");
    String httpRequestDataPP = "api_key=" + apiKeyValue + "&Color=Red" + "&PosX=" + ppx + "&PosY=" + ppy;
    int httpResponseCode = http.POST(httpRequestDataPP); 
    if(httpResponseCode<=0){Serial.print("HTTP ERROR Code: ");Serial.print(httpResponseCode);}
    http.end();
  }
  if(gdist > threshold && gmid <= midBound){
    // do dist and pix calculation to get ppx and ppy;
    perp = gdist;
    if(perp<10){
      Warning = true;
    }
    pix = gpix;
    dx = ((pix-320)/320 * perp / 2); // uses the approximation that the ratio of perp:focal width is 1:1
    dy = perp;
    theta = atan(dx/dy); // we might have to check if we need atan or atan2 (consider quadrants?)
    psi = theta + yaw;
    r = sqrt(pow(dx,2)+pow(dy,2));
    ppx = PositionX + r*sin(psi);
    ppy = PositionY + r*cos(psi) + rover_l;
    HTTPClient http;
    http.begin(PPScript);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");
    String httpRequestDataPP = "api_key=" + apiKeyValue + "&Color=Green" + "&PosX=" + ppx + "&PosY=" + ppy;
    int httpResponseCode = http.POST(httpRequestDataPP); 
    if(httpResponseCode<=0){Serial.print("HTTP ERROR Code: ");Serial.print(httpResponseCode);}
    http.end();
  }
  if(bdist > threshold && bmid <= midBound){
    // do dist and pix calculation to get ppx and ppy;
    perp = bdist;
    if(perp<10){
      Warning = true;
    }
    pix = bpix;
    dx = ((pix-320)/320 * perp / 2); // uses the approximation that the ratio of perp:focal width is 1:1
    dy = perp;
    theta = atan(dx/dy); // we might have to check if we need atan or atan2 (consider quadrants?)
    psi = theta + yaw;
    r = sqrt(pow(dx,2)+pow(dy,2));
    ppx = PositionX + r*sin(psi);
   ppy = PositionY + r*cos(psi) + rover_l; 
    HTTPClient http;
    http.begin(PPScript);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");
    String httpRequestDataPP = "api_key=" + apiKeyValue + "&Color=Blue" + "&PosX=" + ppx + "&PosY=" + ppy;
    int httpResponseCode = http.POST(httpRequestDataPP); 
    if(httpResponseCode<=0){Serial.print("HTTP ERROR Code: ");Serial.print(httpResponseCode);}
    http.end();
  }
  if(ydist > threshold && ymid <= midBound){
    // do dist and pix calculation to get ppx and ppy;
    perp = ydist;
    if(perp<10){
      Warning = true;
    }
    pix = ypix;
    dx = ((pix-320)/320 * perp / 2); // uses the approximation that the ratio of perp:focal width is 1:1
    dy = perp;
    theta = atan(dx/dy); // we might have to check if we need atan or atan2 (consider quadrants?)
    psi = theta + yaw;
    r = sqrt(pow(dx,2)+pow(dy,2));
    ppx = PositionX + r*sin(psi);
    ppy = PositionY + r*cos(psi) + rover_l;
    HTTPClient http;
    http.begin(PPScript);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");
    String httpRequestDataPP = "api_key=" + apiKeyValue + "&Color=Yellow" + "&PosX=" + ppx + "&PosY=" + ppy;
    int httpResponseCode = http.POST(httpRequestDataPP); 
    if(httpResponseCode<=0){Serial.print("HTTP ERROR Code: ");Serial.print(httpResponseCode);}
    http.end();
  }
  if(pdist > threshold && pmid <= midBound){
    // do dist and pix calculation to get ppx and ppy;
    perp = pdist;
    if(perp<10){
      Warning = true;
    }
    pix = ppix;
    dx = ((pix-320)/320 * perp / 2); // uses the approximation that the ratio of perp:focal width is 1:1
    dy = perp;
    theta = atan(dx/dy); // we might have to check if we need atan or atan2 (consider quadrants?)
    psi = theta + yaw;
    r = sqrt(pow(dx,2)+pow(dy,2));
    ppx = PositionX + r*sin(psi);
    ppy = PositionY + r*cos(psi) + rover_l; 
    HTTPClient http;
    http.begin(PPScript);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");
    String httpRequestDataPP = "api_key=" + apiKeyValue + "&Color=Pink" + "&PosX=" + ppx + "&PosY=" + ppy;
    int httpResponseCode = http.POST(httpRequestDataPP); 
    if(httpResponseCode<=0){Serial.print("HTTP ERROR Code: ");Serial.print(httpResponseCode);}
    http.end();
  } 
}

void loop() {
//Timing 
//int start = millis();
//Recieve Energy status
/* EnergyBusNumber = 8; //This Value requires to be confirmed through testing with the energy subsystem physically connected to the ESP32
  Wire.requestFrom(EnergyBusNumber, 4); // Request 4 bytes : 32 bit int from Energy module   
  i = 0;
  EnergyStatus = 0;
  while (Wire.available()) {
    char c = Wire.read(); 
    EnergyStatus |= c << (i*8);// form 32 bit int from the 4 bytes
    i++;
  }
 */
EnergyStatus -= (float)random(300)/2000;
if(EnergyStatus < 0){
  EnergyStatus = 0;
}
/*
PositionX += 10;
PositionY += 5;
if(PositionY > 40){
  PositionX -= 20;
}
*/
//Recieve Drive status (position)
if(Serial1.available()){
  DriveStatus = Serial1.readStringUntil('\n');
  if(DriveStatus != ""){
  Serial.printf("Received: %s \n",DriveStatus);
  if(DriveStatus == "done"){
    Drivebusy = false;
    if(Turning){
      Turning = false;
    }
  }else{
  prevX = PositionX;
  prevY = PositionY;
  sscanf(DriveStatus.c_str(),"%d,%d,%d,%d",&PositionX,&PositionY,&Speed,&yaw);
  distTravelled += PositionX-prevX + PositionY-prevY;
  }
  }
}

//Recieve location of ping pong ball (if found on camera) and send to database
if(Serial2.available() && !Turning){
 char *byteBuff;
 String VStatus;
 VStatus = Serial2.readStringUntil('\n');
 Serial.print(VStatus);
 VisionStatus = VStatus.c_str();
 unsigned int Vbuff[7];
 if (VisionStatus.size()>=56){
 VisionStatus = VisionStatus.substr(0,56);
 for(int i = 0;i<7;i++){
   std::stringstream ss;
   ss << std::hex << VisionStatus.substr(i*8,8);
   ss >> Vbuff[i];
   Serial.print(Vbuff[i]);
   Serial.print("\n");
 }
 }
 if((Vbuff[0]>>24)=='R'){ // Verify Sync
  processVision(Vbuff);
 }
}
//Pathfinding (Obstacle avoidance)
if(Warning && PathFinding){
  HandleWarning();
  Warning = false;
}
//Dummy pingpong balls

  /*
  if(WiFi.status() == WL_CONNECTED){
  int Dummy[3];
  Dummy[0] = random(pow(2,32));
  Dummy[1] = random(pow(2,32));
  Dummy[2] = random(pow(2,32)); 
  //processVision(Dummy);
  }
  */

//POST data to command
if(WiFi.status() == WL_CONNECTED){
  HTTPClient http;
  http.begin(serverName);
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");
  // add fields
  PostType = "Normal";
  String httpRequestDataNormal = "api_key=" + apiKeyValue + "&PostType=" + PostType + "&Energy=" + (String)EnergyStatus + "&Speed=" + (String)Speed + "&Yaw=" + (String)yaw + "&PosX=" + (String)PositionX + "&PosY=" + (String)PositionY; 
  //Serial.print("HTTP Request: ");
  //Serial.println(httpRequestDataNormal);
  int httpResponseCode = http.POST(httpRequestDataNormal); 
   if(httpResponseCode>0){
    //Serial.print("httpResponseCode :");
    //Serial.println(httpResponseCode);
    String Response = http.getString();
    //Serial.println(Response);

  }else{
    Serial.print("HTTP ERROR Code: ");
    Serial.print(httpResponseCode);
  }
  
  http.end();
  //GET Commands from remote server
  /* Backend contains database with list of commands, 
   * sorts by oldest and sends to ESP32 and then deletes the oldest command 
   */
   if(!Drivebusy){
    Serial.println("Drive Not busy");
    InitialX = PositionX;
    if(IQueue.size() > 0){
      Serial.println("IQUEUE");
      Serial.println(IQueue.front());
      Serial1.println(IQueue.front());
      CurrentCommand = IQueue.front();
      IQueue.pop_front();
      Drivebusy = true;
    }else{
     http.begin(serverNameGET);
     http.addHeader("Content-Type", "application/x-www-form-urlencoded");
     //Serial.println("HTTP GET command");
     httpResponseCode = http.GET(); 
     
     if(httpResponseCode>0){
     //Serial.print("httpResponseCode :");
     //Serial.println(httpResponseCode);
     CurrentCommand = http.getString();
     if(CurrentCommand != "nil"){
         Serial.println(CurrentCommand);
         if(CurrentCommand.substring(0,2) == "mv"){
          Serial.println("move");
               std::string temp;
               String temps;
               int x = 0;
               int y = 0;
               sscanf(CurrentCommand.substring(3).c_str(),"%d,%d",&x,&y);
               Serial.println(CurrentCommand.substring(3).c_str());
               int dx = x-PositionX;
               int dy = y-PositionY;
               IQueue.push_back("yw,0,0");
               if(dy>0){
                  temps = "fw," + String(dy) + ",0";
                  IQueue.push_back(temps);
                  Serial.println("push_backed: "  + temps);
               }else{
                  temps = "rv," + String(abs(dy)) + ",0";
                  IQueue.push_back(temps);
                  Serial.println("push_backed: "  + temps);
               }
               if(dx!=0){
                if(dx>0){
                  temps = "tr,90,0";
                  IQueue.push_back(temps);
                  Serial.println("push_backed: "  + temps);
                  temps = "fw," + String(dx) + ",0";
                  IQueue.push_back(temps);
                  Serial.println("push_backed: "  + temps);
                }else{
                  temps = "tl,90,0";
                  IQueue.push_back(temps);
                  Serial.println("push_backed: "  + temps);
                  temps = "fw," + String(abs(dx)) + ",0";
                  IQueue.push_back(temps);
                  Serial.println("push_backed: "  + temps);
                }
               }
           }else{
            if((CurrentCommand.substring(0,2)=="tl") || (CurrentCommand.substring(0,2)=="tr")){
              Turning = true;
            }
            Serial1.println(CurrentCommand);
            Drivebusy = true;
           }
     }
    }
    http.end();
   }
   }
}
//int stopt = millis();
//String Timing = "Loop time: " + String(stopt-start);
Serial.print(Timing);
delay(1000);
}
