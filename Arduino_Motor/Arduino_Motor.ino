// ConstantSpeed.pde
// -*- mode: C++ -*-
//
// Shows how to run AccelStepper in the simplest,
// fixed speed mode with no accelerations
/// \author  Mike McCauley (mikem@airspayce.com)
// Copyright (C) 2009 Mike McCauley
// $Id: ConstantSpeed.pde,v 1.1 2011/01/05 01:51:01 mikem Exp mikem $
#include <AccelStepper.h>

#define HALFSTEP  8
// Motor pin definitions

#define motorPin1 2     // IN1 on the ULN2003 driver 1
#define motorPin2 3     // IN2 on the ULN2003 driver 1
#define motorPin3 4     // IN3 on the ULN2003 driver 1
#define motorPin4 5     // IN4 on the ULN2003 driver 1

// Initialize with pin sequence IN1-IN3-IN2-IN4 for using the AccelStepper with 28BYJ-48
AccelStepper stepper(HALFSTEP, motorPin1, motorPin3, motorPin2, motorPin4);

//Potentiometer pin for controlling motor speed
const int potPin = A5;

void setup()
{  
   stepper.setMaxSpeed(1000);
   stepper.setSpeed(50);        
}
void loop()
{  

  // read potentiometer value: between 0 and 1023
  stepper.setSpeed(analogRead(potPin));
  stepper.runSpeed();
}
