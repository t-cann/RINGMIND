/**Class RingParticle
 * @author Thomas Cann
 * @version 1.0
 */
class RingParticle extends Particle {

  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float r, float dr, float theta, float dtheta) {
    // Initialise our Orboids.
    super((random(1)*(dr) + r)*Rp, theta + random(1)*dtheta);
  }
  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float inner, float outer) {
    // Initialise our Orboids.
    super((random(1)*(outer-inner) + inner)*Rp, random(1)*2.0*PI);
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

  /**
   *
   */
  void render(PGraphics x) {
    x.push();
    x.translate(width/2, height/2);
    x.fill(255);
    x.stroke(255);
    x.point(scale*position.x, scale*position.y);
    x.pop();
  }

  /**
   *  Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
   */
  PVector getAcceleration(RingSystem rs) {

    // acceleration due planet in centre of the ring. 
    PVector a_grav = PVector.mult(position.copy().normalize(), -GMp/position.copy().magSq());

    // acceleration due the moons on this particle.
    for (Moon m : rs.moons) {
      if (m != this) {

        PVector dist = PVector.sub(m.position, position);
        PVector a = PVector.mult(dist, m.GM/pow(dist.mag(), 3));
        a_grav.add(a);
      }
    }

    if( this instanceof Moon){
      
    }else{
      
    //Acceleration from the Grid Object
    a_grav.add(rs.g.gridAcceleration(this));
     
    }
  return a_grav;
}

/**
 *
 */
void set_getAcceleration(RingSystem rs) {
  acceleration = getAcceleration(rs);
}

/**
 *
 */
void updatePosition() {
  position.add(velocity.copy().mult(h_stepsize)).add(acceleration.copy().mult(0.5*sq(h_stepsize)));
}

/**
 *    Updates the velocity of this Ring Particle (Based on Velocity Verlet) using 2 accelerations.  
 */
void updateVelocity(PVector a) {
  this.velocity.add(PVector.add(acceleration.copy(), a).mult(0.5 *h_stepsize));
}

/**
 *  Old Update Method - Updates object for one time step of simulation taking into account the position of one moon.
 *  Roughly Does a Verlet Integration ---> https://en.wikipedia.org/wiki/Leapfrog_integration
 */
void update(ArrayList<Moon> moons) {

  PVector a_grav = PVector.mult(position.copy().normalize(), -GMp/position.copy().magSq());

  for (Moon m : moons) {
    if (m != this) {
      PVector dist = PVector.sub(m.position, position);
      PVector a = PVector.mult(dist, -m.GM/pow(dist.mag(), 3));
      a_grav.add(a);
    }
  }

  PVector tempPosition = PVector.add(position.copy(), velocity.copy().mult(h_stepsize)).add(a_grav.copy().mult(0.5*sq(h_stepsize)));

  PVector a_grav1 = PVector.mult(tempPosition.copy().normalize(), -GMp/tempPosition.copy().magSq());

  for (Moon m : moons) {
    if (m != this) {
      PVector dist = PVector.sub(m.position, tempPosition);
      PVector a = PVector.mult(dist, -m.GM/pow(dist.mag(), 3));
      a_grav1.add(a);
    }
  }

  this.velocity.add(PVector.add(a_grav, a_grav1).mult(0.5 *h_stepsize));
  this.position = tempPosition;
}
}
