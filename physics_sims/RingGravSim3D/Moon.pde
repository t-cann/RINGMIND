// Moon class

class Moon extends Particle {
  float GM;
  float radius;

  Moon() {
    //Mima
    this(2.529477495e13, 400e3, 185.52e6);
  }

  Moon(float Gm, float radius, float orb_radius) {
    super(orb_radius, random(2*PI));
    this.GM=Gm;
    this.radius=radius;
  }

  void display() {

    fill(255, 255, 255);
    //stroke(255, 0, 0);
    //push();

    translate(scale*x1, scale*x2);
    sphere(10*radius*scale);
    //pop();
  }
}
