/**
 * ShearBoxSim
 * by Thomas Cann extends Chris Arridge work in python.
 *
 */

float num_particles = 2000;
//Simulation dimensions [m]
float Lx = 1000;
float Ly = 2000;

//ArrayList<Orboid> orboids;

void setup () {
  size (1000, 500);
  
  //orboids = new ArrayList<Orboid>();
  
  //for (int i = 0; i < n_orboids; i++) {
  //  orboids.add(new Orboid());
  //}
} 

void draw () {
  translate(width/2, height/2);
  background (255); 
  
  //for (Orboid x : orboids) {
  //  // Zero acceleration to start
  //  x.update();
  //}
  
  if (mousePressed) {
  //  orboids.add(new Orboid(mouseX,mouseY));
  } 
}
