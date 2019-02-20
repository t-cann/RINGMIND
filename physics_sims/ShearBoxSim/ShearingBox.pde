//class Orboid

class ShearingBox {

    float GM;  //Gravitational parameter for the central body.
    float r0;  //Central position in the ring [m].
    float Lx;  //Extent of simulation box along planet-point line [m].
    float Ly;  //Extent of simulation box along orbit [m].
    
    ShearingBox(float GM, float r0, float Lx, float Ly){
      //Initialise our ShearingBox Object.
      this.GM = GM;
      this.r0 = r0;
      this.Lx = Lx;
      this.Ly = Ly;
    }
    ShearingBox(){
      //Initialise our Default ShearingBox Object.
      this.GM = 3.793e16;   //Defaults to Saturn.
      this.r0 = 130000e3;   //Defaults to 130000 km.
      this.Lx = 1e3;        //Defaults to 1 km.
      this.Ly = 1e3;        //Defaults to 1 km.
    }
    /** 
    */
    void display(){
      
    }
    
    /** Method to update position
    */
    void update() {
    
    }
}
