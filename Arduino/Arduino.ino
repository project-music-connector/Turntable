/*
Analog input, analog output, serial output

Reads an analog input pin and prints the results to the serial monitor.

created 29 Dec. 2008
modified 9 Apr 2012
by Tom Igoe

modified August 31st 2016
by Alice Barbe
*/


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
//Motor speed potetiometer pin
const int potPin10 = A10;
//Switch pins
const int switchPin0 = 0;
const int switchPin1 = 1;
const int switchPin2 = 2;
const int switchPin3 = 3;
const int switchPin4 = 4;
const int switchPin5 = 5;
const int switchPin6 = 6;

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600);
  //make switch pins inputs
  pinMode(switchPin0, INPUT);
  pinMode(switchPin1, INPUT);
  pinMode(switchPin2, INPUT);
  pinMode(switchPin3, INPUT);
  pinMode(switchPin4, INPUT);
  pinMode(switchPin5, INPUT);
  pinMode(switchPin6, INPUT);
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

  // read the analog in value of the potentiometer:
  int analogPotPin10 = analogRead(potPin10);

  // read the input pin:
  int digitalPin0 = digitalRead(switchPin0);
  int digitalPin1 = digitalRead(switchPin1);
  int digitalPin2 = digitalRead(switchPin2);
  int digitalPin3 = digitalRead(switchPin3);
  int digitalPin4 = digitalRead(switchPin4);
  int digitalPin5 = digitalRead(switchPin5);
  int digitalPin6 = digitalRead(switchPin6);

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

  Serial.print(analogPotPin10, DEC);
  Serial.print(",");
  
  Serial.print(switchPin0, DEC);
  Serial.print(",");
  Serial.print(switchPin1, DEC);
  Serial.print(",");
  Serial.print(switchPin2, DEC);
  Serial.print(",");
  Serial.print(switchPin3, DEC);
  Serial.print(",");
  
  Serial.print(switchPin4, DEC);
  Serial.print(",");
  Serial.print(switchPin5, DEC);
  Serial.print(",");
  Serial.print(switchPin6, DEC);
  
  Serial.println();

  // wait 50 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading, and to allow Processing
  // to process the information:
  delay(50);
}
