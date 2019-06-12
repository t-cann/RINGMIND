import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import remixlab.bias.*; 
import remixlab.bias.event.*; 
import remixlab.dandelion.constraint.*; 
import remixlab.dandelion.core.*; 
import remixlab.dandelion.geom.*; 
import remixlab.fpstiming.*; 
import remixlab.proscene.*; 
import remixlab.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Ringmind extends PApplet {

 
  ///////////////
  //           //
  //           //
  // RINGMIND  //
  //           //
  //           //
  ///////////////

/** RINGMIND 
 * A gravitational simulation in a Cartesian coordinate system.
 *
 * Physics Coding by Lancaster University Physics Graduates.
 * @author Thomas Cann
 * @author Sam Hinson
 *
 * Interaction design and audio visual system 
 * @author ashley james brown march-may.2019 
 */

Boolean Running= true;

public void settings() {

  //fullScreen(P3D, 1);
  size (1000, 800, P3D);
  smooth(); //noSmooth();
}

public void setup() {
  background(0);
  randomSeed(3);
  systemState = State.initState;  //which state shall we begin with 
  setupStates();    //instantiate the scenarios so they are avialble for the state system to handle
  systemState = State.shearState;  //which state shall we begin with 
  setupStates();
}

public void draw() {

  //*************Simulation Update Frame******************

  updateCurrentState(millis());    //calls the render and anything specific to each scene state 

  //******************************************************
}

//--------------------------- INTERACTION KEYS -------------------------------------------------------------------

public void keyPressed() {

  if (key==' ') {
    Running = !Running;
  }
  //NUMERICAL KEY
  if (key=='1') {
    //Proscene - Camera Route #1
  } else if (key=='2') {
    //Proscene - Camera Route #2
  } else if (key=='3') {
    //Proscene - Camera Route #3
  } else if (key=='4') {
    //introState
    systemState= State.introState;
    setupStates();
  } else if (key=='5') {
    //ringmindStableState
    systemState= State.ringmindState;
    setupStates();
  } else if (key=='%') {
    //Unstable Ringmind State
    systemState= State.ringmindUnstableState;
    setupStates();
  } else if (key=='6') {
    //connectedState
    systemState= State.connectedState;
    setupStates();
  } else if (key=='7') {
    //saturnState
    systemState= State.saturnState;
    setupStates();
  } else if (key=='8') {
    //shearState
    systemState= State.shearState;
    setupStates();
  } else if (key=='*') {
    //Toggle Moonlet
    if (s instanceof ShearSystem) {
      ShearSystem ss = (ShearSystem) s;
      ss.Moonlet = !ss.Moonlet;
    }
  } else if (key=='9') {
    //TiltSystem
    systemState= State.formingState;
    setupStates();
  } else if (key=='0') {
    systemState= State.ringboarderState;
    setupStates();
  } else if (key==')') {
    systemState= State.addAlienLettersState;
    setupStates();
  } else if (key=='-') {
    systemState= State.threadingState;
    setupStates();
  }else if (key== '=') {
    systemState= State.resonanceState;
    setupStates();
  }


  //----------------------------TOP ROW QWERTYUIOP[]------------------------------------------------
  if (key=='q') {
    camera1();
  } else if (key=='Q') {
    //
  } else if (key=='w') {
    camera2();
  } else if (key=='W') {
    //
  } else if (key=='e') {
    camera3();
    //Proscene -
  } else if (key=='E') {
    //
  } else if (key=='r') {
    camera4();
    //Proscene - Show Camera Path
  } else if (key=='R') {
    //
  } else if (key=='t') {
    zoomedCamera();
  } else if (key=='T') {
    //
  } else if (key=='y') {
    camera6();
  } else if (key=='Y') {
    //
  } else if (key=='u') {
    closerCamera();
  } else if (key=='U') {
    //
  } else if (key=='i') {
    toptiltCamera();
  } else if (key=='I') {
    //
  } else if (key=='o') {
    camera9();
  } else if (key=='O') {
    //
  } else if (key=='p') {
    camera10();
  } else if (key=='P') {
    //
  } else if (key=='[') {
    initCamera();
  } else if (key==']') {
    scene.camera().interpolateToFitScene(); //if any screen frame translations ahve happened this will jump :-/ hmm. otherwise its a nice zoom to fit
  }

  //---------------------------SECOND ROW ASDFGHJKL--------------------------------------------

  if (key == 'a') {
    //Proscene - 3 Axis Markers
  } else if (key == 'A') {
    useAdditiveBlend = !useAdditiveBlend;
  } else if (key=='s') {
    useTrace = !useTrace;
    //Proscene - Fill Screen
  } else if (key=='S') {
    //Save Path to JSON
  } else if (key=='d') {
    traceAmount=190;
  } else if (key=='D') {
    //
  } else if (key=='f') {
    useFilters=!useFilters;
  } else if (key=='F') {
    //
  } else if (key=='g') {
    systemState= State.fadeup; //fade up all particles
    //Proscene - Grid Square
  } else if (key=='G') {
    //
  } else if (key=='h') {
    systemState= State.fadetoblack; //fadeout all particles from everything
  } else if (key=='H') {
    //
  } else if (key=='j') {
    //
  } else if (key=='J') {
    //
  } else if (key=='k') {
    //
  } else if (key=='k') {
    //
  } else if (key=='l') {
    //
  } else if (key=='L') {
    //
  }

  //---------------------------THIRD ROW ZXCVBNM--------------------------------------------

  if (key=='z') {
    //
  } else if (key=='Z') {
    //
  } else if (key=='x') {
    //
  } else if (key=='X') {
    //
  } else if (key=='c') {
    //oscRingDensity(Saturn);
    //oscRingRotationRate(Saturn);
  } else if (key=='C') {
    //
  } else if (key=='v') {
    saveFrame("./screenshots/ringmind_screen-###.jpg");
  } else if (key=='V') {
    //
  } else if (key=='b') {
    //
  } else if (key=='B') {
    //
  } else if (key=='n') {
    //
  } else if (key=='N') {
    //
  } else if (key=='m') {
    ////turn on this alogorithm to send tony the data
    //MoonAlignment = !MoonAlignment;
  } else if (key=='M') {
    //
  }
}

//-------------------------------
public void keyReleased() {
  //if you edit the camera pathways be sure to save them !!!!
  if (key=='S') {
    scene.saveConfig(); //outputs the camera path to a json file.
    println("camera pathways saved");
  }
}

//---------------------------- MOUSE -----------------------------------------------------------------------

public void mouseReleased() {
  //lets debug print all the camera stuff to help figure out what data we need for each scene
  println("****** camera debug info ******");
  println();
  println("camera orientation");
  Rotation r = scene.camera().frame().orientation();
  r.print();
  println();
  println("camera position");
  println(scene.camera().position());
  println();
  println("view direction");
  println(scene.camera().viewDirection());
  println();
}
//Grid Default Variables 
float R_MIN = 1;                   //[Planetary Radi] 
float R_MAX = 5;                   //[Planetary Radi] 
float GRID_DELTA_R = 0.1f;          //[Planetary Radi]  
float GRID_DELTA_THETA = 1;        //[Degrees]
float GRID_DRAG_CONSTANT = 5e-7f;   //[s^{2}]
float GRID_DRAG_PROBABILITY = 1e4f ;//[[Planetary Radi^{2}.s]

/**Class Grid TODO
 * @author Thomas Cann
 * @author Sam Hinson
 */
class Grid {

  //Grid Variables
  protected float dr, dtheta, r_min, r_max;  
  protected int sizeTheta, sizeR;  
  protected float drag_c, drag_p;  //Constants for Drag Rule. 
  protected int grid[][];          //Grid to hold the number of particle in each cell
  protected float gridNorm[][];    //Grid to hold Normalised Number Density of Particles in Cell (# Particles in Cell / ( Area and Total # Particles in Simulation)). [(1/(m^2)]
  protected PVector gridV[][];     //Grid to hold the average velocity of cell. [ms^-1,ms^-1,ms^-1]
  protected PVector gridCofM[][];  //Grid to hold centroid value for cell.[m,m,m]

  //Optimisation Variables
  private float minSize = 4*(sq(r_min *radians(dtheta)/2)+sq(dr)); //Based on the minimum grid size.

  /**
   *  Grid Constuctor - General need passing all the values. 
   */
  Grid(float r_min, float r_max, float grid_dr, float grid_dtheta, float drag_c, float drag_p) {
    this.dr = grid_dr;
    this.dtheta = grid_dtheta;
    this.r_min = r_min;
    this.r_max = r_max;
    this.sizeTheta =PApplet.parseInt(360/this.dtheta);               //Size of 1st Dimension of Grid Arrays
    this.sizeR = PApplet.parseInt((this.r_max-this.r_min)/this.dr);  //Size of 2nd Dimension of Grid Arrays
    this.grid = new int[sizeTheta][sizeR];
    this.gridNorm = new float[sizeTheta][sizeR];
    this.gridV = new PVector[sizeTheta][sizeR];
    this.gridCofM = new PVector[sizeTheta][sizeR];
    this.drag_c= drag_c; 
    this.drag_p= drag_p; 
    reset();
  }

  /**
   *  Grid Constuctor - Taking in a value for r_min and r_max and all the other values from global variables. 
   */
  Grid(float r_min, float r_max ,float drag_c, float drag_p) {
    this(r_min, r_max, GRID_DELTA_R, GRID_DELTA_THETA, drag_c, drag_p);
  }
  /** 
   * Sets all the values in the arrays to zero. Called at start of Update Method.
   */
  public void reset() {
    for (int i = 0; i < PApplet.parseInt(360/dtheta); i++) {
      for (int j = 0; j < PApplet.parseInt((r_max-r_min)/dr); j++) {
        grid[i][j] = 0;
        gridNorm[i][j] = 0;
        gridV[i][j]= new PVector();
        gridCofM[i][j]= new PVector();
      }
    }
  }

  /**
   * Returns the angle of the particle between 0 and 2PI measured from horizontal right from clockwise.
   *
   * @param   p  a particle with a position vector. 
   * @return  angle  
   */
  public float angle(Particle p) {
    return (atan2(p.position.y, p.position.x)+TAU)%(TAU);
  }

  /**
   * Returns the index of which angular bin a particle belongs to. 
   *
   * @param   p  a particle with a position vector. 
   * @return  i index of grid [between 0 and 360/dr]   
   */
  public int i(Particle p) {
    return i(angle(p));
  }

  /**
   * Returns the index of which angular bin a particle belongs to. 
   *
   * @param   angle between 0 and 2PI measured from horizontal right from clockwise . 
   * @return  i index of grid [between 0 and 360/dr]  
   */
  public int i(float angle) {
    return floor(degrees(angle)/dtheta);
  }

  /**
   * Returns angle of the centre of the cell (from horizontal, upward, clockwise)
   * @param i angular index of grid [between 0 and 360/dr]
   * @return angle of the centre of the cell
   */
  public float angleCell(int i) {
    return radians(dtheta*(i+0.5f));
  }

  /**
   *    Calculates the difference in angle between a particle and the centre of its cell
   */
  public float angleDiff(Particle p) {
    return angleCell(i(p))-angle(p);
  }

  /**
   * Returns the index of which radial bin a particle belongs to.
   *
   * @param p a particle with a position vector.
   * @return j index of grid[between 0 and ring thickness / dr]
   */
  public int j(Particle p) {
    return j(p.position.mag());
  }

  /**
   * Returns the index of which radial bin a particle belongs to.
   *
   * @param radius 
   * @return j index of grid[between 0 and ring thickness / dr]
   */
  public int j(float radius) {
    return floor((radius/System.Rp - r_min)/dr);
  }

  /**
   * Returns radius of the centre of a cell (from x=0 and y=0)
   * @param j  index of grid[between 0 and ring thickness / dr]
   * @return 
   */
  public float radiusCell(int j) {
    return System.Rp*(r_min + dr*(j+0.5f));
  }

  public float radialScaling(Particle p) {
    return sqrt(radiusCell(j(p))/p.position.mag());
  }

  /**
   * Check to see if the Particle is in the grid .
   *
   * @param p a particle with a position vector.
   * @return
   */
  public boolean validij(Particle p) {
    return validij(i(p), j(p));
  }

  public boolean validij(int i, int j ) {
    boolean check = false;
    if (i< sizeTheta && i>=0  ) {
      if (j < PApplet.parseInt((r_max-r_min)/dr)  && j>=0) {
        check = true;
      }
    }
    return check;
  }

  /**
   * Returns a vector from the centre of RingSystem to the centre of a specific angular and radial bin.
   * @param i angular index of grid [between 0 and 360/dr]
   * @param j radial index of grid[between 0 and ring thickness / dr]
   * @return 
   */
  public PVector centreofCell(int i, int j ) {
    float r = radiusCell(j);  
    float angle = angleCell(i);
    return new PVector(r*cos(angle), r*sin(angle));
  }

  /**
   * Returns a vector representing the keplerian velocity of the centre of a specific angular and radial bin. 
   * @param i angular index of grid [between 0 and 360/dr]
   * @param j radial index of grid[between 0 and ring thickness / dr]
   * @return 
   */
  public PVector keplerianVelocityCell(int i, int j) {
    float r = radiusCell(j);  
    float angle = angleCell(i);
    return new PVector(sqrt(System.GMp/(r))*sin(angle), -sqrt(System.GMp/(r))*cos(angle));
  }

  /**
   * Acceleration on a particle due to average values in a grid.  
   * @param Particle p a particle with a position vector.
   * @return  
   */
  public PVector gridAcceleration(Particle p, float dt) {

    PVector a_grid = new PVector();
    if (validij(p)) {
      //Fluid Drag Force / Collisions - acceleration to align to particle the average velocity of the cell. 
      a_grid.add(dragAcceleration(p, dt));

      // Self Gravity   
      //a_grid.add(selfGravAcceleration(p));
    }
    return a_grid;
  }

  /**
   * Drag Acceleration on a particle due to difference between particle velocity and average velocity of the grid cell (taking into account the number of particles in the cell).  
   *
   * @param Particle p 
   * @return 
   */
  public PVector dragAcceleration(Particle p, float dt) {

    // Collisions - acceleration due drag (based on number of particles in grid cell).
    PVector a_drag = new PVector();

    //Find which cell the particle is in.
    int i = i(p);
    int j = j(p);

    float r = 1-exp(-(gridNorm[i][j]*drag_p)/dt);
    if ( random(1)< r) {

      float a, nn;
      a_drag = PVector.sub(gridV[i][j].copy().rotate(angleDiff(p)).mult(radialScaling(p)), p.velocity.copy()); 
      a =  a_drag.magSq();   
      a_drag.normalize();
      nn = gridNorm[i][j];
      a_drag.mult(drag_c*a*nn);
    }
    return a_drag;
  }

  /** Attraction between particles and nearby grid cells.
   * @param Particle p 
   * @return 
   */

  public PVector selfGravAcceleration(Particle p ) {

    //Find which cell the particle is in.
    int x = i(p);
    int y = j(p);

    PVector a_selfgrav = new PVector();

    float r = 0.5f;
    if (random(1) < r) {

      float a, d; // Strength of the attraction number of particles in the cell. 
      d=1e8f;

      int size = 6; //Size of Neighbourhood

      // Loop over (nearest) neighbours. As defined by Size. 

      for ( int i = x-size; i <= x+size; i++) {
        for ( int j = y-size; j <= y+size; j++) {
          if (validij(i, j)) {
            float n = gridNorm[i][j];
            PVector dist = PVector.sub(gridCofM[i][j].copy(), p.position);
            a = dist.magSq();
            if (a< minSize) {
              a_selfgrav.add(PVector.mult(dist.normalize(), n*d/minSize));
            } else {
              a_selfgrav.add(PVector.mult(dist.normalize(), n*d/a));
            }
          }
        }
      }
    }
    return a_selfgrav;
  }

  //  /**
  //   *    Displays Grid cell mouse is over and relevant informotion when mouse is pressed
  //   */
  //  void display(RingSystem rs) {

  //    if (mousePressed) {
  //      float r = sqrt(sq(mouseX-width/2)+ sq(mouseY-height/2))/SCALE;
  //      float angle = (atan2((mouseY-height/2), mouseX-width/2)+TAU)%(TAU);
  //      int i= i(angle);
  //      int j = j(r);

  //      if (Add) {
  //        for (int x=0; x<1; x++) { 
  //          RingParticle a = new RingParticle(r_min+GRID_DELTA_R*j, GRID_DELTA_R, radians(GRID_DELTA_THETA*i), radians(GRID_DELTA_THETA));
  //          rs.rings.get(0).particles.add(a);
  //          rs.totalParticles.add(a);
  //        }
  //      }

  //      if (clear) {
  //        ArrayList<Particle> temp = new ArrayList<Particle>();
  //        for (Particle p : rs.totalParticles) {
  //          if (i(p) == i) {
  //            if (j(p)== j) {
  //              temp.add(p);
  //            }
  //          }
  //        }
  //        for (Particle p : temp) {
  //          rs.totalParticles.remove(p);
  //          rs.rings.get(0).particles.remove(p);
  //        }
  //      }

  //      if (validij(i, j)) {
  //        displaycell(i, j );
  //        float a = 1-exp(-(gridNorm[i][j]*drag_p)/dt);
  //        String output = "\t Normalised Number Density: " +gridNorm[i][j] + "\n\t Average Velocity: " + gridV[i][j].mag()+ "\n\t Probability Threshold: " + a ;
  //        text(output, 0.0, 10.0);
  //        displayVector(i, j, gridV[i][j]);
  //      }
  //    }
  //  }

  //  /**
  //   * Displays PVectorfrom the centre of a Grid Cell to the Sketch.
  //   *
  //   * @param i angular index of grid [between 0 and 360/dr]
  //   * @param j radial index of grid[between 0 and ring thickness / dr]
  //   */
  //  void displayVector(int i, int j, PVector v) {
  //    push();
  //    //translate(width/2, height/2);
  //    stroke(255);
  //    strokeWeight(1);
  //    PVector cofc = centreofCell(i, j);
  //    cofc.mult(SCALE);
  //    PVector temp = v.copy().mult(5E-3);
  //    line(cofc.x, cofc.y, cofc.x + temp.x, cofc.y + temp.y);
  //    pop();
  //  }

  //  /**
  //   * Displays Outline of Grid Cell to the Sketch.
  //   *
  //   * @param i angular index of grid [between 0 and 360/dr]
  //   * @param j radial index of grid[between 0 and ring thickness / dr]
  //   */
  //  void displaycell(int i, int j) {
  //    push();
  //    //Style and Matrix Tranformation Information
  //    //translate(width/2, height/2);
  //    noFill();
  //    stroke(255);
  //    strokeWeight(1);
  //    //Properties Needed
  //    float r = SCALE*Rp*(r_min + dr *j);
  //    float R = SCALE*Rp*(r_min + dr *(j+1));
  //    float theta = radians(dtheta *i);
  //    float N =GRID_DELTA_THETA;
  //    beginShape();
  //    // Outer circle
  //    for (int x = 0; x<=N; x++) {
  //      vertex(R*cos(x*radians(dtheta)/N + theta), R*sin(x*radians(dtheta)/N +theta));
  //    }
  //    // Inner circle
  //    for (int x = 0; x<=N; x++) {
  //      vertex(r*cos((theta+radians(dtheta))-x*radians(dtheta)/N), r*sin((theta+radians(dtheta))-x*radians(dtheta)/N));
  //    }
  //    endShape(CLOSE);
  //    pop();
  //  }

  /**
   * Loops through all the particles adding relevant properties to  grids. Will allow generalised rules to be applied to particles.
   *
   * @param rs a collection of particles represent a planetary ring system. 
   */
  public void update(System s) {

    //Reset all the grid values.
    reset();

    if ( s instanceof RingSystem) {

      RingSystem rs = (RingSystem)s;

      //Loop through all the particles trying to add them to the grid.
      for (Ring x : rs.rings) {
        for (RingParticle r : x.particles) {
          int i = i(r);
          int j = j(r);
          if (validij(i, j)) {
            grid[i][j] +=1;
            PVector v = new PVector(r.velocity.x, r.velocity.y);
            v.rotate(-angleDiff(r)).mult(1/radialScaling(r));
            gridV[i][j].add(v);
            gridCofM[i][j].add(r.position);
          }
        }
      }

      int total =0 ;
      for (int i = 0; i < PApplet.parseInt(360/dtheta); i++) {
        for (int j = 0; j < PApplet.parseInt((r_max-r_min)/dr); j++) {
          total += grid[i][j];
          if (grid[i][j] !=0) {
            gridCofM[i][j].div(grid[i][j]);
          } else {
            gridCofM[i][j].set(0.0f, 0.0f, 0.0f);
          }
        }
      }
      // Improve the calculate of gridV 

      //As cannot simulate every particle, add constant or multiple number of particles with keplerian velocity to help maintain correct averages.

      //float actualtosimratio = 2; // actual number of particles to simulated 

      //for (int i = 0; i < int(360/dtheta); i++) {
      //  for (int j = 0; j < int((r_max-r_min)/dr); j++) {
      //    gridNorm[i][j] = grid[i][j]/((r_min+j*dr+dr/2)*dr*radians(dtheta)*total);
      //    gridV[i][j].add(keplerianVelocityCell(i, j));
      //    gridV[i][j].add(keplerianVelocityCell(i, j));
      //    for (int k = 0; k<grid[i][j]; k ++) {
      //      gridV[i][j].add(keplerianVelocityCell(i, j));
      //    }
      //    gridV[i][j].div(actualtosimratio*(grid[i][j]+1));
      //  }
      //}



      //  //Looping through all the grid cell combining properties to calculate normalised values and average values from total values.
      for (int i = 0; i < PApplet.parseInt(360/dtheta); i++) {
        for (int j = 0; j < PApplet.parseInt((r_max-r_min)/dr); j++) {

          gridNorm[i][j] = grid[i][j]/((r_min+j*dr+dr/2)*dr*radians(dtheta)*total);


          if (grid[i][j] !=0) {
            gridV[i][j].div(grid[i][j]);
          } else {
            gridV[i][j].set(0.0f, 0.0f, 0.0f);
          }
        }
      }
    }
  }

  ////---------------------------------------
  //void tiltupdate(RingSystem rs) {

  //  //Reset all the grid values.
  //  reset();

  //  //Loop through all the tilt particles trying to add them to the grid.
  //  for (Ring x : rs.rings) {
  //    for (TiltParticle r : x.Tparticles) {
  //      int i = i(r);
  //      int j = j(r);
  //      if (validij(i, j)) {
  //        grid[i][j] +=1;
  //        PVector v = new PVector(r.velocity.x, r.velocity.y);
  //        v.rotate(-angleDiff(r)).mult(1/radialScaling(r));
  //        gridV[i][j].add(v);
  //        gridCofM[i][j].add(r.position);
  //      }
  //    }
  //  }

  //  int total =0 ;
  //  for (int i = 0; i < int(360/dtheta); i++) {
  //    for (int j = 0; j < int((r_max-r_min)/dr); j++) {
  //      total += grid[i][j];
  //      if (grid[i][j] !=0) {
  //        gridCofM[i][j].div(grid[i][j]);
  //      } else {
  //        gridCofM[i][j].set(0.0, 0.0, 0.0);
  //      }
  //    }
  //  }

  //  //Looping through all the grid cell combining properties to calculate normalised values and average values from total values.
  //  for (int i = 0; i < int(360/dtheta); i++) {
  //    for (int j = 0; j < int((r_max-r_min)/dr); j++) {

  //      gridNorm[i][j] = grid[i][j]/((r_min+j*dr+dr/2)*dr*radians(dtheta)*total);


  //      if (grid[i][j] !=0) {
  //        gridV[i][j].div(grid[i][j]);
  //      } else {
  //        gridV[i][j].set(0.0, 0.0, 0.0);
  //      }
  //    }
  //  }
  //}

  //-----------------------------------

  /**
   * Returns a Table Object from a 2D array containing Int data type.
   *
   * @param grid a 2D array of values. 
   */
  public Table gridToTable(int grid[][]) {
    Table tempTable = new Table();

    for (int j=0; j<grid.length; j++) {
      tempTable.addColumn();
    }

    for (int i=0; i<grid[0].length; i++) {
      TableRow newRow =tempTable.addRow();
      for (int j=0; j<grid.length; j++) {
        newRow.setInt(j, grid[j][i]);
      }
    }

    return tempTable;
  }

  /**
   * Returns a Table Object from a 2D array containing float data type.
   *
   * @param grid a 2D array of values. 
   */
  public Table gridToTable(float grid[][]) {
    Table tempTable = new Table();

    for (int j=0; j<grid.length; j++) {
      tempTable.addColumn();
    }

    for (int i=0; i<grid[0].length; i++) {
      TableRow newRow =tempTable.addRow();
      for (int j=0; j<grid.length; j++) {
        newRow.setFloat(j, grid[j][i]);
      }
    }

    return tempTable;
  }

  /**
   * Returns a Table Object from a 2D array containing PVector objects.
   *
   * @param grid a 2D array of values.
   * @return Table Object with 
   */
  public Table gridToTable(PVector grid[][]) {
    Table tempTable = new Table();

    for (int j=0; j<grid.length; j++) {
      tempTable.addColumn();
    }

    for (int i=0; i<grid[0].length; i++) {
      TableRow newRow =tempTable.addRow();
      for (int j=0; j<grid.length; j++) {
        newRow.setFloat(j, grid[j][i].mag());
      }
    }

    return tempTable;
  }
}

//TODO
//abstract class AbstractGrid {


//  protected float dr, dtheta, r_min, r_max; 
//  protected int sizeTheta, sizeR;
//  protected float drag_c, drag_p;  //Constants for Drag Rule.
//  protected AbstractGridElement grid[][];

//  abstract void Reset();
//  abstract int i(Object o);
//  abstract int j(Object o);
//  abstract boolean validij(Object o);
//}

//abstract class AbstractGridElement {
//}
//<Particle Tab>//
//Contains:
//-Classes(Particle, RingParticle, Moon, ResonantParticle, ResonantMoon, Resonance, TiltParticle, ShearingParticle, Moonlet
//-Interfaces(Alignable)
//-Methods(Particle I/O)

/**Class Particle
 * @author Thomas Cann
 * @author Sam Hinson
 */
abstract class Particle {

  PVector position; // Position float x1, x2, x3; 
  PVector velocity; // Velocity float v1, v2, v3;
  PVector acceleration;  //Update all constructors!

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Particle(float x1_, float x2_, float x3_, float v1_, float v2_, float v3_, float a1_, float a2_, float a3_) {
    //default position
    this.position = new PVector(x1_, x2_, x3_);
    //default velocity
    this.velocity = new PVector(v1_, v2_, v3_);
    this.acceleration = new PVector(a1_, a2_, a3_);
  }

  /**
   *  Class Constuctor - passing in values of position and velocity. 
   */
  Particle(float x1_, float x2_, float x3_, float v1_, float v2_, float v3_) {
    //default position
    this.position = new PVector(x1_, x2_, x3_);
    //default velocity
    this.velocity = new PVector(v1_, v2_, v3_);
    this.acceleration = new PVector();
  }

  /**
   *  Class Constuctor -passing in PVectors of position and velocity. 
   */
  Particle(PVector position_, PVector velocity_) {
    //default position
    this.position = position_.copy();
    //default velocity
    this.velocity = velocity_.copy();
  }

  /**
   *  Class Constuctor - Initialises an Orboid object with a random position in the ring with correct orbital velocity. 
   */
  Particle(float r, float phi) {
    this(r*cos(phi), r*sin(phi), 0, sqrt(System.GMp/(r))*sin(phi), -sqrt(System.GMp/(r))*cos(phi), 0);
  }

  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  Particle(float radius) {
    // Initialise ourRingParticle.
    this(radius, random(1)*2.0f*PI); //random(1)
  }

  /**
   *  Class Constuctor - Initialises an Particle object with zero position and velocity. 
   */
  Particle() {
    this(0, 0, 0, 0, 0, 0);
  }

  /**Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
   * @param rs
   * @return acceleration on the particle PVector[m.s^-2,m.s^-2,m.s^-2]
   */
  public PVector getAcceleration(System s) {
    PVector a_grav = new PVector();

    // acceleration due planet in centre of the ring. 
    a_grav = PVector.mult(position.copy().normalize(), -System.GMp/position.copy().magSq());

    //Acceleration from the Grid Object
    if (s.g != null) {
      for (Grid x : s.g) {
        a_grav.add(x.gridAcceleration(this, s.dt));
      }
    }
    return a_grav;
  }

  /** Calculates the acceleration on this particle (based on its current position) (Overrides value of acceleration stored by particle)
   * @param rs
   */
  public void set_getAcceleration(System s) {
    acceleration = getAcceleration(s);
  }

  /** 
   *  Update Position of particle based of Velocity and Acceleration. 
   */
  public void updatePosition(float dt) {

    position.add(velocity.copy().mult(dt)).add(acceleration.copy().mult(0.5f*sq(dt)));
  }

  /**
   * Updates the velocity of this Particle (Based on Velocity Verlet) using 2 accelerations. 
   * @param a current acceleration of particle
   */
  public void updateVelocity(PVector a, float dt) {

    velocity.add(PVector.add(acceleration.copy(), a).mult(0.5f *dt));
  }

  public abstract Particle clone();
}

//---------------------------------------------------------------------------------------------------------------------------------------------------//

/**Class RingParticle
 * @author Thomas Cann
 * @author Sam Hinson
 * @version 1.0
 */
class RingParticle extends Particle {

  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float r, float dr, float theta, float dtheta) {
    // Initialise our Orboids.
    super((random(1)*(dr) + r)*System.Rp, theta + random(1)*dtheta);
  }
  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float inner, float outer) {
    // Initialise our Orboids.
    super((random(1)*(outer-inner) + inner)*System.Rp, random(1)*2.0f*PI);
  }

  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float radius) {
    // Initialise ourRingParticle.
    super(radius, random(1)*2.0f*PI);
  }

  RingParticle() {
    super();
  }

  ///**Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
  // * @param s RingmindSystem
  // * @return PVector [ms^(-2)] 
  // */
  //PVector getAcceleration(RingmindSystem s) {

  //  // acceleration due planet in centre of the ring. 
  //  PVector a_grav = PVector.mult(position.copy().normalize(), -System.GMp/position.copy().magSq());

  //  //Acceleration from the Grid Object
  //  for (Grid x : s.rs.g) {
  //    a_grav.add(x.gridAcceleration(this, s.dt));
  //  }
  //  for (Particle p : s.ms.particles) {
  //    Moon m =(Moon)p;
  //    PVector dist = PVector.sub(m.position, position);
  //    PVector a = PVector.mult(dist, m.GM/pow(dist.mag(), 3));
  //    a_grav.add(a);
  //  }
  //  return a_grav;
  //}

  /**Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
   * @param s System
   * @return PVector [ms^(-2)] 
   */
  public @Override PVector getAcceleration(System s) {

    PVector a_grav;
    if (s instanceof RingmindSystem) {
      //println("test");
      RingmindSystem rms = (RingmindSystem)s;
      // acceleration due planet in centre of the ring. 
      a_grav = PVector.mult(position.copy().normalize(), -System.GMp/position.copy().magSq());

      //Acceleration from the Grid Object
      for (Grid x : rms.rs.g) {
        a_grav.add(x.gridAcceleration(this, s.dt));
      }

      for (Particle p : rms.ms.particles) {
        if (p instanceof Moon) {
          Moon m = (Moon)p;
          PVector dist = PVector.sub(m.position, position);
          PVector a = PVector.mult(dist, m.GM/pow(dist.mag(), 3));
          a_grav.add(a);
        }
      }
    } else {
      a_grav =super.getAcceleration(s);
    }

    return a_grav;
  }

  /**
   *  Clone Method - Return New Object with same properties.
   * @return particle object a deep copy of this. 
   */
  public @Override Particle clone() {
    Particle p = new RingParticle(); 
    p.position= this.position.copy();
    p.velocity = this.velocity.copy();
    return p;
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------//

/**Class Moon
 *
 * @author Thomas Cann
 * @author Sam Hinson
 */

class Moon extends Particle implements Alignable {

  float GM;
  float radius;
  int c ;
  final float moonSizeScale= 2;

  /**
   *  Class Constuctor - General Moon object with random angle. 
   */
  Moon(float Gm, float radius, float orb_radius, int c) {
    super(orb_radius);
    this.GM=Gm;
    this.radius=radius;
    this.c= c;
  }
  /**
   *  Class Constuctor - General Moon object with random angle. 
   */
  Moon(float Gm, float radius, float orb_radius) {
    super(orb_radius);
    this.GM=Gm;
    this.radius=radius;
    c= color(random(255), random(255), random(255));
  }
  /**
   *  Class Constuctor - Default Moon object with properties of Mima (loosely). 
   */
  Moon(PVector p, PVector v) {
    //Mima (Source: Nasa Saturn Factsheet)
    //GM - 2.529477495E9 [m^3 s^-2]
    //Radius - 2E5 [m]
    //Obital Radius - 185.52E6 [m]

    this(2.529477495e13f, 400e3f, 185.52e6f);
    this.position.x = p.x;
    this.position.y = p.y;
    this.position.z = p.z;
    this.velocity.x = v.x;
    this.velocity.y = v.y;
    this.velocity.z = v.z;
  }
  Moon() {
    super();
    this.GM=0;
    this.radius=0;
    c= color(0, 0, 255);
  }

  /**
   *Display Method - Renders this object to screen displaying its position and colour.
   */
  public @Deprecated void display() {
    push();
    translate(width/2, height/2);
    ellipseMode(CENTER);
    fill(c);
    stroke(c);
    circle(System.SCALE*position.x, System.SCALE*position.y, 2*moonSizeScale*radius*System.SCALE);
    pop();
  }  

  /**Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
   * @param System Object
   * @return current acceleration of this moon due to rest of System [ms^(-2)] . 
   */
  public PVector getAcceleration(RingmindSystem s) {

    // acceleration due planet in centre of the ring. 
    PVector a_grav = PVector.mult(position.copy().normalize(), -System.GMp/position.copy().magSq());

    // acceleration due the moons on this particle.
    for (Particle p : s.ms.particles) {
      if (p instanceof Moon) {
        Moon m = (Moon)p;
        if (m != this) {
          PVector dist = PVector.sub(m.position, position);
          PVector a = PVector.mult(dist, m.GM/pow(dist.mag(), 3));
          a_grav.add(a);
        }
      }
    }

    return a_grav;
  }

  /**Clone Method - Return New Object with same properties.
   * @return particle object a deep copy of this. 
   */
  public @Override Particle clone() {
    Moon p = new Moon(); 
    p.position= this.position.copy();
    p.velocity = this.velocity.copy();
    p.GM = this.GM;
    p.radius = this.radius;
    p.c= this.c;
    return p;
  }

  /**Returns a boolean of true when 2 alignable object are within angular threshold
   * @param Object that implements Alignable.
   * @return Returns true when 2 alignable object are within angular threshold.
   */
  public boolean isAligned(Alignable other) {
    boolean temp =false;
    Moon otherMoon = (Moon)other;
    float dAngle = this.position.heading() - otherMoon.position.heading();

    float angleThreshold = radians(1);
    if ( abs(dAngle) < angleThreshold) { //abs(dAngle) % PI could be used to have alignments on either side of the planet!
      temp =true;
    } 
    return temp;
  }

  /** Time taken for two Alignale objects to align. 
   * @param Object that implements Alignable.
   * @return time taken for two Alignale objects to align. 
   */
  public float timeToAlignment(Alignable other) {
    Moon otherMoon = (Moon)other;
    float dAngle = this.position.heading() - otherMoon.position.heading();
    float dOmega = kepler_omega(this)-kepler_omega(otherMoon);
    return dAngle/(dOmega*s.simToRealTimeRatio);
  }

  /** Method to calculate the Keplerian orbital angular frequency (using Kepler's 3rd law).
   *@param r Radial position (semi-major axis) to calculate the period [m].
   *@return The angular frequency [radians/s].
   */
  public float kepler_omega(Moon m) {
    return sqrt(System.GMp/(pow(m.position.mag(), 3.0f)));
  }


  /**Method to get the angle in degrees of the moon
   * @param m Moon Object.
   * @return [degrees].
   */
  public float moonAngle(Moon m) {
    PVector center = new PVector(0, 0, 0);
    PVector mm = new PVector(m.position.x, m.position.y, 0);
    return degrees(PVector.angleBetween(center, mm));
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------//

/**Interface Alignable - template for checking if different objects types of objects align. 
 * @author Thomas Cann
 */
public interface Alignable {
  public boolean isAligned(Alignable other); //Alignment Threshold
  //public float timeToAlignment(Alignable other); //What units? [s]
}

//---------------------------------------------------------------------------------------------------------------------------------------------------//
/**Class ResonantParticle - Removes Gravity interaction and used information in Resonance class to thin rings.  
 * @author Thomas Cann
 */
public class ResonantParticle extends RingParticle {

  /**
   * TODO
   */
  ResonantParticle() {
    //TODO
  }

  /**
   *  Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
   */
  public @Override PVector getAcceleration(System s) {

    //TODO
    //// acceleration due to planet in centre of the ring. 
    PVector a_grav = new PVector();
    //a_grav = PVector.mult(position.copy().normalize(), -GMp/position.copy().magSq());

    ////Acceleration from the Grid Object
    //for (Grid x : rs.g) {
    //  a_grav.add(x.gridAcceleration(this));
    //}
    //for (Moon m : rs.moons) {
    //  //for all resonances of the moon 

    //  PVector dist = PVector.sub(m.position, position);
    //  PVector a = PVector.mult(dist, m.GM/pow(dist.mag(), 3));

    //  if (m.r != null){
    //  for (Resonance R : m.r) {

    //    float x = position.mag()/60268e3;
    //    //Check if Particle >Rgap ?&& <Rmax
    //    //println(x+" "+R.rGap+ " "+ R.rMax);
    //    if (x>R.rGap && x<R.rMax) {
    //      //Calcuaculate and Apply if it is !
    //      println(R.calcAccleration(x-R.rGap));
    //      a.mult(R.calcAccleration(x-R.rGap));
    //    }
    //  }}else{
    //    println("No Resonances ");

    //  }
    //  a_grav.add(a);
    //}

    return a_grav;
  }
}

/**Class ResonantMoon - Removes Gravity interaction and used information in Resonance class to thin rings.  
 * @author Thomas Cann
 */
public class ResonantMoon extends Moon {

  ArrayList<Resonance> r;

  /**
   *  Class Constuctor - Create Resonant Moon object with empty arraylist to store Resonances. 
   */
  ResonantMoon(float Gm, float radius, float orb_radius) {
    super(Gm, radius, orb_radius);
    r = new ArrayList<Resonance>();
  }

  /**Method to add a Resonance to arraylsit.
   * @param Q ratio [t_moon/t_particle].
   */
  public void addResonance(float Q) {
    r.add(new Resonance(Q, this));
  }
}

/**Class Resonance - Orbital Resonance / Limdblad Resonance information.  
 * @author Thomas Cann
 */
public class Resonance {

  float Q;                         //ratio [t_moon/t_particle]
  float rGap;                      //inner most radius of gap. [Planetary Radi](Hard Edge)
  float rMax;                      //outer most radius of gap. [Planetary Radi](Soft Edge)
  float bellMag = 1e5f;             //Strength of Clearing Force [m.s^-2]
  float bellWidth = 0.001913069f;   //Width of Clearing Force [Planetary Radi ^2]
  //float Effect;                  //Scale of strength Force based on Gravitational force due to moon at ring gap --> moonmass/(rmoon -rgap)^2 multiplied by a constant

  /**
   *  Class Constuctor - Calculates Resonance properties based of Q and Moon.
   */
  Resonance(float Q, Moon m) {
    this.Q = Q;
    calcRGap(m);
    //calcEffect(m);
    calcRmax();
  }

  /** Method to calculate inner radius at which gap should form.
   *  @param m Moon Object which resonance is based off.  
   */
  public void calcRGap(Moon m) {
    rGap = (m.position.mag()*pow(Q, (-2.0f/3.0f)))/60268e3f;
  }

  /** Method to calculate inner radius at which gap should form.
   *  @param x radius from centre planet[Planetary Radi]
   *  @return acceleration[m.s^-2]
   */
  public float calcAccleration(float x) {
    return bellMag*exp( -sq(x) /(Q*bellWidth)) + 1; // a proportional to GM pow(Q, ?)
  }

  /**
   *  Method to calculate a radius at which stop applying gap force. Magnitude of force is 1/100 of max.
   *  Bell/Effect curve ==> f(0)= 1 ---> f(RMax)=0.01
   */
  public void calcRmax() {
    //
    rMax = rGap + sqrt((-bellWidth*log(0.01f/bellMag))/Q);
  }

  //TODO
  //void calcEffect(Moon m) {
  //  //Accleration at gap ( Gravitational force due to moon at ring gap --> moonmass/(rmoon -rgap)^2 multiplied by a constant
  //}
}

/**
 * Method to add specific ResonanceMoon object to an Arraylist.
 */
public void addResonanceMoon(int i, ArrayList<ResonantMoon> m) {
  //Source: Nasa Saturn Factsheet

  switch(i) {
  case 1: 
    // Mimas Mass 3.7e19 [kg] Radius 2.08e5 [m] Obital Radius 185.52e6 [m]
    ResonantMoon moon =new ResonantMoon(G*3.7e19f, 2.08e5f, 185.52e6f);
    moon.addResonance(2.0f);
    m.add(moon);
    break;
  }
}


//---------------------------------------------------------------------------------------------------------------------------------------------------//

/** Class TiltParticle
 */
class TiltParticle extends RingParticle {

  float inclination;        //Rotation round x axis [degrees].
  float rotation;           //Rotation round z axis [degrees].
  float minInclination;     //minimum inclination of particle [degrees].
  float lambda;             //exponential decay constant [milliseconds^{-1}].
  float initialiseTime;     //time when particle is initialised [milliseconds].

  /** 
   * Class Constuctor - Initialises an TiltParticle object with a random position in the ring with correct orbital velocity. 
   */
  TiltParticle(float inner, float outer, float max_inclination, float min_inclination, float lambda) {
    super(inner, outer);
    this.inclination= randomGaussian()*max_inclination;
    this.rotation =random(360);
    this.minInclination = randomGaussian()* min_inclination;
    this.lambda= lambda;
    this.initialiseTime = millis();
  }

  /** Method to exponential decrease inclination with after since initialisation.
   *  @return  curretn angle to incline plane[degrees]
   */
  public float inclination() {
    return inclination* exp(-lambda*(millis()-initialiseTime)) +minInclination ;
  }

  /**Method rotates a Tilt Particle Simulated Position. Around x-axis by inclination() the around z-axis by rotation.   
   *@param p TiltParticle object
   *@return RotatedPosition PVector[m,m,m]
   */
  public PVector displayRotate(TiltParticle p) {
    PVector temp = p.position.copy();
    float angle = radians(p.inclination());
    float cosi = cos(angle);
    float sini = sin(angle);
    temp.y = cosi * p.position.y - sini * p.position.z;
    temp.z = cosi * p.position.z + sini * p.position.y;
    PVector temp1 = temp.copy();
    float cosa = cos(radians(p.rotation));
    float sina = sin(radians(p.rotation));
    temp.x = cosa * temp1.x - sina * temp1.y;
    temp.y = cosa * temp1.y + sina * temp1.x;
    return temp;
  }
  /**Method rotates this Tilt Particle Simulated Position. Around x-axis by inclination() the around z-axis by rotation. 
   *@return RotatedPosition PVector[m,m,m]
   */
  public PVector displayRotate() {
    return displayRotate(this);
  }
}

//------------------------------------- SHEAR PARTICLE -------------------------------------------------------

class ShearParticle extends Particle {

  //position.x;    //Position of Particle along planet-point line relative to moonlet [m].
  //position.y;    //Position of Particle along along orbit relative to moonlet [m].

  final float SG = 6.67408e-11f; //Shear Gravitational Constant
  //ShearParticle Initialisation Properties
  final float particle_rho = 900.0f;  //Density of a ring particle [kg/m^3].
  final float particle_a = 0.01f;     //Minimum size of a ring particle [m].
  final float particle_b = 10.0f;     //Maximum size of a ring particle [m].
  final float particle_lambda = 5;   //Power law index for the size distribution [dimensionless].
  final float particle_D =1.0f/( exp(-particle_lambda*particle_a) -exp(-particle_lambda*particle_b));
  final float particle_C =particle_D * exp(-particle_lambda*particle_a);

  //ShearParticle Properties
  float radius;
  float GM;
  float m;

  boolean highlight= false;

  /**CONSTUCTOR Particle
   */
  ShearParticle(ShearSystem s) {
    //Initialise default Particle Object.
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    //
    position.x= (random(1)-0.5f)*s.Lx;
    //
    if (position.x >0) {
      position.y = -s.Ly/2;
    } else if (position.x ==0) {
      position.y =0; //Think about this !!
    } else {
      position.y = s.Ly/2;
    }
    //  
    velocity.x = 0;
    velocity.y = 1.5f * s.Omega0 * position.x;
    //

    this.radius = - log((particle_C-random(1.0f))/particle_D)/particle_lambda;
    this.GM = SG* (4.0f*PI/3.0f)*pow(radius, 3.0f)*particle_rho;
    m= PI*pow(radius, 3.0f)*4.0f/3.0f;
  }

  ShearParticle() {
    //
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    //
    this.radius = - log((particle_C-random(1.0f))/particle_D)/particle_lambda;
    this.GM = SG* (4.0f*PI/3.0f)*pow(radius, 3.0f)*particle_rho;
    m= PI*pow(radius, 3.0f)*4.0f/3.0f;
  }

  /**Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
   * @param sb Shearing Box
   * @return accleration of this particles due to ShearingBox
   */
  public @Override PVector getAcceleration(System s) {
    ShearSystem ss = (ShearSystem)s;
    // acceleration due planet in centre of the ring. 
    PVector a_grav = new PVector();
    if (ss.A1) {
      a_grav.x += 2.0f*ss.Omega0*ss.S0*position.x;
    }
    if (ss.A2) {
      a_grav.x += 2.0f*ss.Omega0*velocity.y;
    }
    if (ss.Moonlet) {
      float moonlet_GMr3 = ss.moonlet.GM/pow(position.mag(), 3.0f);
      a_grav.x += -moonlet_GMr3*position.x;
      a_grav.y += -moonlet_GMr3*position.y;
    }

    if (ss.Self_Grav) {
      for (Particle p : ss.particles) {
        ShearParticle sp = (ShearParticle)p;
        if (sp!=this) {
          PVector distanceVect = PVector.sub(position.copy(), sp.position.copy());

          // Calculate magnitude of the vector separating the balls
          float distanceVectMag = distanceVect.mag();
          if (distanceVectMag > radius+sp.radius) {
            distanceVect = distanceVect.mult(sp.GM /pow(distanceVectMag, 3));
            a_grav.x+= -distanceVect.x ;
            a_grav.y+=-distanceVect.y;
          }
        }
      }
    }
    //PVector.mult(position.copy().normalize(), -GMp/position.copy().magSq())
    return a_grav;
  }

  /** Reset
   * @param s 
   */
  public void Reset(ShearSystem s) {
    acceleration.x=0;
    acceleration.y=0;
    //
    position.x= (random(1)-0.5f)*s.Lx;
    //
    if (position.x >0) {
      position.y = -s.Ly/2;
    } else if (position.x ==0) {
      position.y =0; //Think about this !!
    } else {
      position.y = s.Ly/2;
    }
    //  
    velocity.x = 0;
    velocity.y = 1.5f * s.Omega0 * position.x;
    //
    this.radius = - log((particle_C-random(1))/particle_D)/particle_lambda;
    this.GM = SG* (4*PI/3)*pow(radius, 3)*particle_rho;
  }

  /**Clone Method - Return New Object with same properties.
   * @return particle object a deep copy of this. 
   */
  public Particle clone() {
    ShearParticle p = new ShearParticle(); 
    p.position= this.position.copy();
    p.velocity = this.velocity.copy();
    p.acceleration = this.acceleration.copy();
    return p;
  }
}

//-----------------------------------------MOONLET---------------------------------------------------------------

class Moonlet extends ShearParticle {

  //Ring Moonlet Properties
  float moonlet_r = 50.0f;            //Radius of the moonlet [m].
  final float moonlet_density = 1000.0f; //Density of the moonlet [kg/m]
  float moonlet_GM = SG*(4.0f*PI/3.0f)*pow(moonlet_r, 3.0f)*moonlet_density; //Standard gravitational parameter.

  Moonlet() {
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    this.radius = moonlet_r ;
    this.GM = moonlet_GM;
    m= PI*pow(radius, 3.0f)*4.0f/3.0f;
  }
}

//-----------------------------------------Particle I/O--------------------------------------------------------------

/** Method addParticlesFromTable
 * @param s
 * @param filename
 */
public void addParticlesFromTable(System s, String filename) {
  Table table; 
  table = loadTable("./files/"+filename);  // Example Filenames  "output.csv" "input.csv"

  if (s instanceof RingSystem) {
    RingSystem rs=(RingSystem)s;
    for (int i = 0; i < table.getRowCount(); i++) {
      RingParticle temp = new RingParticle();
      temp.position.x= table.getFloat(i, 0);
      temp.position.y= table.getFloat(i, 1);
      temp.position.z= table.getFloat(i, 2);
      temp.velocity.x= table.getFloat(i, 3);
      temp.velocity.y= table.getFloat(i, 4);
      temp.velocity.z= table.getFloat(i, 5);
      temp.acceleration.x= table.getFloat(i, 6);
      temp.acceleration.y= table.getFloat(i, 7);
      temp.acceleration.z= table.getFloat(i, 8);
      rs.rings.get(0).addParticle(temp);
    }
  } else if (s instanceof ShearSystem) {
    s.particles.clear();
    ShearSystem ss=(ShearSystem)s;

    for (int i = 0; i < table.getRowCount(); i++) {
      ShearParticle temp = new ShearParticle(ss);
      temp.position.x= table.getFloat(i, 0);
      temp.position.y= table.getFloat(i, 1);
      temp.position.z= table.getFloat(i, 2);
      temp.velocity.x= table.getFloat(i, 3);
      temp.velocity.y= table.getFloat(i, 4);
      temp.velocity.z= table.getFloat(i, 5);
      temp.acceleration.x= table.getFloat(i, 6);
      temp.acceleration.y= table.getFloat(i, 7);
      temp.acceleration.z= table.getFloat(i, 8);
      s.particles.add(temp);
    }
  }
}

/** Method importFromFileToGrid
 * @param s 
 * @param filename
 */
public void importFromFileToGrid(System s, String filename) {

  Table table; 
  table = loadTable("./files/" + filename); //DEBUG println(table.getRowCount()+" "+ table.getColumnCount());

  //Check that there is a ArrayList of Grid objects and it is not empty.
  if (s.g != null && !s.g.isEmpty()) {

    //If Statement to depending on System.
    if (s instanceof RingSystem) {

      //If Multiple Grids will always use Index 0. 
      int index =0;
      RingSystem rs = (RingSystem)s;
      rs.rings.add(new Ring( 1, 3, 0));
      ArrayList<RingParticle> tempParticles = new ArrayList<RingParticle>();
      for (int i = 0; i < table.getRowCount(); i++) {
        for (int j = 0; j < table.getColumnCount(); j++) {
          for (int x=0; x<table.getInt(i, j); x++) {
            tempParticles.add(new RingParticle(s.g.get(index).r_min+GRID_DELTA_R*i, GRID_DELTA_R, radians(GRID_DELTA_THETA*-j-180), radians(GRID_DELTA_THETA)));
          }
        }
      }
      rs.rings.get(0).particles=tempParticles;
    }
  }
}

//---------------------------------------------------------------------------------------------------------------
/**Render System Global Variables
 */
Renderer renderer;
PGraphics pg;
RenderContext renderContext;
PShader offscreenShader;

boolean useAdditiveBlend = false;
boolean useTrace = false;
boolean useFilters = false;
int traceAmount=70;

/** 
 */
public void renderSetup() {
  //Renderer Object
  renderer = new Renderer();
  renderer.withMoon = true;
  //PGraphics Object
  pg = createGraphics(1024, 1024, P3D);
  //RenderContext Object
  renderContext = new RenderContext();
  renderContext.pgfx = this;
  renderContext.shader = loadShader("texfrag.glsl", "texvert.glsl");
  renderContext.mat.spriteTexture = loadImage("partsmall.png");
  renderContext.mat.diffTexture = pg;
  renderContext.mat.strokeColor = 255;
  //PShader Object
  offscreenShader = loadShader("cloudy.glsl");
  //LOAD CUSTOM FILTERS
  loadFilters();
}

/**default overlay render without shader
 */
public void renderOffScreenOnPGraphicsClean() {
  pg.beginDraw();
  pg.background(255, 255, 255); //no shader diffuse texture over the top
  pg.endDraw();
}

/**default overlay render using shader
 */
public void renderOffScreenOnPGraphics() {
  pg.beginDraw();
  pg.shader(offscreenShader);
  offscreenShader.set("resolution", PApplet.parseFloat(pg.width), PApplet.parseFloat(pg.height));
  offscreenShader.set("time", PApplet.parseFloat(millis()));
  pg.rect(0, 0, pg.width, pg.height);
  pg.endDraw();
}

/**a little keyhole example
 */
public void renderOffScreenOnPGraphics2() {
  pg.beginDraw();
  pg.background(0, 0, 0);
  //pg.stroke(255);
  //pg.fill(255);
  //pg.strokeWeight(100);
  //pg. line(0,0,pg.wdith,pg.height);

  pg.ellipse(mouseX, mouseY, 200, 200);
  pg.endDraw();
}

/** Class Renderer
 * @author ashley james brown
 * @author Thomas Cann
 */
class Renderer {

  boolean withMoon = true;
  float scale=System.SCALE; 


  /**Render Method
   *@param s Particle System to render.
   *@param ctx 
   *@param renderType
   */
  public void render(System s, RenderContext ctx, int renderType) {
    PGraphicsOpenGL pg = (PGraphicsOpenGL) ctx.pgfx.g;

    if (s instanceof RingmindSystem) {
      //--------------------------------------------RingSystemRender-------------------------------------------------- 
      RingmindSystem rms = (RingmindSystem)s;
      RingSystem rs = rms.rs;
      MoonSystem ms = rms.ms;
      push();
      shader(ctx.shader, POINTS);


      for (int i = 0; i < rs.rings.size(); i++) {
        Ring r = rs.rings.get(i);
        Material mat = r.material;
        if (mat == null) {
          mat = ctx.mat;
        }
        stroke(mat.strokeColor, mat.partAlpha);
        strokeWeight(mat.strokeWeight);

        ctx.shader.set("weight", mat.partWeight);
        ctx.shader.set("sprite", mat.spriteTexture);
        ctx.shader.set("diffTex", mat.diffTexture);
        ctx.shader.set("view", pg.camera); //don't touch that :-)


        if (renderType==1) {
          beginShape(POINTS);
        } else {
          beginShape(LINES);
        }
        for (int ringI = 0; ringI < r.getMaxRenderedParticle(); ringI++) {
          RingParticle p = r.particles.get(ringI);
          vertex(scale*p.position.x, scale*p.position.y, scale*p.position.z);
        }
        endShape();
      }
      pop();

      if (withMoon) {
        ellipseMode(CENTER);
        push();
        for (Particle p : ms.particles) {

          Moon m=(Moon)p;
          pushMatrix();
          //translate(width/2, height/2);
          fill(m.c);
          stroke(m.c);
          //strokeWeight(m.radius*scale);
          strokeWeight(1);

          //beginShape(POINTS);
          translate(scale*m.position.x, scale*m.position.y, 0);
          sphere(m.radius*scale);
          //vertex(scale*m.position.x, scale*m.position.y, 2*m.radius*scale);
          //endShape();
          // circle(scale*position.x, scale*position.y, 2*radius*scale);
          popMatrix();
        }
        pop();
      }
    } else if (s instanceof ShearSystem) {
      //--------------------------------------------ShearSystemRender--------------------------------------------------

      //println("TEST");
      ShearSystem ss = (ShearSystem)s;
      push();
      shader(ctx.shader, POINTS);

      Material mat = ss.material;
      if (mat == null) {
        mat = ctx.mat;
      }

      stroke(mat.strokeColor, mat.partAlpha);
      strokeWeight(mat.strokeWeight);

      ctx.shader.set("weight", mat.partWeight);
      ctx.shader.set("sprite", mat.spriteTexture);
      ctx.shader.set("diffTex", mat.diffTexture);
      ctx.shader.set("view", pg.camera); //don't touch that :-)

      beginShape(POINTS);
      for (int PP = 0; PP < ss.particles.size(); PP++) {
        ShearParticle sp = (ShearParticle)ss.particles.get(PP);

        ////Highlight was boolean flag to show check for collisions in Shearing Particle
        //if (sp.highlight) {
        //  fill(255, 0, 0);
        //  stroke(255, 0, 0);
        //} else { 
        //  fill(255);
        //  stroke(255);
        //}
        vertex(-sp.position.y*width/ss.Ly, -sp.position.x*height/ss.Lx, 2*scale*sp.radius*width/ss.Ly, 2*scale*sp.radius*height/ss.Lx);
      }
      endShape();
      pop();

      if (ss.Guides) {
        for (int PP = 0; PP < ss.particles.size(); PP++) {
          ShearParticle sp = (ShearParticle)ss.particles.get(PP);
          //ss.displayPosition(sp.position, 1, color(255, 0, 0));
          push();
          translate(-sp.position.y*width/ss.Ly, -sp.position.x*height/ss.Lx, 0);
          //circle(0, 0, 2*scale*sp.radius*width/ss.Ly);
          ss.displayPVector(sp.velocity, 1000, color(0, 255, 0)); //green
          ss.displayPVector(sp.acceleration, 10000000, color(0, 0, 255)); //blue
          pop();
        }
      }

      //moonlet
      if (ss.Moonlet) {
        if (ss.Guides) {
          ellipseMode(CENTER);
          push();
          translate(0, 0);
          fill(255);
          sphere(ss.moonlet.radius/2);
          pop();
        }
      }
    } else if (s instanceof TiltSystem) {
      //--------------------------------------------TiltSystemRender--------------------------------------------------
      push();
      shader(ctx.shader, POINTS);
      TiltSystem r = (TiltSystem)s;
      //Ring r = rs.rings.get(0);
      // Ring r = rs.rings.get(i);

      Material mat = r.material;
      if (mat == null) {
        mat = ctx.mat;
      }

      stroke(mat.strokeColor, mat.partAlpha);
      strokeWeight(mat.strokeWeight);

      ctx.shader.set("weight", mat.partWeight);
      ctx.shader.set("sprite", mat.spriteTexture);
      ctx.shader.set("diffTex", mat.diffTexture);
      ctx.shader.set("view", pg.camera); //don't touch that :-)

      beginShape(POINTS);
      for (int ringI = 0; ringI < r.particles.size(); ringI++) {
        TiltParticle tp = (TiltParticle)r.particles.get(ringI);
        PVector position1 = tp.displayRotate();
        vertex(scale*position1.x, scale*position1.y, scale*position1.z);
      }
      endShape();

      pop();
    }
  }

  /**Render Method
   *@param s Particle System to render.
   *@param ctx 
   *@param renderType
   */
  public void renderComms(System s, RenderContext ctx, int renderType) {
    PGraphicsOpenGL pg = (PGraphicsOpenGL) ctx.pgfx.g;
    RingmindSystem rms= (RingmindSystem)s;
    push();
    shader(ctx.shader, POINTS);

    Ring r = rms.rs.rings.get(0);
    // Ring r = rs.rings.get(i);

    Material mat = r.material;
    if (mat == null) {
      mat = ctx.mat;
    }

    stroke(mat.strokeColor, mat.partAlpha);
    strokeWeight(mat.strokeWeight);

    ctx.shader.set("weight", mat.partWeight);
    ctx.shader.set("sprite", mat.spriteTexture);
    ctx.shader.set("diffTex", mat.diffTexture);
    ctx.shader.set("view", pg.camera); //don't touch that :-)


    //now lets go through all those particles and see if they are near to another and draw lines between them

    //stroke(255);
    //strokeWeight(10);
    beginShape(LINES);
    for (int i=0; i <1000; i++) {
      RingParticle rp = (RingParticle) r.particles.get(i);
      float distance=0;
      for (int j=0; j <3000; j++) {
        RingParticle rpj = (RingParticle) r.particles.get(j);
        distance = dist(scale*rp.position.x, scale*rp.position.y, scale*rpj.position.x, scale*rpj.position.y);
        if (distance < 20) {
          vertex(scale*rp.position.x, scale*rp.position.y);
          vertex(scale*rpj.position.x, scale*rpj.position.y);
        }
      }
    }
    endShape();

    pop();
  }
}

//----------------------------------------------------------------------------------------

/** Class RenderContext - what it is going to render (material and shader) and where (PApplet - sketch).
 * @author ashley james brown march-may.2019
 */
class RenderContext {
  RenderContext() {
    mat = new Material();
  }
  PShader shader;
  Material mat;
  PApplet pgfx;
}

//-----------------------------------------------------------------------------------------
/**
 *Custom Shaders for filter effects
 */
PShader gaussianBlur, metaBallThreshold;

/** Configures Filters
 */
public void loadFilters() {

  // Load and configure the filters
  gaussianBlur = loadShader("gaussianBlur.glsl");
  gaussianBlur.set("kernelSize", 32); // How big is the sampling kernel?
  gaussianBlur.set("strength", 7.0f); // How strong is the blur?

  //maybe? gives a kind of metaball effect but only at certain angles
  metaBallThreshold = loadShader("threshold.glsl");
  metaBallThreshold.set("threshold", 0.5f);
  metaBallThreshold.set("antialiasing", 0.05f); // values between 0.00 and 0.10 work best
}

/** Applies Filters
 */
public void applyFilters() {
  // Vertical blur pass
  gaussianBlur.set("horizontalPass", 0);
  filter(gaussianBlur);

  // Horizontal blur pass
  gaussianBlur.set("horizontalPass", 1);
  filter(gaussianBlur);

  //remove this for just a blurry thing without going to black and white but when backgroudn trails work could be glorious overly bright for teh abstract part
  // filter(metaBallThreshold); //this desnt work too well with depth rendering.
}

//-----------------------------------------------------------------------------------------

/** Class Material - represents a Material used to texture particles
 * @author ashley james brown march-may.2019
 */
class Material {
  PImage diffTexture;
  PImage spriteTexture;
  int strokeColor = 255;
  float partWeight = 1;      //do not change or sprite texture wont show unless its 1.
  float partAlpha = 0;       //trick to fade out to black.
  float strokeWeight = 1;    //usually 1 so we can see our texture but if we turn off we can make a smaller particle point as long as the weight above is bigger than 1.
}

/** Ring Particle Materials
 */
Material RingMat1, RingMat2, RingMat3, RingMat4, RingMat5, RingMat6;

/** Shearing Particle Material
 */
Material ShearMat1;

/** Method that assigns material objects to all the Material variables. 
 *  
 */
public void createMaterials() {

  //----------- Materials for RingSystem ---------------

  // first ring material is the deafult material fully showing
  RingMat1 =  new Material();
  RingMat1.strokeColor = color(255, 255, 255);
  RingMat1.spriteTexture = loadImage("partsmall.png");
  RingMat1.diffTexture = pg;
  RingMat1.strokeWeight = 1; //.1;
  RingMat1.partWeight = 10;
  RingMat1.partAlpha=255;

  //pink
  // second ring material to be different just as proof of concept
  RingMat2 =  new Material();
  RingMat2.strokeColor = color(203, 62, 117);
  RingMat2.spriteTexture = loadImage("partsmall.png");
  RingMat2.diffTexture = pg;
  RingMat2.strokeWeight = 2.1f;//.1
  RingMat2.partWeight = 10;
  RingMat2.partAlpha=255;

  // second ring material to be different just as proof of concept
  //more blue
  RingMat3 =  new Material();
  RingMat3.strokeColor = color(54, 73, 232);
  RingMat3.spriteTexture = loadImage("partsmall.png");
  RingMat3.diffTexture = pg;
  RingMat3.strokeWeight = 2.1f;//.1
  RingMat3.partWeight = 10;
  RingMat3.partAlpha=255;

  RingMat4 =  new Material();
  RingMat4.strokeColor = color(204, 206, 153);
  RingMat4.spriteTexture = loadImage("partsmall.png");
  RingMat4.diffTexture = pg;
  RingMat4.strokeWeight = 2.1f;//.1
  RingMat4.partWeight = 10;
  RingMat4.partAlpha=255;

  RingMat5 =  new Material();
  RingMat5.strokeColor = color(153, 21, 245);
  RingMat5.spriteTexture = loadImage("partsmall.png");
  RingMat5.diffTexture = pg;
  RingMat5.strokeWeight = 2.1f;//.1
  RingMat5.partWeight = 10;
  RingMat5.partAlpha=255;

  RingMat6 =  new Material();
  RingMat6.strokeColor = color(24, 229, 234);
  RingMat6.spriteTexture = loadImage("partsmall.png");
  RingMat6.diffTexture = pg;
  RingMat6.strokeWeight = 2.1f;//.1
  RingMat6.partWeight = 10;
  RingMat6.partAlpha=255;

  //----------- Materials for ShearSystem ---------------

  ShearMat1 =  new Material();
  ShearMat1.strokeColor = color(255, 255, 255);
  ShearMat1.spriteTexture = loadImage("partsmall.png");
  ShearMat1.diffTexture = pg;
  ShearMat1.strokeWeight = 2.1f;//.1
  ShearMat1.partWeight = 10;
  ShearMat1.partAlpha=255;
}



//----------Palette-----------------
//#FEB60A,#FF740A,#D62B00,#A30000,#640100,#FEB60A,#FF740A,#D62B00
//fire
//153,21,245
//----------------------------------

//----------------------------CAMERA-------------------------------------------------------------










Scene scene;

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

public void initScene() {

  scene = new Scene(this);
  // edit the json file for the starting view.
  // turn off the dispose method
  unregisterMethod("dispose", scene); //stops it autosaving the camera from where we last had it ech time and loads our default first bit of data for where we are looking

  scene.eyeFrame().setDamping(0.05f); //0 is a little too rigid
  scene.eye().centerScene(); //center the entire scene

  scene.eye().setPosition(new Vec(0, 0, 0)); //center the eye
  scene.camera().lookAt(scene.center()); // point it at 0,0,0

  //load json file with predone camera paths.... 
  scene.loadConfig(); //this also laods how the camera looks when we startup the very beginning but we will overwrite by using the scenes to change that.

  //trun off debug guides
  scene.setGridVisualHint(false);
  scene.setAxesVisualHint(false);

  //must set scene to be big so it redners properly
  scene.setRadius(500); //how big is the scene - bigger means slower to load at startup

  scene.showAll();
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// camera setups

// camera top down looking straight on down on the ring almost 2d from a zoom of 1000
public void initCamera() {
  scene.camera().setOrientation(new Quat(0, 0, 0, 1));
  scene.camera().setPosition(new Vec(0, 0, 1000));
  scene.camera().setViewDirection(new Vec (0, 0, -1));
}

public void zoomedCamera() {
  scene.camera().setOrientation(new Quat(0, 0, 0, 1));
  scene.camera().setPosition(new Vec(0, 0, 300));
  scene.camera().setViewDirection(new Vec (0, 0, -1));
}

public void closerCamera() {
  scene.camera().setOrientation(new Quat(0, 0, 0, 1));
  scene.camera().setPosition(new Vec(0, 0, 670));
  scene.camera().setViewDirection(new Vec (0, 0, -1));
}

public void toptiltCamera() {
  scene.camera().setOrientation(new Quat(-0.27797017f, -0.8494466f, -0.44852334f));
  scene.camera().setPosition(new Vec(216.607f, 262.6706f, -178.04265f));
  scene.camera().setViewDirection(new Vec (-0.50023884f, -0.6601704f, 0.5603001f));
}

//zoomed far back distant view of ring system
public void camera1() {
  scene.camera().setOrientation(new Quat(-0.95024925f, -0.2884153f, 0.11765616f, 0.9159098f));
  scene.camera().setPosition(new Vec(-800, 2100, 1800));
  scene.camera().setViewDirection(new Vec (0.2725f, -0.7403f, -0.61448f));
}

//side tilt from the middle
public void camera2() {
  scene.camera().setOrientation(new Quat(-0.9245066f, 0.025740312f, 0.38029608f, 4.032707f));
  scene.camera().setPosition(new Vec(-176, -208, 116));
  scene.camera().setViewDirection(new Vec (0.59f, 0.703f, -0.39f));
}

//slightly angled from aboe the ring looking down
public void camera3() {
  scene.camera().setOrientation(new Quat(-0.406788f, -0.40678796f, 0.817953f, 1.7704078f));
  scene.camera().setPosition(new Vec( -281.5827f, 0.0f, 212.75641f));
  scene.camera().setViewDirection(new Vec ( 0.7974214f, -5.960465e-8f, -0.60342294f));
}

//Zoomed out of Shearing box
public void camera4() {
  scene.camera().setOrientation(new Quat(0.0f, 0.0f, 0.0f, 0.0f));
  scene.camera().setPosition(new Vec( 0.0f, 0.0f, 924.92285f));
  scene.camera().setViewDirection(new Vec ( 0.0f, 0.0f, -1.0f));
}

//left side rotated toward the camera straight in view
public void camera6() {
  scene.camera().setOrientation(new Quat(0.071595766f, -0.99373794f, 0.08578421f, 1.1399398f));
  scene.camera().setPosition(new Vec(-342, -43, 160));
  scene.camera().setViewDirection(new Vec (0.8f, 0.11f, -0.42f));
}

public void camera9() {
  scene.camera().setOrientation(new Quat(-0.86009645f, -0.5100075f, -0.011246648f, 1.7854911f));
  scene.camera().setPosition(new Vec(-69.61055f, 96.30619f, -38.591106f));
  scene.camera().setViewDirection(new Vec (0.48656437f, -0.84730774f, 0.21289584f));

  //ideally translate for a better view
}

public void camera10() {
  scene.camera().setOrientation(new Quat(-0.38721877f, -0.87212867f, 0.2990871f, 2.547316f));
  scene.camera().setPosition(new Vec(-85.0407f, -32.172462f, -231.61795f));
  scene.camera().setViewDirection(new Vec (0.41859165f, 0.43964458f, 0.79466575f ));
}

public void cameraChaos() {
  scene.camera().setOrientation(new Quat(0.40550593f, -0.44041216f, -0.80100065f, 2.8794248f));
  scene.camera().setPosition(new Vec(-525.04645f, -798.2069f, 295.27277f ));
  scene.camera().setViewDirection(new Vec (0.52437866f, 0.79858387f, -0.2954503f));
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/** Method to Output Debug Information to Window Title Bar.
 */
public void titleText() {
  String txt_fps;
  try {
    txt_fps = String.format(getClass().getSimpleName()+ "   [size %d/%d]   [frame %d]   [fps %6.2f] [Time Elapsed in Seconds %d] [Simulation Time Elapsed in Hours %d]", width, height, frameCount, frameRate, PApplet.parseInt(millis()/1000.0f), PApplet.parseInt(s.totalSystemTime/3600.0f) );
  }
  catch(Exception e) {
    txt_fps = "";
  }
  surface.setTitle(txt_fps);
}
/**Class Ring - collection of ring particles 
 * @author Thomas Cann
 * @author ashley james brown
 */
class Ring {
  
  //render variables
  private int maxRenderedParticle;
  Material material = null;
  //ring variables
  ArrayList<RingParticle> particles;
  float r_inner, r_outer, Omega0, density;
  int c;

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Ring( float Inner, float Outer, int n_particles) {

    this.r_inner = Inner;
    this.r_outer = Outer;

    particles = new ArrayList<RingParticle>();
    for (int i = 0; i < n_particles; i++) {
      particles.add(new RingParticle(Inner, Outer));
    }

    Omega0 = kepler_omega((Inner + Outer)/2.0f);

    //set a default but overwritable by methods below for each ring and depends on state
    maxRenderedParticle = n_particles;

    this.density = density();
  }

  /**
   *  Method to add RingParticle to particles arraylist (increasing number ofrendered particles as well)
   */
  public void addParticle(RingParticle rp) {
    particles.add(rp);
    maxRenderedParticle += 1;
  }

  /**
   *  Get Method - MaxRenderedParticle
   *  @return maxRenderedParticle (used in Render)
   */
  public int getMaxRenderedParticle() {
    return maxRenderedParticle;
  }

  /**
   *  Set Method - MaxRenderedParticle
   *  @param newMax
   */
  public void setMaxRenderedParticle(int newMax) {
    maxRenderedParticle = min(particles.size(), newMax);
  }

  /** Method to calculate the Keplerian orbital angular frequency (using Kepler's 3rd law).
   *@param r Radial position (semi-major axis) to calculate the period [m].
   *@return The angular frequency [radians/s].
   */
  public float kepler_omega(float r) {
    return sqrt(1/(pow(r, 3.0f)));
  }

  /** Method to calculate the density of particles in ring.
   *@return denstiy [N/A].
   */
  public float density() {
    return particles.size() /(PI *(sq(r_outer) - sq(r_inner)));
  }
}
System s;
float G = 6.67408e-11f;       // Gravitational Constant 6.67408E-11[m^3 kg^-1 s^-2]



/**Class System
 */
public abstract class System {

  //Timestep variables 
  float dt;                                      //Simulation Time step [s]
  float simToRealTimeRatio = 3600.0f/1.0f;         // 3600.0/1.0 --> 1hour/second
  float maxTimeStep = 20* simToRealTimeRatio / 30;
  float totalSystemTime =0.0f;                    // Tracks length of time simulation has be running

  int n_particles = 10000;                       //Used for system initialiations 
  ArrayList<Particle> particles;
  ArrayList<Grid> g;

  static final float GMp = 3.7931187e16f;
  static final float Rp = 60268e3f;                // Length scale (1 Saturn radius) [m]
  static final float SCALE = 100/Rp;              // Converts from [m] to [pixel] with planetary radius (in pixels) equal to the numerator. Size of a pixel represents approximately 600km.

  Material material = RingMat1;

  /**  Updates System for one time step of simulation taking into account the System.
   */
  public void update() {

    update(this);

    //if (simToRealTimeRatio/frameRate < maxTimeStep) {
    //  this.dt= simToRealTimeRatio/frameRate;
    //} else {
    //  this.dt= maxTimeStep;
    //  println("At Maximum Time Step");
    //}

    //for (Particle p : particles) {
    //  p.set_getAcceleration(this);
    //}
    //for (Particle p : particles) {
    //  p.updatePosition(dt);
    //}
    //for (Grid x : g) {
    //  x.update(this);
    //}
    //for (Particle p : particles) {
    //  p.updateVelocity(p.getAcceleration(this), dt);
    //}
    //totalSystemTime += dt;
  }


  ///**  Updates System for one time step of simulation taking into account the System.
  // */
  public void update(System s) {

    if (simToRealTimeRatio/frameRate < maxTimeStep) {
      s.dt= simToRealTimeRatio/frameRate;
    } else {
      s.dt= maxTimeStep;
      println("At Maximum Time Step");
    }

    for (Particle p : particles) {
      p.set_getAcceleration(s);
    }
    for (Particle p : particles) {
      p.updatePosition(s.dt);
    }
    for (Grid x : g) {
      x.update(this);
    }
    for (Particle p : particles) {
      p.updateVelocity(p.getAcceleration(s), s.dt);
    }
    s.totalSystemTime += s.dt;
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class RingmindSystem extends System {

  RingSystem rs;
  MoonSystem ms;

  RingmindSystem(int ring_index, int moon_index) {
    rs = new RingSystem(ring_index);
    ms = new MoonSystem(moon_index);
  }

  public @Override void update() {
    if (simToRealTimeRatio/frameRate < maxTimeStep) {
      rs.dt= simToRealTimeRatio/frameRate;
    } else {
      rs.dt= maxTimeStep;
      println("At Maximum Time Step");
    }

    for (Particle p : rs.particles) {
      p.set_getAcceleration(this);
    }
    for (Particle p : rs.particles) {
      p.updatePosition(rs.dt);
    }
    for (Grid x : rs.g) {
      x.update(rs);
    }
    for (Particle p : rs.particles) {
      p.updateVelocity(p.getAcceleration(this), rs.dt);
    }
    totalSystemTime += rs.dt;
    ms.update();
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class RingSystem extends System {

  // What are the minimum and maximum extents in r for initialisation


  ArrayList<Ring> rings;

  RingSystem(int ring_index) {
    particles = new ArrayList<Particle>();
    g = new ArrayList<Grid>();

    rings = new ArrayList<Ring>();
    applyBasicMaterials();

    switch(ring_index) {
    case 1:
      rings.add(new Ring( 1.1f, 4.9f, n_particles)); //Generic Disc of Particles
      rings.get(0).material = RingMat2;
      break;
    case 2:
      //Saturn Ring Data (Source: Nasa Saturn Factsheet) [in Saturn radii]
      rings.add(new Ring( 1.110f, 1.236f, n_particles/10)); // D Ring: Inner 1.110 Outer 1.236
      rings.add(new Ring( 1.239f, 1.527f, n_particles/10)); // C Ring: Inner 1.239 Outer 1.527
      rings.add(new Ring( 1.527f, 1.951f, n_particles/10)); // B Ring: Inner 1.527 Outer 1.951
      rings.add(new Ring( 2.027f, 2.269f, n_particles/2));  // A Ring: Inner 2.027 Outer 2.269
      rings.add(new Ring( 2.320f, 2.321f, n_particles/10)); // F Ring: Inner 2.320 Outer *
      rings.add(new Ring( 2.754f, 2.874f, n_particles/10)); // G Ring: Inner 2.754 Outer 2.874
      //rings.add(new Ring(2.987, 7.964, 1000)); // E Ring: Inner 2.987 Outer 7.964
      //Gaps/Ringlet Data  // Titan Ringlet 1.292 // Maxwell Gap 1.452 // Encke Gap 2.26 // Keeler Gap 2.265
      applyBasicMaterials();
      break;

    case 3:
      importFromFileToGrid(this, "output.csv");
      break;

    case 4:
      rings.add(new Ring( 1, 3, 0));
      //rings.get(0).particles.add(new RingParticle(2, 0, 0, 0));
      break;

    case 5:
      //2 Discs of Particles
      rings.add(new Ring( 1.1f, 2.9f, n_particles/2));
      rings.add(new Ring( 4.5f, 4.7f, n_particles/2));
      break;

    case 6:
      //Square
      importFromFileToGrid(this, "Square.csv");
      break;  

    case 10:
      // main RINGMIND
      g.add(new Grid(1.0f, 3.4f, 1e-8f, 1e4f));
      g.add(new Grid(3.4f, 5.0f, 1e-8f, 1e4f)); //switch 1E-8 and go to 2E-7
      //g.add(new Grid(3.4, 5.0, 2E7, 1E4)); //switch 1E-8 and go to 2E-7
      rings.add(new Ring( 1.110f, 1.236f, n_particles/12)); //inner ring
      rings.add(new Ring( 1.611f, 2.175f, n_particles/4)); //propeller ring
      rings.add(new Ring( 2.185f, 2.6f, n_particles/4));  //propeller ring
      rings.add(new Ring( 2.794f, 2.795f, n_particles/6)); //narrow ring
      rings.add(new Ring( 2.920f, 2.921f, n_particles/6)); //narrow ring
      rings.add(new Ring( 3.5f, 3.8f, n_particles/3)); //clumping ring

      for (Ring r : rings) {
        r.material = RingMat3;
      }
      rings.get(0).material = RingMat4;
      rings.get(1).material = RingMat2;
      rings.get(2).material = RingMat2;
      rings.get(3).material = RingMat6;
      rings.get(4).material = RingMat6;
      rings.get(5).material = RingMat5;

      break;

    case 11:
      // main RINGMIND
      g.add(new Grid(1.0f, 3.4f, 1e-8f, 1e4f));
      g.add(new Grid(3.4f, 5.0f, 9e-7f, 1e4f)); //switch 1E-8 and go to 2E-7
      //g.add(new Grid(3.4, 5.0, 2E7, 1E4)); //switch 1E-8 and go to 2E-7
      rings.add(new Ring( 1.110f, 1.236f, n_particles/12)); //inner ring
      rings.add(new Ring( 1.611f, 2.175f, n_particles/4)); //propeller ring
      rings.add(new Ring( 2.185f, 2.6f, n_particles/4));  //propeller ring
      rings.add(new Ring( 2.794f, 2.795f, n_particles/6)); //narrow ring
      rings.add(new Ring( 2.920f, 2.921f, n_particles/6)); //narrow ring
      rings.add(new Ring( 3.5f, 3.8f, n_particles/3)); //clumping ring   

      for (Ring r : rings) {
        r.material = RingMat3;
      }
      rings.get(0).material = RingMat4;
      rings.get(1).material = RingMat2;
      rings.get(2).material = RingMat2;
      rings.get(3).material = RingMat6;
      rings.get(4).material = RingMat6;
      rings.get(5).material = RingMat5;

      break;

    case 13:
      //rings.add(new Ring( 5.0, 5.2, 22500));
      //// rings.get(0).particles.clear();
      ////addParticlesFromTable("outputParticles.csv");
      //// rings.add(new Ring(1,5.0,5.2,1000));

      for (Ring r : rings) {
        r.material = RingMat5;
      }
      break;

    default:
      break;
    }

    for (Ring r : rings) {
      for (Particle p : r.particles) {
        particles.add(p);
      }
    }
    calcDensity();
  }

  /** Calculated relative densities to inner most ring.
   */
  public void calcDensity() {
    for (int i =0; i<rings.size(); i++) {
      rings.get(i).density = rings.get(i).density()/rings.get(0).density();
    }
  }
  public void applyBasicMaterials() {
    for (Ring r : rings) {
      r.material = RingMat1;
    }
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


/** Class MoonSystem - represents
 *
 */
class MoonSystem extends System {


  MoonSystem(int moon_index) {

    particles = new ArrayList<Particle>();
    g = new ArrayList<Grid>();

    switch(moon_index) {

      case(1):
      //no moons
      break;

      case(2):
      //Adding All 18 of Saturn Moons
      for (int i = 0; i < 18; i++) {
        addMoon(i, particles);
      }
      break;

      case(3):
      // Adding Specific Moons ( e.g. Mima, Enceladus, Tethys, ... )
      addMoon(5, particles); //add the first 5 moons
      //addMoon(7, moons);
      //addMoon(9, moons);
      //addMoon(12, moons);
      //addMoon(14, moons);
      break;

      case(4):
      // Inner smaller moons
      addMoon(19, particles);
      addMoon(20, particles);
      addMoon(21, particles);
      addMoon(22, particles);
      addMoon(23, particles);
      // Larger outer moons
      addMoon(24, particles);
      addMoon(25, particles);
      addMoon(26, particles);
      addMoon(27, particles);
      addMoon(28, particles);
      break;

    default:
      break;
    }
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


class AlignableMoonSystem extends MoonSystem {
  AlignableMoonSystem(int moon_index) {
    super(moon_index);
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/**Class ShearSystem
 *@author Thomas Cann
 */
class ShearSystem extends System {

  Boolean Moonlet = false;
  Boolean Self_Grav = false;
  Boolean Collisions =false;
  Boolean Output = false;
  Boolean A1 =true;
  Boolean A2 =true;
  Boolean Guides = true;
  Boolean Reset =false;

  //Simulation dimensions [m]
  int Lx = 1000;       //Extent of simulation box along planet-point line [m].
  int Ly = 2000;       //Extent of simulation box along orbit [m].

  //Initialises Simulation Constants
  final float GM = 3.793e16f;   //Shear Gravitational parameter for the central body, defaults to Saturn  GM = 3.793e16.
  final float r0 = 130000e3f;   //Central position in the ring [m]. Defaults to 130000 km.
  final float Omega0 = sqrt(GM/(pow(r0, 3.0f))); //The Keplerian orbital angular frequency (using Kepler's 3rd law). [radians/s]
  final float S0 = -1.5f*Omega0; //"The Keplerian shear. Equal to -(3/2)Omega for a Keplerian orbit or -rdOmega/dr. [radians/s]

  Moonlet moonlet;

  ShearSystem() {
    g = new ArrayList<Grid>();
    particles = new ArrayList<Particle>();
    moonlet = new Moonlet();
    random_start();
  }

  /** Take a step using the Velocity Verlet (Leapfrog) ODE integration algorithm.
   * Additional Method to Check if particles have left simulation.
   */
  public @Override void update() {

    super.update();

    //Have any particles left the simulation box, or collided with the moonlet?
    //If so, remove and replace them.
    for (Particle p : particles) {
      ShearParticle x =(ShearParticle)p;
      if (particle_outBox(x)) {
        x.Reset(this);
      }
      if (Moonlet) {
        if (particle_inMoonlet(x)) {
          x.Reset(this);
        }
      }
    }
  }

  /** Method to boolean if Particle is out of ShearingBox.
   *@param x  A Particle to inject.
   *@return True if out of Shearing Box
   */
  public boolean particle_outBox(ShearParticle x) {
    if ((x.position.x >Lx/2)||(x.position.x<-Lx/2)||(x.position.y<-Ly/2)||(x.position.y>Ly/2)) {
      return true;
    } else {
      return false;
    }
  }
  /** Method to boolean if Particle is out of ShearingBox.
   *@param x  A Particle to inject.
   *@return True if out of Shearing Box
   */
  public boolean particle_inMoonlet(ShearParticle x) {
    if ((x.position.mag() < moonlet.radius)) {
      //moonlet_r +=x.radius*0.1; 
      //moonlet_GM += x.GM;
      return true;
    } else {
      return false;
    }
  }
  /** Method to inject a number of Particle object into Shearing Box.
   *@param n  Number of Particle to inject.
   */
  public void random_inject(float n) {
    //particles.add(new Moonlet());
    for (int i = 0; i < n; i++) {
      particles.add(new ShearParticle(this));
    }
  }

  /** Method to Initialise the simulation with a random set of starting particles at the edges (in y).
   */
  public void random_start() {
    random_inject(n_particles);
  }

  /** Method to calculate the Keplerian orbital period (using Kepler's 3rd law).
   *@param r  Radial position (semi-major axis) to calculate the period [m].
   *@return   The period [s].
   */
  public float kepler_period(float r) {
    return 2.0f*PI*sqrt((pow(r, 3.0f))/GM);
  }

  /** Method to calculate the Keplerian orbital angular frequency (using Kepler's 3rd law).
   *@param r  Radial position (semi-major axis) to calculate the period [m].
   *@return   The angular frequency [radians/s].
   */
  public float kepler_omega(float r) {
    return sqrt(GM/(pow(r, 3.0f)));
  }

  /** Method to calculate the Keplerian orbital speed.
   *@param r  Radial position (semi-major axis) to calculate the period [m].
   *@return   The speed [m/s].
   */
  public float kepler_speed(float r) {
    return sqrt(GM/r);
  }

  /** Method to calculate the Keplerian shear. Equal to -(3/2)Omega for a Keplerian orbit or -rdOmega/dr.
   *@param r Radial position (semi-major axis) to calculate the period [m]. 
   *@return Shear [radians/s].
   */
  public float kepler_shear(float r) {
    return -1.5f*kepler_omega(r);
  }


  public void initTable() {
    addParticlesFromTable(this, "shearoutput.csv");
  }

  /**Display vector from the centre of screen to position that a particle is rendered
   * @param v vector to display from middle of screen.
   * @param scale multiple by magnitude.
   * @param c color of line.
   */
  public void displayPosition(PVector v, float scale, int c) {
    stroke(c);
    line(0, 0, -v.y*scale*width/Ly, -v.x*scale*height/Lx);
  }

  /**Display vector from the centre of screen with length and direction of vector (no screen dimension scaling)
   * @param v vector to display from middle of screen.
   * @param scale multiple by magnitude.
   * @param c color of line.
   */
  public void displayPVector(PVector v, float scale, int c) {
    stroke(c);
    line(0, 0, -v.y*scale, -v.x*scale);
  }
}

/**Class TiltSystem
 * @author Thomas Cann
 */
class TiltSystem extends System {

  float Max_Inclination=80; //Maximum Magnitude of Inclined Planes round x-axis[degrees]
  float Min_Inclination=1;  //Minimum Magnitude of Inclined Planes round x-axis[degrees]
  float Lambda= 8e-5f;       //Exponential decay constant [milliseconds^-1] == 1/LAMBDA -> Mean Life Time[ milliseconds]
  //Example Ranges for Lambda ==> 8E-5 decays in about 30seconds // 3E-5 decays in 90 seconds;
  float Inner = 1.1f;        //Inner Radius for Particles[Planetary Radi] 
  float Outer = 4.9f;        //Outer Radius for Particles[Planetary Radi] 

  /**
   *  Default Constructor
   */
  TiltSystem() {
    particles = new ArrayList<Particle>();
    g = new ArrayList<Grid>();

    for (int i = 0; i < n_particles; i++) {
      particles.add(new TiltParticle(Inner, Outer, Max_Inclination, Min_Inclination, Lambda));
    }
  }
}

//---------------------------------------------------------------------------------------------

/** Method addMoon - method to add specific moon to Arraylist of Particles.
 * @param i index of switch statement
 * @param m ArrayList if Particles
 */
public void addMoon(int i, ArrayList<Particle> m) {

  //Source: Nasa Saturn Factsheet

  switch(i) {
  case 0:
    // Pan Mass 5e15 [kg] Radius 1.7e4 [m] Orbital Radius 133.583e6 [m]
    m.add(new Moon(G*5e15f, 1.7e4f, 133.5832e6f));
    break;
  case 1:
    // Daphnis Mass 1e14 [kg] Radius 4.3e3 [m] Orbital Radius 136.5e6 [m]
    m.add(new Moon(G*1e14f, 4.3e3f, 136.5e6f));
    break;
  case 2:
    // Atlas Mass 7e15 [kg] Radius 2e4 [m] Orbital Radius 137.67e6 [m]
    m.add(new Moon(G*7e15f, 2.4e4f, 137.67e6f));
    break;
  case 3:
    // Promethieus Mass 1.6e17 [kg] Radius 6.8e4 [m] Orbital Radius 139.353e6 [m]
    m.add(new Moon(G*1.6e17f, 6.8e4f, 139.353e6f));
    break;
  case 4:
    // Pandora Mass 1.4e17 [kg] Radius 5.2e4 [m] Orbital Radius 141.7e6 [m]
    m.add(new Moon(G*1.4e17f, 5.2e4f, 141.7e6f));
    break;
  case 5:
    // Epimetheus Mass 5.3e17 [kg] Radius 6.5e4 [m] Orbital Radius 151.422e6 [m]
    m.add(new Moon(G*5.3e17f, 6.5e4f, 151.422e6f, color(0, 255, 0)));
    break;
  case 6:
    // Janus Mass 1.9e18 [kg] Radius 1.02e5 [m] Orbital Radius 151.472e6 [m]
    m.add(new Moon(G*1.9e18f, 1.02e5f, 151.472e6f));
    break;
  case 7: 
    // Mimas Mass 3.7e19 [kg] Radius 2.08e5 [m] Obital Radius 185.52e6 [m]
    m.add(new Moon(G*3.7e19f, 2.08e5f, 185.52e6f));
    break;
  case 8:
    // Enceladus Mass 1.08e20 [kg] Radius 2.57e5 [m] Obital Radius 238.02e6 [m]
    m.add(new Moon(G*1.08e20f, 2.57e5f, 238.02e6f));
    break;
  case 9:
    // Tethys Mass 6.18e20 [kg] Radius 5.38e5 [m] Orbital Radius 294.66e6 [m]
    m.add(new Moon(G*6.18e20f, 5.38e5f, 294.66e6f));
    break;
  case 10:
    // Calypso Mass 4e15 [kg] Radius 1.5e4 [m] Orbital Radius 294.66e6 [m]
    m.add(new Moon(G*4e15f, 1.5e4f, 294.66e6f));
    break;
  case 11:
    // Telesto Mass 7e15 [kg] Radius 1.6e4 [m] Orbital Radius 294.66e6 [m]
    m.add(new Moon(G*7e15f, 1.6e4f, 294.66e6f));
    break;
  case 12:
    // Dione Mass 1.1e21 [kg] Radius 5.63e5 [m] Orbital Radius 377.4e6 [m]
    m.add(new Moon(G*1.1e21f, 5.63e5f, 377.4e6f));
    break;
  case 13:
    // Helele Mass 3e16 [kg] Radius 2.2e4 [m] Orbital Radius 377.4e6[m]
    m.add(new Moon(G*3e16f, 2.2e4f, 377.4e6f));
    break;
  case 14:
    // Rhea Mass 2.31e21 [kg] Radius 7.65e5 [m] Orbital Radius 527.04e6 [m]
    m.add(new Moon(G*2.31e21f, 7.65e5f, 527.4e6f));
    break;
  case 15:
    // Titan Mass 1.3455e23 [kg] Radius 2.575e6 [m] Orbital Radius 1221.83e6 [m]
    m.add(new Moon(G*1.34455e23f, 2.57e6f, 1221.83e6f));
    break;
  case 16:
    // Hyperion Mass 5.6e18 [kg] Radius 1.8e5 [m] Orbital Radius 1481.1e6 [m]
    m.add(new Moon(G*5.6e18f, 1.8e5f, 1481.1e6f));
    break;
  case 17:
    // Iapetus Mass 1.81e21 [kg] Radius 7.46e5 [m] Orbital Radius 3561.3e6 [m]
    m.add(new Moon(G*1.81e21f, 7.46e5f, 3561.3e6f));
    break;
  case 18:
    // Pheobe Mass 8.3e18 [kg] Radius 1.09e5 [m] Orbital Radius 12944e6 [m] 
    m.add(new Moon(G*8.3e18f, 1.09e5f, 12994e6f));
    break;
    // Inner smaller moons
  case 19:
    m.add(new Moon(G*3.7e18f, 1.77e6f, 1.373657091f*System.Rp));    
    break;
  case 20:
    m.add(new Moon(G*1.5e20f, 2.66e6f, 2.180544711f*System.Rp));
    break;
  case 21:
    m.add(new Moon(G*9.0e18f, 9.90e5f, 2.857321894f*System.Rp));
    break;
  case 22:
    m.add(new Moon(G*3.7e19f, 1.32e6f, 3.226611418f*System.Rp));
    break;
  case 23:
    m.add(new Moon(G*3.7e19f, 4.08e6f, 4.0165977f*System.Rp));
    break;
    // Larger outer moons
  case 24:
    m.add(new Moon(G*2.31e21f, 1.65e7f, 8.75091259f*System.Rp));
    break;
  case 25:
    m.add(new Moon( G*4.9e20f, 6.85e7f, 16.49f*System.Rp));  
    break;
  case 26:
    m.add(new Moon( G*1.34455e23f, 8.57e7f, 20.27327f*System.Rp));  
    break;
  case 27:
    m.add(new Moon( G*3.7e22f, 2.08e8f, 34.23f*System.Rp));
    break;
  case 28:
    m.add(new Moon( G*1.81e21f, 7.46e7f, 49.09f*System.Rp));
    break;
  }
}


//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//import java.util.concurrent.TimeUnit;
//import java.util.concurrent.ExecutorService;
//import java.util.concurrent.Executors;

///**
// *
// */
//class ThreadingSystem extends System {
  
  

//ExecutorService executor;
//int numThreads = 8;

//Render

//if ( s instanceof ThreadingSystem) {
//  push();
//  shader(ctx.shader, POINTS);

//  Material mat  = RingMat1;
//  stroke(mat.strokeColor, mat.partAlpha);
//  strokeWeight(mat.strokeWeight);

//  ctx.shader.set("weight", mat.partWeight);
//  ctx.shader.set("sprite", mat.spriteTexture);
//  ctx.shader.set("diffTex", mat.diffTexture);
//  ctx.shader.set("view", pg.camera); //don't touch that :-)

//  if (renderType==1) {
//    beginShape(POINTS);
//  } else {
//    beginShape(LINES);
//  }
//  for (int x = 0; x < s.particles.size(); x++) {
//    Particle p = s.particles.get(x);
//    vertex(scale*p.position.x, scale*p.position.y, scale*p.position.z);
//  }
//  endShape();

//  pop();
//} else

//Requires Thread Particle with these methods.
//    /** 
// *  Update Position of particle based of Velocity and Acceleration. 
// */
//Runnable updatePosition(float dt) {
//  class UpdatePosition implements Runnable {
//    float dt;
//    UpdatePosition(float dt) {
//      this.dt = dt;
//    }

//    public void run() {
//      position.add(velocity.copy().mult(dt)).add(acceleration.copy().mult(0.5*sq(dt)));
//    }
//  }
//  return new UpdatePosition(dt);
//}

///**
// * Updates the velocity of this Particle (Based on Velocity Verlet) using 2 accelerations. 
// * @param a current acceleration of particle
// */
//Runnable updateVelocity(PVector a, float dt) {
//  class UpdateVelocity implements Runnable {
//    PVector a;
//    float dt;
//    UpdateVelocity(PVector a, float dt ) {
//      this.dt =dt;
//      this.a = a;
//    }
//    public void run() {
//      velocity.add(PVector.add(acceleration.copy(), a).mult(0.5 *dt));
//    }
//  }
//  return new UpdateVelocity( a, dt);
//}

//  /**
//   */
//  ThreadingSystem() {



//    for (int i = 0; i < 10000; i++) {
//      particles.add(new RingParticle(1, 3));
//    }
//  }

//    void update() {

//      if (simToRealTimeRatio/frameRate < maxTimeStep) {
//        this.dt= simToRealTimeRatio/frameRate;
//      } else {
//        this.dt= maxTimeStep;
//        println("At Maximum Time Step");
//      }

//       for (Particle p : particles) {
//        p.set_getAcceleration(this);
//      }
//      executor = Executors.newFixedThreadPool(numThreads);
//      for (Particle p : particles) {
//        executor.execute(p.updatePosition(dt));
//      }

//      executor.shutdown();
//      while (!executor.isTerminated()) {
//      }

//         for (Grid x : g) {
//        x.update(this);
//      }

//      executor = Executors.newFixedThreadPool(numThreads);
//      for (Particle p : particles) {
//        executor.execute(p.updateVelocity(p.getAcceleration(this),dt));
//      }

//      executor.shutdown();
//      while (!executor.isTerminated()) {
//      }
//      totalSystemTime += dt;
//    }
//}
/** Enumerated Variable State - Values equaling Different Display States
 */
enum State {
  // State called at start of program in initialise everything. 
  initState, 

  /**
   * Main Initialisation States
   */
    //
    introState, 
    //
    ringmindState, 
    //
    ringmindUnstableState, 
    //forming - particles not in plane, collapsing down to a ring.
    formingState, 
    //shear - 
    shearState, 
    //tuning - the ring sound, lets just focus on a ring
    tuningState, 
    //
    connectedState, 
    //
    threadingState, 
    //
    saturnState, 
    //
    ringboarderState, 
    //
    addAlienLettersState, 
    //outro - what is a ringmind lets return back to the beginning.
    
    resonanceState,
    
    outroState, 

  /**
   * Display States
   */
    fadetoblack, 
    fadeup, 
    nocamlock
};

State systemState;

/**Setup States Method - called to initialise the state. 
 */
public void setupStates() {
  switch(systemState) {
  case initState:

    renderSetup();
    initScene();   //setup proscene camera and eye viewports etc
    createMaterials();       //extra materials we can apply to the rings

    //init with = rings 10,  moons 4, rendering normal =true (titl would be false);
    s = new RingmindSystem(1,0);  

    break;
  case introState:

    initCamera();
    s = new RingmindSystem(2, 2); 
    break;

  case ringmindState:

    useAdditiveBlend=true;
    closerCamera();
    s = new RingmindSystem(10, 4);


    break;

  case ringmindUnstableState:

    closerCamera();
    useAdditiveBlend=true;
    G=6.67408e-9f;
    s = new RingmindSystem(11, 4);

    break;

  case connectedState:

    useAdditiveBlend=true;
    //Connecting=true; 
    //simToRealTimeRatio = 360.0/1.0; //slow it down
    zoomedCamera();
    s = new RingmindSystem(1, 2);
    break;

  case saturnState:

    s = new RingmindSystem(2, 4);

    break;

  case ringboarderState:

    //zoomedCamera();
    initCamera();
    s = new RingmindSystem(13, 0);


    break;
  case addAlienLettersState:
    if (s instanceof RingmindSystem) {
      //RingmindSystem rms = (RingmindSystem)s;
      addParticlesFromTable(s, "outputParticles.csv");
      // rms.rs.rings.get(1).setMaxRenderedParticle(rms.rs.rings.get(1).particles.size());
      //for (Ring r : rms.rs.rings) {
      //  r.material = RingMat5;
      //}
    }
    break;

  case formingState:
    useAdditiveBlend=true;
    s = new TiltSystem();
    break;

    //case orbitalState:

    //  drawMoons=false;
    //  Threading=true;
    //  toptiltCamera();
    //  G=6.67408E-13;
    //  Saturn = new RingSystem(1, 2, true);
    //  applyBasicMaterials();
    //  for (Ring r : Saturn.rings) {
    //    r.material = RingMat5;
    //  }
    //  for (Moon m : Saturn.moons) {
    //    m.radius = 1;
    //  }

    //  Saturn.moons.get(2).GM =4.529477495e13;
    //  Saturn.moons.get(0).GM =2.529477495e13;

    //  break;

  case shearState:
    useAdditiveBlend=true;
    zoomedCamera();
    s = new ShearSystem();
    s.simToRealTimeRatio = 2000.0f/1.0f;  
    break;
  }
}

/**Update State Method - separate update method for each state. 
 *depending on which scenario do different things and render differently etc
 *@param t 
 */
public void updateCurrentState(int t) {

  if (Running) {
    if(s != null){
    s.update();
    }
  }

  if (useTrace) {
    scene.beginScreenDrawing();
    fill(0, traceAmount);
    rect(0, 0, width, height);
    scene.endScreenDrawing();
  } else {
    background(0);
  }

  // Display all of the objects to screen using the renderer.
  if (useAdditiveBlend) {
    blendMode(ADD);
  } else {
    blendMode(NORMAL);
  }
   
  renderOffScreenOnPGraphicsClean();
  switch(systemState) {
  case connectedState:
  renderer.renderComms(s, renderContext, 1);
    break;
    
  default:
   renderer.render(s, renderContext, 1);
    break;
  }

  if (useFilters) {
    applyFilters();
  }

  titleText();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Ringmind" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
