//class Orboid

class Orboid extends Particle {

  float r_orboid;
  float phi_orboid;
  float v_orboid;

  Orboid() {
    // Initialise our Orboids.
    super((random(1)*(r_max-r_min) + r_min)*Rp,random(1)*2.0*PI);
    //r_orboid = (random(1)*(r_max-r_min) + r_min)*Rp;
    //phi_orboid = random(1)*2.0*PI;
    //x1=r_orboid*cos(phi_orboid);
    //x2=r_orboid*sin(phi_orboid);
    //v1=sqrt(GMp/(r_orboid))*sin(phi_orboid);
    //v2=-sqrt(GMp/(r_orboid))*cos(phi_orboid);
    
    
    //r_orboid = (random(1)*(r_max-r_min) + r_min)*Rp;
    //phi_orboid = random(1)*2.0*PI;
    //x1 = r_orboid*cos(phi_orboid);
    //x2 = r_orboid*sin(phi_orboid);
    //v1 = sqrt(GMp/(r_orboid))*sin(phi_orboid);
    //v2 = -sqrt(GMp/(r_orboid))*cos(phi_orboid);
    //v_orboid = sqrt(sq(v1)+sq(v2));
  }

  //Constructor so we can add orboids with mouse
  Orboid(int MouseX, int MouseY) {
    //Initialise our Orboids.
    float radius = sqrt(sq(MouseX -(width/2)) + sq(MouseY-(height/2)));
    float angle = atan2(float(MouseY-height/2), float(MouseX-width/2));
    r_orboid = radius;
    phi_orboid = angle;
    //vr = random(1)*vr_maxinitial;
    //vtheta = random(1)*vtheta_maxinitial;
  }

  void display() {
    //translate(width/2, height/2);
    fill(255);
    stroke(255);
    point(scale*x1,scale*x2);
  }
  
  float Etot_orboid() {
    float PE_orboid = 1*GMp/r_orboid;
    float KE_orboid = 1*(pow(v_orboid, 2))/2;
    return PE_orboid + KE_orboid;
  }

  //update method
  void update() {

    // acceleration functions
    float ax_grav = (-GMp*x1/pow(sqrt(sq(x1) + sq(x2)), 3.0))*1.0;
    float ay_grav = (-GMp*x2/pow(sqrt(sq(x1) + sq(x2)), 3.0))*1.0;
    // temp x and y positions
    float x1_orboid;
    float y1_orboid;

    // leapfrog integration
    x1_orboid = x1 + v1*h_stepsize + 0.5*ax_grav*h_stepsize*h_stepsize;
    y1_orboid = x2 + v2*h_stepsize + 0.5*ay_grav*h_stepsize*h_stepsize;
    
    float ax_grav1 = (-GMp*x1_orboid/pow(sqrt(sq(x1_orboid) + sq(y1_orboid)), 3.0))*1.0;
    float ay_grav1 = (-GMp*y1_orboid/pow(sqrt(sq(x1_orboid) + sq(y1_orboid)), 3.0))*1.0;
    
    v1 = v1 + 0.5*(ax_grav+ax_grav1)*h_stepsize;
    v2 = v2 + 0.5*(ay_grav+ay_grav1)*h_stepsize;
    x1 = x1_orboid;
    x2 = y1_orboid;
    v_orboid = sqrt(sq(v1)+sq(v2));
    
    //print(v_orboid+" ");
    display();
  }
}
