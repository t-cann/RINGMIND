/** Collection of Classes
 * @author Thomas Cann
 * @version 1.0
 */

/**  Class RingSystem collection of Rings, Ringlets and Gaps for a planetary ring system. 
 * @author Thomas Cann
 * @version 1.0
 */
class RingSystem {

  ArrayList<Ring> rings;
  float r_min, r_max, num_particles;
  float GM;  //GM of Planet at Centre of Rings

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  RingSystem() {
    //default
    rings = new ArrayList<Ring>();

    //Saturn Ring Data (Source: Nasa Saturn Factsheet) [in Saturn radii]
    // D Ring: Inner 1.110 Outer 1.236
    rings.add(new Ring(1.239, 1.951, 5000));
    // C Ring: Inner 1.239 Outer 1.527
    // B Ring: Inner 1.527 Outer 1.951
    // A Ring: Inner 2.027 Outer 2.269
    rings.add(new Ring(2.027, 2.269, 5000));
    // F Ring: Inner 2.320 Outer *
    // G Ring: Inner 2.754 Outer 2.874
    // E Ring: Inner 2.987 Outer 7.964

    //Gaps/Ringlet Data
    // Titan Ringlet 1.292
    // Maxwell Gap 1.452
    // Encke Gap 2.265
    // Keeler Gap 2.265
  }

  void update() {
    for (Ring r : rings) {
      r.update();
    }
  }

  void display() {
    for (Ring r : rings) {
      r.display();
    }
  }
}

/**  Class Ring
 * @author Thomas Cann
 * @version 1.0
 */
class Ring {

  ArrayList<RingParticle> particles;
  float r_inner, r_outer;
  color c;

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Ring(float Inner, float Outer, int n_particles) {
    particles = new ArrayList<RingParticle>();
    for (int i = 0; i < n_particles; i++) {
      particles.add(new RingParticle(Inner, Outer));
    }
  }
  void update() {
    for (RingParticle p : particles) {
      p.update();
    }
  }
  void display() {
    for (RingParticle p : particles) {
      p.display();
    }
  }
}

/**  Class RingParticle
 * @author Thomas Cann
 * @version 1.0
 */
class RingParticle extends Particle {

  /**
   *  Class Constuctor - Initialises an Orboid object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float inner, float outer) {
    // Initialise our Orboids.
    super((random(1)*(outer-inner) + inner)*Rp, random(1)*2.0*PI);
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
