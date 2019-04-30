/**Class Moon
 *
 * @author Thomas Cann
 * @author Sam Hinson
 * @version 1.0
 */

public interface Alignable {

  public boolean isAligned(Alignable other);  //Alignment Threshold
  //public float timeToAlignment(Alignable other); //What units? [s]
}


class Moon extends Particle implements Alignable {
  float GM;
  float radius;
  color c ;


  final float moonSizeScale= 10;


  /**
   *  Class Constuctor - General Moon object with random angle. 
   */
  Moon(float Gm, float radius, float orb_radius, color c) {
    super(orb_radius);
    this.GM=Gm;
    this.radius=radius;
    this.c= c;
  }
  /**
   *  Class Constuctor - General Moon object with random angle. 
   */
  Moon(float Gm, float radius, float orb_radius) {
    super(orb_radius);
    this.GM=Gm;
    this.radius=radius;
    c= color(255, 0, 0);
  }
  /**
   *  Class Constuctor - Default Moon object with properties of Mima (loosely). 
   */
  Moon(PVector p, PVector v) {
    //Mima (Source: Nasa Saturn Factsheet)
    //GM - 2.529477495E9 [m^3 s^-2]
    //Radius - 2E5 [m]
    //Obital Radius - 185.52E6 [m]

    this(2.529477495e13, 400e3, 185.52e6);
    this.position.x = p.x;
    this.position.y = p.y;
    this.position.z = p.z;
    this.velocity.x = v.x;
    this.velocity.y = v.y;
    this.velocity.z = v.z;
  }
  boolean isAligned(Alignable other) {
    boolean temp =false;
    Moon otherMoon = (Moon)other;
    float dAngle = this.position.heading() - otherMoon.position.heading();
    float angleThreshold = radians(1);
    if ( abs(dAngle) < angleThreshold) {//% PI
      temp =true;
      //if(dAngle >0){

      //}
      this.c= color(0, 0, 255);
      otherMoon.c= color(0, 0, 255);
    } 
    return temp;
  }
  
  float timeToAlignment(Alignable other){
    Moon otherMoon = (Moon)other;
    float dAngle = this.position.heading() - otherMoon.position.heading();
    float dOmega = kepler_omega(this)-kepler_omega(otherMoon);
    return dAngle/(dOmega*simToRealTimeRatio);
  }

  /** Method to calculate the Keplerian orbital angular frequency (using Kepler's 3rd law).
   *@param r  Radial position (semi-major axis) to calculate the period [m].
   *@return   The angular frequency [radians/s].
   */
  float kepler_omega(Moon m) {
    return sqrt(GMp/(pow(m.position.mag(), 3.0)));
  }

  /**
   *  Display Method - Renders this object to screen displaying its position and colour.
   */
  void display() {
    push();
    translate(width/2, height/2);
    ellipseMode(CENTER);
    fill(c);
    stroke(c);
    circle(SCALE*position.x, SCALE*position.y, 2*moonSizeScale*radius*SCALE);
    pop();
  }
  //  void render(PGraphics x) {
  //  x.push();
  //  x.translate(width/2, height/2);
  //  x.ellipseMode(CENTER);
  //  x.fill(c);
  //  x.stroke(c);
  //  x.circle(scale*position.x, scale*position.y, 2*moonSizeScale*radius*scale);
  //  x.pop();
  //}

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

    return a_grav;
  }
}
