/**Class Moon
 *
 * @author Thomas Cann
 * @author Sim Hinson
 * @version 1.0
 */

class Moon extends RingParticle {
  float GM;
  float radius;
  color c ;
  
  
  /**
   *  Class Constuctor - General Moon object with random angle. 
   */
  Moon(float Gm, float radius, float orb_radius,color c) {
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
    c= color(255,0,0);
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


  /**
   *  Display Method - Renders this object to screen displaying its position and colour.
   */
  void display() {
    push();
    translate(width/2, height/2);
    ellipseMode(CENTER);
    fill(c);
    stroke(c);
    circle(scale*position.x, scale*position.y, 2*radius*scale);
    pop();
  }
    void render(PGraphics x) {
    x.push();
    x.translate(width/2, height/2);
    x.ellipseMode(CENTER);
    x.fill(c);
    x.stroke(c);
    x.circle(scale*position.x, scale*position.y, 2*radius*scale);
    x.pop();
  }
}

///**
//   *  Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
//   */
//  PVector getAcceleration(RingSystem rs) {

//    // acceleration due planet in centre of the ring. 
//    PVector a_grav = PVector.mult(position.copy().normalize(), -GMp/position.copy().magSq());




//  return a_grav;
//}
