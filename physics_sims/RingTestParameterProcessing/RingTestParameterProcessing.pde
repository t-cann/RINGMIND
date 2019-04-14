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

float Interval = 120000;
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
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-7 Drag1-7 DragProb13";
 break;
 case(1):
 G=1E-7;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-7 Drag1-7 DragProb53";
 break;
 case(2):
 G=1E-7;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-7 Drag1-7 DragProb14";
 break;
 case(3):
 G=1E-7;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-7 Drag1-7 DragProb54";
 break;
  case(4):
 G=1E-7;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-7 Drag2-7 DragProb13";
 break;
 case(5):
 G=1E-7;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-7 Drag2-7 DragProb53";
 break;
 case(6):
 G=1E-7;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-7 Drag2-7 DragProb14";
 break;
 case(7):
 G=1E-7;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-7 Drag2-7 DragProb54";
 break;
 case(8):
 G=1E-7;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-7 Drag4-7 DragProb13";
 break;
 case(9):
 G=1E-7;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-7 Drag4-7 DragProb53";
 break;
 case(10):
 G=1E-7;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-7 Drag4-7 DragProb14";
 break;
 case(11):
 G=1E-7;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-7 Drag4-7 DragProb54";
 break;
 case(12):
 G=1E-7;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-7 Drag6-7 DragProb13";
 break;
 case(13):
 G=1E-7;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-7 Drag6-7 DragProb53";
 break;
 case(14):
 G=1E-7;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-7 Drag6-7 DragProb14";
 break;
 case(15):
 G=1E-7;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-7 Drag6-7 DragProb54";
 break;
 case(16):
 G=1E-7;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-7 Drag8-7 DragProb13";
 break;
 case(17):
 G=1E-7;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-7 Drag8-7 DragProb53";
 break;
 case(18):
 G=1E-7;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-7 Drag8-7 DragProb14";
 break;
 case(19):
 G=1E-7;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-7 Drag8-7 DragProb54";
 break;
case(20):
 G=1E-7;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-7 Drag1-6 DragProb13";
 break;
 case(21):
 G=1E-7;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-7 Drag1-6 DragProb53";
 break;
 case(22):
 G=1E-7;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-7 Drag1-6 DragProb14";
 break;
 case(23):
 G=1E-7;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-7 Drag1-6 DragProb54";
 break;
 case(24):
 G=5E-8;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-8 Drag1-7 DragProb13";
 break;
 case(25):
 G=5E-8;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-8 Drag1-7 DragProb53";
 break;
 case(26):
 G=5E-8;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-8 Drag1-7 DragProb14";
 break;
 case(27):
 G=5E-8;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-8 Drag1-7 DragProb54";
 break;
 case(28):
 G=5E-8;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-8 Drag2-7 DragProb13";
 break;
 case(29):
 G=5E-8;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-8 Drag2-7 DragProb53";
 break;
 case(30):
 G=5E-8;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-8 Drag2-7 DragProb14";
 break;
 case(31):
 G=5E-8;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-8 Drag2-7 DragProb54";
 break;
 case(32):
 G=5E-8;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-8 Drag4-7 DragProb13";
 break;
 case(33):
 G=5E-8;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-8 Drag4-7 DragProb53";
 break;
 case(34):
 G=5E-8;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-8 Drag4-7 DragProb14";
 break;
 case(35):
 G=5E-8;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-8 Drag4-7 DragProb54";
 break;
 case(36):
 G=5E-8;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-8 Drag6-7 DragProb13";
 break;
 case(37):
 G=5E-8;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-8 Drag6-7 DragProb53";
 break;
 case(38):
 G=5E-8;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-8 Drag6-7 DragProb14";
 break;
 case(39):
 G=5E-8;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-8 Drag6-7 DragProb54";
 break;
 case(40):
 G=5E-8;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-8 Drag8-7 DragProb13";
 break;
 case(41):
 G=5E-8;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-8 Drag8-7 DragProb53";
 break;
 case(42):
 G=5E-8;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-8 Drag8-7 DragProb14";
 break;
 case(43):
 G=5E-8;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-8 Drag8-7 DragProb54";
 break;
