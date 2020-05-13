import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
int number_of_clicks;
OscMessage myMessage;

void setup(){
  
  size(640, 360);
  noStroke();
  
  rectMode(CENTER);
  
  oscP5 = new OscP5(this, 12000);
  
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  
  number_of_clicks = 0;
  
}


void draw(){
  
  background(51);
    
  fill(number_of_clicks, 0, 0);
  rect(320, 180, 100, 100, 7);
  
}

//when you click on the square, this function is called
//it modifies the color of the square
//it sends a message to supercollider
void mousePressed(){
  
  // +10 makes a visible difference, +1 was not enough. btw don't minde this number
  number_of_clicks = number_of_clicks + 10;
  
  if(number_of_clicks > 245){
    number_of_clicks = 0;
  }
  
  myMessage = new OscMessage("/click");
  
   myMessage.add(number_of_clicks);
  
   oscP5.send(myMessage, myRemoteLocation); 
  
   myMessage.print();
}
