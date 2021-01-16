//************************************************************************
//  PART 1: Serial output setup and example output:
//  .  Modifies the example Blink code to illustrate serial output
//  .  Common code for ATtiny85 and ATtiny84
//************************************************************************
#include <SoftwareSerial.h>    // Arduino SoftwareSerial class
 
#define pot     1
#define rxPin   4
#define txPin   3

 
// Create instance of the Software Serial class specifying which device
// pins are to be used for receive and transmit
SoftwareSerial mySerial(rxPin, txPin);

int val=0;

//------------------------------------------------------------------------
// Initialize processing resources
//------------------------------------------------------------------------
void setup() 
{            
  mySerial.begin(9600);       // Start serial processing      
  delay(1000);                // Give Serial class time to complete initialization.
                 
  

  mySerial.println("=============================");
  mySerial.println("SETUP Complete - Georges Hart");
  mySerial.println("=============================");
  mySerial.println(" ");
  delay(1000);
  val=0;
}
 
//------------------------------------------------------------------------
// Toggle the led; document HIGH/LOW with serial output messages
//------------------------------------------------------------------------
void loop(){

  val = analogRead(pot);
  
  // read Analog in pin 6
  mySerial.println(val);
  delay(25);                  
  
}
