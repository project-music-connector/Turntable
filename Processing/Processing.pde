//Turntable
//Alice Barbe & Beatriz Fusaro
//September, 2016

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

TriOsc tric4;
TriOsc trid4;
TriOsc trie4;
TriOsc trif4;
TriOsc trig4;
TriOsc tria4;
TriOsc trib4;
TriOsc tric5;
TriOsc trid5;
TriOsc trie5;

SqrOsc weird0;
SawOsc weird1;
SawOsc weird2;
WhiteNoise weird3;
PinkNoise weird4;
WhiteNoise weird5;
SinOsc weird6;
SinOsc weird7;
SinOsc weird8;
SqrOsc weird9;

SinOsc rand0;
SinOsc rand1;
SinOsc rand2;
SinOsc rand3;
SinOsc rand4;
SinOsc rand5;
SinOsc rand6;
SinOsc rand7;
SinOsc rand8;
SinOsc rand9;

//define integer number infrared sensors
int numberOfSensors = 10;
//define integer number of digital switches
int numberOfSwitches = 7;

//initialize configuration array which will contain audio sample objects
SoundFile[] collection1 = new SoundFile[numberOfSensors]; 
//initialize soundType 2
TriOsc[] collection2 = new TriOsc[numberOfSensors];
float[] triOscFreq = {261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25, 586.33, 659.25};
//initialize soundType 7
SinOsc[] collection7 = new SinOsc[numberOfSensors];

//create color arrays
int[] newColors = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
int[] oldColors = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};

