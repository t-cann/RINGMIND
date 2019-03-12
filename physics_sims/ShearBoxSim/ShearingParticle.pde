/**Represents a Particle
 * @author Thomas Cann
 * @version 1.0
 */

class Particle {

  //position vector
  float x;    //Position of Particle along planet-point line relative to moonlet [m].
  float y;    //Position of Particle along along orbit relative to moonlet [m].
  //velocity vector
  float vx;
  float vy;
  //accleration vector
  float ax=0;
  float ay=0;

  //ShearParticle Properties
  float radius;
  float GM;
  float m;

  /**CONSTUCTOR Particle
   */
  Particle() {
    //Initialise default Particle Object.

    //
    x= (random(1)-0.5)*Lx;
    //
    if (x >0) {
      y = -Ly/2;
    } else if (x ==0) {
      y =0; //Think about this !!
    } else {
      y = Ly/2;
    }
    //  
    vx = 0;
    vy = 1.5 * Omega0 * x;
    //
    this.radius = - log((particle_C-random(1))/particle_D)/particle_lambda;
    this.GM = G* (4*PI/3)*pow(radius, 3)*particle_rho;
    m= PI*pow(radius, 3)*4.0/3.0;
  }


  /**Method to Display Particle
   */
  void display() {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    //ellipse(-y*width/Ly,-x*height/Lx,20, 20); //Debugging
    //println(radius);
    float scale =10; //Makes Particles Visible
    ellipse(-y*width/Ly, -x*height/Lx, 2*scale*radius*width/Ly, 2*scale*radius*height/Lx);
  }
  /**Method to Update Particle
   */
  void update_position() {
    //Updates postions
    x += vx*dt+ 0.5 *ax*pow(dt, 2);
    y += vy*dt+ 0.5 *ay*pow(dt, 2);
  }
  void update_velocity() {
    //Updates velocities
    vx += ax*dt;
    vy += ay*dt;
  }

  /** Method to update the acceleration on this particle due to Moonlet (TODO Extend Particle into Moonlet and ShearParticle)
   */
  void update_acceleration() {
    float moonlet_GMr3 = moonlet_GM/pow(sqrt(pow(x, 2)+pow(y, 2)), 3);
    ax+=2*Omega0*S0*x+2*Omega0*vy-moonlet_GMr3*x;
    ay+=-2*Omega0*vx-moonlet_GMr3*y;
  }
  /** Method to update the acceleration on this particle due to Moonlet (TODO Extend Particle into Moonlet and ShearParticle)
   */
  void update_acceleration(Particle other) {
    PVector distanceVect = PVector.sub(new PVector(x, y), new PVector(other.x, other.y));
    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();
    distanceVect = distanceVect.mult(other.GM /pow(distanceVectMag, 3));
    ax+= distanceVect.x ;
    ay+=-distanceVect.y;
  }

  void Reset() {
    ax=0;
    ay=0;
    //
    x= (random(1)-0.5)*Lx;
    //
    if (x >0) {
      y = -Ly/2;
    } else if (x ==0) {
      y =0; //Think about this !!
    } else {
      y = Ly/2;
    }
    //  
    vx = 0;
    vy = 1.5 * Omega0 * x;
    //
    this.radius = - log((particle_C-random(1))/particle_D)/particle_lambda;
    this.GM = G* (4*PI/3)*pow(radius, 3)*particle_rho;
  }
}

//TODO

///**CONSTUCTOR Particle
//* @param rho 
//* @param a  Minimum size of a ring particle [m].
//* @param b  Maximum size of a ring particle [m].
//* @param lambda ower law index for the size distribution [dimensionless].
//* @param D 
//* @param C
//*/
//Particle(float rho, float a, float b, float lambda){
//  //Initialise a Particle Object.
//  this.rho =rho;
//  this.a = a;
//  this.b = b;
//  this.lambda = lambda;
//  this.D=1.0/( exp(-this.lambda*this.a) -exp(-this.lambda*this.b));
//  this.C= this.D * exp(-this.lambda*this.a);  
//}

//    /**CONSTUCTOR Particle
//*/
//Particle(){
//  //Initialise default Particle Object.
//  this(1000.0,0.95,1.05,1e-6);

//}
