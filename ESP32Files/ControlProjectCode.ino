#include <WiFi.h>
#include <Wire.h>
#include <ESPAsyncWebServer.h>
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
//Connect to internet and create webserver on port 80 
const char *ssid = "Sentil 2.4";
const char *password = "alden2001";
AsyncWebServer server(80);
//Params
String EnergyStatus = "debug energy";
String Speed = "debug speed";
String Pos = "debug pos";
String Yaw = "debug yaw";

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
//Check for commands(HTTP server.on("/something, HTTP_GET)
/* Commands: use server.on
 *  Get Rover position and ping pong ball position
 *  Movement (send commands to drive)
 *  Get Energy status 
 */
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request){
    //Serial.print("Get Root!");
    request->send(SPIFFS, "/index.html", String(), false);
  });
  server.on("/readings", HTTP_GET, [](AsyncWebServerRequest *request){

    request->send(SPIFFS, "/readings.html", String(), false);
  });
  server.on("/readings.css", HTTP_GET, [](AsyncWebServerRequest *request){

    request->send(SPIFFS, "/readings.css", String(), false);
  });
  server.on("/readings.js", HTTP_GET, [](AsyncWebServerRequest *request){
   
    request->send(SPIFFS, "/readings.js", String(), false);
  });
  server.on("/energy", HTTP_GET, [](AsyncWebServerRequest *request){
    EnergyStatus = random(300);
    request->send_P(200, "text/plain", EnergyStatus.c_str());
  });
  server.on("/speed", HTTP_GET , [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", Speed.c_str());
  });
  server.on("/position", HTTP_GET , [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", Pos.c_str());
  });
  server.on("/yaw", HTTP_GET , [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", Yaw.c_str());
  });
  server.begin();
}


void loop() {
//Recieve Energy status

//Recieve Drive status (position)
//Send drive position to vision
//Recieve location of ping pong ball (if found on camera)
//Update array of ping pong ball locations


}
