/**Class which implements a shearing box approximation for computing local ring particle physics.
 * @author Thomas Cann
 * @version 1.0
 */

float num_particles = 1000;

//Simulation dimensions [m]
int Lx = 1000;       //Extent of simulation box along planet-point line [m].
int Ly = 2000;       //Extent of simulation box along orbit [m].
//Initialises Simulation Constants
final float GM = 3.793e16;   //Gravitational parameter for the central body, defaults to Saturn  GM = 3.793e16.
final float r0 = 130000e3;   //Central position in the ring [m]. Defaults to 130000 km.
//Ring Particle Properties
final float particle_rho = 900.0;  //Density of a ring particle [kg/m^3].
final float particle_a = 0.01;     //Minimum size of a ring particle [m].
final float particle_b = 10.0;     //Maximum size of a ring particle [m].
final float particle_lambda = 5;   //Power law index for the size distribution [dimensionless].
final float particle_D =1.0/( exp(-particle_lambda*particle_a) -exp(-particle_lambda*particle_b));
final float particle_C =particle_D * exp(-particle_lambda*particle_a);
//Ring Moonlet Properties
float moonlet_r = 50.0;            //Radius of the moonlet [m].
final float moonlet_density = 1000.0; //Density of the moonlet [kg/m]
float moonlet_GM = G*(4.0*PI/3.0)*pow(moonlet_r, 3.0)*moonlet_density; //Standard gravitational parameter.
//
final float Omega0 = sqrt(GM/(pow(r0, 3.0))); //The Keplerian orbital angular frequency (using Kepler's 3rd law). [radians/s]
final float S0 = -1.5*Omega0; //"The Keplerian shear. Equal to -(3/2)Omega for a Keplerian orbit or -rdOmega/dr. [radians/s]

class ShearingBox {



  ArrayList<Particle> particles;  // ArrayList for all "Particles" in Shearing Box
  ArrayList<Particle>[][] grid;   // Grid of ArrayLists
  int scl = 5;                    // Size of each grid cell (in Simulation) [m]
  int cols, rows;                 // Total coluns and rows

  /**CONSTUCTOR Shearing Box 
   */
  ShearingBox() {
    //Initialise our ShearingBox Object.
    particles = new ArrayList<Particle>(); 
    cols = Ly/scl;
    rows = Lx/scl;

    // Initialize grid as 2D array of empty ArrayLists
    grid = new ArrayList[cols+1][rows+1];
    for (int i = 0; i < cols+1; i++) {
      for (int j = 0; j < rows+1; j++) {
        grid[i][j] = new ArrayList<Particle>();
      }
    }
    println(Omega0+ " " + S0);

    random_start();
  }

  /** 
   */
  void display() {
    push();
    translate(width/2, height/2);
    fill(255);
    if (Moonlet) {
      circle(0, 0, moonlet_r);
    }

    for (Particle x : particles) {
      // Zero acceleration to start
      x.display();
    }

    if (Reset) {
      //for (Particle x : particles) {
      //  // Zero acceleration to start
      //  x.Reset();
      //}

      Table table; 
      table = loadTable("/files/output.csv");//"input.csv"

      particles.clear();

      for (int i = 0; i < table.getRowCount(); i++) {
        Particle temp = new Particle();
        temp.position.x= table.getFloat(i, 0);
        temp.position.y= table.getFloat(i, 1);
        temp.position.z= table.getFloat(i, 2);
        temp.velocity.x= table.getFloat(i, 3);
        temp.velocity.y= table.getFloat(i, 4);
        temp.velocity.z= table.getFloat(i, 5);
        temp.acceleration.x= table.getFloat(i, 6);
        temp.acceleration.y= table.getFloat(i, 7);
        temp.acceleration.z= table.getFloat(i, 8);
        particles.add(temp);
      }

      Reset =false;
    }
    pop();
  }

  /** Method to update position
   */
  void update() {
    for (Particle p : particles) {
      p.highlight = false;
    }


    step_verlet();
    //if ( frameCount %100 == 0) {
    //  saveTable(particlesToTable(), "/files/output.csv");
    //}
    //   if (Collisions) {

    //  grid_update();
    //}
  }


  Table particlesToTable() {
    Table tempTable = new Table();

    for (int j=0; j<9; j++) {
      tempTable.addColumn();
    }

    for (Particle p : particles) {
      TableRow newRow =tempTable.addRow();
      newRow.setFloat(0, p.position.x);
      newRow.setFloat(1, p.position.y);
      newRow.setFloat(2, p.position.z);
      newRow.setFloat(3, p.velocity.x);
      newRow.setFloat(4, p.velocity.y);
      newRow.setFloat(5, p.velocity.z);
      newRow.setFloat(6, p.acceleration.x);
      newRow.setFloat(7, p.acceleration.y);
      newRow.setFloat(8, p.acceleration.z);
    }



    return tempTable;
  }



