/**
 * ShearBoxSim
 * by Thomas Cann extends Chris Arridge work in python.
 *
 */

float num_particles = 2000;
//Simulation dimensions [m]
float Lx = 1000;       //Extent of simulation box along planet-point line [m].
float Ly = 2000;       //Extent of simulation box along orbit [m].
//Simulation Time step [s]
float dt =100; 
//Initialises Simulation Constants
final float GM = 3.793e16;   //Gravitational parameter for the central body, defaults to Saturn  GM = 3.793e16.
final float r0 = 130000e3;   //Central position in the ring [m]. Defaults to 130000 km.
//Ring Particle Properties
final float particle_rho = 900.0;  //Density of a ring particle [kg/m^3].
final float particle_a = 0.01;     //Minimum size of a ring particle [m].
final float particle_b = 10.0;     //Maximum size of a ring particle [m].
final float particle_lambda = 5;   //Power law index for the size distribution [dimensionless].
final float particle_D =1.0/( exp(-particle_lambda*particle_a) -exp(-particle_lambda*particle_b));
final float particle_C =particle_D * exp(-particle_lambda*particle_a);
//Ring Moonlet Properties
final float moonlet_r = 50.0;        //Radius of the moonlet [m].
final float moonlet_density = 900.0; //Density of the moonlet [kg/m]
final float moonlet_GM = 6.67408e-11*(4*PI/3)*pow(moonlet_r,3)*moonlet_density; //Standard gravitational parameter.


//ArrayList<Orboid> orboids;

void setup () {
  size (1000, 500);
  ShearingBox s = new ShearingBox(width, height);
  
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
