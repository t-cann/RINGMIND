/**
 * RingSim
 * by Thomas Cann extends Chris Arridge work in python.
 *
 */
float time = 0 ;
float h_stepsize = 0.1;
float n_orboids = 10000;
float scale = 1;

//What are the minimum and maximum extents in r for initialisation
float r_min = 1.5*scale;
float r_max = 3.0*scale;
float vr_maxinitial = 0*scale;
float vtheta_maxinitial = 0.1*scale;

//How strong is the damping of radial motions?
float amp_rule_1 = 0.1*scale;

//How strong is the forcing to Keplerian motion?
float amp_rule_2 = 0.1*scale;

//How strong is random scattering?
float amp_rule_4 = 1e-5*scale;

//Where are the orbital resonances (ring gaps) and what is their width, and how
//strong is the gap. Larger values of w will make the gaps wider, larger values
//of s will make them emptier.
float r_res_a = 2.2*scale;
float w_res_a = 0.1*scale;
float s_res_a = 0.0005*scale;
float r_res_b = 2.8*scale;
float w_res_b = 0.01*scale;
float s_res_b = 0.5*scale;
float r_res_c = 1.8*scale;
float w_res_c = 0.01*scale;
float s_res_c = 0.5*scale;

// Spiral Density Wave effect
float amp_rule_5 = 1e-5;
float Q=2;
float r_gap=2.2;
float r_moon= r_gap*pow(Q,2/3);
float theta_moon = 0;
float vtheta_moon = sqrt(1/pow(r_moon,3));

// A boolean to track whether we are recording are not
boolean recording = false;

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
  
  theta_moon += vtheta_moon*h_stepsize;
  push();
  stroke(0);
  line(0,0, 400 * cos(theta_moon),400*sin(theta_moon));
  pop();
  for (Orboid x : orboids) {
    // Zero acceleration to start
    x.update();
  }
  time+= h_stepsize;
  println(time+ " ");
  
  if (mousePressed) {
    orboids.add(new Orboid(mouseX,mouseY));
  } 
  
  // If we are recording call saveFrame!
  // The number signs (#) indicate to Processing to 
  // number the files automatically
  if (recording) {
    saveFrame("output/frames####.png");
  }
   
  // Let's draw some stuff to tell us what is happening
  // It's important to note that none of this will show up in the
  // rendered files b/c it is drawn *after* saveFrame()
  textAlign(CENTER);
  fill(255);
  if (!recording) {
    text("Press r to start recording.", width/2, height-24);
  } 
  else {
    text("Press r to stop recording.", width/2, height-24);
  }
  
  // A red dot for when we are recording
  stroke(255);
  if (recording) {
    fill(255, 0, 0);
  } else { 
    noFill();
  }
  ellipse(width/2, height-48, 16, 16);
  
  //delay(100);

}

void keyPressed() {
  
  // If we press r, start or stop recording!
  if (key == 'r' || key == 'R') {
    recording = !recording;
  }
}
