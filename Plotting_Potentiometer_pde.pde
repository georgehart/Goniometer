/*
    Reading Serial data from a ATtiny85
    potmeter
    
    Georges Hart 
    november 2020
    trial version
    
    
*/



import processing.serial.*;
Serial myPort;        // The serial port

float inByte;         // Incoming serial data
boolean newData = false;
int xPos = 1;         // horizontal position of the graph 

//Variables to draw a continuous line.
int lastxPos=1;
int lastheight=0;

String s = "Georges Hart";

void setup () {

   frameRate(50);
// set the window size:
   size(800, 600);
   surface.setTitle("TFE Goniometrie - GH");

// ----- FONTS ------

  
  //fullScreen(); 
    

  myPort = new Serial(this, "/dev/ttyUSB0", 9600);  

  // A serialEvent() is generated when a newline character is received :
  myPort.bufferUntil('\n');
  background(0);      // set inital background:
  
  
  
//----------------------------------------------
String[] fontList = PFont.list();
printArray(fontList);
  
  
}
void draw () {
  // ----- probeersels -----
  achtergrond();
  
  // -----------------------
  
  
  if (newData) {
     
    measurement();
        
    
    //Drawing a line from Last inByte to the new one.
    stroke(121,214,135);      //stroke color
    strokeWeight(2);        //stroke wider
    line(lastxPos, lastheight, xPos, height - inByte); 
    lastxPos= xPos;
    lastheight= int(height-inByte);

    // at the edge of the window, go back to the beginning:
    if (xPos >= width) {
      xPos = 0;
      lastxPos= 0;
      

      
      background(0);  //Clear the screen.
      achtergrond();
          

     
    } 
    else {
      // increment the horizontal position:
      xPos++;
    }
   newData =false;
 }
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);                // trim off whitespaces.
    inByte = float(inString);                 // convert to a number.
    inByte = map(inByte, 0, 1023, 0, height); //map to the screen height.
    newData = true; 
  }
}

void achtergrond(){
  
    stroke(85,85,85);      //stroke color
    strokeWeight(1);   
     for(int i = 0; i < width; i = i+50){
      line(0, i, width, i);
      line(i, 0 ,i, height);
   }
   
}

void measurement(){
  
     for(int x=40 ; x<240 ; x++){
      for(int y=0 ; y<40 ; y++){
            set(x, y, 0);
      }  
    }
  
     PFont f= createFont("Quicksand-Regular.otf", 32,true);
     textFont(f);
     text(inByte, 40, 40);  // Text wraps within text box
}

  
  
