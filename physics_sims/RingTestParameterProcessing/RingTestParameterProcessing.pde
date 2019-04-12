/**Class RingSystemProcessing 
 * A gravitational simulation in a Cartesian coordinate system.
 *
 * @author Thomas Cann
 * @author Sam Hinson
 * @version 2.0
 */
 

//Initialising Objects
Simulation S;

float time; 

int count = 0; 
int count0 =5;
int reinitialise;

String filename= "Default";

float Interval = 180000;
ArrayList<ArrayList<Float>> options;

void setup() {
  size (1900, 1000, P2D);
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
  saveFrame("data/2019_04_12/"+filename+"/"+((Interval*(reinitialise+1))/60000)+"min "+(int(totalSimTime/3600.0))+"hrs.png");
}

void update() {
  S.update();
}

void reinitialise(){
 
 switch(count0){
 case(0):
 G=1E-7;
 GRID_DRAG_CONSTANT = 1E-5;
 filename = "G-7 Drag-5";
 break;
 case(1):
 G=1E-7;
 GRID_DRAG_CONSTANT = 1E-6;
 filename = "G-7 Drag-6";
 break;
 case(2):
 G=1E-7;
 GRID_DRAG_CONSTANT = 1E-7;
 filename = "G-7 Drag-7";
 break;
 case(3):
 G=1E-8;
 GRID_DRAG_CONSTANT = 1E-5;
 filename = "G-8 Drag-5";
 break;
 case(4):
 G=1E-8;
 GRID_DRAG_CONSTANT = 1E-6;
 filename ="G-8 Drag-6";
 break;
 case(5):
 G=1E-8;
 GRID_DRAG_CONSTANT = 1E-7;
 filename = "G-8 Drag-7";
 break;
 case(6):
 G=1E-9;
 GRID_DRAG_CONSTANT = 1E-5;
 filename = "G-9 Drag-5";
 break;
 case(7):
 G=1E-9;
 GRID_DRAG_CONSTANT = 1E-6;
 filename = "G-9 Drag-6";
 break;
 case(8):
 G=1E-9;
 GRID_DRAG_CONSTANT = 1E-7;
 filename = "G-9 Drag-7";
 break;
 case(9):
 G=1E-10;
 GRID_DRAG_CONSTANT = 1E-5;
 filename = "G-10 Drag-5";
 break;
 case(10):
 G=1E-10;
 GRID_DRAG_CONSTANT = 1E6;
 filename ="G-10 Drag-6";
 break;
 case(11):
 G=1E-10;
 GRID_DRAG_CONSTANT = 1E-7;
 filename = "G-10 Drag-7";
 break;

 default:
 exit();
 }
 count0 ++;
 S.reinitialise();
}
