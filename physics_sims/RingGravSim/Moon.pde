/**Class Moon
 *
 * @author Thomas Cann
 * @author Sim Hinson
 * @version 1.0
 */

class Moon extends Particle {
  float GM;
  float radius;

  /**
   *  Class Constuctor - Default Moon object with properties of Mima (loosely). 
   */
  Moon() {
    //Mima
    this(2.529477495e13, 400e3, 185.52e6);
  }
  /**
   *  Class Constuctor - General Moon object with random angle. 
   */
  Moon(float Gm, float radius, float orb_radius) {
    super(orb_radius, random(2*PI));
    this.GM=Gm;
    this.radius=radius;
  }

  /**
   *  Display Method - Renders this object to screen displaying its position and colour.
   */
  void display() {
    ellipseMode(CENTER);
    fill(255, 0, 0);
    stroke(255, 0, 0);
    circle(scale*position.x, scale*position.y, 2*radius*scale);
  }
}
