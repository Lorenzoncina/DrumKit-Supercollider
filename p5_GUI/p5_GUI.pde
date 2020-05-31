import oscP5.*;
import netP5.*;


// to generate multiple particle system
ArrayList<ParticleSystem> systems;
//osc communication
OscP5 oscP5;
//color object
NetAddress myRemoteLocation;//to supercollider
NetAddress myReceiverLocation; //from supercollider
// int number_of_clicks;
int Syn_Type;
// add osc communicaton
OscMessage myMessage;
// doing : link supercollider
int color1,color2,color3;
PImage bg; // load background image
PImage select; // load sl
// init all ava img
String[] path = {"pic/avatar1.png","pic/avatar2.png","pic/avatar3.png","pic/avatar4.png","pic/avatar5.png","pic/avatar6.png","pic/avatar7.png","pic/avatar8.png"};
PImage[] images = new PImage[path.length];
PVector[] image_pos = new PVector[path.length]; // store ava position
// load text font

// ---------- Processing Funtion-------setup(): initialize the window, runs once
void setup() {
  size(1000, 500);// update new size bg
  //use background img instead, no need color
  //background(255);
  // paint the interactive square first
  paintSquares(100);
  bg = loadImage("pic/background.jpg");
  background(bg);
  select = loadImage("pic/select.png");// the hand selector as mouse
  //ava5 = loadImage("pic/avatar6.png");
  initAvatar();
  //insted, set all avatar at position
  setAvatar();
  // setup background Text "A Drum Kit"
  textFont(createFont("ComicSansMS-48",32));
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  myReceiverLocation = new NetAddress("127.0.0.1", 57130);
  Syn_Type = -1;
  //ava5 = loadImage("pic/avatar6.png");
  systems = new ArrayList<ParticleSystem>();// add new ps
}

// -- Processing Function------- draw():   Called directly after setup()
// All Processing programs update the screen at the end of draw()
// draw() loops forever, until stopped
void draw() {
  // load background first
  background(bg);
  //paint square back
  paintSquares(15);
  // draw Text Title "A Drum Kit"
  textAlign(CENTER);
  fill(#8E6762);
  text("A Drum Kit", width/2, 70); // shadow effect
  fill(#D33A3A,200);
  text("A Drum Kit", width/2+2, 70);
  // ----- set avatar back
  // loda all avatar img
  setAvatar();
  //ava5 = loadImage("pic/avatar6.png");
  //image(ava5, 550, 300);
  fill(255);
  noStroke();
  image(select, mouseX, mouseY);//elipse(mouseX, mouseY, 10, 10);
  // add particle system
    if (systems.isEmpty()) {
    fill(255,120);
    textAlign(CENTER);
    text("click mouse to start playing", width/2, height/2 + 200);
    
  }
  //Todo if empty free the system
  // if not empty
  for (ParticleSystem ps : systems) {
    ps.run();
  //
    }
  }

//mouse click listener
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
  changeAva(Syn_Type);
  //New particle system
  systems.add(new ParticleSystem(20, new PVector(mouseX, mouseY)));
  
}

void oscEvent(OscMessage anewMessage){
  if (anewMessage.checkAddrPattern("/changeColor")==true){
  color1 = anewMessage.get(0).intValue();
  color2 = anewMessage.get(1).intValue();
  color3 = anewMessage.get(2).intValue();
  println("This is a message received from SuperCollider___________",color1,"",color2,"",color3,"");
  }
  if (anewMessage.checkAddrPattern("/sendSoundDes")==true){
    String aMes = anewMessage.get(0).stringValue();
    println("This is another message!!!!!!!!", aMes,"");
  }
}
