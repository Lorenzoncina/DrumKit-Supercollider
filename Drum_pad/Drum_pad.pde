import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;//to supercollider
NetAddress myReceiverLocation; //from supercollider
// int number_of_clicks;
int Syn_Type;
// add osc communicaton
OscMessage myMessage;
// doing : link supercollider
int color1,color2,color3;
PImage ava5;

void paintSquares(int alpha) {
  noStroke();
  // list of sound {\bd,\hh,\sn,\cb,\kc,\fm}
  color[] s_clr = {#4B6886,#61606D,#CC6600,#25A162,#C5272E,#22B8E7};
  for(int i = 0; i<6;i++){
    fill(s_clr[i], alpha);
    rect(i % 3 * (width/3), i % 2 * (height/2) , width/3, height/2);
  }
  
  
}

void showPressShadow(int x, int y) {
  int linewidth = width/3;
  int lineheight = height/2;
  stroke(10);
  strokeWeight(2);
  line(x, y+lineheight, x+linewidth-2/2, y+lineheight);
  strokeWeight(2);
  stroke(10);
  line(x+linewidth-2/2, y, x+linewidth-2/2, y+lineheight-2/2);
  strokeWeight(1);
  line(x, y, x, y+lineheight-2/2);
}


// ---------- Processing Funtion
// setup(): initialize the window
// runs once
void setup() {
  size(750, 500);
  background(255);
  paintSquares(100);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  myReceiverLocation = new NetAddress("127.0.0.1", 57130);
  Syn_Type = -1;
  ava5 = loadImage("frog.png");
}

// -- Processing Function
// draw():   Called directly after setup()
// All Processing programs update the screen at the end of draw()
// draw() loops forever, until stopped
void draw() {
  paintSquares(15);
  image(ava5, 500, 300);
  fill(255);
  noStroke();
  ellipse(mouseX, mouseY, 30, 30);
  ava5 = loadImage("frog.png");

}

// A function to check which region is the square
int checkSquareNum(int Mx, int My){
    int click_stype= -1;
    if (Mx <= width/3 && My <= height/2) {
      click_stype = 0;
    }   
    else if (Mx > width/3 && Mx <= width*2/3 && My <=height/2) {
      click_stype= 1;
    } 
    else if (Mx > width*2/3 && Mx <= width && My <=height/2) {
      click_stype = 2;
    }
    else if (Mx <= width/3 && My >height/2) {
      click_stype = 3;
    }
    else if (Mx > width/3 && Mx <= width*2/3 && My >height/2) {
      click_stype = 4;
    }
    else {
      click_stype = 5;
    }
  return click_stype;
}

// when you click on the square, this function is called
// it sends a message to supercollider
void mousePressed() {
  myMessage = new OscMessage("/click");
  //base drum
  print(mouseX, mouseY);
  //----  add something for checking the square number
  Syn_Type = checkSquareNum(mouseX, mouseY);
  
  myMessage.add(Syn_Type);
  // processing controller -> osc ->supercollider play syn from 0-5
  oscP5.send(myMessage, myRemoteLocation); 
  myMessage.print();
  // receive the changed color from supercollider
  // change the color on the clicked square
  changeSquareColor(Syn_Type,color1,color2, color3);

}

void oscEvent(OscMessage anewMessage){
  if (anewMessage.checkAddrPattern("/changeColor")==true){
  color1 = anewMessage.get(0).intValue();
  color2 = anewMessage.get(1).intValue();
  color3 = anewMessage.get(2).intValue();
  println("This is a message received from SuperCollider___________",color1,"",color2,"",color3,"");
  }
}

void changeSquareColor(int n, int color1,int color2,int color3){
   int[] x = { 0, width/3, width*2/3, 0, width/3, width*2/3};
   int[] y = { 0, 0, 0, height/2, height/2, height/2};
   fill(color1,color2,color3,100);
   rect(x[n],y[n],width/3,height/2);
   //change ava
   if (n == 5){
        ava5 = loadImage("frog1.png");
   };
}
  
