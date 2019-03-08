//class Orboid

class Orboid {

  float r_orboid;
  float phi_orboid;
  float x_orboid;
  float y_orboid;
  float vx_orboid;
  float vy_orboid;
  float v_orboid;

  Orboid() {
    // Initialise our Orboids.
    r_orboid = (random(1)*(r_max-r_min) + r_min)*Rp;
    phi_orboid = random(1)*2.0*PI;
    x_orboid = r_orboid*cos(phi_orboid);
    y_orboid = r_orboid*sin(phi_orboid);
    vx_orboid = sqrt(GM/(r_orboid))*sin(phi_orboid);
    vy_orboid = -sqrt(GM/(r_orboid))*cos(phi_orboid);
    v_orboid = sqrt(sq(vx_orboid)+sq(vy_orboid));
  }

  //Constructor so we can add orboids with mouse
  Orboid(int MouseX, int MouseY) {
    //Initialise our Orboids.
    float x = (MouseX -(width/2))/scale;
    float y = (MouseY -(height/2))/scale;
    float radius = sqrt(sq(x) + sq(y));
    float angle = atan2(y, x);
    float vx = sqrt(GM/(radius))*sin(angle);
    float vy = -sqrt(GM/(radius))*cos(angle);
    r_orboid = radius;
    phi_orboid = angle;
    x_orboid = x;
    y_orboid = y;
    vx_orboid = vx;
    vy_orboid = vy;
  }

  void display() {
    //translate(width/2, height/2);
    fill(255);
    stroke(255);
    point(scale*x_orboid, scale*y_orboid);
  }

  float Etot_orboid() {
    float PE_orboid = 1*GM/r_orboid;
    float KE_orboid = 1*(pow(v_orboid, 2))/2;
    return PE_orboid + KE_orboid;
  }

  //update method
  void update() {

    // acceleration functions
    float ax_grav = (-GM*x_orboid/pow(sqrt(sq(x_orboid) + sq(y_orboid)), 3.0))*1.0;
    float ay_grav = (-GM*y_orboid/pow(sqrt(sq(x_orboid) + sq(y_orboid)), 3.0))*1.0;
    // temp x and y positions
    float x1_orboid;
    float y1_orboid;

    // leapfrog integration
    x1_orboid = x_orboid + vx_orboid*h_stepsize + 0.5*ax_grav*h_stepsize*h_stepsize;
    y1_orboid = y_orboid + vy_orboid*h_stepsize + 0.5*ay_grav*h_stepsize*h_stepsize;

    float ax_grav1 = (-GM*x1_orboid/pow(sqrt(sq(x1_orboid) + sq(y1_orboid)), 3.0))*1.0;
    float ay_grav1 = (-GM*y1_orboid/pow(sqrt(sq(x1_orboid) + sq(y1_orboid)), 3.0))*1.0;

    vx_orboid = vx_orboid + 0.5*(ax_grav+ax_grav1)*h_stepsize;
    vy_orboid = vy_orboid + 0.5*(ay_grav+ay_grav1)*h_stepsize;
    x_orboid = x1_orboid;
    y_orboid = y1_orboid;
    v_orboid = sqrt(sq(vx_orboid)+sq(vy_orboid));

    //print(v_orboid+" ");
    display();
  }
}
