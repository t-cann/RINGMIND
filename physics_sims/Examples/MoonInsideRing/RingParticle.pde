/**  Class RingParticle
 * @author Thomas Cann
 * @version 1.0
 */
class RingParticle extends Particle {

  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float inner, float outer) {
    // Initialise our Orboids.
    super((random(1)*(outer-inner) + inner)*Rp, 2.0*PI);
  }

  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float radius) {
    // Initialise ourRingParticle.
    super(radius, random(1)*2.0*PI);
  }

  /**
   *  Display Method - Renders this object to screen displaying its position and colour.
   */
  void display() {
    push();
    translate(width/2, height/2);
    fill(255);
    stroke(255);
    point(scale*position.x, scale*position.y);
    pop();
  }

  void render(PGraphics x) {
    x.push();
    x.translate(width/2, height/2);
    x.fill(255);
    x.stroke(255);
    x.point(scale*position.x, scale*position.y);
    x.pop();
  }

  /**
   *  Updates object for one time step of simulation taking into account the position of one moon.
   */
  void update(ArrayList<Moon> moons) {

    // acceleration functions
    float ax_grav = (-GMp*position.x/pow(sqrt(sq(position.x) + sq(position.y)), 3.0));
    float ay_grav = (-GMp*position.y/pow(sqrt(sq(position.x) + sq(position.y)), 3.0));
    for (Moon m : moons) {
      if (m != this) {
        ax_grav += (m.GM*(m.position.x-position.x)/pow(sqrt(sq(m.position.x-position.x) + sq(m.position.y-position.y)), 3.0));
        ay_grav += (m.GM*(m.position.y-position.y)/pow(sqrt(sq(m.position.x-position.x) + sq(m.position.y-position.y)), 3.0));
      }
    }
    // temp x and y positions
    float x1_orboid;
    float x2_orboid;

    // leapfrog integration
    x1_orboid = position.x + velocity.x*h_stepsize + 0.5*ax_grav*h_stepsize*h_stepsize;
    x2_orboid = position.y + velocity.y*h_stepsize + 0.5*ay_grav*h_stepsize*h_stepsize;


    float ax_grav1 = (-GMp*x1_orboid/pow(sqrt(sq(x1_orboid) + sq(x2_orboid)), 3.0)); 
    float ay_grav1 = (-GMp*x2_orboid/pow(sqrt(sq(x1_orboid) + sq(x2_orboid)), 3.0));

    for (Moon m : moons) {
      if (m != this) {
        ax_grav1 += (m.GM*(m.position.x-x1_orboid)/pow(sqrt(sq(m.position.x-x1_orboid) + sq(m.position.y-x2_orboid)), 3.0));
        ax_grav1 +=(m.GM*(m.position.y-x2_orboid)/pow(sqrt(sq(m.position.x-x1_orboid) + sq(m.position.y-x2_orboid)), 3.0));
      }
    }

    velocity.x = velocity.x + 0.5*(ax_grav+ax_grav1)*h_stepsize;
    velocity.y = velocity.y + 0.5*(ay_grav+ay_grav1)*h_stepsize;
    position.x = x1_orboid;
    position.y = x2_orboid;
    //v_orboid = sqrt(sq(velocity.x)+sq(velocity.y));
  }
}

/**  Class Moonlet 
 * @author Thomas Cann
 * @version 1.0
 */
class Moonlet {

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Moonlet() {
    //default
  }
}
