
  // Basic parameters
  int n_particles = 10000;   
  float h_stepsize;
  RingSystem Saturn;

  //Dynamic Timestep variables
  final float simToRealTimeRatio = 3600.0/1.0;   // 3600.0/1.0 --> 1hour/second
  final float maxTimeStep = 20* simToRealTimeRatio / 30;
  float totalSimTime =0.0;                       // Tracks length of time simulation has be running


  
class Simulation {//implements Runnable{

 //void run(){
   
 //    Saturn = new RingSystem(); 
     
 //    do{
       
 //    } while ()
 //}

 
  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Simulation() {
    
    Saturn = new RingSystem(); 
    
  }
  
  void reinitialise(){
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
    Saturn.display();
    fps();

    
  }
  
 

  //Display FrameRate and Time data to bar along bottom of screen
  void fps() {
    surface.setTitle("Framerate: " + int(frameRate) + "     Time Elapsed[Seconds]: " + int(millis()/1000.0) + "     Simulation Time Elapsed[hours]: " + int(totalSimTime/3600.0)); //Set the frame title to the frame rate
  }


}
