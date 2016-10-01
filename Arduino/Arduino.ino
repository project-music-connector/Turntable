/*
Analog input, analog output, serial output
Reads an analog input pin and prints the results to the serial monitor.
created 29 Dec. 2008
modified 9 Apr 2012
by Tom Igoe
modified September 2016
by Alice Barbe & Beatriz Fusaro
*/
#include <math.h>

//Infrared Sensor Pins
const int irPin0 = A0;
const int irPin1 = A1;
const int irPin2 = A2;
const int irPin3 = A3;
const int irPin4 = A4;
const int irPin6 = A6;
const int irPin5 = A5;
const int irPin7 = A7;
const int irPin8 = A8;
const int irPin9 = A9;

//Switch pins
const int switch2 = 8;
const int switch3 = 9;
const int switch4 = 10;
const int switch5 = 11;
const int switch6 = 12;
const int switch1 = 13;

//Motor pin
const int motorPin = 3;

//Potentiometer pin for controlling motor speed
const int potPin = A10;

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
  pinMode(switch1, INPUT);
  pinMode(switch2, INPUT);
  pinMode(switch3, INPUT);
  pinMode(switch4, INPUT);
  pinMode(switch5, INPUT);
  pinMode(switch6, INPUT);
  //make motor pin output
  pinMode(motorPin, OUTPUT);
  
}

void loop() {
  // read the analog in value of the IR sensors:
  int analogIRPin0 = analogRead(irPin0);
  int analogIRPin1 = analogRead(irPin1);
  int analogIRPin2 = analogRead(irPin2);
  int analogIRPin3 = analogRead(irPin3);
  int analogIRPin4 = analogRead(irPin4);
  int analogIRPin5 = analogRead(irPin5);
  int analogIRPin6 = analogRead(irPin6);
  int analogIRPin7 = analogRead(irPin7);
  int analogIRPin8 = analogRead(irPin8);
  int analogIRPin9 = analogRead(irPin9);
  analogIRPin0 = RunningAverage(analogIRPin0, value, pv0);
  analogIRPin1 = RunningAverage(analogIRPin1, value, pv1);
  analogIRPin2 = RunningAverage(analogIRPin2, value, pv2);
  analogIRPin3 = RunningAverage(analogIRPin3, value, pv3);
  analogIRPin4 = RunningAverage(analogIRPin4, value, pv4);
  analogIRPin5 = RunningAverage(analogIRPin5, value, pv5);
  analogIRPin6 = RunningAverage(analogIRPin6, value, pv6);
  analogIRPin7 = RunningAverage(analogIRPin7, value, pv7);
  analogIRPin8 = RunningAverage(analogIRPin8, value, pv8);
  analogIRPin9 = RunningAverage(analogIRPin9, value, pv9);
  value += 1;
  if (value == 5){
    value = 0;
  }

  // read the input pin:
  int digitalPin1 = digitalRead(switch1);
  int digitalPin2 = digitalRead(switch2);
  int digitalPin3 = digitalRead(switch3);
  int digitalPin4 = digitalRead(switch4);
  int digitalPin5 = digitalRead(switch5);
  int digitalPin6 = digitalRead(switch6);
  
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
  
  // print switch results to serial
  if (digitalPin1 == HIGH) {
    Serial.print(1, DEC);
  }
  else if (digitalPin2 == HIGH) {
    Serial.print(2, DEC);
  }
  else if (digitalPin3 == HIGH) {
    Serial.print(3, DEC);
  }
  else if (digitalPin4 == HIGH) {
    Serial.print(4, DEC);
  }
  else if (digitalPin5 == HIGH) {
    Serial.print(5, DEC);
  }
  else if (digitalPin6 == HIGH) {
    Serial.print(6, DEC);
  }
  Serial.print(",");

  // read potentiometer value: between 0 and 1023
  int potValue = analogRead(potPin);
  
  // output voltage between 0 and 255 to control motor speed
  analogWrite(motorPin, potValue / 4);
  //Serial.print("    ");
  //Serial.print(potValue / 4, DEC);
  
  Serial.println();

  // wait 50 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading, and to allow Processing
  // to process the information:
  delay(50);
}
