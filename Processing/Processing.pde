//Turntable
//Alice Barbe & Beatriz Fusaro
//September, 2016

import processing.sound.*;
import processing.serial.*; //import the Serial library so can read from arudino input via serial communication

int end = 10;    // the number 10 is ASCII for linefeed (end of serial.println), later we will look for this to break up individual messages
String serial;   // declare a new string called 'serial' 
Serial port;     // The serial port, this is a new instance of the Serial class (an Object)

//declare SoundFile variables that will contain the sounds
SoundFile drum0;
SoundFile drum1;
SoundFile drum2;
SoundFile drum3;
SoundFile drum4;
SoundFile drum5;
SoundFile drum6;
SoundFile drum7;
SoundFile drum8;
SoundFile drum9;

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

SinOsc mix0;
SinOsc mix1;
SinOsc mix2;
SinOsc mix3;
SinOsc mix4;
SinOsc mix5;
SoundFile mix6;
SoundFile mix7;
SoundFile mix8;
SoundFile mix9;

SoundFile piano0;
SoundFile piano1;
SoundFile piano2;
SoundFile piano3;
SoundFile piano4;
SoundFile piano5;
SoundFile piano6;
SoundFile piano7;
SoundFile piano8;
SoundFile piano9;

SoundFile guitar0;
SoundFile guitar1;
SoundFile guitar2;
SoundFile guitar3;
SoundFile guitar4;
SoundFile guitar5;
SoundFile guitar6;
SoundFile guitar7;
SoundFile guitar8;
SoundFile guitar9;

//define integer number infrared sensors
int numberOfSensors = 10;
//define integer number of digital switches
int numberOfSwitches = 7;

//initialize configuration array which will contain audio sample objects
//initialize soundType 1 (drums)
SoundFile[] collection1 = new SoundFile[numberOfSensors]; 
//initialize soundType 2
TriOsc[] collection2 = new TriOsc[numberOfSensors];
//float[] triOscFreq = {261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25, 586.33, 659.25};
float[] triOscFreq = {65.41, 98.00, 164.81, 261.63, 329.63, 392.00, 523.25, 659.25, 783.99, 1046.50};
//initialize soundType 4 (mix)
SoundFile[] collection4 = new SoundFile[numberOfSensors];
float[] sinOscFreq = {293.66, 329.63, 369.99, 440.00, 587.33, 880.00};
//initialize soundType 5 (piano)
SoundFile[] collection5 = new SoundFile[numberOfSensors];
//initialize soundType 6 (guitar)
SoundFile[] collection6 = new SoundFile[numberOfSensors];

//arrays to stop generated sounds when switching modes
SinOsc[] stopSinOsc = new SinOsc[9];
TriOsc[] stopTriOsc = new TriOsc[10];
SawOsc[] stopSawOsc = new SawOsc[2];
SqrOsc[] stopSqrOsc = new SqrOsc[2];
WhiteNoise[] stopWhiteNoise = new WhiteNoise[2];
PinkNoise[] stopPinkNoise = new PinkNoise[1];

//create color arrays
int[] newColors = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
int[] oldColors = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};

//This counter will determine if you have changed sound types
int soundType;
int oldSoundType = 0;
//Threshold for black vs white
//int[] threshold = {600, 650, 550, 550, 600, 600, 600, 600, 650, 700};
int[] threshold = {80, 80, 80, 80, 80, 80, 80, 80, 80, 80};
//Array for holding serial input in integers
int[] serialInputInt;


