/*
Analog input, analog output, serial output
Reads an analog input pin and prints the results to the serial monitor.
created 29 Dec. 2008
modified 9 Apr 2012
by Tom Igoe
modified September 2016
by Alice Barbe & Beatriz Fusaro
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

//Switch pins
const int switch1 = 0;
const int switch4 = 1;
const int switch5 = 2;
const int switch6 = 3;

//Motor pin
const int motorPin = 4;

//Motor switch pins
const int switchBUW = 5;
const int switchYBU1 = 6;
const int switchYBU2 = 7;
const int switchRBU = 8;
const int switchBU = 9;


void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600);
  
  //make switch pins inputs
  pinMode(switch1, INPUT);
  pinMode(switch4, INPUT);
  pinMode(switch5, INPUT);
  pinMode(switch6, INPUT);
  
  //make motor pin output
  pinMode(motorPin, OUTPUT);
  
  //make motor switch pins inputs
  pinMode(switchBUW, INPUT);
  pinMode(switchYBU1, INPUT);
  pinMode(switchYBU2, INPUT);
  pinMode(switchRBU, INPUT);
  pinMode(switchBU, INPUT);
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

  // read the input pin:
  int digitalPin1 = digitalRead(switch1);
  int digitalPin4 = digitalRead(switch4);
  int digitalPin5 = digitalRead(switch5);
  int digitalPin6 = digitalRead(switch6);

  //read input pins of switch motor
  int digitalPinBUW = digitalRead(switchBUW);
  int digitalPinYBU1 = digitalRead(switchYBU1);
  int digitalPinYBU2 = digitalRead(switchYBU2);
  int digitalPinRBU = digitalRead(switchRBU);
  int digitalPinBU = digitalRead(switchBU);
  
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
  if (digitalPin4 == 1 && digitalPin5 == 1 && digitalPin6 == 1) {
    Serial.print(1, DEC);
  } else if (digitalPin1 == 1 && digitalPin5 == 1 && digitalPin6 == 1) {
    Serial.print(7, DEC);
  } else if (digitalPin4 == 1 && digitalPin5 == 1) {
    Serial.print(3, DEC);
  } else if (digitalPin1 == 1 && digitalPin5 == 1) {
    Serial.print(5, DEC);
  } else if (digitalPin1 == 1 && digitalPin4 == 1) {
    Serial.print(2, DEC);
  } else if (digitalPin1 == 1) {
    Serial.print(4, DEC);
  } else if (digitalPin5 == 1) {
    Serial.print(6, DEC);
  }  
  Serial.println();

  // evaluate motor speed switch value
  int motorSwitchValue;
  if (digitalPinBUW == 1 && digitalPinYBU2 == 1 && digitalPinRBU == 1) {
    motorSwitchValue = 0;
  } else if (digitalPinBUW == 1 && digitalPinYBU2 == 1) {
    motorSwitchValue = 1;
  } else if (digitalPinBUW == 1 && digitalPinYBU2 == 1 && digitalPinRBU == 1) {
    motorSwitchValue = 2;
  } else if (digitalPinBUW == 1 && digitalPinYBU1 == 1 && digitalPinRBU == 1) {
    motorSwitchValue = 3;
  } else if (digitalPinYBU1 == 1 && digitalPinRBU == 1) {
    motorSwitchValue = 4;
  }

  // output voltage between 0 and 255 to control motor speed
  analogWrite(motorPin, motorSwitchValue * 63);

  // wait 50 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading, and to allow Processing
  // to process the information:
  delay(50);
}
