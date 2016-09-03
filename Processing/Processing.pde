//Turntable
//Alice Barbe
//August 27th, 2016
/*
import processing.sound.*;
SoundFile c4;
void setup() {   c4 = new SoundFile(this, "C4.wav"); 
}
void draw() {  
  c4.play();
delay(2000);}
*/

import processing.sound.*;
import processing.serial.*; //import the Serial library so can read from arudino input via serial communication

int end = 10;    // the number 10 is ASCII for linefeed (end of serial.println), later we will look for this to break up individual messages
String serial;   // declare a new string called 'serial' 
Serial port;     // The serial port, this is a new instance of the Serial class (an Object)

//declare SoundFile variables that will contain the sounds
SoundFile c4;
SoundFile d4;
SoundFile e4;
SoundFile f4;
SoundFile g4;
SoundFile a4;
SoundFile b4;
SoundFile c5;
SoundFile d5;
SoundFile e5;

//define integer number infrared sensors
int numberOfSensors = 10;
//define integer number of digital switches
int numberOfSwitches = 7;
//initialize configuration array which will contain audio sample objects
SoundFile[] collection = new SoundFile[numberOfSensors]; 



//create color arrays
int[] newColors = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
int[] oldColors = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};

//This counter will determine if you have changed sound types
int soundType;
//Threshold for black vs white
int threshold = 800;
//Delay for soundType 2
int delay_num = 100;


void setup() {

  //load sound.wav files from data folder and create new objects out of them, assigning them to the initialized variables
  c4 = new SoundFile(this, "C4.wav");
  d4 = new SoundFile(this, "D4.wav");
  e4 = new SoundFile(this, "E4.wav");
  f4 = new SoundFile(this, "F4.wav");
  g4 = new SoundFile(this, "G4.wav");
  a4 = new SoundFile(this, "A4.wav");
  b4 = new SoundFile(this, "B4.wav");
  c5 = new SoundFile(this, "C5.wav");
  d5 = new SoundFile(this, "D5.wav");
  e5 = new SoundFile(this, "E5.wav");
  //create collections arrays
  collection[1] = d4;
  collection[2] = e4;
  collection[3] = f4;
  collection[4] = g4;
  collection[5] = a4;
  collection[6] = b4;
  collection[7] = c5;
  collection[8] = d5;
  collection[9] = e5;
  collection[0] = c4;


  //serial reading code
  //when testing, this next line should be the ONLY line to cause an error: ArrayIndexOutOfBoundsExcpetion: 0
  port = new Serial(this, Serial.list()[0], 9600); // initializing the object by assigning a port and baud rate (must match that of Arduino)
  port.clear();  // function from serial library that throws out the first reading, in case we started reading in the middle of a string from Arduino
  serial = port.readStringUntil(end); // function that reads the string from serial port until a println and then assigns string to our string variable (called 'serial')
  serial = null; // initially, the string will be null (empty)
  
  //initialize soundType to a default value of 1
  soundType = 1;

} //end setup


void draw() {

  //****************GET SERIAL DATA AND READ IT*******************************
  //if there is data coming from the serial port read it/ store it
  while (port.available() > 0) { 
    serial = port.readStringUntil(end);
  } //end while

  //if the string is not empty, do this
  if (serial != null) { 
    //sensor input from Arduino, each value is separated and split depending on the ','
    //and then saved in separate cells of the array so we can access each 
    String[] serialInput = split(serial, ','); 
    //can help to print these to console at this point to check it's working
    for (String s : serialInput) {
      print(s + ", ");
    }
    print("\n");

    //convert the string inputs that are stored in the serialInputInt array, which will then be further decomposed
    int serialInputInt [];//Array that we will store the the infrared sensor input from Arduino after we have converted it to int
    serialInputInt = int(serialInput);
    
    //create infrared sensor array
    int[] irSensors = new int[numberOfSensors];
    arrayCopy(serialInputInt, 0, irSensors, 0, numberOfSensors);
    
    //create potentiometer variable
    int potentiometer = serialInputInt[10];
    
    //create switches array
    int[] switches = new int[numberOfSwitches];
    arrayCopy(serialInputInt, numberOfSwitches - 1, switches, 0, numberOfSwitches);
    
    
    //**************DETERMINE SOUNDTYPE******************************************
    /*
    for (int x = 0; x <= numberOfSwitches; x++) {
      if (switches[x] == 1) {
        soundType = x;
      } //end if
    } //end for
    */
    
    //**************EVALUATE SENSOR DATA AND PLAY SOUNDS ACCORDINGLY**************
    for (int x = 0; x < numberOfSensors; x++) {
      
      //determine color, update oldColor and newColor
      oldColors[x] = newColors[x];               //oldColor is now equal to the previous value of newColor
      if (irSensors[x] <= threshold) {           //if sensor value below threshold, color is white
        newColors[x] = 1;
      } //end(sensors[x] <= threshold)
      else {                                     //otherwise, color is black
        newColors[x] = 0;
      } //end else
  
      //play sounds
      if (soundType == 1) {                      //if single sounds
        if(newColors[x] - oldColors[x] == -1) {   //if we have gone from white to black, 
          collection[x].play();                  //play sound
        } //end if               
        //if(oldColors[x] - newColors[x] == -1) {   //if we have gone from black to white,
        //  collection[x].stop();                  //stop sound (OPTIONAL)
        //} //end if
      } //end if(soundType == 1)
  
      else if (soundType == 2) {                 //if repeated sounds
        if(newColors[x] == 1) {                  //if the color is black
          collection[x].play();                  //play the sound, allow for a momentary delay. 
          delay(delay_num);                      //As processing loops back around, the sound should repeat.
        } //end if
      } //end if(soundType == 2)
    } //end for
  }//end if(serial != null)
} //end draw()