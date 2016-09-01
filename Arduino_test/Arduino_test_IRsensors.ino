/*
  Analog input, analog output, serial output

 Reads an analog input pin, maps the result to a range from 0 to 255
 and uses the result to set the pulsewidth modulation (PWM) of an output pin.
 Also prints the results to the serial monitor.

 The circuit:
 * potentiometer connected to analog pin 0.
   Center pin of the potentiometer goes to the analog pin.
   side pins of the potentiometer go to +5V and ground
 * LED connected from digital pin 9 to ground

 created 29 Dec. 2008
 modified 9 Apr 2012
 by Tom Igoe

 This example code is in the public domain.
 

 */


// These constants won't change.  They're used to give names to the pins used:
const int inPin1 = A1;

const int inPin2 = A2;
const int inPin3 = A3;
const int inPin4 = A4;
const int inPin5 = A5;
const int inPin6 = A6;
const int inPin7 = A7;
const int inPin8 = A8;
const int inPin9 = A9;
const int inPin10 = A10;

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600);
}

void loop() {
  // read the analog in value:
  int analogInPin1 = analogRead(inPin1);
  int analogInPin2 = analogRead(inPin2);
  int analogInPin3 = analogRead(inPin3);
  int analogInPin4 = analogRead(inPin4);
  int analogInPin5 = analogRead(inPin5);
  int analogInPin6 = analogRead(inPin6);
  int analogInPin7 = analogRead(inPin7);
  int analogInPin8 = analogRead(inPin8);
  int analogInPin9 = analogRead(inPin9);
  int analogInPin10 = analogRead(inPin10);
  
  // print the results to the serial monitor:
  Serial.print(analogInPin1);
  Serial.print(" ");
  Serial.print(analogInPin2);
  Serial.print(" ");
  Serial.print(analogInPin3);
  Serial.print(" ");
  Serial.print(analogInPin4);
  Serial.print(" ");
  Serial.print(analogInPin5);
  Serial.print(" ");
  Serial.print(analogInPin6);
  Serial.print(" ");
  Serial.print(analogInPin7);
  Serial.print(" ");
  Serial.print(analogInPin8);
  Serial.print(" ");
  Serial.print(analogInPin9);
  Serial.print(" ");
  Serial.print(analogInPin10);
  Serial.print(" \n");

  // wait 2 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading:
  delay(2);
}
