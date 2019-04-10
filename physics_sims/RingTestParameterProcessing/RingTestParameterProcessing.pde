/**Class RingSystemProcessing 
 * A gravitational simulation in a Cartesian coordinate system.
 *
 * @author Thomas Cann
 * @version 2.0
 */

//Initialising Objects
Simulation S;

float time; 

int count = 0; 
int countI = 0; 
float Interval = 180; //000;


void setup() {
  size (1200, 700, P2D);
  //fullScreen(P2D,1);
  frameRate(60);
  smooth(); //noSmooth();
  randomSeed(3);
  Saturn = new RingSystem();
  background(0);
}

void draw() {
  time = millis() - Interval * count ;
  
  if (time > Interval) {

    output();
    
    count ++;

    if ( count % 4 == 0 ) {
      reinitialise();
    }
  }

  update();
}

void output() {
  S.display();
  saveFrame("data/frame-####.png");
}

void update() {
  S.update();
}

void reinitialise() {
  
  countI ++;
  
}
