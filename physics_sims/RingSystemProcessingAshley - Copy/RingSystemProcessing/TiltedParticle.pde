/**Class RingParticle
 * @author Thomas Cann
 * @version 1.0
 */

class TiltedParticle extends Particle {
 

  
  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  TiltedParticle(float r, float dr, float theta, float dtheta) {
    
    super((random(1)*(dr) + r)*Rp, theta + random(1)*dtheta);

  }
 



}
