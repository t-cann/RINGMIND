//class Orboid

class Orboid {

    float r;
    float theta;
    float vr;
    float vtheta;
    float ar;
    float atheta;
    float scale =100;
    
    Orboid(){
      //Initialise our Orboids.
      //r = random(1)*(r_max-r_min) + r_min;
      //theta = random(1)*2.0*PI;
      //vr = random(1)*vr_maxinitial;
      //vtheta = random(1)*vtheta_maxinitial;
    }
    Orboid(int MouseX, int MouseY){
      //Initialise our Orboids.
      float radius =sqrt(sq(MouseX -(width/2)) + sq(MouseY-(height/2)));
      float angle = atan2(float(MouseY-height/2), float(MouseX-width/2));
      r = radius/scale;
      theta = angle;
      //vr = random(1)*vr_maxinitial;
      //vtheta = random(1)*vtheta_maxinitial;
    }
    
    void display(){
    fill(255,0,0);
    stroke(255,0,0);
    //stroke(0);
    //strokeWeight(2);
    
    point(scale *r*cos(theta), scale*r*sin(theta));
    //ellipse(r*cos(theta),r*sin(theta) , 100, 100);
    
    //print(" x: " + r*cos(theta));
    //print(" y: " + r*sin(theta));
    //println();
    
    
    }
    
    
    // Method to update position
    void update() {
    //Zero acceleration to start
    ar=0;
    atheta=0;
    //Apply rule 1: we damp out any motions towards/away from the planet
    //ar = -amp_rule_1*vr;
    
    ////Apply rule 2: orboids want to move at Keplerian speed for their orbital distance.
    //atheta = -amp_rule_2*(vtheta - sqrt(1/r))/r;    // theta is an angle, this is basically v=r*omega since aphi is an angular acceleration

    //// Apply rule 3: orboids are pushed away from resonance sites
    //ar += a_ringgap(r,r_res_a,w_res_a)*s_res_a;
    //ar += a_ringgap(r,r_res_b,w_res_b)*s_res_b;
    //ar += a_ringgap(r,r_res_c,w_res_c)*s_res_c;
    
    //// Apply rule 4: there is a small amount of natural scattering in random directions.
    
    //vr += (random(1)-0.5)*amp_rule_4;
    //vtheta += (random(1)-0.5)*amp_rule_4;
    
    //// Update velocities and positons
    //vr += ar*h_stepsize;
    //vtheta += atheta*h_stepsize;
    //r += vr*h_stepsize;
    //theta += vtheta*h_stepsize;
    
    //print(" r: " + r);
    //print(" theta: " + theta);
    //print(" vr: " + vr);
    //print(" vtheta: " + vtheta);
    //print(" ar: " + ar);
    //print(" atheta: " + atheta);
    //println();
    
    display();

    }
    
    float a_ringgap(float r, float r_gap, float w_gap){
      // Converted in Java np.exp(-((r-r_gap)/w_gap)**2)*np.sign(r-r_gap)

      float temp_a;
      if(r-r_gap >0){
        temp_a = exp(-(pow(((r-r_gap)/w_gap),2)));
      } else if(r-r_gap ==0){
        temp_a =0;
      } else {
        temp_a = exp(-(pow(((r-r_gap)/w_gap),2)))*-1;
      }
      return temp_a;
    }
    }
