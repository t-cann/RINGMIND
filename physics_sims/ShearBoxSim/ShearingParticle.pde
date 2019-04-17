/**Represents a Particle
 * @author Thomas Cann
 * @version 1.0
 */

float scale =10.0; //Makes Particles Visible

class Particle {


  PVector position; //position vector
  //position.x;    //Position of Particle along planet-point line relative to moonlet [m].
  //position.y;    //Position of Particle along along orbit relative to moonlet [m].
  PVector velocity; //velocity vector
  PVector acceleration; //accleration vector


  //ShearParticle Properties
  float radius;
  float GM;
  float m;
  
  boolean highlight= false;



  /**CONSTUCTOR Particle
   */
  Particle() {
    //Initialise default Particle Object.
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    //
    position.x= (random(1)-0.5)*Lx;
    //
    if (position.x >0) {
      position.y = -Ly/2;
    } else if (position.x ==0) {
      position.y =0; //Think about this !!
    } else {
      position.y = Ly/2;
    }
    //  
    velocity.x = 0;
    velocity.y = 1.5 * Omega0 * position.x;
    //
    this.radius = - log((particle_C-random(1.0))/particle_D)/particle_lambda;
    this.GM = G* (4.0*PI/3.0)*pow(radius, 3.0)*particle_rho;
    m= PI*pow(radius, 3.0)*4.0/3.0;
  }


  /**Method to Display Particle
   */
  void display() {
    push();
    if(!highlight){
    fill(255, 0, 0);
    stroke(255, 0, 0);
    } else { 
    fill( 0);
    stroke(0);
    }
    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    //ellipse(-y*width/Ly,-x*height/Lx,20, 20); //Debugging
    //println(radius);
    //displayPosition(position,1,color(255,0,0));
    if(Guides){
    translate(-position.y*width/Ly,-position.x*height/Lx);
    circle(0,0,2*scale*radius*width/Ly);
    displayPVector(velocity,1000,color(0,255,0));
    displayPVector(acceleration,1000000,color(0,0,255));}else{
    ellipse(-position.y*width/Ly, -position.x*height/Lx, 2*scale*radius*width/Ly, 2*scale*radius*height/Lx);
    }
    pop();
    
  }
  void displayPosition(PVector v, float scale, color c){
    stroke(c);
    line(0,0,-v.y*scale*width/Ly,-v.x*scale*height/Lx);
  } 
  void displayPVector(PVector v, float scale, color c){
    stroke(c);
    line(0,0,-v.y*scale,-v.x*scale);
  }


  /**
   *  Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
   */
  PVector getAcceleration(ShearingBox sb) {

    // acceleration due planet in centre of the ring. 
    PVector a_grav = new PVector();

    if(A1){
    a_grav.x += 2.0*Omega0*S0*position.x;
    }
    if(A2){
    a_grav.x += 2.0*Omega0*velocity.y;
    a_grav.y += -2.0*Omega0*velocity.x;
    }
    if (Moonlet) {
      float moonlet_GMr3 = moonlet_GM/pow(position.mag(), 3.0);
      a_grav.x += -moonlet_GMr3*position.x;
      a_grav.y += -moonlet_GMr3*position.y;
    }

    if (Self_Grav) {
      for (Particle p : sb.particles) {
        if (p!=this) {
          PVector distanceVect = PVector.sub(position.copy(), p.position.copy());
          
          // Calculate magnitude of the vector separating the balls
          float distanceVectMag = distanceVect.mag();
          if (distanceVectMag > radius+p.radius){
          distanceVect = distanceVect.mult(p.GM /pow(distanceVectMag, 3));
          a_grav.x+= -distanceVect.x ;
          a_grav.y+=-distanceVect.y;
          }
        }
      }
    }
    //PVector.mult(position.copy().normalize(), -GMp/position.copy().magSq())

    return a_grav;
  }

  /**
   *
   */
  void set_getAcceleration(ShearingBox sb) {
    acceleration = getAcceleration(sb);
  }

  /**
   *
   */
  void updatePosition() {
    position.add(velocity.copy().mult(dt)).add(acceleration.copy().mult(0.5*sq(dt)));
  }

  /**
   *    Updates the velocity of this Ring Particle (Based on Velocity Verlet) using 2 accelerations.  
   */
  void updateVelocity(PVector a) {
    this.velocity.add(PVector.add(acceleration.copy(), a).mult(0.5 *dt));
  }

  ///** Computes self-gravity terms and adds them to an existing acceleration vector.
  // */
  //void calculate_self_grav(ShearingBox sb) {   

  //  for (Particle x : sb.particles) {
  //        // Against every other Particle in the grid
  //        for (Particle other : sb.particles) {
  //          // As long as its not the same one
  //          if (other != x) {
  //          //Adding Self Gravity
  //            //x.update_acceleration(other);
  //          }
  //        }
  //      }
  //}

  ///**Method to Update Particle
  // */
  //void update_position() {
  //  //Updates postions
  //  position.x += velocity.x*dt+ 0.5 *acceleration.x*pow(dt, 2);
  //  position.y += velocity.y*dt+ 0.5 *acceleration.y*pow(dt, 2);
  //}
  //void update_velocity() {
  //  //Updates velocities
  //  velocity.x += acceleration.x*dt;
  //  velocity.y += acceleration.y*dt;
  //}
  ///** Method to update the acceleration on this particle due to Moonlet (TODO Extend Particle into Moonlet and ShearParticle)
  // */
  //void update_acceleration() {
  //  float moonlet_GMr3 = moonlet_GM/pow(position.mag(), 3);
  //  acceleration.x+=2*Omega0*S0*position.x+2*Omega0*velocity.y-moonlet_GMr3*position.x;
  //  acceleration.y+=-2*Omega0*velocity.x-moonlet_GMr3*position.y;
  //}
  ///** Method to update the acceleration on this particle due to Moonlet (TODO Extend Particle into Moonlet and ShearParticle)
  // */
  //void update_acceleration(Particle other) {
  //  PVector distanceVect = PVector.sub(position.copy(), other.position.copy());
  //  // Calculate magnitude of the vector separating the balls
  //  float distanceVectMag = distanceVect.mag();
  //  distanceVect = distanceVect.mult(other.GM /pow(distanceVectMag, 3));
  //  acceleration.x+= distanceVect.x ;
  //  acceleration.y+=-distanceVect.y;
  //}

  void Reset() {
    acceleration.x=0;
    acceleration.y=0;
    //
    position.x= (random(1)-0.5)*Lx;
    //
    if (position.x >0) {
      position.y = -Ly/2;
    } else if (position.x ==0) {
      position.y =0; //Think about this !!
    } else {
      position.y = Ly/2;
    }
    //  
    velocity.x = 0;
    velocity.y = 1.5 * Omega0 * position.x;
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

class Moonlet extends Particle {

  Moonlet(){
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    this.radius = moonlet_r ;
    this.GM = moonlet_GM;
    m= PI*pow(radius, 3.0)*4.0/3.0;
  }

}
