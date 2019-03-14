/**  Collection of Classes
 * @author Thomas Cann
 * @version 1.0
 */

/**  Class RingSystem collection of Rings, Ringlets and Gaps for a planetary ring system. 
 * @author Thomas Cann
 * @version 1.0
 */
class RingSystem {

  ArrayList<Ring> rings;
  private float r_min, r_max, num_particles;

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  RingSystem() {
    //default
    rings = new ArrayList<Ring>();

    //Saturn Ring Data (Source: Nasa Saturn Factsheet) [in Saturn radii]
    // D Ring: Inner 1.110 Outer 1.236
    rings.add(new Ring());
    // C Ring: Inner 1.239 Outer 1.527
    // B Ring: Inner 1.527 Outer 1.951
    // A Ring: Inner 2.027 Outer 2.269
    // F Ring: Inner 2.320 Outer *
    // G Ring: Inner 2.754 Outer 2.874
    // E Ring: Inner 2.987 Outer 7.964

    //Gaps/Ringlet Data
    // Titan Ringlet 1.292
    // Maxwell Gap 1.452
    // Encke Gap 2.265
    // Keeler Gap 2.265
  }
}

/**  Class Ring
 * @author Thomas Cann
 * @version 1.0
 */
class Ring {

  ArrayList<RingParticle> particles;
  private float r_min, r_max, num_particles;
  color c;

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Ring() {
    //default
  }
}

/**  Class RingParticle
 * @author Thomas Cann
 * @version 1.0
 */
class RingParticle {

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  RingParticle() {
    //default
  }
}

/**  Class RingParticle
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
