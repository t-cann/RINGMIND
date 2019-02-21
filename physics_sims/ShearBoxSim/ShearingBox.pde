/**Class which implements a shearing box approximation for computing local ring particle physics.
* @author Thomas Cann
* @version 1.0
*/

class ShearingBox {

    ArrayList<Particle> particles;
   
    /**CONSTUCTOR Shearing Box 
    */
    ShearingBox(float w, float h){
      //Initialise our ShearingBox Object.
      
    }

    /** 
    */
    void display(){
      
    }
    
    /** Method to update position
    */
    void update() {
    
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
