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
  r_orboid = (random(n_orboids)*(r_max-r_min) + r_min)*Rp;
  phi_orboid = random(n_orboids)*2.0*np.pi;
  x_orboid = r_orboid*cos(phi_orboid);
  y_orboid = r_orboid*sin(phi_orboid);
  vx_orboid = sqrt(GM/(r_orboid))*sin(phi_orboid);
  vy_orboid = -sqrt(GM/(r_orboid))*cos(phi_orboid);
  v_orboid = np.zeros((n_steps+1, 10));
  v_orboid[0, :] = sqrt(sq(vx_orboid[0:10])+sq(vy_orboid[0:10]));
  }
  
  //Constructor so we can add orboids with mouse
      Orboid(int MouseX, int MouseY){
      //Initialise our Orboids.
      float radius =sqrt(sq(MouseX -(width/2)) + sq(MouseY-(height/2)));
      float angle = atan2(float(MouseY-height/2), float(MouseX-width/2));
      r_orboid = radius;
      phi_orboid = angle;
      //vr = random(1)*vr_maxinitial;
      //vtheta = random(1)*vtheta_maxinitial;
    }
}
