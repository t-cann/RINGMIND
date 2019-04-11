/**Class RingParticle
 * @author Thomas Cann
 * @version 1.0
 */
 
   float MAX_INCLINATION;
 float LAMBDA;

class TiltedParticle extends Particle {
 
  float rotation;
  float inclination;
  float initialiseTime;

  
  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  TiltedParticle(float r, float dr, float theta, float dtheta) {
    
    super((random(1)*(dr) + r)*Rp, theta + random(1)*dtheta);
    rotation =random(360);
    inclination= randomGaussian()*MAX_INCLINATION;
    initialiseTime = millis();
  }
 
  float inclination(){
  return inclination* exp(-LAMBDA*(millis()-initialiseTime));
  }


}