  /** Take a step using the Velocity Verlet (Leapfrog) ODE integration algorithm.
   *   TODO: Check Algorithm is correct.
   */
  void step_verlet() {

    //Calculate first approximation for acceleration
    for (Particle x : particles) {
      // Zero acceleration to start
      x.set_getAcceleration(this);
    }

    // Integrate to get approximation for new position and velocity
    for (Particle x : particles) {
      // Zero acceleration to start
      x.updatePosition();
    }



    //Calculate Second Approximation to the acceleration.
    for (Particle x : particles) {
      // Zero acceleration to start
      x.updateVelocity(x.getAcceleration(this));
    }

    //Have any particles left the simulation box, or collided with the moonlet?
    //If so, remove and replace them.
    for (Particle x : particles) {
      if (particle_outBox(x)) {
        x.Reset();
      }
      if (Moonlet) {
        if (particle_inMoonlet(x)) {
          x.Reset();
        }
      }
    }
  }


  /** Method to boolean if Particle is out of ShearingBox.
   *@param x  A Particle to inject.
   *@return True if out of Shearing Box
   */
  boolean particle_outBox(Particle x) {
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
  boolean particle_inMoonlet(Particle x) {
    if ((x.position.mag() < moonlet_r)) {
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
  void random_inject(float n) {
    //particles.add(new Moonlet());
    for (int i = 0; i < n; i++) {
      particles.add(new Particle());
    }
  }

  /** Method to Initialise the simulation with a random set of starting particles at the edges (in y).
   */
  void random_start() {
    random_inject(num_particles);
  }

  /** Method to calculate the Keplerian orbital period (using Kepler's 3rd law).
   *@param r  Radial position (semi-major axis) to calculate the period [m].
   *@return   The period [s].
   */
  float kepler_period(float r) {
    return 2.0*PI*sqrt((pow(r, 3.0))/GM);
  }

  /** Method to calculate the Keplerian orbital angular frequency (using Kepler's 3rd law).
   *@param r  Radial position (semi-major axis) to calculate the period [m].
   *@return   The angular frequency [radians/s].
   */
  float kepler_omega(float r) {
    return sqrt(GM/(pow(r, 3.0)));
  }

  /** Method to calculate the Keplerian orbital speed.
   *@param r  Radial position (semi-major axis) to calculate the period [m].
   *@return   The speed [m/s].
   */
  float kepler_speed(float r) {
    return sqrt(GM/r);
  }

  /** Method to calculate the Keplerian shear. Equal to -(3/2)Omega for a Keplerian orbit or -rdOmega/dr.
   *@param r Radial position (semi-major axis) to calculate the period [m]. 
   *@return Shear [radians/s].
   */
  float kepler_shear(float r) {
    return -1.5*kepler_omega(r);
  }

  void grid_update() {

    // Every time through draw clear all the lists
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j].clear();
      }
    }

    // Register every Thing object in the grid according to it's position
    for (Particle p : particles) {

      int x = (int(p.position.x) +Lx/2)/ scl;   //
      int y = (int(p.position.y) +Ly/2)/scl;     //

      //println("y: " + y + "x: " + x);

      grid[y][x].add(p);
      // as well as its 8 neighbors 

      //for (int n = -1; n <= 1; n++) {
      //  for (int m = -1; m <= 1; m++) {
      //    if (x+n >= 0 && x+n < cols && y+m >= 0 && y+m< rows) grid[x+n][y+m].add(t);
      //  }
      //}
    }



    // Run through the Grid
    for (int i = 0; i < cols; i++) {
      //line(i*scl,0,i*scl,height);
      for (int j = 0; j < rows; j++) {
        //line(0,j*scl,width,j*scl);

        // For every list in the grid
        ArrayList<Particle> temp = grid[i][j];
        // Check every Particle 
        for (Particle p : temp) {
          // Against every other Particle in the grid
          for (Particle other : temp) {
            // As long as its not the same one
            if (other != p) {



              // Check to see if they are touching
              // (We could do many other things here besides just intersection tests, such
              // as apply forces, etc.)
              float dis = dist(p.position.x, p.position.y, other.position.x, other.position.y);
              if (dis < p.radius + other.radius) {               
                collision(p, other);
              }
            }
          }
        }

        fill(temp.size()*30, temp.size()*10, 0);
        rect(i*scl, j*scl, scl, scl);
      }
    }
  }

  /** Collision between 2 Particle Objects
   *   TODO: Check Algorithm is correct.
   */
  void collision(Particle p, Particle other) {
    println("collision");

    // Get distances between the balls components
    PVector distanceVect = PVector.sub(p.position, other.position);

    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching
    float minDistance = p.radius + other.radius;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      other.position.x += correctionVector.x;
      other.position.y += correctionVector.y;
      p.position.x -= correctionVector.x;
      p.position.y -= correctionVector.y;

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball positions. You 
       just need to worry about bTemp[1] position*/
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      /* this ball's position is relative to the other
       so you can use the vector between them (bVect) as the 
       reference point in the rotation expressions.
       bTemp[0].position.x and bTemp[0].position.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * p.velocity.x + sine * p.velocity.y;
      vTemp[0].y  = cosine * p.velocity.y - sine * p.velocity.x;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate 
       the final velocity along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      // final rotated velocity for b[0]
      vFinal[0].x = ((p.m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (p.m + other.m);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[1].x = ((other.m - p.m) * vTemp[1].x + 2 * p.m * vTemp[0].x) / (p.m + other.m);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      other.position.x = p.position.x + bFinal[1].x;
      other.position.y = p.position.y + bFinal[1].y;

      p.position.x += bFinal[0].x;
      p.position.y += bFinal[0].y;

      // update velocities
      p.velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      p.velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  }
}
