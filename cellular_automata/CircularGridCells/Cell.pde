/** 
 *
 * Purpose:  Circlar Grid Cell without using arc function.
 *
 * Cell has a coordinate of inner couner and size in both radial and angular directions.
 *            
 * @author Thomas Cann
 * @version 1.1
 */

class Cell {

  protected float x1, x2; //r and theta
  protected float w1, w2; //dr and dtheta
  protected float N; // Nu

  ArrayList<PVector> Cell = new ArrayList<PVector>(); 

  float state;

  /**
   * This is a constructor for a Circlar Grid Cell.
   *
   * @param r_ the inner radius of grid cell. [pixels]
   * @param theta_ the initial angle of grid cell. [degrees]
   * @param dr_ the radial size of the grid cell. [pixels]
   * @param dtheta_ the angular size of the grid cell. [degrees]
   */

  Cell(float r_, float theta_, float dr_, float dtheta_) {
    this.x1 = r_;
    this.x2 = theta_;
    this.w1 = dr_;
    this.w2 = dtheta_;
    state = random(2);
    N = x1*w2;

    float R= x1 +w1;

    for (float angle = x2; angle <= (x2+w2); angle += 2) {
      // Note we are not starting from 0 in order to match the
      // path of a circle.  
      PVector v = PVector.fromAngle(radians(angle));
      v.mult(R);
      Cell.add(v);
    }

    for (float angle = x2+w2; angle >= (x2); angle -= 2) {
      // Note we are not starting from 0 in order to match the
      // path of a circle.  
      PVector v = PVector.fromAngle(radians(angle));
      v.mult(x1);
      Cell.add(v);
    }
  }

  /**
   * This method displays the object on the screen relative to centre of the screen.
   */
  void display() {
    
    fill(state*255);
    stroke(0);
    strokeWeight(2);
    pushMatrix();
    translate(width/2, height/2);
    beginShape();

    for (PVector v : Cell) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
  /**
   * This method displays the object on the screen relative to centre of the screen.
   */
  void display_Old() {

    float R= x1 +w1;

    fill(state*255);
    stroke(0);
    strokeWeight(1);
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
