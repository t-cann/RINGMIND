/**Class Grid
 * @author Thomas Cann
 * @version 1.0
 */
class Grid {


  float dr= 0.1; //[Planetary Radi]  
  float dtheta = 1; // [Degrees]

  int sizeTheta =int(360/dtheta);
  int sizeR = int((r_max-r_min)/dr);

  int grid[][];
  float gridNorm[][];
  PVector gridV[][];

  float minSize = 4*(sq(r_min *radians(dtheta)/2)+sq(dr)); //Based on the minimum grid size.

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Grid() {


    grid = new int[sizeTheta][sizeR];
    gridNorm = new float[sizeTheta][sizeR];
    gridV = new PVector[sizeTheta][sizeR];

    reset();
  }

  /** 
   * Sets all the values in the arrays to zero. Called at start of Update Method.
   */
  void reset() {
    for (int i = 0; i < int(360/dtheta); i++) {
      for (int j = 0; j < int((r_max-r_min)/dr); j++) {
        grid[i][j] = 0;
        gridNorm[i][j] =0;
        gridV[i][j]= new PVector();
      }
    }
  }

  /**
   * Returns the index of which angular bin a particle belongs to.
   *
   * @param   p  a particle with a position vector. 
   * @return     
   */
  int i(Particle p) {
    return floor((degrees(atan2(p.position.y, p.position.x))+180)/dtheta);
  }

