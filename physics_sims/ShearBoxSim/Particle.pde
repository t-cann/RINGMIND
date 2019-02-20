/**Represents a Particle
* @author Thomas Cann
* @version 1.0
*/

class Particle {
    
    //position vector
    float x;
    float y;
    //velocity vector
    float vx;
    float vy;

    float rho;
    float a;
    float b;
    float lambda;
    float D;
    float C;
    
    /**CONSTUCTOR Particle
    * @param rho 
    * @param a  Minimum size of a ring particle [m].
    * @param b  Maximum size of a ring particle [m].
    * @param lambda ower law index for the size distribution [dimensionless].
    * @param D 
    * @param C
    */
    Particle(float rho, float a, float b, float lambda){
      //Initialise a Particle Object.
      this.rho =rho;
      this.a = a;
      this.b = b;
      this.lambda = lambda;
      this.D=1.0/( exp(-this.lambda*this.a) -exp(-this.lambda*this.b));
      this.C= this.D * exp(-this.lambda*this.a);  
    }

    /**CONSTUCTOR Particle
    */
    Particle(){
      //Initialise default Particle Object.
      this(1000.0,0.95,1.05,1e-6);
           
    }
}
