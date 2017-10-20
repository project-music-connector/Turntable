//by Alice Barbe and Beatriz Fusaro

#include <math.h>
#include <AccelStepper.h>
#define HALFSTEP  8


// Motor pin definitions
#define motorPin1 50     // IN1 on the ULN2003 driver 1
#define motorPin2 51     // IN2 on the ULN2003 driver 1
#define motorPin3 52     // IN3 on the ULN2003 driver 1
#define motorPin4 53     // IN4 on the ULN2003 driver 1

// Initialize with pin sequence IN1-IN3-IN2-IN4 for using the AccelStepper with 28BYJ-48
AccelStepper stepper(HALFSTEP, motorPin1, motorPin3, motorPin2, motorPin4);
  
//Infrared Sensor Pins
const int irPin0  = A0;
const int irPin1  = A1;
const int irPin2  = A2;
const int irPin3  = A3;
const int irPin4  = A4;
const int irPin6  = A6;
const int irPin5  = A5;
const int irPin7  = A7;
const int irPin8  = A8;
const int irPin9  = A9;
const int irPin10 = A10;
const int irPin11 = A11;
const int irPin12 = A12;
const int irPin13 = A13;
const int irPin14 = A14;

//Switch pins
const int switch1  = 28;
const int switch2  = 29;
const int switch3  = 30;
const int switch4  = 31;
const int switch5  = 32;
const int switch6  = 33;
const int switch7  = 34;
const int switch8  = 35;
const int switch9  = 36;
const int switch10 = 37;
const int switch11 = 38;
const int switch12 = 39;

//Potentiometer pin for controlling motor speed
const int potPin = A15;

int pv0[5] = {0, 0, 0, 0, 0};
int pv1[5] = {0, 0, 0, 0, 0};
int pv2[5] = {0, 0, 0, 0, 0};
int pv3[5] = {0, 0, 0, 0, 0};
int pv4[5] = {0, 0, 0, 0, 0};
int pv5[5] = {0, 0, 0, 0, 0};
int pv6[5] = {0, 0, 0, 0, 0};
int pv7[5] = {0, 0, 0, 0, 0};
int pv8[5] = {0, 0, 0, 0, 0};
int pv9[5] = {0, 0, 0, 0, 0};
int pv10[5] = {0, 0, 0, 0, 0};
int pv11[5] = {0, 0, 0, 0, 0};
int pv12[5] = {0, 0, 0, 0, 0};
int pv13[5] = {0, 0, 0, 0, 0};
int pv14[5] = {0, 0, 0, 0, 0};
int value = 0;

int RunningAverage(int newer, int value, int pv[5]) {
  pv[value] = newer;
  int sum = 0;
  for (int i = 0; i < 5; i++) {
    sum += pv[i];
  }
  return sum/5;
}

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600);
  
  //make switch pins inputs
  pinMode(switch1, INPUT_PULLUP);
  pinMode(switch2, INPUT_PULLUP);
  pinMode(switch3, INPUT_PULLUP);
  pinMode(switch4, INPUT_PULLUP);
  pinMode(switch5, INPUT_PULLUP);
  pinMode(switch6, INPUT_PULLUP);  
  pinMode(switch7, INPUT_PULLUP);
  pinMode(switch8, INPUT_PULLUP);
  pinMode(switch9, INPUT_PULLUP);
  pinMode(switch10, INPUT_PULLUP);
  pinMode(switch11, INPUT_PULLUP);
  pinMode(switch12, INPUT_PULLUP);

  //set initial motor values
  stepper.setMaxSpeed(1000);
  stepper.setSpeed(50);  
}

