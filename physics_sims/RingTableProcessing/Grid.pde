/**Class Grid
 * @author Thomas Cann
 * @version 1.0
 */
class Grid {


  float dr= 0.1; //[Planetary Radi]  
  float dtheta = 1; // [Degrees]
  int grid[][];
  float gridNorm[][];
  PVector gridV[][];

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Grid() {

    grid = new int[int(360/dtheta)][int((r_max-r_min)/dr)];
    gridNorm = new float[int(360/dtheta)][int((r_max-r_min)/dr)];
    gridV = new PVector[int(360/dtheta)][int((r_max-r_min)/dr)];

    reset();
  }

  void reset() {
    for (int i = 0; i < int(360/dtheta); i++) {
      for (int j = 0; j < int((r_max-r_min)/dr); j++) {
        grid[i][j] = 0;
        gridNorm[i][j] =0;
        gridV[i][j]= new PVector();
      }
    }
  }
  
  int i(Particle p) {
    return floor((degrees(atan2(p.position.y, p.position.x))+180)/dtheta);
  }
  int j(Particle p) {
    return floor((p.position.mag()/Rp - r_min)/dr);
  }
  
  PVector centreofCell(int i, int j ){
  float r =  Rp*(r_min + dr*(j+0.5));
  float angle = radians(dtheta*(i+0.5) -180);
  return new PVector(r*cos(angle),r*sin(angle),0);
  }
  
  
  void update(RingSystem rs) {

    reset();

    for (Ring x : rs.rings) {
      for (RingParticle r : x.particles) {
        try {
          grid[i(r)][j(r)] +=1;
          gridV[i(r)][j(r)].add(r.velocity);
        }
        catch(Exception e) {
          //println("particle out of bounds");
        }
      }
    }


    //int total=0;
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


    //saveTable(gridToTable(grid), "output.csv");
    //saveTable(gridToTable(grid), "new.csv");
    //println(total);
    //println(grid[0]);
  }

  /**
   *
   */
  int[] findIndices(Particle p) {
    int[] temp = new int[2];
    temp[0]=floor((degrees(atan2(p.position.y, p.position.x))+180)/dtheta);
    //if (floor((p.position.mag()/Rp - r_min)/dr) < int((r_max-r_min)/dr)) {
    //  if (floor((p.position.mag()/Rp - r_min)/dr) > 0) {
    temp[1]=floor((p.position.mag()/Rp - r_min)/dr);
    //  }else{}

    //}

    return temp;
  }

  float returnGridNorm(Particle p){
    float temp =0;
    try{
    temp = gridNorm[i(p)][j(p)];
    } catch (Exception e){}
    return temp;
  }
  
  PVector returnGridV(Particle p){
    PVector temp = new PVector();
    try{
    temp = gridV[i(p)][j(p)].copy();
    } catch (Exception e){}
    return temp;
  }

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
