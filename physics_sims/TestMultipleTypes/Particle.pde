
class Particle {

  float x1, x2, x3;      // Position
  float v1, v2, v3;      // Velocity
  float a1, a2, a3;      // Acceleration
  
  color c = color(255, 0, 0);

  Particle() {
    //Default Position
    x1=random(width);
    x2=random(height);
    x3=10;
    //Default Velocity
    v1=0.0;
    v2=0.0;
    v3=0.0;
    //Default Acceleration
    a1=0.0;
    a2=0.0;
    a3=0.0;
  }

 void display() {
    fill(c);
    stroke(c);
    circle(x1,x2,x3);
  }
  
 void update(ArrayList<Particle> p){
 //for(Particle x:p){
 //  x1 = x1-x.x1 ;
 //}
 }
  
}