void loop() {
  // read the analog in value of the IR sensors:
  int analogIRPin0  = analogRead(irPin0);
  int analogIRPin1  = analogRead(irPin1);
  int analogIRPin2  = analogRead(irPin2);
  int analogIRPin3  = analogRead(irPin3);
  int analogIRPin4  = analogRead(irPin4);
  int analogIRPin5  = analogRead(irPin5);
  int analogIRPin6  = analogRead(irPin6);
  int analogIRPin7  = analogRead(irPin7);
  int analogIRPin8  = analogRead(irPin8);
  int analogIRPin9  = analogRead(irPin9);
  int analogIRPin10 = analogRead(irPin10);
  int analogIRPin11 = analogRead(irPin11);
  int analogIRPin12 = analogRead(irPin12);
  int analogIRPin13 = analogRead(irPin13);
  int analogIRPin14 = analogRead(irPin14);
  analogIRPin0  = RunningAverage(analogIRPin0, value, pv0);
  analogIRPin1  = RunningAverage(analogIRPin1, value, pv1);
  analogIRPin2  = RunningAverage(analogIRPin2, value, pv2);
  analogIRPin3  = RunningAverage(analogIRPin3, value, pv3);
  analogIRPin4  = RunningAverage(analogIRPin4, value, pv4);
  analogIRPin5  = RunningAverage(analogIRPin5, value, pv5);
  analogIRPin6  = RunningAverage(analogIRPin6, value, pv6);
  analogIRPin7  = RunningAverage(analogIRPin7, value, pv7);
  analogIRPin8  = RunningAverage(analogIRPin8, value, pv8);
  analogIRPin9  = RunningAverage(analogIRPin9, value, pv9);
  analogIRPin10 = RunningAverage(analogIRPin10, value, pv10);
  analogIRPin11 = RunningAverage(analogIRPin11, value, pv11);
  analogIRPin12 = RunningAverage(analogIRPin12, value, pv12);
  analogIRPin13 = RunningAverage(analogIRPin13, value, pv13);
  analogIRPin14 = RunningAverage(analogIRPin14, value, pv14);
  value += 1;
  if (value == 5){
    value = 0;
  }

  // read the input pin:
  int switchPin1  = digitalRead(switch1);
  int switchPin2  = digitalRead(switch2);
  int switchPin3  = digitalRead(switch3);
  int switchPin4  = digitalRead(switch4);
  int switchPin5  = digitalRead(switch5);
  int switchPin6  = digitalRead(switch6);
  int switchPin7  = digitalRead(switch7);
  int switchPin8  = digitalRead(switch8);
  int switchPin9  = digitalRead(switch9);
  int switchPin10 = digitalRead(switch10);
  int switchPin11 = digitalRead(switch11);
  int switchPin12 = digitalRead(switch12);
  
  /*The Serial.print() doesn't have a space
  the ',' is used to parse the values in processing
  the last value does not require the ',' 
  but make sure you have a blank Serial.println(); following it*/
  // print the results to the serial monitor:
  
  Serial.print(analogIRPin0, DEC);
  Serial.print(",");
  Serial.print(analogIRPin1, DEC);
  Serial.print(",");
  Serial.print(analogIRPin2, DEC);
  Serial.print(",");
  Serial.print(analogIRPin3, DEC);
  Serial.print(",");
  Serial.print(analogIRPin4, DEC);
  Serial.print(",");
  Serial.print(analogIRPin5, DEC);
  Serial.print(",");
  Serial.print(analogIRPin6, DEC);
  Serial.print(",");
  Serial.print(analogIRPin7, DEC);
  Serial.print(",");
  Serial.print(analogIRPin8, DEC);
  Serial.print(",");
  Serial.print(analogIRPin9, DEC);
  Serial.print(",");
  Serial.print(analogIRPin10, DEC);
  Serial.print(",");
  Serial.print(analogIRPin11, DEC);
  Serial.print(",");
  Serial.print(analogIRPin12, DEC);
  Serial.print(",");
  Serial.print(analogIRPin13, DEC);
  Serial.print(",");
  Serial.print(analogIRPin14, DEC);
  Serial.print(",");
  
  // print switch results to serial
  if (switchPin1 == LOW || switchPin7 == LOW) {
    Serial.print(1, DEC);
  } else if (switchPin2 == LOW || switchPin8 == LOW) {
    Serial.print(2, DEC);
  } else if (switchPin3 == LOW || switchPin9 == LOW) {
    Serial.print(3, DEC);
  } else if (switchPin4 == LOW || switchPin10 == LOW) {
    Serial.print(4, DEC);
  } else if (switchPin5 == LOW || switchPin11 == LOW) {
    Serial.print(5, DEC);
  } else if (switchPin6 == LOW || switchPin12 == LOW) {
    Serial.print(6, DEC);
  } else {
    Serial.print(1, DEC); //default to 1 in case the switch skips a beat
  }
  
  Serial.print(",");

  
  int potValue = analogRead(potPin);
  
  Serial.print(potValue);
  Serial.println();

  // read potentiometer value: between 0 and 1023
  stepper.setSpeed(potValue);
  stepper.runSpeed();

  // wait 50 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading, and to allow Processing
  // to process the information:
  //delay(50);
}
