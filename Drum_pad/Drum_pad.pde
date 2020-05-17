import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
//int number_of_clicks;
int click_type;
OscMessage myMessage;


void setup(){

  size(500,500);
  //other: square 2 and 3
  background(250, 180, 100);
  fill(50,75,120);
  //square 1: bass drum
  rect(0,0,250,250);
  
  fill(50,128,100);
  //square 4: snare
  rect(250,250,500,500);
  

  
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  click_type = -1;
  
}


void draw(){
  
}
//when you click on the square, this function is called
//it sends a message to supercollider

void mousePressed(){
   click_type = -1;
   myMessage = new OscMessage("/click");
   //base drum
   print(mouseX,mouseY);
   if(mouseX <=250 && mouseY<= 250){
     click_type = 0;
   }
   else if(mouseX >250 && mouseY >250){
     click_type = 2;
   }
   else{
     click_type = 1;
   }
   myMessage.add(click_type);
  
   oscP5.send(myMessage, myRemoteLocation); 
  
   myMessage.print();

}