case(44):
 G=5E-8;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-8 Drag1-6 DragProb13";
 break;
 case(45):
 G=5E-8;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-8 Drag1-6 DragProb53";
 break;
 case(46):
 G=5E-8;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-8 Drag1-6 DragProb14";
 break;
 case(47):
 G=5E-8;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-8 Drag1-6 DragProb54";
 break; 
 case(48):
 G=5E-7;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-7 Drag1-7 DragProb13";
 break;
 case(49):
 G=5E-7;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-7 Drag1-7 DragProb53";
 break;
 case(50):
 G=5E-7;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-7 Drag1-7 DragProb14";
 break;
 case(51):
 G=5E-7;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-7 Drag1-7 DragProb54";
 break;
 case(52):
 G=5E-7;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-7 Drag2-7 DragProb13";
 break;
 case(53):
 G=5E-7;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-7 Drag2-7 DragProb53";
 break;
 case(54):
 G=5E-7;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-7 Drag2-7 DragProb14";
 break;
 case(55):
 G=5E-7;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-7 Drag2-7 DragProb54";
 break;
 case(56):
 G=5E-7;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-7 Drag4-7 DragProb13";
 break;
 case(57):
 G=5E-7;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-7 Drag4-7 DragProb53";
 break;
 case(58):
 G=5E-7;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-7 Drag4-7 DragProb14";
 break;
 case(59):
 G=5E-7;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-7 Drag4-7 DragProb54";
 break;
 case(60):
 G=5E-7;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-7 Drag6-7 DragProb13";
 break;
 case(61):
 G=5E-7;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-7 Drag6-7 DragProb53";
 break;
 case(62):
 G=5E-7;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-7 Drag6-7 DragProb14";
 break;
 case(63):
 G=5E-7;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-7 Drag6-7 DragProb54";
 break;
 case(64):
 G=5E-7;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-7 Drag8-7 DragProb13";
 break;
 case(65):
 G=5E-7;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-7 Drag8-7 DragProb53";
 break;
 case(66):
 G=5E-7;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-7 Drag8-7 DragProb14";
 break;
 case(67):
 G=5E-7;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-7 Drag8-7 DragProb54";
 break;
case(68):
 G=5E-7;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G5-7 Drag1-6 DragProb13";
 break;
 case(69):
 G=5E-7;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G5-7 Drag1-6 DragProb53";
 break;
 case(70):
 G=5E-7;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G5-7 Drag1-6 DragProb14";
 break;
 case(71):
 G=5E-7;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G5-7 Drag1-6 DragProb54";
 break; 
 case(72):
 G=1E-6;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-6 Drag1-7 DragProb13";
 break;
 case(73):
 G=1E-6;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-6 Drag1-7 DragProb53";
 break;
 case(74):
 G=1E-6;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-6 Drag1-7 DragProb14";
 break;
 case(75):
 G=1E-6;
 GRID_DRAG_CONSTANT = 1E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-6 Drag1-7 DragProb54";
 break;
 case(76):
 G=1E-6;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-6 Drag2-7 DragProb13";
 break;
 case(77):
 G=1E-6;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-6 Drag2-7 DragProb53";
 break;
 case(78):
 G=1E-6;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-6 Drag2-7 DragProb14";
 break;
 case(79):
 G=1E-6;
 GRID_DRAG_CONSTANT = 2E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-6 Drag2-7 DragProb54";
 break;
 case(80):
 G=1E-6;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-6 Drag4-7 DragProb13";
 break;
 case(81):
 G=1E-6;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-6 Drag4-7 DragProb53";
 break;
 case(82):
 G=1E-6;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-6 Drag4-7 DragProb14";
 break;
 case(83):
 G=1E-6;
 GRID_DRAG_CONSTANT = 4E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-6 Drag4-7 DragProb54";
 break;
 case(84):
 G=1E-6;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-6 Drag6-7 DragProb13";
 break;
 case(85):
 G=1E-6;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-6 Drag6-7 DragProb53";
 break;
 case(86):
 G=1E-6;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-6 Drag6-7 DragProb14";
 break;
 case(87):
 G=1E-6;
 GRID_DRAG_CONSTANT = 6E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-6 Drag6-7 DragProb54";
 break;
 case(88):
 G=1E-6;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-6 Drag8-7 DragProb13";
 break;
 case(89):
 G=1E-6;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-6 Drag8-7 DragProb53";
 break;
 case(90):
 G=1E-6;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-6 Drag8-7 DragProb14";
 break;
 case(91):
 G=1E-6;
 GRID_DRAG_CONSTANT = 8E-7;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-6 Drag8-7 DragProb54";
 break;
case(92):
 G=1E-6;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 1E3;
 filename = "G1-6 Drag1-6 DragProb13";
 break;
 case(93):
 G=1E-6;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 5E3;
 filename = "G1-6 Drag1-6 DragProb53";
 break;
 case(94):
 G=1E-6;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 1E4;
 filename = "G1-6 Drag1-6 DragProb14";
 break;
 case(95):
 G=1E-6;
 GRID_DRAG_CONSTANT = 1E-6;
 GRID_DRAG_PROBABILITY = 5E4;
 filename = "G1-6 Drag1-6 DragProb54";
 break;
 default:
 exit();
 }
 count0 ++;
 S.reinitialise();
}
