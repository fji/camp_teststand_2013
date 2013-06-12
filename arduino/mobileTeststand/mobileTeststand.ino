//
// Mobile Teststand
// for Zühlke Camp 2013 - Mobile Teststand
//


#include <SPI.h>
#include <Ethernet.h>
#include <Servo.h> 

const int BUFSIZE = 255;
int pos;

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(192,168,1,177);

EthernetServer server(80);

// Set up servos
Servo servos[6];
int angles[6];

Servo servo0;  
Servo servo1;
Servo servo2;
Servo servo3;
Servo servo4;
Servo servo5;

// angle of the servos for portrait and landscape mode, minimum of our servos is 30, maximum is 150
const int PORTRAIT = 30;
const int LANDSCAPE = 120;

//delay to control the speed of the rotation
const int TURNDELAY = 5;

void setup() 
{ 
  Serial.begin(9600);
  
  Ethernet.begin(mac, ip);
  server.begin();
  Serial.print("server is at ");
  Serial.println(Ethernet.localIP());  
  
  //Setup servos
  servo0.attach(22);
  servo1.attach(24);
  servo2.attach(26);
  servo3.attach(28);
  servo4.attach(30);
  servo5.attach(32);

  servos[0] = servo0;
  servos[1] = servo1;
  servos[2] = servo2;
  servos[3] = servo3;
  servos[4] = servo4;
  servos[5] = servo5;
  
  resetAllServos();
  
} 


//The loop
void loop() 
{ 
  EthernetClient client = server.available();
  if (client) {
    Serial.println("new client");
    processHttpRequests(client);
  }
} 


//Turn right round baby

void setServo(int servo, int servoAngle)
{
  servos[servo].write(servoAngle);
  angles[servo] = servoAngle;
}

void turnServoTo(int servo, int servoAngle){
  if(angles[servo] <= servoAngle){
    for(pos = angles[servo]; pos <= servoAngle; pos += 1){                                 
      setServo(servo, pos);
      delay(TURNDELAY);                    
    }
  }
  else{
    for(pos = angles[servo]; pos >= servoAngle; pos -= 1){                                 
      setServo(servo, pos);
      delay(TURNDELAY);                    
    }
  }
}

void turnToPortrait(int servo){
  Serial.print("Servo "); Serial.print(servo); Serial.println(" to portrait"); 
  turnServoTo(servo, PORTRAIT);
}

void turnToLandscape(int servo){
  Serial.print("Servo "); Serial.print(servo); Serial.println(" to landscape");
  turnServoTo(servo, LANDSCAPE);
}

void setAllServos(int pos)
{
  for(int i=0; i< (sizeof(servos)/sizeof(servos[0])); i++){
    turnServoTo(i, pos);
    angles[i] = pos;
  }
}

void resetAllServos(){
  Serial.println("Resetting all Servos ");
  setAllServos(PORTRAIT);
}


//Little Helpers

int degreeAngleToServoAngle(int degreeAngle){
  return degreeAngle + 30;
}

int servoAngleToDegreeAngle(int servoAngle){
  return servoAngle - 30;
}


//Debug outputs

void printServoPositions(){
  Serial.println("------------");
  for(int i=0; i< (sizeof(servos)/sizeof(servos[0])); i++){
    Serial.print("Servo "); Serial.print(i); Serial.print(": "); Serial.println(servoAngleToDegreeAngle(angles[i]));
  }
  Serial.println("------------");
}
