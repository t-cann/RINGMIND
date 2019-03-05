// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Cell {

  float x1, x2; //r and theta
  float w1, w2; //dr and dtheta
  float N =20;
  
  int state;
  
  Cell(float x_, float y_, float w1_, float w2_) {
    x1 = x_;
    x2 = y_;
    w1 = w1_;
    w2 = w2_;

    state = int(random(2));
  }


  void display() {
    float R= x1 +w1;
  
    
    fill(state*255);
    stroke(0);
    pushMatrix();
    translate(width/2,height/2);
    beginShape();
    // Outer circle
    for(int i = 0; i<=N; i++) {
     vertex(R*cos(i*(x2+w2)/N+ x2),R*sin(i*(x2+w2)/N + x2));
    }
 
  // Inner circle
  beginContour();
   for(int i = 0; i<=N; i++) {
    vertex(x1*cos((x2+w2)-i*(x2+w2)/N),x1*sin((x2+w2)-i*(x2+w2)/N));
   }
  endContour();
    endShape(CLOSE);
    popMatrix();
  }
}
