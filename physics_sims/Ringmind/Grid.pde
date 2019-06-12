//Grid Default Variables 
float R_MIN = 1;                   //[Planetary Radi] 
float R_MAX = 5;                   //[Planetary Radi] 
float GRID_DELTA_R = 0.1;          //[Planetary Radi]  
float GRID_DELTA_THETA = 1;        //[Degrees]
float GRID_DRAG_CONSTANT = 5E-7;   //[s^{2}]
float GRID_DRAG_PROBABILITY = 1E4 ;//[[Planetary Radi^{2}.s]

/**Class Grid - polar spatial subdivision using density of particles, average velocity and center of mass to probabliticly model collisions. 
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
    this.sizeTheta =int(360/this.dtheta);               //Size of 1st Dimension of Grid Arrays
    this.sizeR = int((this.r_max-this.r_min)/this.dr);  //Size of 2nd Dimension of Grid Arrays
    this.grid = new int[sizeTheta][sizeR];
    this.gridNorm = new float[sizeTheta][sizeR];
    this.gridV = new PVector[sizeTheta][sizeR];
    this.gridCofM = new PVector[sizeTheta][sizeR];
    this.drag_c= drag_c; 
    this.drag_p= drag_p; 
    reset();
  }

  /**
   *  Grid Constuctor - Taking in a value for r_min and r_max and drag constants but all the other values from global variables. 
   */
  Grid(float r_min, float r_max ,float drag_c, float drag_p) {
    this(r_min, r_max, GRID_DELTA_R, GRID_DELTA_THETA, drag_c, drag_p);
  }
  /** 
   * Sets all the values in the arrays to zero. Called at start of Update Method.
   */
  void reset() {
    for (int i = 0; i < int(360/dtheta); i++) {
      for (int j = 0; j < int((r_max-r_min)/dr); j++) {
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
  float angle(Particle p) {
    return (atan2(p.position.y, p.position.x)+TAU)%(TAU);
  }

  /**
   * Returns the index of which angular bin a particle belongs to. 
   *
   * @param   p  a particle with a position vector. 
   * @return  i index of grid [between 0 and 360/dr]   
   */
  int i(Particle p) {
    return i(angle(p));
  }

  /**
   * Returns the index of which angular bin a particle belongs to. 
   *
   * @param   angle between 0 and 2PI measured from horizontal right from clockwise . 
   * @return  i index of grid [between 0 and 360/dr]  
   */
  int i(float angle) {
    return floor(degrees(angle)/dtheta);
  }

  /**
   * Returns angle of the centre of the cell (from horizontal, upward, clockwise)
   * @param i angular index of grid [between 0 and 360/dr]
   * @return angle of the centre of the cell
   */
  float angleCell(int i) {
    return radians(dtheta*(i+0.5));
  }

  /**
   *    Calculates the difference in angle between a particle and the centre of its cell
   */
  float angleDiff(Particle p) {
    return angleCell(i(p))-angle(p);
  }

  /**
   * Returns the index of which radial bin a particle belongs to.
   *
   * @param p a particle with a position vector.
   * @return j index of grid[between 0 and ring thickness / dr]
   */
  int j(Particle p) {
    return j(p.position.mag());
  }

  /**
   * Returns the index of which radial bin a particle belongs to.
   *
   * @param radius 
   * @return j index of grid[between 0 and ring thickness / dr]
   */
  int j(float radius) {
    return floor((radius/System.Rp - r_min)/dr);
  }

  /**
   * Returns radius of the centre of a cell (from x=0 and y=0)
   * @param j  index of grid[between 0 and ring thickness / dr]
   * @return 
   */
  float radiusCell(int j) {
    return System.Rp*(r_min + dr*(j+0.5));
  }

  float radialScaling(Particle p) {
    return sqrt(radiusCell(j(p))/p.position.mag());
  }

  /**
   * Check to see if the Particle is in the grid .
   *
   * @param p a particle with a position vector.
   * @return
   */
  boolean validij(Particle p) {
    return validij(i(p), j(p));
  }

  boolean validij(int i, int j ) {
    boolean check = false;
    if (i< sizeTheta && i>=0  ) {
      if (j < int((r_max-r_min)/dr)  && j>=0) {
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
  PVector centreofCell(int i, int j ) {
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
  PVector keplerianVelocityCell(int i, int j) {
    float r = radiusCell(j);  
    float angle = angleCell(i);
    return new PVector(sqrt(System.GMp/(r))*sin(angle), -sqrt(System.GMp/(r))*cos(angle));
  }

  /**
   * Acceleration on a particle due to average values in a grid.  
   * @param Particle p a particle with a position vector.
   * @return  
   */
  PVector gridAcceleration(Particle p, float dt) {

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
  PVector dragAcceleration(Particle p, float dt) {

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

  PVector selfGravAcceleration(Particle p ) {

    //Find which cell the particle is in.
    int x = i(p);
    int y = j(p);

    PVector a_selfgrav = new PVector();

    float r = 0.5;
    if (random(1) < r) {

      float a, d; // Strength of the attraction number of particles in the cell. 
      d=1E8;

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
  
  /**
   * Loops through all the particles adding relevant properties to  grids. Will allow generalised rules to be applied to particles.
   *
   * @param rs a collection of particles represent a planetary ring system. 
   */
  void update(System s) {

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
      for (int i = 0; i < int(360/dtheta); i++) {
        for (int j = 0; j < int((r_max-r_min)/dr); j++) {
          total += grid[i][j];
          if (grid[i][j] !=0) {
            gridCofM[i][j].div(grid[i][j]);
          } else {
            gridCofM[i][j].set(0.0, 0.0, 0.0);
          }
        }
      }




      //  //Looping through all the grid cell combining properties to calculate normalised values and average values from total values.
      for (int i = 0; i < int(360/dtheta); i++) {
        for (int j = 0; j < int((r_max-r_min)/dr); j++) {

          gridNorm[i][j] = grid[i][j]/((r_min+j*dr+dr/2)*dr*radians(dtheta)*total);


          if (grid[i][j] !=0) {
            gridV[i][j].div(grid[i][j]);
          } else {
            gridV[i][j].set(0.0, 0.0, 0.0);
          }
        }
      }
    }
  }

  /**
   * Returns a Table Object from a 2D array containing Int data type.
   *
   * @param grid a 2D array of values. 
   */
  Table gridToTable(int grid[][]) {
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
  Table gridToTable(float grid[][]) {
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
  Table gridToTable(PVector grid[][]) {
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
