
  // Basic parameters
  int n_particles = 10000;   
  float h_stepsize;
  RingSystem Saturn;

  //Dynamic Timestep variables
  final float simToRealTimeRatio = 3600.0/1.0;   // 3600.0/1.0 --> 1hour/second
  final float maxTimeStep = 20* simToRealTimeRatio / 30;
  float totalSimTime =0.0;                       // Tracks length of time simulation has be running


  
class Simulation {



 
  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Simulation() {
    
    Saturn = new RingSystem();
    
  }


  void update() {
    // calculate simulation time step for this frame
    if (simToRealTimeRatio/frameRate < maxTimeStep) {
      h_stepsize= simToRealTimeRatio/frameRate;
    } else {
      h_stepsize= maxTimeStep;
      println("At Maximum Time Step");
    }

    //*************Update and Render Frame******************

    //Updates properties of all objects.

    //thread("update");

      Saturn.update();
 
    //Display all of the objects to screen.


    //******************************************************

    totalSimTime +=h_stepsize;
  }
  
  void display(){
  
    background(0);
    guidelines();
    Saturn.display();
    fps();

    
  }
  
 

  //Display FrameRate and Time data to bar along bottom of screen
  void fps() {
    surface.setTitle("Framerate: " + int(frameRate) + "     Time Elapsed[Seconds]: " + int(millis()/1000.0) + "     Simulation Time Elapsed[hours]: " + int(totalSimTime/3600.0)); //Set the frame title to the frame rate
  }

  //guidelines round edge of rings and planet.
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


}
