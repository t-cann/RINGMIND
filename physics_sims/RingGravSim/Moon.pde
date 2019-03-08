// Moon class

class Moon extends Orboid {

  float GM_Mima = 2.529477495e9;
  float radius_Mima = 200e3;
  float radius = 185.52e6;


  Moon() {
    super();
    r_orboid = radius;
    phi_orboid = random(1)*2.0*PI;
    x_orboid = r_orboid*cos(phi_orboid);
    y_orboid = r_orboid*sin(phi_orboid);
    vx_orboid = sqrt(GM/(r_orboid))*sin(phi_orboid);
    vy_orboid = -sqrt(GM/(r_orboid))*cos(phi_orboid);
    v_orboid = sqrt(sq(vx_orboid)+sq(vy_orboid));
}
  
  
  void display() {
    ellipseMode(CENTER);
    fill(255);
    stroke(255);
    circle(scale*x_orboid, scale*y_orboid, 2*radius_Mima*scale);
  }
}
