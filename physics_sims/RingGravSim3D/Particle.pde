// Particle Class

class Particle {

  float x1, x2, x3;      // Position
  float v1, v2, v3;      // Velocity

  Particle(float x1_, float x2_, float x3_, float v1_, float v2_, float v3_) {
    //default position
    x1 = x1_;
    x2 = x2_;
    x3 = x3_;
    //default velocity
    v1 = v1_;
    v2 = v2_;
    v3 = v3_;
  }
  Particle() {
    this(0, 0, 0, 0, 0, 0);
  }
  Particle(float r, float phi) {
    this(r*cos(phi), r*sin(phi), 0, sqrt(GMp/(r))*sin(phi), -sqrt(GMp/(r))*cos(phi), 0);
  }
  
  

  void display() {
  }

  void update() {
    // acceleration functions
    float ax_grav = (-GMp*x1/pow(sqrt(sq(x1) + sq(x2)), 3.0))*1.0;
    float ay_grav = (-GMp*x2/pow(sqrt(sq(x1) + sq(x2)), 3.0))*1.0;
    
    // temp x and y positions
    float x1_temp;
    float y1_temp;

    // leapfrog integration
    x1_temp = x1 + v1*h_stepsize + 0.5*ax_grav*h_stepsize*h_stepsize;
    y1_temp = x2 + v2*h_stepsize + 0.5*ay_grav*h_stepsize*h_stepsize;

    float ax_grav1 = (-GMp*x1_temp/pow(sqrt(sq(x1_temp) + sq(y1_temp)), 3.0))*1.0;
    float ay_grav1 = (-GMp*y1_temp/pow(sqrt(sq(x1_temp) + sq(y1_temp)), 3.0))*1.0;

    v1 = v1 + 0.5*(ax_grav+ax_grav1)*h_stepsize;
    v2 = v2 + 0.5*(ay_grav+ay_grav1)*h_stepsize;
    x1 = x1_temp;
    x2 = y1_temp;

    display();
  }
  
 
}
