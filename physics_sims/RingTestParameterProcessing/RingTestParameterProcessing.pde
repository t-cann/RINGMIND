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
int count0 =0;
int reinitialise;

String filename= "Default";

float Interval = 180000;
ArrayList<ArrayList<Float>> options;

void setup() {
  size (1200, 700, P2D);
  //fullScreen(P2D,1);
  frameRate(60);
  smooth(); //noSmooth();
  randomSeed(3);
  S = new Simulation();
  background(0);
  reinitialise();
  
}

void draw() {

  time = millis() - Interval * count ;
  
  if (time > Interval) {

    output();
    
    count ++;
    reinitialise =count % 5; 
    if ( reinitialise == 0 ) {
      reinitialise();
    }
  }

  update();
  
  

}

void output() {
  S.display();
  saveFrame("data/11_04_2019/"+filename+"/"+(reinitialise)+".png");
}

void update() {
  S.update();
}

void reinitialise(){
 
 switch(count0){
 case(0):
 G=1E-8;
 GRID_DRAG_CONSTANT = 1E-5;
 filename = G + GRID_DRAG_CONSTANT+ "Test";
 break;
 case(1):
 G=1E-8;
 GRID_DRAG_CONSTANT = 1E-7;
 filename = G + GRID_DRAG_CONSTANT+ "Test";
 case(2):
 G=1E-8;
 GRID_DRAG_CONSTANT = 1E-9;
 filename = G + GRID_DRAG_CONSTANT+ "Test";
 default:
 exit();
 }
 count0 ++;
 S.reinitialise();
}
