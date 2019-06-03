/** //<>//
 * ShearBoxSim
 * by Thomas Cann extends Chris Arridge work in python.
 *
 */
//Simulation time elapsed [s]
float totalSimTime= 0;
//Simulation Time step [s]
float dt =100; //Rough Time Set to be able to see affects. 

//Dynamic Timestep variables
final float simToRealTimeRatio = 3600.0/1.0;   // 3600.0/1.0 --> 1hour/second
final float maxTimeStep = 20* simToRealTimeRatio / 30;

final float G = 6.67408e-11; //Gravitational Constant

Boolean Running = true;
Boolean Display = true;
Boolean Moonlet = true;
Boolean Self_Grav = false;
Boolean Collisions =false;
//Boolean A1 =true;
//Boolean A2 =true;
Boolean Guides = false;
Boolean Reset =false;

ShearingBox s;

void setup () {
  size (1000, 500);
  s = new ShearingBox();
} 

void draw () {

  // calculate simulation time step for this frame
  //if (simToRealTimeRatio/frameRate < maxTimeStep) {
  //  dt= simToRealTimeRatio/frameRate;
  //} else {
  //  dt= maxTimeStep;
  //  println("At Maximum Time Step");
  //}


  //println("Simulation Time: "+ timeSimTime);
  //*************Update and Render Frame******************

  //Updates properties of all objects.

  if (Running) {
    update();
  }
  //Display all of the objects to screen.
  if (Display) {
    display();
  }
  fps();
  //******************************************************
  //gap = totalSimTime /3600;
  totalSimTime += dt;
}

void display() {
  background (255);
  s.display();
}
void update() {
  s.update();
}
void fps() {
  surface.setTitle("Framerate: " + int(frameRate) +  "     dt[Seconds]:"+dt+ "     Time Elapsed[Seconds]: " + int(millis()/1000.0) + "     Simulation Time Elapsed[Hours]: " + int(totalSimTime/3600)); //Set the frame title to the frame rate
}

void keyPressed() {
  //switch(key) {
  //  case(1):G
  //  case(2):
  //  case(3):
  //}
  if (key ==' ') {
    Running=!Running;
  } else if (key =='h') {
    Display=!Display;
  } else if (key =='g') {
    Guides=!Guides;
  } else if (key =='m') {
    Moonlet = !Moonlet;
  } else if (key =='s') {
    Self_Grav = !Self_Grav;
    if (Self_Grav) {
      println("Self_Grav ON");
    }
  } else if (key =='c') {
    Collisions = !Collisions;
    if (Collisions) {
      println("Collision ON");
    }
  //} else if (key =='1') {
  //  A1 = !A1;
  //  if (A1) {
  //    println("A1 ON");
  //  } else {
  //    println("OFF");
  //  }
  //} else if (key =='2') {
  //  A2 = !A2;
  //  if (A2) {
  //    println("A2 ON");
  //  } else {
  //    println("OFF");
  //  }
  } else if (key =='r') {
    Reset = !Reset;
  }
}
