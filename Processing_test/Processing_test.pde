import processing.sound.*;
import processing.serial.*;

String serial;
Serial port; 

int[] newColors = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
int[] oldColors = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
int soundType;
int threshold = 800;
SoundFile[] collection = {null, null, null, null, null, null, null, null, null, null};
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


void setup() {
  port = new Serial(this, Serial.list()[0], 9600); 
  port.clear();
  serial = port.readStringUntil(10);
  serial = null; 
  
  soundType = 1;
  c4 = new SoundFile(this, "A4.wav");
  d4 = new SoundFile(this, "A4.wav");
  e4 = new SoundFile(this, "A4.wav");
  f4 = new SoundFile(this, "A4.wav");
  g4 = new SoundFile(this, "A4.wav");
  a4 = new SoundFile(this, "A4.wav");
  b4 = new SoundFile(this, "A4.wav");
  c5 = new SoundFile(this, "A4.wav");
  d5 = new SoundFile(this, "A4.wav");
  e5 = new SoundFile(this, "A4.wav");
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
  
  serial = port.readStringUntil(10);
  if (serial != null) { 
    String[] serialInput = split(serial, ','); 
    for (String s : serialInput) {
       print(s + ", ");
    }
    print("\n");
    int[] serialInputInt;
    serialInputInt = int(serialInput);
  }
  
  delay(50);
}

void draw() {
  while (port.available() > 0) { 
    serial = port.readStringUntil(10);
    if (serial != null) { 
      String[] serialInput = split(serial, ','); 
      for (String s : serialInput) {
        print(s + ", ");
      }
      print("\n");
      int[] serialInputInt;
      serialInputInt = int(serialInput);
      int[] irSensors = new int[10];
      arrayCopy(serialInputInt, 0, irSensors, 0, 10);
      for (int x = 0; x < 10; x++) {
        oldColors[x] = newColors[x];              
        if (irSensors[x] <= threshold) {           
          newColors[x] = 1;
        } else {                                     
          newColors[x] = 0;
        }
        if (newColors[x] - oldColors[x] == -1) {
          collection[x].play();
        } else if (newColors[x] - oldColors[x] == 1) {
          collection[x].stop();
        }
      }
    }
  }
}