//This counter will determine if you have changed sound types
int soundType;
//Threshold for black vs white
int threshold = 800;
//Delay for soundType
int delay_num = 100;
//Array for holding serial input in integers
int[] serialInputInt;


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
  
  //create collection array
  collection1[0] = c4;
  collection1[1] = d4;
  collection1[2] = e4;
  collection1[3] = f4;
  collection1[4] = g4;
  collection1[5] = a4;
  collection1[6] = b4;
  collection1[7] = c5;
  collection1[8] = d5;
  collection1[9] = e5;
  
  //initialize triangle oscillation objects
  tric4 = new TriOsc(this);
  trid4 = new TriOsc(this);
  trie4 = new TriOsc(this);
  trif4 = new TriOsc(this);
  trig4 = new TriOsc(this);
  tria4 = new TriOsc(this);
  trib4 = new TriOsc(this);
  tric5 = new TriOsc(this);
  trid5 = new TriOsc(this);
  trie5 = new TriOsc(this);
  
  //create triangle oscillation array
  collection2[0] = tric4;
  collection2[1] = trid4;
  collection2[2] = trie4;
  collection2[3] = trif4;
  collection2[4] = trig4;
  collection2[5] = tria4;
  collection2[6] = trib4;
  collection2[7] = tric5;
  collection2[8] = trid5;
  collection2[9] = trie5;
  
  //initialize triangle oscillation frequencies
  for (int x = 0; x < numberOfSensors; x++) {
    collection2[x].freq(triOscFreq[x]);
  }
  
  weird0 = new SqrOsc(this);
  weird1 = new SawOsc(this);
  weird2 = new SawOsc(this);
  weird3 = new WhiteNoise(this);
  weird4 = new PinkNoise(this);
  weird5 = new WhiteNoise(this);
  weird6 = new SinOsc(this);
  weird7 = new SinOsc(this);
  weird8 = new SinOsc(this);
  weird9 = new SqrOsc(this);
  
  weird0.freq(77.78);
  weird1.freq(2489.02);
  weird6.freq(207.65);
  weird7.freq(196.00);
  weird8.freq(185.00);
  weird9.freq(466.16);
  
  rand0 = new SinOsc(this);
  rand1 = new SinOsc(this);
  rand2 = new SinOsc(this);
  rand3 = new SinOsc(this);
  rand4 = new SinOsc(this);
  rand5 = new SinOsc(this);
  rand6 = new SinOsc(this);
  rand7 = new SinOsc(this);
  rand8 = new SinOsc(this);
  rand9 = new SinOsc(this);
  
  collection7[0] = rand0;
  collection7[1] = rand1;
  collection7[2] = rand2;
  collection7[3] = rand3;
  collection7[4] = rand4;
  collection7[5] = rand5;
  collection7[6] = rand6;
  collection7[7] = rand7;
  collection7[8] = rand8;
  collection7[9] = rand9;
  
  //initialize sinusoidal oscillation frequencies with random numbers
  for (int x = 0; x < numberOfSensors; x++) {
    collection7[x].freq(random(220, 880));
  }

  //serial reading code
  //when testing, this next line should be the ONLY line to cause an error: ArrayIndexOutOfBoundsExcpetion: 0
  port = new Serial(this, Serial.list()[0], 9600); // initializing the object by assigning a port and baud rate (must match that of Arduino)
  port.clear();  // function from serial library that throws out the first reading, in case we started reading in the middle of a string from Arduino
  serial = port.readStringUntil(end); // function that reads the string from serial port until a println and then assigns string to our string variable (called 'serial')
  serial = null; // initially, the string will be null (empty)
  
  //run data in the buffer once to ensure that we splice the data properly when we begin processing the data in draw()
  delay(50);
  serial = port.readStringUntil(10);
  if (serial != null) { 
    String[] serialInput = split(serial, ','); 
    for (String s : serialInput) {
       print(s + ", ");
    }
    print("\n");
    serialInputInt = int(serialInput);
  }

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
    serialInputInt = int(serialInput);
    
    //create infrared sensor array
    int[] irSensors = new int[numberOfSensors];
    arrayCopy(serialInputInt, 0, irSensors, 0, numberOfSensors);
    
    
    //**************DETERMINE AND USE SOUNDTYPE******************************************
    
    soundType = int(serialInputInt[10]);
    
    //**************EVALUATE SENSOR DATA AND PLAY SOUNDS ACCORDINGLY**************
    //determine color, update oldColor and newColor
    for (int x = 0; x < numberOfSensors; x++) {
      oldColors[x] = newColors[x];               //oldColor is now equal to the previous value of newColor
      if (irSensors[x] <= threshold) {           //if sensor value below threshold, color is white
        newColors[x] = 1;
      } //end(sensors[x] <= threshold)
      else {                                     //otherwise, color is black
        newColors[x] = 0;
      } //end else
    } //end for
    
    //SoundType 1: Drum set
    if (soundType == 1) {
      for (int x = 0; x < numberOfSensors; x++) {
        if(newColors[x] - oldColors[x] == -1) {          //if we have gone from white to black, 
          collection1[x].play();                          //play sound
        } else if(oldColors[x] - newColors[x] == -1) {   //if we have gone from black to white,
          collection1[x].stop();                          //stop sound  
        }
      } //end for
    } //end if
    
    //SoundType 2: Triangle Oscillations
    if (soundType == 2) {
      for (int x = 0; x < numberOfSensors; x++) {
        if(newColors[x] - oldColors[x] == -1) {          //if we have gone from white to black, 
          collection2[x].play();                         //play sound
        } else if(oldColors[x] - newColors[x] == -1) {   //if we have gone from black to white,
          collection2[x].stop();                         //stop sound  
        }
      } //end for
    } //end if
      
    //SoundType 3: Weird Noises
    if (soundType == 3) {
      if(newColors[0] - oldColors[0] == -1) {          //if we have gone from white to black, 
        weird0.play();                                 //play sound
      } else if(oldColors[0] - newColors[0] == -1) {   //if we have gone from black to white,
        weird0.stop();                                 //stop sound  
      }
      
      if(newColors[1] - oldColors[1] == -1) {          //if we have gone from white to black, 
        weird1.play();                                 //play sound
      } else if(oldColors[1] - newColors[1] == -1) {   //if we have gone from black to white,
        weird1.stop();                                 //stop sound  
      }
      
      if(newColors[2] - oldColors[2] == -1) {          //if we have gone from white to black, 
        weird2.play();                                 //play sound
      } else if(oldColors[2] - newColors[2] == -1) {   //if we have gone from black to white,
        weird2.stop();                                 //stop sound  
      }
      
      if(newColors[3] - oldColors[3] == -1) {          //if we have gone from white to black, 
        weird3.play();                                 //play sound
      } else if(oldColors[3] - newColors[3] == -1) {   //if we have gone from black to white,
        weird3.stop();                                 //stop sound  
      }
      
      if(newColors[4] - oldColors[4] == -1) {          //if we have gone from white to black, 
        weird4.play();                                 //play sound
      } else if(oldColors[4] - newColors[4] == -1) {   //if we have gone from black to white,
        weird4.stop();                                 //stop sound  
      }  
      
      if(newColors[5] - oldColors[5] == -1) {          //if we have gone from white to black, 
        weird5.play();                                 //play sound
      } else if(oldColors[5] - newColors[5] == -1) {   //if we have gone from black to white,
        weird5.stop();                                 //stop sound  
      }
      
      if(newColors[6] - oldColors[6] == -1) {          //if we have gone from white to black, 
        weird6.play();                                 //play sound
      } else if(oldColors[6] - newColors[6] == -1) {   //if we have gone from black to white,
        weird6.stop();                                 //stop sound  
      }
      
      if(newColors[7] - oldColors[7] == -1) {          //if we have gone from white to black, 
        weird7.play();                                 //play sound
      } else if(oldColors[7] - newColors[7] == -1) {   //if we have gone from black to white,
        weird7.stop();                                 //stop sound  
      }
      
      if(newColors[8] - oldColors[8] == -1) {          //if we have gone from white to black, 
        weird8.play();                                 //play sound
      } else if(oldColors[8] - newColors[8] == -1) {   //if we have gone from black to white,
        weird8.stop();                                 //stop sound  
      }
      
      if(newColors[9] - oldColors[9] == -1) {          //if we have gone from white to black, 
        weird9.play();                                 //play sound
      } else if(oldColors[9] - newColors[9] == -1) {   //if we have gone from black to white,
        weird9.stop();                                 //stop sound  
      }
    } //end if
    
    if (soundType == 4) {
      
    } //end if
    
    if (soundType == 5) {
      
    } //end if
    
    if (soundType == 6) {
      
    } //end if
    
    if (soundType == 7) {
      for (int x = 0; x < numberOfSensors; x++) {
        if(newColors[x] - oldColors[x] == -1) {          //if we have gone from white to black, 
          collection7[x].play();                         //play sound
        } else if(oldColors[x] - newColors[x] == -1) {   //if we have gone from black to white,
          collection7[x].stop();                         //stop sound  
        }
      } //end for
    } //end if

  }//end if(serial != null)
} //end draw()