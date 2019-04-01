/**Class Particle
 *
 * @author Thomas Cann
 * @author Sim Hinson
 * @version 1.0
 */
abstract class Particle {

  PVector position; // Position float x1, x2, x3; 
  PVector velocity; // Velocity float v1, v2, v3;
  PVector acceleration;  //Update all constructors!

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Particle(float x1_, float x2_, float x3_, float v1_, float v2_, float v3_, float a1_, float a2_, float a3_) {
    //default position
    this.position = new PVector(x1_, x2_, x3_);
    //default velocity
    this.velocity = new PVector(v1_, v2_, v3_);
    this.acceleration = new PVector(a1_,a2_,a3_);
  }

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Particle(float x1_, float x2_, float x3_, float v1_, float v2_, float v3_) {
    //default position
    this.position = new PVector(x1_, x2_, x3_);
    //default velocity
    this.velocity = new PVector(v1_, v2_, v3_);
    this.acceleration = new PVector();
  }

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Particle(PVector position_, PVector velocity_) {
    //default position
    this.position = position_.copy();
    //default velocity
    this.velocity = velocity_.copy();
    
  }

  /**
   *  Class Constuctor - Initialises an Orboid object with a random position in the ring with correct orbital velocity. 
   */
  Particle(float r, float phi) {
    this(r*cos(phi), r*sin(phi), randomGaussian(), sqrt(GMp/(r))*sin(phi), -sqrt(GMp/(r))*cos(phi), 0);
  }

  /**
   *  Class Constuctor - Initialises an Particle object with zero position and velocity. 
   */
  Particle() {
    this(0, 0, 0, 0, 0, 0);
  }

  /**
   *  Display Method - Renders this object to screen displaying its position and colour.
   */
  void display() {
  }

  ///**
  // *  Clone Method - Return New Object with same properties.
  // */
  //Particle clone() {
  //  Particle p = new Particle();
  //  p.position= this.position.copy();
  //  p.velocity = this.velocity.copy();
  //  return p;
  //}

  /**
   *  Updates object for one time step of simulation.
   */
  void update() {
    // acceleration functions
   
    PVector a_grav = PVector.mult(position.copy().normalize(),-GMp/position.copy().magSq());
    
    PVector tempPosition = PVector.add(position.copy(),velocity.copy().mult(h_stepsize)).add(a_grav.copy().mult(0.5*sq(h_stepsize)));
    
    PVector a_grav1 = PVector.mult(tempPosition.copy().normalize(),-GMp/tempPosition.copy().magSq());
    
    this.velocity.add(PVector.add(a_grav,a_grav1).mult(0.5 *h_stepsize));
    this.position = tempPosition;

  }
}
