/**Class Particle
 *
 * @author Thomas Cann
 * @author Sim Hinson
 * @version 1.0
 */
class Particle {

  PVector position; // Position float x1, x2, x3; 
  PVector velocity; // Velocity float v1, v2, v3;


  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Particle(float x1_, float x2_, float x3_, float v1_, float v2_, float v3_) {
    //default position
    position = new PVector(x1_, x2_, x3_);
    //default velocity
    velocity = new PVector(v1_, v2_, v3_);
  }

  /**
   *  Class Constuctor - Initialises an Particle object with zero position and velocity. 
   */
  Particle() {
    this(0, 0, 0, 0, 0, 0);
  }

  /**
   *  Class Constuctor - Initialises an Orboid object with a random position in the ring with correct orbital velocity. 
   */
  Particle(float r, float phi) {
    this(r*cos(phi), r*sin(phi), 0, sqrt(GMp/(r))*sin(phi), -sqrt(GMp/(r))*cos(phi), 0);
  }


  /**
   *  Display Method - Renders this object to screen displaying its position and colour.
   */
  void display() {
  }

  /**
   *  Clone Method - Return New Object with same properties.
   */
  Particle clone() {
    Particle p = new Particle();
    p.position= this.position.copy();
    p.velocity = this.velocity.copy();
    return p;
  }

  /**
   *  Updates object for one time step of simulation.
   */
  void update() {
    // acceleration functions
    float ax_grav = (-GMp*position.x/pow(sqrt(sq(position.x) + sq(position.y)), 3.0))*1.0;
    float ay_grav = (-GMp*position.y/pow(sqrt(sq(position.x) + sq(position.y)), 3.0))*1.0;

    // temp x and y positions
    float x1_temp;
    float y1_temp;

    // leapfrog integration
    x1_temp = position.x + velocity.x*h_stepsize + 0.5*ax_grav*h_stepsize*h_stepsize;
    y1_temp = position.y + velocity.y*h_stepsize + 0.5*ay_grav*h_stepsize*h_stepsize;

    float ax_grav1 = (-GMp*x1_temp/pow(sqrt(sq(x1_temp) + sq(y1_temp)), 3.0))*1.0;
    float ay_grav1 = (-GMp*y1_temp/pow(sqrt(sq(x1_temp) + sq(y1_temp)), 3.0))*1.0;

    velocity.x = velocity.x + 0.5*(ax_grav+ax_grav1)*h_stepsize;
    velocity.y = velocity.y + 0.5*(ay_grav+ay_grav1)*h_stepsize;
    position.x = x1_temp;
    position.y = y1_temp;

    display();
  }
}