  /**
   * Returns the index of which radial bin a particle belongs to.
   *
   * @param p a particle with a position vector.
   * @return
   */
  int j(Particle p) {
    return floor((p.position.mag()/Rp - r_min)/dr);
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
   * Returns a vector from the centre of RingSystem to the centre of a specific angular and radial bin. TODO Switch to Particle?
   */
  PVector centreofCell(int i, int j ) {
    float r = radiusCell(j);  
    float angle = angleCell(i);
    return new PVector(r*cos(angle), r*sin(angle));
  }

  PVector keplerianVelocityCell(int i, int j) {
    float r = radiusCell(j);  
    float angle = angleCell(i);
    return new PVector(sqrt(GMp/(r))*sin(angle), -sqrt(GMp/(r))*cos(angle));
  }

  /**
   * Returns radius of the centre of a cell (from x=0 and y=0)
   */
  float radiusCell(int j) {
    return Rp*(r_min + dr*(j+0.5));
  }

  /**
   * Returns angle of the centre of the cell (from horizontal, upward, clockwise)
   */
  float angleCell(int i) {
    return radians(dtheta*(i+0.5) +180);
  }

  // Calculates the difference in radius between a particle and the centre of its cell
  float radialDiff(Particle p) {
    return radiusCell(j(p))-p.position.mag();
  }

  float radialScaling(Particle p) {
    return sqrt(radiusCell(j(p))/p.position.mag());
  }

  // Calculates the difference in angle between a particle and the centre of its cell
  float angleDiff(Particle p) {
    return (angleCell(i(p))-((atan2(p.position.y, p.position.x))));
  }
  

  


  

  /**
   * Loops through all the particles adding relevant properties to  grids. Will allow generalised rules to be applied to particles.
   *
   * @param rs a collection of particles represent a planetary ring system. 
   */
  void update(RingSystem rs) {

    //Reset all the grid values.
    reset();

    //Loop through all the particles trying to add them to the grid.
    for (Ring x : rs.rings) {
      for (RingParticle r : x.particles) {
        int i = i(r);
        int j = j(r);
        if (validij(i, j)) {
          grid[i][j] +=1;
          gridV[i][j].add(r.velocity);
        }
      }
    }

    // Improve the calculate of gridV 

    //As cannot simulate every particle, add constant or multiple number of particles with keplerian velocity to help maintain correct averages.

    //float actualtosimratio = 2; // actual number of particles to simulated 

    //for (int i = 0; i < int(360/dtheta); i++) {
    //  for (int j = 0; j < int((r_max-r_min)/dr); j++) {
    //      gridNorm[i][j] = grid[i][j]/((r_min+j*dr+dr/2)*dr*radians(dtheta));
    //    gridV[i][j].add(keplerianVelocityCell(i, j));
    //    gridV[i][j].add(keplerianVelocityCell(i, j));
    //    for (int k = 0; k<grid[i][j]; k ++) {
    //      gridV[i][j].add(keplerianVelocityCell(i, j));
    //    }
    //    gridV[i][j].div(actualtosimratio*(grid[i][j]+1));
    //  }
    //}


    //Looping through all the grid cell combining properties to calculate normalised values and average values from total values.
    for (int i = 0; i < int(360/dtheta); i++) {
      for (int j = 0; j < int((r_max-r_min)/dr); j++) {
        //total +=grid[i][j] ;
        gridNorm[i][j] = grid[i][j]/((r_min+j*dr+dr/2)*dr*radians(dtheta));


        if (grid[i][j] !=0) {
          gridV[i][j].div(grid[i][j]);
        } else {
          gridV[i][j].set(0.0, 0.0, 0.0);
        }
      }
    }
  }

  PVector gridAcceleration(Particle p) {

    PVector a_grid = new PVector();
    if (validij(p)) {
      //Fluid Drag Force / Collisions - acceleration to align to particle the average velocity of the cell. 
      a_grid.add(dragAcceleration(p));

      // Self Gravity   
      //a_grid.add(selfGravAcceleration(p));
    }
    return a_grid;
  }

  
  PVector position2D(Particle p){
    return new PVector(p.position.x,p.position.y);
  }
  
  //PVector angularTransformation(Particle p,PVector twod){
  
  //return twod.rotate(angleCell(i - angleparticle );
  //}
  
  
  PVector dragAcceleration(Particle p ) {

    // Collisions - acceleration due drag (based on number of particles in grid cell).
    PVector a_drag = new PVector();

    float r = 0.5;
    if ( r < random(1)) {    

      //Find which cell the particle is in.
      int x = i(p);
      int y = j(p);

      int sizeR = 0; //Size of Neighbourhood
      int sizeTheta = 0;

      float c, a, nn;
      c= 1E-9;
      //a=1;  

      for ( int i = x-sizeTheta; i <= x+sizeTheta; i++) {
        for ( int j = y-sizeR; j <= y+sizeR; j++) {
          if (validij(i, j)) {

            //a_drag = PVector.sub(gridV[i][j].copy().normalize(), p.velocity.copy().normalize());
            //gridV[i][j].copy().rotate(angleDiff(p)).mult(radialScaling(p));
            //gridV[i][j].mult(radialScaling(p));

            //a = a_drag.magSq(); //a=1;
            //n = gridNorm[i][j];

            a_drag = PVector.sub(gridV[i][j].copy().rotate(angleDiff(p)).mult(radialScaling(p)), p.velocity);


            a = a_drag.magSq(); //a=1;
            nn = gridNorm[i][j];
            a_drag.normalize();
            a_drag.mult(c*a*nn);
          }
        }
      }
    }
    return a_drag;
  }

  PVector selfGravAcceleration(Particle p ) {

    //Find which cell the particle is in.
    int x = i(p);
    int y = j(p);

    PVector a_selfgrav = new PVector();

    float r = 0;
    if ( r < random(1)) {

      float a, d; // Strength of the attraction number of particles in the cell. 
      d=1E5;

      int size = 2; //Size of Neighbourhood

      // Loop over (nearest) neighbours. As defined by Size. 

      for ( int i = x-size; i <= x+size; i++) {
        for ( int j = y-size; j <= y+size; j++) {
          if (validij(i, j)) {
            float n = gridNorm[i][j];
            PVector dist = PVector.sub(centreofCell(i, j), p.position);
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
   * Returns the normalise particle density relevant to specific particle.
   *
   * @param p a particle with a position vector. 
   */
  float returnGridNorm(Particle p) {
    float temp =0;
    try {
      temp = gridNorm[i(p)][j(p)];
    } 
    catch (Exception e) {
    }
    return temp;
  }

  /**
   * Returns the average cell velocity relevant to specific particle.
   *
   * @param p a particle with a position vector. 
   */
  PVector returnGridV(Particle p) {
    PVector temp = new PVector();
    try {
      temp = gridV[i(p)][j(p)].copy();
    } 
    catch (Exception e) {
    }
    return temp;
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

  /** 
   * Redudent Method - Returns array holding the two indices for a specific particle.  
   *
   * @param p a particle with a position vector.
   */
  int[] findIndices(Particle p) {
    int[] temp = new int[2];
    temp[0]=i(p);
    //if (floor((p.position.mag()/Rp - r_min)/dr) < int((r_max-r_min)/dr)) {
    //  if (floor((p.position.mag()/Rp - r_min)/dr) > 0) {
    temp[1]=j(p);
    //  }else{}

    //}

    return temp;
  }

  //void display() {

  //  for (RingParticle p : particles) {
  //    p.display();
  //  }
  //}
  //void render(PGraphics x) {
  //  for (RingParticle p : particles) {
  //    p.render(x);
  //  }
  //}
}

//CODE Snippets

//saveTable(gridToTable(grid), "output.csv");
//saveTable(gridToTable(grid), "new.csv");
//println(total);
//println(grid[0]);
