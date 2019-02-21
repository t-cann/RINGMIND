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
    
    /**CONSTUCTOR Particle
    */
    Particle(){
    //Initialise default Particle Object.
      
    //
    x= (random(1)-0.5)*Lx;
    //
    if(x >0){
        y = -Ly/2;
      } else if(x ==0){
        y =0; //Think about this !!
      } else {
        y = Ly/2;
      }
    //  
    vx = 0;
    vy = 1.5 * Omega0 * x;
    //
    this.radius = - log((particle_C-random(1))/particle_D)/particle_lambda;
    this.GM = 6.67408e-11* (4*PI/3)*pow(radius,3)*particle_rho;
    }
    
    /**Method to Display Particle
    */
    void display(){
    fill(255,0,0);
    stroke(255,0,0);
    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    //ellipse(-y*width/Ly,-x*height/Lx,20, 20); //Debugging
    //println(radius);
    float scale =1; //Makes Particles Visible
    ellipse(-y*width/Ly,-x*height/Lx,2*scale*radius*width/Ly, 2*scale*radius*height/Lx);
    }
    /**Method to Update Particle
    */
    void update(){
    //Updates postions
    x += vx*dt+ 0.5 *ax*pow(dt,2);
    y += vy*dt+ 0.5 *ay*pow(dt,2);
    //Updates velocities
    vx += ax*dt;
    vy += ay*dt;
    }
    
    void Reset(){
      
    //
    x= (random(1)-0.5)*Lx;
    //
    if(x >0){
        y = -Ly/2;
      } else if(x ==0){
        y =0; //Think about this !!
      } else {
        y = Ly/2;
      }
    //  
    vx = 0;
    vy = 1.5 * Omega0 * x;
    //
    this.radius = - log((particle_C-random(1))/particle_D)/particle_lambda;
    this.GM = 6.67408e-11* (4*PI/3)*pow(radius,3)*particle_rho;
      
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
