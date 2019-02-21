/**Class which implements a shearing box approximation for computing local ring particle physics.
* @author Thomas Cann
* @version 1.0
*/

float num_particles = 1000;
//Simulation dimensions [m]
float Lx = 1000;       //Extent of simulation box along planet-point line [m].
float Ly = 2000;       //Extent of simulation box along orbit [m].
//Simulation Time step [s]
float dt =1e-4; 
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
//
final float Omega0 = 2.0*PI*sqrt((pow(r0,3))/GM);
final float S0 = -1.5*Omega0;

class ShearingBox {

    
    
    ArrayList<Particle> particles;
   
    /**CONSTUCTOR Shearing Box 
    */
    ShearingBox(){
    //Initialise our ShearingBox Object.
    particles = new ArrayList<Particle>(); 
    random_start();
    }

    /** 
    */
    void display(){
    for (Particle x : particles) {
      // Zero acceleration to start
      x.display();
    }
    }
    
    /** Method to update position
    */
    void update() {
      
      for (Particle x : particles) {
      // Zero acceleration to start
      x.update();
      }
      
    }
    /** Take a step using the Velocity Verlet (Leapfrog) ODE integration algorithm.
    */
    void step_verlet() {
      
      //Calculate first approximation for acceleration
      
      // Integrate to get approximation for new position and velocity
      
      
      
      //Calculate Second Approximation to the acceleration.
      
      //Intergrate to get final new position and velocity.
      
      //Have any particles left the simulation box, or collided with the moonlet?
      //If so, remove and replace them.
      
      
    }
    
    /** Computes self-gravity terms and adds them to an existing acceleration vector.
    */
    void calculate_self_grav() {
      for(int i = 0; i < particles.size(); i++) {
      //Compute relative positon of particle i from the others
      
      }
    }
    
    /** Method to inject a number of Particle object into Shearing Box.
    *@param n  Number of Particle to inject.
    */
    void random_inject(float n){
    
      for (int i = 0; i < n; i++) {
        particles.add(new Particle());
      }
      
    }
    
    /** Method to Initialise the simulation with a random set of starting particles at the edges (in y).
    */
    void random_start(){
      random_inject(num_particles);    
    }
    
    /** Method to calculate the Keplerian orbital period (using Kepler's 3rd law).
    *@param r  Radial position (semi-major axis) to calculate the period [m].
    *@return   The period [s].
    */
    float kepler_period(float r) {
     return 2.0*PI*sqrt((pow(r,3))/GM);
    }
    
    /** Method to calculate the Keplerian orbital angular frequency (using Kepler's 3rd law).
    *@param r  Radial position (semi-major axis) to calculate the period [m].
    *@return   The angular frequency [radians/s].
    */
    float kepler_omega(float r) {
     return sqrt(GM/(pow(r,3)));
    }
    
    /** Method to calculate the Keplerian orbital speed.
    *@param r  Radial position (semi-major axis) to calculate the period [m].
    *@return   The speed [m/s].
    */
    float kepler_speed(float r) {
     return sqrt(GM/r);
    }
    
    /** Method to calculate the Keplerian shear. Equal to -(3/2)Omega for a Keplerian orbit or -rdOmega/dr.
    *@param r Radial position (semi-major axis) to calculate the period [m]. 
    *@return Shear [radians/s].
    */
    float kepler_shear(float r) {
     return -1.5*kepler_omega(r);
    }
}