void setup() {

  //load sound.wav files from data folder and create new objects out of them, assigning them to the initialized variables
  drum0 = new SoundFile(this, "crash-acoustic.wav");
  drum1 = new SoundFile(this, "tom-acoustic01.wav");
  drum2 = new SoundFile(this, "openhat-acoustic01.wav");
  drum3 = new SoundFile(this, "kick-vinyl01.wav");
  drum4 = new SoundFile(this, "clap-analog.wav");
  drum5 = new SoundFile(this, "kick-acoustic01.wav");
  drum6 = new SoundFile(this, "snare-acoustic02.wav");
  drum7 = new SoundFile(this, "hihat-acoustic01.wav");
  drum8 = new SoundFile(this, "cowbell-808.wav");
  drum9 = new SoundFile(this, "perc-laser.wav");

  collection1[0] = drum0;
  collection1[1] = drum1;
  collection1[2] = drum2;
  collection1[3] = drum3;
  collection1[4] = drum4;
  collection1[5] = drum5;
  collection1[6] = drum6;
  collection1[7] = drum7;
  collection1[8] = drum8;
  collection1[9] = drum0;
  
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
  
  for (int x = numberOfSensors - 1; x >= 0; x--) {
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
  
  mix0 = new SinOsc(this);
  mix1 = new SinOsc(this); 
  mix2 = new SinOsc(this); 
  mix3 = new SinOsc(this); 
  mix4 = new SinOsc(this); 
  mix5 = new SinOsc(this); 
  mix6 = new SoundFile(this, "drum_othertom.wav");
  mix7 = new SoundFile(this, "kick_acoustic01.wav");
  mix8 = new SoundFile(this, "tom_acoustic01.wav");
  mix9 = new SoundFile(this, "snare.wav");
  
  mix0.freq(293.66);
  mix1.freq(329.63);
  mix2.freq(369.99);
  mix3.freq(440.00);
  mix4.freq(587.33);
  mix5.freq(880.00);
  
  piano0 = new SoundFile(this, "1g-sharp.wav");
  piano1 = new SoundFile(this, "2a.wav");
  piano2 = new SoundFile(this, "3b-flat.wav");
  piano3 = new SoundFile(this, "4b.wav");
  piano4 = new SoundFile(this, "5c.wav");
  piano5 = new SoundFile(this, "6c-sharp.wav");
  piano6 = new SoundFile(this, "7d.wav");
  piano7 = new SoundFile(this, "8e-flat.wav");
  piano8 = new SoundFile(this, "9e.wav");
  piano9 = new SoundFile(this, "10f.wav");

  collection5[0] = piano0;
  collection5[1] = piano1;
  collection5[2] = piano2;
  collection5[3] = piano3;
  collection5[4] = piano4;
  collection5[5] = piano5;
  collection5[6] = piano6;
  collection5[7] = piano7;
  collection5[8] = piano8;
  collection5[9] = piano9;
  
  guitar0 = new SoundFile(this, "6-Stg-Steel-Gtr-A4.wav");
  guitar1 = new SoundFile(this, "6-Stg-Steel-Gtr-G4.wav");
  guitar2 = new SoundFile(this, "6-Stg-Steel-Gtr-A3.wav");
  guitar3 = new SoundFile(this, "6-Stg-Steel-Gtr-E3.wav");
  guitar4 = new SoundFile(this, "6-Stg-Steel-Gtr-C3.wav");
  guitar5 = new SoundFile(this, "6-Stg-Steel-Gtr-A2.wav");
  guitar6 = new SoundFile(this, "6-Stg-Steel-Gtr-G2.wav");
  guitar7 = new SoundFile(this, "6-Stg-Steel-Gtr-D2.wav");
  guitar8 = new SoundFile(this, "6-Stg-Steel-Gtr-A1.wav");
  guitar9 = new SoundFile(this, "6-Stg-Steel-Gtr-E1.wav");

  collection6[0] = guitar0;
  collection6[1] = guitar1;
  collection6[2] = guitar2;
  collection6[3] = guitar3;
  collection6[4] = guitar4;
  collection6[5] = guitar5;
  collection6[6] = guitar6;
  collection6[7] = guitar7;
  collection6[8] = guitar8;
  collection6[9] = guitar9;
  
  //Add generated sounds to stop arrays
  for (int x = 0; x < 10; x++) {
    stopTriOsc[x] = collection2[x];
  }
  
  stopSinOsc[0] = weird6;
  stopSinOsc[1] = weird7;
  stopSinOsc[2] = weird8;
  stopSinOsc[3] = mix0;
  stopSinOsc[4] = mix1;
  stopSinOsc[5] = mix2;
  stopSinOsc[6] = mix3;
  stopSinOsc[7] = mix4;
  stopSinOsc[8] = mix5;
  
  stopSqrOsc[0] = weird0;
  stopSqrOsc[1] = weird9;
  
  stopSawOsc[0] = weird1;
  stopSawOsc[1] = weird2;
  
  stopWhiteNoise[0] = weird3;
  stopWhiteNoise[1] = weird5;
  
  stopPinkNoise[0] = weird4;  

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
    
    oldSoundType = soundType;        //oldSoundType is now equal to the previous value of soundType
    soundType = serialInputInt[10];  //update soundType
    //soundType = 2;
    
    //if we change soundType, stop all previous sounds
    if (soundType != oldSoundType) {
      for (int x = 0; x < stopTriOsc.length; x++) {
        stopTriOsc[x].stop();
      }
      for (int x = 0; x < stopSinOsc.length; x++) {
        stopSinOsc[x].stop();
      }
      for (int x = 0; x < stopSawOsc.length; x++) {
        stopSawOsc[x].stop();
      }
      for (int x = 0; x < stopSqrOsc.length; x++) {
        stopSqrOsc[x].stop();
      }
      for (int x = 0; x < stopWhiteNoise.length; x++) {
        stopWhiteNoise[x].stop();
      }
      for (int x = 0; x < stopPinkNoise.length; x++) {
        stopPinkNoise[x].stop();
      }
    }    
    
    //**************EVALUATE SENSOR DATA AND PLAY SOUNDS ACCORDINGLY**************
    //determine color, update oldColor and newColor
    for (int x = 0; x < numberOfSensors; x++) {
      oldColors[x] = newColors[x];                  //oldColor is now equal to the previous value of newColor
      if (irSensors[x] <= threshold[x]) {           //if sensor value below threshold, color is white
        newColors[x] = 1;
      }
      else {                                        //otherwise, color is black
        newColors[x] = 0;
      }
      print(newColors[x] + ", ");

    } //end for
    
    //SoundType 1: Drum set
    if (soundType == 1) {
      for (int x = 0; x < numberOfSensors; x++) {
        if(newColors[x] - oldColors[x] == -1) {          //if we have gone from white to black, 
          collection1[x].play();                         //play sound
        } else if(oldColors[x] - newColors[x] == -1) {   //if we have gone from black to white,
          collection1[x].stop();                         //stop sound  
        }
      }
    } //end if
    
    //SoundType 2: Triangle Oscillations
    if (soundType == 2) {
      for (int x = 0; x < numberOfSensors; x++) {
        if(newColors[x] - oldColors[x] == -1) {          //if we have gone from white to black, 
          collection2[x].play();                         //play sound
        } else if(oldColors[x] - newColors[x] == -1) {   //if we have gone from black to white,
          collection2[x].stop();                         //stop sound  
        }
      }
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
      if(newColors[0] - oldColors[0] == -1) {        //if we have gone from white to black, 
        mix0.play();                                 //play sound
      } else if(oldColors[0] - newColors[0] == -1) { //if we have gone from black to white,
        mix0.stop();                                 //stop sound  
      }
      
      if(newColors[1] - oldColors[1] == -1) {        //if we have gone from white to black, 
        mix1.play();                                 //play sound
      } else if(oldColors[1] - newColors[1] == -1) { //if we have gone from black to white,
        mix1.stop();                                 //stop sound  
      }
      
      if(newColors[2] - oldColors[2] == -1) {        //if we have gone from white to black, 
        mix2.play();                                 //play sound
      } else if(oldColors[2] - newColors[2] == -1) { //if we have gone from black to white,
        mix2.stop();                                 //stop sound  
      }
      
      if(newColors[3] - oldColors[3] == -1) {        //if we have gone from white to black, 
        mix3.play();                                 //play sound
      } else if(oldColors[3] - newColors[3] == -1) { //if we have gone from black to white,
        mix3.stop();                                 //stop sound  
      }
      
      if(newColors[4] - oldColors[4] == -1) {        //if we have gone from white to black, 
        mix4.play();                                 //play sound
      } else if(oldColors[4] - newColors[4] == -1) { //if we have gone from black to white,
        mix4.stop();                                 //stop sound  
      }  
      
      if(newColors[5] - oldColors[5] == -1) {        //if we have gone from white to black, 
        mix5.play();                                 //play sound
      } else if(oldColors[5] - newColors[5] == -1) { //if we have gone from black to white,
        mix5.stop();                                 //stop sound  
      }
      
      if(newColors[6] - oldColors[6] == -1) {        //if we have gone from white to black, 
        mix6.play();                                 //play sound
      } else if(oldColors[6] - newColors[6] == -1) { //if we have gone from black to white,
        mix6.stop();                                 //stop sound  
      }
      
      if(newColors[7] - oldColors[7] == -1) {        //if we have gone from white to black, 
      //  mix7.play();                               //play sound
      } else if(oldColors[7] - newColors[7] == -1) { //if we have gone from black to white,
      //  mix7.stop();                               //stop sound  
      }
      
      if(newColors[8] - oldColors[8] == -1) {        //if we have gone from white to black, 
        //mix8.play();                                 //play sound
      } else if(oldColors[8] - newColors[8] == -1) { //if we have gone from black to white,
        mix8.stop();                                 //stop sound  
      }
      
      if(newColors[9] - oldColors[9] == -1) {        //if we have gone from white to black, 
        mix9.play();                                 //play sound
      } else if(oldColors[9] - newColors[9] == -1) { //if we have gone from black to white,
        mix9.stop();                                 //stop sound  
      }
    } //end if
    
    if (soundType == 5) {
      for (int x = 0; x < numberOfSensors; x++) {
        if(newColors[x] - oldColors[x] == -1) {          //if we have gone from white to black, 
          collection5[x].play();                         //play sound
        } else if(oldColors[x] - newColors[x] == -1) {   //if we have gone from black to white,
          collection5[x].stop();                         //stop sound  
        }
      }
    } //end if
    
    if (soundType == 6) {
      for (int x = 0; x < numberOfSensors; x++) {
        if(newColors[x] - oldColors[x] == -1) {          //if we have gone from white to black, 
          collection6[x].play();                         //play sound
        } else if(oldColors[x] - newColors[x] == -1) {   //if we have gone from black to white,
          collection6[x].stop();                         //stop sound  
        }
      }
    } //end if

  }//end if(serial != null)
} //end draw()