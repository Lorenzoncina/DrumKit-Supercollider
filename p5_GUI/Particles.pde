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
    // Render 
    super.display();
    // add a rotating line
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    stroke(#FAF184, lifespan);
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
    velocity = new PVector(random(-3, 3), random(-2, 0));
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
    //#4C139D#58C4F0
    stroke(#F8ECF2, lifespan-60); //darker stroke
    fill(#FBB8B8, lifespan-60);// brighter filling color
    ellipse(position.x, position.y, 5, 5);
  }

  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}
