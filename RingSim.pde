/**
 * RingSim
 * by Thomas Cann extends Chris A work in python.
 *
 */

float h_stepsize = 0.01;
float n_orboids = 10000;
float scale = 1;

//What are the minimum and maximum extents in r for initialisation
float r_min = 1.5*scale;
float r_max = 3.0*scale;
float vr_maxinitial = 0.01*scale;
float vtheta_maxinitial = 0.01*scale;

//How strong is the damping of radial motions?
float amp_rule_1 = 0.5*scale;

//How strong is the forcing to Keplerian motion?
float amp_rule_2 = 0.01*scale;

//How strong is random scattering?
float amp_rule_4 = 1e-3*scale;

//Where are the orbital resonances (ring gaps) and what is their width, and how
//strong is the gap. Larger values of w will make the gaps wider, larger values
//of s will make them emptier.
float r_res_a = 2.2*scale;
float w_res_a = 0.5*scale;
float s_res_a = 0.005*scale;
float r_res_b = 2.8*scale;
float w_res_b = 0.01*scale;
float s_res_b = 0.5*scale;
float r_res_c = 1.8*scale;
float w_res_c = 0.01*scale;
float s_res_c = 0.5*scale;


ArrayList<Orboid> orboids;

void setup () {
  size (900, 900);
  
  orboids = new ArrayList<Orboid>();
  
  for (int i = 0; i < n_orboids; i++) {
    orboids.add(new Orboid());
  }
} 

void draw () {
  translate(width/2, height/2);
  background (255); 
  
  for (Orboid x : orboids) {
    // Zero acceleration to start
    x.update();
  }
  
  if (mousePressed) {
    orboids.add(new Orboid(mouseX,mouseY));
  } 
  
  //delay(100);

}
