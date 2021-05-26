#include <WiFi.h>
#include <Wire.h>
#include <ESPAsyncWebServer.h>
#include <HTTPClient.h>
#include <SPIFFS.h>
#include <String>
#include <Wire.h>
#include <Arduino.h>

//Initialize pins for communucation with drive, vision and energy
/*Pin Info:
 * IO16 - Arduino D9 Drive RX
 * IO17 - Arduino D8 Drive TX
 * IO19 - Arduino D5 Vision RX
 * 1018 - Arduino D6 Vision TX
 * IO21 - SDA Energy I2C Data
 * IO22 - SCL Energy 12C Clock
 * GND - GND
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


//Params (RAW)
String EnergyStatus = "debug energy";
String VisionStatus;
String DriveStatus;

//Params (Decoded)
int Speed;
int PositionX;
int PositionY;
int Yaw;
int ObjectX;
int ObjectY;

//HTTP Params
const char* serverName = "http://esp32-mars-rover.000webhostapp.com/esp-log-data.php";
String PostType = "";
String apiKeyValue = "EXAMPLEKEY2000";
const char* serverNameGET = "http://esp32-mars-rover.000webhostapp.com/sql-query-latest.php?api_key=EXAMPLEKEY2000&database=commands";

void setup() {
Serial.begin(115200);
if(!SPIFFS.begin(true)){
    Serial.println("An Error has occurred while mounting SPIFFS");
    return;
  }
//UART and I2C Pins
Serial1.begin(115200,SERIAL_8N1,DriveRX,DriveTX);
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


void loop() {
//Recieve Energy status
EnergyStatus = random(300);
//Recieve Drive status (position)
if(Serial1.available()){
  DriveStatus = Serial1.readStringUntil('\n');
  Serial.printf("Received: %s \n",DriveStatus);
  //Send drive position to vision
}


//Recieve location of ping pong ball (if found on camera) 
if(Serial2.available()){
  VisionStatus = Serial2.readStringUntil('\n');
  Serial.printf("Received: %s \n",VisionStatus);
}
//Send ping pong ball location using PostType Object

//POST data to command
if(WiFi.status() == WL_CONNECTED){
  HTTPClient http;
  http.begin(serverName);
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");
  // add fields
  PostType = "Normal";
  String httpRequestDataNormal = "api_key=" + apiKeyValue + "&PostType=" + PostType + "&Energy=" + (String)EnergyStatus + "&Speed=" + (String)Speed + "&Yaw=" + (String)Yaw + "&PosX=" + (String)PositionX + "&PosY=" + (String)PositionY; 
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
   }
  }
  http.end();

}
delay(1000);
}
