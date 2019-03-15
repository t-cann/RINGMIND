/**Class RingGravSim 
 * A gravitational simulation in a Cartesian coordinate system.
 *
 * @author Thomas Cann
 * @author Sim Hinson
 * @version 1.2
 */

// Basic parameters
int n_particles = 10000;   
float h_stepsize;

//Dynamic Timestep variables
final float simToRealTimeRatio = 3600.0/1.0;   // 3600.0/1.0 --> 1hour/second
float totalSimTime =0.0;                       // Tracks length of time simulation has be running

RingSystem Saturn;

void setup() {
  size (1920, 1000, P2D);
  frameRate(30);
  smooth(); //noSmooth();
  randomSeed(0);
  
  Saturn = new RingSystem();
  background(0);
}

void draw() {
  
  // calculate simulation time step for this frame
  h_stepsize= simToRealTimeRatio/frameRate;
  
  //*************Update and Render Frame******************
  
  //Updates properties of all objects.
  
  Saturn.update();
  
  //Renders to screen based of new properties of objects.
  if(frameCount%50 ==0){
  background(0);
  }  
  guidelines();
  
  Saturn.display();
  
  fps();
  
  //******************************************************
  
  totalSimTime +=h_stepsize;

}

void fps(){
  push();
  fill(0);
  rect(0, height-20, width, 20);
  fill(255);
  text("Framerate: " + int(frameRate) + "     Time Elapsed[Seconds]: " + int(millis()/1000.0) + "     Simulation Time Elapsed[hours]: " + int(totalSimTime/3600.0) , 10, height-6);
  pop();
}

void guidelines(){
  push();
    translate(width/2, height/2);
  
  stroke(255, 165, 0);
  noFill();
  circle(0, 0, 2*r_max*scale*Rp);
  circle(0, 0, 2*r_min*scale*Rp);
  stroke(255, 165, 0);
  fill(255, 165, 0);
  circle(0, 0, 2.0*scale*Rp);
  pop();
}
