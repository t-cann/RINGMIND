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
    this(0,0,0,0,0,0);
  }
  Particle(float r, float phi){
    this(r*cos(phi),r*sin(phi),0,sqrt(GMp/(r))*sin(phi),-sqrt(GMp/(r))*cos(phi),0);
  }

  void display() {
  
  }
  
  void update() {
  
  }
}
