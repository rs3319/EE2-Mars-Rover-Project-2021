#include <WiFi.h>
#include <Wire.h>
#include <HTTPClient.h>
#include <String>
#include <Arduino.h>
#include <math.h>
#include <sstream>
#include <iostream>
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

//Connect to internet
const char *ssid = "Sentil 2.4";
const char *password = "alden2001";
//AsyncWebServer server(81);
bool Drivebusy = false;

//Params (RAW)
String EnergyStatus = "debug energy";
std::string VisionStatus;
String DriveStatus;

//Params (Decoded)
int Speed;
int PositionX = 0;
int PositionY = 0;
int yaw;
int ObjectX;
int ObjectY;

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


void processVision(unsigned int Vbuff[7]){
  int area_threshold = 0x8;
  int upper_threshold = 1;
  int threshold = area_threshold;
  int ball_d = 4;
  float focal_l = 800;
  int rover_l =  24;
  int centre_pixel = 320;
  int rw = abs((Vbuff[1] & 0x3FF)-(Vbuff[1] >> 19)); //fine
  int rh = abs((Vbuff[2] >> 19) - ((Vbuff[1] >> 10)&0x1FF)); //fine
  int gw = abs((Vbuff[3] >> 19)-((Vbuff[2] >> 9)& 0x3FF)); //fine
  int gh = abs(((Vbuff[3] >> 10)&0x1FF) - (Vbuff[2] & 0x1FF)); //fine
  int bw = abs((Vbuff[0] & 0x3FF) - (Vbuff[3]&0x3FF)); //fine
  int bh = abs((Vbuff[4] >> 19) - ((Vbuff[0] >> 10)& 0x1FF)); //fine
  int yw = abs((Vbuff[5] >> 19) - ((Vbuff[4] >> 9)& 0x3FF)); //fine
  int yh = abs(((Vbuff[5] >> 10)& 0x1FF) - (Vbuff[4] & 0x1FF)); //fine
  int pw = abs(((Vbuff[6] >> 9) & 0x3FF) - (Vbuff[5] & 0x3FF)); //fine
  int ph = abs((Vbuff[6] & 0x1FF) - (Vbuff[6] >> 19)); //fine
  
  float rdist = (((float)rw/rh > 0.5) && ((float)rw/rh < 1.5) && (rw < 400)) ? ((ball_d * focal_l / rw) ) : 0 ;
  float gdist = (((float)gw/gh > 0.5) && ((float)gw/gh < 1.5) && (gw < 400) ) ? ((ball_d * focal_l / gw) ) : 0;
  float bdist = (((float)bw/bh > 0.5) && ((float)bw/bh < 1.5) && (bw < 400)) ? ((ball_d * focal_l / bw) ) : 0;
  float ydist = (((float)yw/yh > 0.5) && ((float)yw/yh < 1.5) && (yw < 400) ) ? ((ball_d * focal_l / yw) ) : 0;
  float pdist = (((float)pw/ph > 0.5) && ((float)pw/ph < 1.5) && (pw < 400)) ? ((ball_d * focal_l / pw) ) : 0;
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
  if(rdist > threshold){
    // do dist and pix calculation to get ppx and ppy;
    perp = rdist;
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
  if(gdist > threshold){
    // do dist and pix calculation to get ppx and ppy;
    perp = gdist;
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
  if(bdist > threshold){
    // do dist and pix calculation to get ppx and ppy;
    perp = bdist;
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
  if(ydist > threshold){
    // do dist and pix calculation to get ppx and ppy;
    perp = ydist;
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
  if(pdist > threshold){
    // do dist and pix calculation to get ppx and ppy;
    perp = pdist;
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
//Recieve Energy status
EnergyStatus = random(300);
/*
PositionX += 10;
PositionY += 5;
if(PositionY > 40){
  PositionX -= 20;
}
*/
//Recieve Drive status (position)
if(Serial1.available()){
  DriveStatus = Serial1.readString();
  if(DriveStatus != ""){
  Serial.printf("Received: %s \n",DriveStatus);
  if(DriveStatus == "done"){
    Drivebusy = false;
  }else{
  sscanf(DriveStatus.c_str(),"%d,%d,%d,%d",&PositionX,&PositionY,&Speed,&yaw);
  }
  }
}

//Recieve location of ping pong ball (if found on camera) and send to database
if(Serial2.available()){
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

//Dummy pingpong balls
if(WiFi.status() == WL_CONNECTED){
  /*
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
     http.begin(serverNameGET);
     http.addHeader("Content-Type", "application/x-www-form-urlencoded");
     //Serial.println("HTTP GET command");
     httpResponseCode = http.GET(); 
     String CurrentCommand = "";
     if(httpResponseCode>0){
     //Serial.print("httpResponseCode :");
     //Serial.println(httpResponseCode);
     CurrentCommand = http.getString();
     if(CurrentCommand != "nil"){
         Serial.println(CurrentCommand);
         Serial1.println(CurrentCommand);
         Drivebusy = true;
     }
    }
    http.end();
   }
}
delay(1000);
}
