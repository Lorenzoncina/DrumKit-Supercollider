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

void paintSquares(int alpha) {
  noStroke();
  // list of sound {\bd,\hh,\sn,\cb,\kc,\fm}
  color[] s_clr = {#4B6886,#61606D,#CC6600,#25A162,#C5272E,#22B8E7,#C5272E,#22B8E7 };
  for(int i = 0; i<8;i++){
    fill(s_clr[i], alpha);
    rect(i % 3 * (width/4), i % 2 * (height/2) , width/4, height/2);
  }
}

void showPressShadow(int x, int y) {
  int linewidth = width/4;
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

//set avatar init path, load img
void setAvatar(){
  for(int i = 0; i<8;i++){
    images[i] = loadImage(path[i]);
  }
    imageMode(CENTER);
    //------------------- to do
    image(images[0],220,200);
    image(images[1],440,200);
    image(images[2],680,200);
    image(images[3],125,320);
    image(images[4],380, 320);
    image(images[5],600, 320);
    image(images[6],850, 200); //extra 1
    image(images[7],840, 320); // extra 2
  //}
}

// ---------- Processing Funtion
// setup(): initialize the window, runs once
void setup() {
  size(1000, 500);// update new size bg
  //use background img instead, no need color
  //background(255);
  // paint the interactive square first
  paintSquares(100);
  bg = loadImage("pic/background.jpg");
  background(bg);
  select = loadImage("pic/select.png");
  //ava5 = loadImage("pic/avatar6.png");
  //insted, set all avatar
  setAvatar();
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  myReceiverLocation = new NetAddress("127.0.0.1", 57130);
  Syn_Type = -1;
  //ava5 = loadImage("pic/avatar6.png");
  systems = new ArrayList<ParticleSystem>();// add new ps
}

// -- Processing Function
// draw():   Called directly after setup()
// All Processing programs update the screen at the end of draw()
// draw() loops forever, until stopped
void draw() {
  // load background first
  background(bg);
  //paint square back
  paintSquares(15);
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
    fill(255);
    textAlign(CENTER);
    text("click mouse to start playing", width/2, height/2);
  }
  //Todo if empty free the system
  // if not empty
  for (ParticleSystem ps : systems) {
    ps.run();
  //
    }
  }

// A function to check which region is the square
int checkSquareNum(int Mx, int My){
    int click_stype= -1;
    if (Mx <= width/4 && My <= height/2) {
      click_stype = 0;
    }   
    else if (Mx > width/4 && Mx <= width*2/4 && My <=height/2) {
      click_stype= 1;
    } 
    else if (Mx > width * 2/4 && Mx <= width *3/4 && My <=height/2) {
      click_stype = 2;
    }
    else if (Mx > width * 3/4 && Mx <= width && My <=height/2) {
      click_stype = 3;
    }
    else if (Mx <= width/4 && My >height/2) {
      click_stype = 4;
    }
    else if(Mx > width /4 && Mx <= width *2/4 && My > height/2){
      click_stype = 5;
    }
    else if(Mx > width * 3/4 && Mx <= width && My > height/2){
      click_stype = 7;
    }
    else {
      click_stype = 6;
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

void changeSquareColor(int n, int color1,int color2,int color3){
   int[] x = { 0, width/4, width*2/4,width *3/4, 0, width/4, width*2/4,width*3/4};
   int[] y = { 0, 0, 0,0, height/2, height/2, height/2, height/2};
   fill(color1,color2,color3,100);
   rect(x[n],y[n],width/4,height/2);
   //change ava
   if (n == 5){
        images[5] = loadImage("pic/avatar6c.png");
        image(images[5], 600, 320);
   };
}
  
void soundAnimation(){
  //to do 

}

class ParticleSystem {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;                   // An origin point for where particles are birthed
  int aliveTime = 600;// the alive time for particle system

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList<Particle>();   // Initialize the arraylist
    origin = v.copy(); 
    aliveTime = num;
  }


  void run() {
    // Cycle through the ArrayList backwards, because we are deleting while iterating
    if (!dead()) addParticle();
    for (int i = particles.size()-1; i >= 0; i--) { // i >= 0; i--
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
    aliveTime -= 1; // make aliveTime less
  }

  void addParticle() {
    Particle p;
    // Add either a Particle or CrazyParticle to the system
    if (int(random(0, 2)) == 0) {
      p = new Particle(origin);
    } 
    else {
      p = new CrazyParticle(origin);
    }
    particles.add(p);
  }

  void addParticle(Particle p) {
    particles.add(p);
  }

  // A method to test if the particle system still has particles
  boolean dead() {
    return (aliveTime <= 0);
  }
}



// A subclass of Particle

class CrazyParticle extends Particle {

  // Just adding one new variable to a CrazyParticle
  // It inherits all other fields from "Particle", and we don't have to retype them!
  float theta;

  // The CrazyParticle constructor can call the parent class (super class) constructor
  CrazyParticle(PVector l) {
    // "super" means do everything from the constructor in Particle
    super(l);
    // One more line of code to deal with the new variable, theta
    theta = 0.0;
  }

  // no method run() here, inherited from Particle
  // This update() method overrides the parent class update() method
  void update() {
    super.update();
    // Increment rotation based on horizontal velocity
    float theta_vel = (velocity.x * velocity.mag()) / 10.0f; //10
    theta += theta_vel;
  }

  // This display() method overrides the parent class display() method
  void display() {
    // Render the ellipse just like in a regular particle
    super.display();
    // Then add a rotating line
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    stroke(255, lifespan);
    line(0, 0, 2, 0);
    popMatrix();
  }
}


// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);//0.05
    velocity = new PVector(random(-2, 2), random(-2, 0));
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
    //#F9BC45,#FAF184
    stroke(#4C139D, lifespan-60); //darker stroke
    fill(#58C4F0, lifespan-60);// brighter filling color
    ellipse(position.x, position.y, 5, 5);
  }

  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}
