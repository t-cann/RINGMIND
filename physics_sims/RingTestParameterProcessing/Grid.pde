/**Class Grid
 * @author Thomas Cann
 * @version 1.0
 */

//Global Variables 
float GRID_DELTA_R = 0.05; //[Planetary Radi]  
float GRID_DELTA_THETA = 1; // [Degrees]
float GRID_DRAG_CONSTANT = 1E-7;
float GRID_DRAG_PROBABILITY = 1E4 ;


class Grid {


  protected float dr, dtheta, r_min, r_max; 
  protected int sizeTheta, sizeR;
  protected float drag_c, drag_p;  //Constants for Drag Rule.

  protected int grid[][];          //Grid to hold the number of particle in each cell
  protected float gridNorm[][];    //Grid to hold Normalised Number Density of Particles in Cell (by Area and Total number).
  protected PVector gridV[][];     //Grid to hold the average velocity of cell. 
  protected PVector gridCofM[][];  //Grid to hold centroid value for cell.

  //Optimisation Variables
  private float minSize = 4*(sq(r_min *radians(dtheta)/2)+sq(dr)); //Based on the minimum grid size.

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Grid() {

    dr = GRID_DELTA_R;
    dtheta = GRID_DELTA_THETA;
    r_min = R_MIN;
    r_max = R_MAX;
    sizeTheta =int(360/dtheta); //Size of 1st Dimension of Grid Arrays
    sizeR = int((r_max-r_min)/dr); //Size of 2nd Dimension of Grid Arrays
    grid = new int[sizeTheta][sizeR];
    gridNorm = new float[sizeTheta][sizeR];
    gridV = new PVector[sizeTheta][sizeR];
    gridCofM = new PVector[sizeTheta][sizeR];

    drag_c= GRID_DRAG_CONSTANT; 
    drag_p= GRID_DRAG_PROBABILITY; 
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
    //return (atan2(p.position.y, p.position.x)+PI);
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
   */
  float angleCell(int i) {
    return radians(dtheta*(i+0.5));
  }

  // Calculates the difference in angle between a particle and the centre of its cell
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
    return floor((radius/Rp - r_min)/dr);
  }

  /**
   * Returns radius of the centre of a cell (from x=0 and y=0)
   */
  float radiusCell(int j) {
    return Rp*(r_min + dr*(j+0.5));
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

  PVector dragAcceleration(Particle p) {

    // Collisions - acceleration due drag (based on number of particles in grid cell).
    PVector a_drag = new PVector();

    //Find which cell the particle is in.
    int i = i(p);
    int j = j(p);

    float r = 1-exp(-(gridNorm[i][j]*drag_p)/h_stepsize);
    if ( random(1)< r) {

      float a, nn;
      //println(degrees(angleDiff(p)));
      a_drag = PVector.sub(gridV[i][j].copy().rotate(angleDiff(p)).mult(radialScaling(p)), p.velocity.copy()); // 

      //println( p.position.mag()+ "\t::" +a_drag.mag());
      a =  a_drag.magSq(); //a=1; 
      a_drag.normalize();
      nn = gridNorm[i][j];
      a_drag.mult(drag_c*a*nn);
    }
    return a_drag;
  }


  PVector selfGravAcceleration(Particle p ) {

    //Find which cell the particle is in.
    int x = i(p);
    int y = j(p);

    PVector a_selfgrav = new PVector();

    float r = 0.5;
    if (random(1) < r) {

      float a, d; // Strength of the attraction number of particles in the cell. 
      d=1E8;

      int size = 2; //Size of Neighbourhood

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




  //  PVector dragAccelerationC(Particle p) {

  //    // Collisions - acceleration due drag (based on number of particles in grid cell).
  //    PVector a_drag = new PVector();

  //    float r = 0.9;
  //    if ( r > random(1)) {    

  //      //Find which cell the particle is in.
  //      int x = i(p);
  //      int y = j(p);

  //      int sizeR = 2; //Size of Neighbourhood
  //      int sizeTheta = 2;

  //      float c, a, n;
  //      c= 1E-5;


  //      for ( int i = x-sizeTheta; i <= x+sizeTheta; i++) {
  //        for ( int j = y-sizeR; j <= y+sizeR; j++) {
  //          if (validij(i, j)) {

  //            //PVector drag = PVector.sub(gridV[i][j].copy().normalize(), p.velocity.copy().normalize());
  //            PVector drag = PVector.sub(gridV[i][j].copy(), p.velocity.copy());

  //            a =1;// drag.magSq(); //a=1; 
  //            drag.normalize();
  //            n = gridNorm[x][y];
  //            drag.mult(c*a*n);
  //            a_drag.add(drag);
  //          }
  //        }
  //      }
  //    }


  //  return a_drag;
  //}

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




  void display() {

    if (mousePressed) {
      float r = sqrt(sq(mouseX-width/2)+ sq(mouseY-height/2))/SCALE;
      float angle = (atan2((mouseY-height/2), mouseX-width/2)+TAU)%(TAU);

      //println(i(angle) +"   " + j(r));

      int i= i(angle);
      int j = j(r);
      if (validij(i, j)) {

        displaycell(i, j );
        float a = 1-exp(-(gridNorm[i][j]*1E4)/h_stepsize);
        String output = "\t Normalised Number Density: " +gridNorm[i][j] + "\n\t Average Velocity: " + gridV[i][j].mag()+ "\n\t Probability Threshold: " + a ;
        text(output, 0.0, 10.0);

        displayVector(i, j, gridV[i][j]);

        //println("r : "+r +" angle: "+ angle);
        //println("X: "+(mouseX-width/2) +" Y: "+ -(mouseY-height/2));
        //println("MouseX: "+mouseX +"MouseY: "+ mouseY);
      }
    }

    //for (RingParticle p : particles) {
    //  p.display();
    //}
  }

  void displayVector(int i, int j, PVector v) {
    push();
    translate(width/2, height/2);
    stroke(255);
    //scale(1,-1);
    strokeWeight(1);
    PVector cofc = centreofCell(i, j);
    cofc.mult(SCALE);
    PVector temp = v.copy().mult(5E-3);
    //println(cofc.x);
    line(cofc.x, cofc.y, cofc.x + temp.x, cofc.y + temp.y);
    pop();
  }

  void displaycell(int i, int j) {
    push();
    translate(width/2, height/2);
    //scale(1, -1);
    noFill();
    stroke(255);
    strokeWeight(1);



    float r = SCALE*Rp*(r_min + dr *j);
    float R = SCALE*Rp*(r_min + dr *(j+1));
    float theta = radians(dtheta *i);

    //println(r+ " :: " + R+ " ::: "+ theta);
    float N =10;

    beginShape();
    // Outer circle

    //vertex(100,100);
    //vertex(-100,100);
    //vertex(-100,-100);
    //vertex(100,-100);
    for (int x = 0; x<=N; x++) {
      vertex(R*cos(x*radians(dtheta)/N + theta), R*sin(x*radians(dtheta)/N +theta));
    }

    // Inner circle
    //beginContour();
    for (int x = 0; x<=N; x++) {
      vertex(r*cos((theta+radians(dtheta))-x*radians(dtheta)/N), r*sin((theta+radians(dtheta))-x*radians(dtheta)/N));
    }
    //endContour();

    endShape(CLOSE);
    pop();
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



    ////  //Looping through all the grid cell combining properties to calculate normalised values and average values from total values.
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


  //void render(PGraphics x) {
  //  for (RingParticle p : particles) {
  //    p.render(x);
  //  }
  //}
}
