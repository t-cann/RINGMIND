/** 
 *
 * Purpose:  Circlar Grid Cell without using arc function.
 *
 * Cell has a coordinate of inner couner and size in both radial and angular directions.
 *            
 * @author Thomas Cann
 * @version 1.0
 */

class Cell {

  protected float x1, x2; //r and theta
  protected float w1, w2; //dr and dtheta
  protected float N; // Nu

  float state;

  /**
   * This is a constructor for a Circlar Grid Cell.
   *
   * @param r_ the inner radius of grid cell.
   * @param theta_ the initial angle of grid cell.
   * @param dr_ the radial size of the grid cell.
   * @param dtheta_ the angular size of the grid cell.
   */

  Cell(float r_, float theta_, float dr_, float dtheta_) {
    this.x1 = r_;
    this.x2 = theta_;
    this.w1 = dr_;
    this.w2 = dtheta_;
    state = random(2);
    N = x1*w2;
  }

  /**
   * This method displays the object on the screen relative to centre of the screen.
   */
  void display() {
    float R= x1 +w1;


    fill(state*255);
    stroke(0);
    pushMatrix();
    translate(width/2, height/2);
    beginShape();
    // Outer circle
    for (int i = 0; i<=N; i++) {
      vertex(R*cos(i*(w2)/N + x2), R*sin(i*(w2)/N + x2));
    }

    // Inner circle
    //beginContour();
    for (int i = 0; i<=N; i++) {
      vertex(x1*cos((x2+w2)-i*(w2)/N), x1*sin((x2+w2)-i*(w2)/N));
    }
    //endContour();
    endShape(CLOSE);
    popMatrix();
  }
}
