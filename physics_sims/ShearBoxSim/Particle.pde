//class Particle by Thomas Cann Version 1

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
    
    Particle(float rho, float a, float b, float lambda, float D, float C){
      //Initialise a Particle Object.
      this.rho =rho;
      this.a = a;
      this.b = b;
      this.lambda = lambda;
      this.D= D;
      this.C=C;
      
      
    }
    Particle(){
      //Initialise default Particle Object.
      this.rho =1000.0;
      this.a = 0.95;
      this.b = 1.05;
      this.lambda = 1e-6;
      this.D=1.0/( exp(-this.lambda*this.a) -exp(-this.lambda*this.b));
      this.C= this.D * exp(-this.lambda*this.a);
      
      
    }
}
