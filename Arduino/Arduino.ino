/*
Analog input, analog output, serial output

Reads an analog input pin and prints the results to the serial monitor.

created 29 Dec. 2008
modified 9 Apr 2012
by Tom Igoe

modified August 26th 2016
by Alice Barbe
*/


// These constants won't change.  They're used to give names to the pins used:
const int inPin0 = A0;
const int inPin1 = A1;
const int inPin2 = A2;
const int inPin3 = A3;
const int inPin4 = A4;
const int inPin5 = A5;
const int inPin6 = A6;
const int inPin7 = A7;
const int inPin8 = A8;
const int inPin9 = A9;

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600);
}

void loop() {
  // read the analog in value:
  int analogInPin0 = analogRead(inPin0);
  int analogInPin1 = analogRead(inPin1);
  int analogInPin2 = analogRead(inPin2);
  int analogInPin3 = analogRead(inPin3);
  int analogInPin4 = analogRead(inPin4);
  int analogInPin5 = analogRead(inPin5);
  int analogInPin6 = analogRead(inPin6);
  int analogInPin7 = analogRead(inPin7);
  int analogInPin8 = analogRead(inPin8);
  int analogInPin9 = analogRead(inPin9);
  

  /*The Serial.print() doesn't have a space
  the ',' is used to parse the values in processing
  the last value does not require the ',' 
  but make sure you have a blank Serial.println(); following it*/
  // print the results to the serial monitor:
  Serial.print(analogInPin0, DEC);
  Serial.print(",");
  Serial.print(analogInPin1, DEC);
  Serial.print(",");
  Serial.print(analogInPin2, DEC);
  Serial.print(",");
  Serial.print(analogInPin3, DEC);
  Serial.print(",");
  Serial.print(analogInPin4, DEC);
  Serial.print(",");
  Serial.print(analogInPin5, DEC);
  Serial.print(",");
  Serial.print(analogInPin6, DEC);
  Serial.print(",");
  Serial.print(analogInPin7, DEC);
  Serial.print(",");
  Serial.print(analogInPin8, DEC);
  Serial.print(",");
  Serial.print(analogInPin9, DEC);
  Serial.println();

  // wait 2 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading:
  delay(2);
}
