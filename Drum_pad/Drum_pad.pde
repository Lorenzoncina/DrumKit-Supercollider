import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

// int number_of_clicks;
int click_stype;

// add osc communicaton
OscMessage myMessage;

void paintSquares(int alpha) {
  //square area 1: bass drum
  fill(50,75,120,alpha);
  rect(0,0,width/2,height/2);
  
  //square area 4: snare drum
  fill(50,128,100,alpha);
  rect(width/2,height/2,width/2,height/2);
  
  //other: 2-3,hi-hat
  fill(250, 180, 100,alpha);
  rect(0,height/2,width/2,height/2);
  rect(width/2,0,width/2,height/2);
}


void showPressShadow(int x,int y){
  int linewidth = width/2;
  int lineheight = height/2;
  strokeWeight(4);
  line(x, y, x+linewidth, y);
  strokeWeight(4);
  stroke(126);
  line(x+linewidth, y, x+linewidth, y+lineheight);
}

// Processing Funtion
// setup(): initialize the window
// runs once
void setup(){
  size(500,500);
  background(255);
  paintSquares(100);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  click_stype = -1;
}

// -- Processing Function
// draw():   Called directly after setup()
// All Processing programs update the screen at the end of draw()
// draw() loops forever, until stopped
void draw(){
  paintSquares(15);
  fill(255);
  noStroke();
  ellipse(mouseX, mouseY, 30, 30);

}

// when you click on the square, this function is called
// it sends a message to supercollider
void mousePressed(){
   click_stype = -1;
   myMessage = new OscMessage("/click");
   //base drum
   print(mouseX,mouseY);
   if(mouseX <=250 && mo'[useY<= 250){
     click_stype = 0;
     showPressShadow(0,0);// x, y start position

   }
   else if(mouseX >250 && mouseY >250){
     click_stype= 2;
     showPressShadow(250,250);
   }
   else{
     click_stype = 1;
   }
   myMessage.add(click_stype);
  
   oscP5.send(myMessage, myRemoteLocation); 
  
   myMessage.print();

}
