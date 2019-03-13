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
    ellipseMode(CENTER);
    fill(255, 0, 0);
    stroke(255, 0, 0);
    circle(scale*position.x, scale*position.y, 2*radius*scale);
  }
}
