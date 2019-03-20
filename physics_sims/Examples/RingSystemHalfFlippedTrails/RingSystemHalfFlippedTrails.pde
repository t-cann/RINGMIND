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
final float maxTimeStep = 20* simToRealTimeRatio / 30;
float totalSimTime =0.0;                       // Tracks length of time simulation has be running

PGraphics pg;
PGraphics pg1;

RingSystem Saturn;
//Renderer R;

void setup() {
  size (1200, 1000, P2D);
  frameRate(30);
  smooth(); //noSmooth();
  randomSeed(3);
  
  pg = createGraphics(width/2,height,P2D);
  pg1 = createGraphics(width/2,height,P2D);
  
  Saturn = new RingSystem();
  //R= new Renderer();
  background(0);
}

void draw() {

  // calculate simulation time step for this frame
  if(simToRealTimeRatio/frameRate < maxTimeStep){
  h_stepsize= simToRealTimeRatio/frameRate;
  } else{
  h_stepsize= maxTimeStep;
  println("At Maximum Time Step");
  }

  //*************Update and Render Frame******************

  //Updates properties of all objects.
  
  //Saturn.update();
  thread("update");
  
  //PVector diff = PVector.sub(Saturn.moons.get(0).position,Saturn.moons.get(1).position);

  //println(diff.mag());
  
  //Renders to screen based of new properties of objects.
  //if(frameCount%50 ==0){}

  background(0);

  guidelines();
  
  pg.beginDraw();
  if(mousePressed){
  pg.clear();
  }
  pg.scale(1,-1);
  pg.translate(0,-height);
  Saturn.render(pg);
  
  pg.endDraw();
  
  pg1.beginDraw();
  if(mousePressed){
  pg1.clear();
  }
  pg1.translate(-width/2,0);
  Saturn.render(pg1);
  
  pg1.endDraw();
  
  
  noTint();
  image(pg,0,0);
  noTint();
  //tint(255,0,255,255);
  image(pg1,width/2,0);
  //Saturn.display();
  
  //R.render(Saturn);
  //for(PGraphics x:R.buffer){
  //image(x,0,0);
  //}

  fps();

  //******************************************************

  totalSimTime +=h_stepsize;
}

void update(){
Saturn.update();

}

void fps(){
  push();
  fill(0);
  rect(0, height-20, width, 20);
  fill(255);
  text("Framerate: " + int(frameRate) + "     Time Elapsed[Seconds]: " + int(millis()/1000.0) + "     Simulation Time Elapsed[hours]: " + int(totalSimTime/3600.0) , 10, height-6);
  pop();
}


void guidelines() {
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
