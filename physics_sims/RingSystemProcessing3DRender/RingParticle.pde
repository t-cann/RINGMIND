/**Class RingParticle
 * @author Thomas Cann
 * @version 1.0
 */
 
  float MAX_INCLINATION=80;
  float MIN_INCLINATION=1;
 float LAMBDA= 1E-4;
class RingParticle extends Particle {

  
  float rotation;
  float inclination;
  float initialiseTime;
  float minInclination;

  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float r, float dr, float theta, float dtheta) {
    // Initialise our Orboids.
    super((random(1)*(dr) + r)*Rp, theta + random(1)*dtheta);
    rotation =random(360);
    inclination= randomGaussian()*MAX_INCLINATION;
    minInclination = randomGaussian()* MIN_INCLINATION;
    initialiseTime = millis();
  }
  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float inner, float outer) {
    // Initialise our Orboids.
    super((random(1)*(outer-inner) + inner)*Rp, random(1)*2.0*PI);
    rotation =random(360);
    inclination= randomGaussian()*MAX_INCLINATION;
    minInclination = randomGaussian()* MIN_INCLINATION;
    initialiseTime = millis();
  }

  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float radius) {
    // Initialise ourRingParticle.
    super(radius, random(1)*2.0*PI);
        rotation =random(360);
    inclination= randomGaussian()*MAX_INCLINATION;
    minInclination = randomGaussian()* MIN_INCLINATION;
    initialiseTime = millis();
  }


  float inclination(){
  return inclination* exp(-LAMBDA*(millis()-initialiseTime)) +minInclination  ;
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

}
