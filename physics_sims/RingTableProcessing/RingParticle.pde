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
   *  Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
   */
  PVector getAcceleration(RingSystem rs) {

    // acceleration due planet in centre of the ring. 
    PVector a_grav = PVector.mult(position.copy().normalize(), -GMp/position.copy().magSq());

    //Acceleration from the Grid Object
    for (Grid x : rs.g) {
      a_grav.add(x.gridAcceleration(this));
    }
    for (Moon m : rs.moons) {
      PVector dist = PVector.sub(m.position, position);
      PVector a = PVector.mult(dist, m.GM/pow(dist.mag(), 3));
      a_grav.add(a);
    }
    return a_grav;
  }

  /**
   *  Display Method - Renders this object to screen displaying its position and colour.
   */
  //void display() {
  //  push();
  //  translate(width/2, height/2);
  //  fill(255);
  //  stroke(255);
  //  strokeWeight(2);
  //  point(scale*position.x, scale*position.y);
  //  pop();
  //}

  /**
   *
   */
  //void render(PGraphics x) {
  //  x.push();
  //  x.translate(width/2, height/2);
  //  x.fill(255);
  //  x.stroke(255);
  //  x.point(scale*position.x, scale*position.y);
  //  x.pop();
  //}
}
