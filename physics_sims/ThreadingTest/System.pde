System s;
float G = 6.67408E-11;       // Gravitational Constant 6.67408E-11[m^3 kg^-1 s^-2]

import java.util.concurrent.TimeUnit;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**Class System
 */
public abstract class System {


  ExecutorService executor;
  int numThreads = 8;

  //Timestep variables 
  float dt;                                      //Simulation Time step [s]
  float simToRealTimeRatio = 3600.0/1.0;         // 3600.0/1.0 --> 1hour/second
  float maxTimeStep = 20* simToRealTimeRatio / 30;
  float totalSystemTime =0.0;                    // Tracks length of time simulation has be running

  int n_particles = 10000;                       //Used for system initialiations 
  ArrayList<Particle> particles;
  ArrayList<Grid> g;

  static final float GMp = 3.7931187e16;
  static final float Rp = 60268e3;                // Length scale (1 Saturn radius) [m]
  static final float SCALE = 100/Rp;              // Converts from [m] to [pixel] with planetary radius (in pixels) equal to the numerator. Size of a pixel represents approximately 600km.

  Material material = RingMat1;

  /**  Updates System for one time step of simulation taking into account the System.
   */
  void update() {

    //update(this);

    if (simToRealTimeRatio/frameRate < maxTimeStep) {
      this.dt= simToRealTimeRatio/frameRate;
    } else {
      this.dt= maxTimeStep;
      println("At Maximum Time Step");
    }

    for (Particle p : particles) {
      p.set_getAcceleration(this);
    }
    for (Particle p : particles) {
      p.updatePosition(dt).run();
    }
    for (Grid x : g) {
      x.update(this);
    }
    for (Particle p : particles) {
      p.updateVelocity(p.getAcceleration(this), dt).run();
    }
    totalSystemTime += dt;
  }


  ///**  Updates System for one time step of simulation taking into account the System.
  // */
  //void update(System s) {

  //  if (simToRealTimeRatio/frameRate < maxTimeStep) {
  //    s.dt= simToRealTimeRatio/frameRate;
  //  } else {
  //    s.dt= maxTimeStep;
  //    println("At Maximum Time Step");
  //  }

  //  for (Particle p : particles) {
  //    p.set_getAcceleration(s);
  //  }
  //  for (Particle p : particles) {
  //    p.updatePosition(s.dt);
  //  }
  //  for (Grid x : g) {
  //    x.update(this);
  //  }
  //  for (Particle p : particles) {
  //    p.updateVelocity(p.getAcceleration(s), s.dt);
  //  }
  //  s.totalSystemTime += s.dt;
  //}
}


//public class TaskSGA implements Runnable {
//    System s;


//    @Override
//    public void run() {
//        s.doSomeStuff();

//    }
//}


/**
 *
 */
class ParticleSystem extends System {

  /**
   */
  ParticleSystem() {

    particles = new ArrayList<Particle>();
    g = new ArrayList<Grid>();

    for (int i = 0; i < 10000; i++) {
      particles.add(new RingParticle(1, 3));
    }
  }

  //  void update() {

  //    if (simToRealTimeRatio/frameRate < maxTimeStep) {
  //      this.dt= simToRealTimeRatio/frameRate;
  //    } else {
  //      this.dt= maxTimeStep;
  //      println("At Maximum Time Step");
  //    }

  //     for (Particle p : particles) {
  //      p.set_getAcceleration(this);
  //    }
  //    executor = Executors.newFixedThreadPool(numThreads);
  //    for (Particle p : particles) {
  //      executor.execute(p.updatePosition(dt));
  //    }

  //    executor.shutdown();
  //    while (!executor.isTerminated()) {
  //    }

  //       for (Grid x : g) {
  //      x.update(this);
  //    }

  //    executor = Executors.newFixedThreadPool(numThreads);
  //    for (Particle p : particles) {
  //      executor.execute(p.updateVelocity(p.getAcceleration(this),dt));
  //    }

  //    executor.shutdown();
  //    while (!executor.isTerminated()) {
  //    }
  //    totalSystemTime += dt;
  //  }


  //  private Runnable set_getAcceleration(final Particle p, System s) {
  //    Runnable aRunnable = new Runnable() {
  //      public void run() {
  //        p.set_getAcceleration(s);
  //      }
  //    };
  //    return aRunnable;
  //  }

  //  private Runnable updatePosition(final Particle p, final float dt ) {
  //    Runnable aRunnable = new Runnable() {
  //      public void run() {
  //        p.updatePosition(dt);
  //      }
  //    };
  //    return aRunnable;
  //  }

  //  private Runnable updateVelocity( final Particle p, final float dt ) {
  //    Runnable aRunnable = new Runnable() {
  //      public void run() {
  //        p.updateVelocity(p.getAcceleration(this), dt);
  //      }
  //    };
  //    return aRunnable;
  //  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


class RingmindSystem extends System {
  RingSystem rs;
  MoonSystem ms;

  RingmindSystem(int ring_index, int moon_index) {

    rs = new RingSystem(ring_index);
    ms = new MoonSystem(moon_index);

    //particles = new ArrayList<Particle>();
    //for(Particle p :rs.particles){
    //particles.add(p);
    //}
    //for(Particle p :ms.particles){
    //particles.add(p);
    //}
    //for(Grid x :rs.g){
    //g.add(x);
    //}
  }

  void update() {
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
      rings.add(new Ring( 1.1, 4.9, n_particles)); //Generic Disc of Particles
      rings.get(0).material = RingMat2;
      break;
    case 2:
      //Saturn Ring Data (Source: Nasa Saturn Factsheet) [in Saturn radii]
      rings.add(new Ring( 1.110, 1.236, n_particles/10)); // D Ring: Inner 1.110 Outer 1.236
      rings.add(new Ring( 1.239, 1.527, n_particles/10)); // C Ring: Inner 1.239 Outer 1.527
      rings.add(new Ring( 1.527, 1.951, n_particles/10)); // B Ring: Inner 1.527 Outer 1.951
      rings.add(new Ring( 2.027, 2.269, n_particles/2));  // A Ring: Inner 2.027 Outer 2.269
      rings.add(new Ring( 2.320, 2.321, n_particles/10)); // F Ring: Inner 2.320 Outer *
      rings.add(new Ring( 2.754, 2.874, n_particles/10)); // G Ring: Inner 2.754 Outer 2.874
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
      rings.add(new Ring( 1.1, 2.9, n_particles/2));
      rings.add(new Ring( 4.5, 4.7, n_particles/2));
      break;

    case 6:
      //Square
      importFromFileToGrid(this, "Square.csv");
      break;  

    case 10:
      // main RINGMIND
      g.add(new Grid(1.0, 3.4, 1E-8, 1E4));
      g.add(new Grid(3.4, 5.0, 1E-8, 1E4)); //switch 1E-8 and go to 2E-7
      //g.add(new Grid(3.4, 5.0, 2E7, 1E4)); //switch 1E-8 and go to 2E-7
      rings.add(new Ring( 1.110, 1.236, n_particles/12)); //inner ring
      rings.add(new Ring( 1.611, 2.175, n_particles/4)); //propeller ring
      rings.add(new Ring( 2.185, 2.6, n_particles/4));  //propeller ring
      rings.add(new Ring( 2.794, 2.795, n_particles/6)); //narrow ring
      rings.add(new Ring( 2.920, 2.921, n_particles/6)); //narrow ring
      rings.add(new Ring( 3.5, 3.8, n_particles/3)); //clumping ring

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
      g.add(new Grid(1.0, 3.4, 1E-8, 1E4));
      g.add(new Grid(3.4, 5.0, 9E-7, 1E4)); //switch 1E-8 and go to 2E-7
      //g.add(new Grid(3.4, 5.0, 2E7, 1E4)); //switch 1E-8 and go to 2E-7
      rings.add(new Ring( 1.110, 1.236, n_particles/12)); //inner ring
      rings.add(new Ring( 1.611, 2.175, n_particles/4)); //propeller ring
      rings.add(new Ring( 2.185, 2.6, n_particles/4));  //propeller ring
      rings.add(new Ring( 2.794, 2.795, n_particles/6)); //narrow ring
      rings.add(new Ring( 2.920, 2.921, n_particles/6)); //narrow ring
      rings.add(new Ring( 3.5, 3.8, n_particles/3)); //clumping ring   

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
  void calcDensity() {
    for (int i =0; i<rings.size(); i++) {
      rings.get(i).density = rings.get(i).density()/rings.get(0).density();
    }
  }
  void applyBasicMaterials() {
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
  Boolean Guides = false;
  Boolean Reset =true;

  //Simulation dimensions [m]
  int Lx = 1000;       //Extent of simulation box along planet-point line [m].
  int Ly = 2000;       //Extent of simulation box along orbit [m].

  //Initialises Simulation Constants
  final float GM = 3.793e16;   //Shear Gravitational parameter for the central body, defaults to Saturn  GM = 3.793e16.
  final float r0 = 130000e3;   //Central position in the ring [m]. Defaults to 130000 km.
  final float Omega0 = sqrt(GM/(pow(r0, 3.0))); //The Keplerian orbital angular frequency (using Kepler's 3rd law). [radians/s]
  final float S0 = -1.5*Omega0; //"The Keplerian shear. Equal to -(3/2)Omega for a Keplerian orbit or -rdOmega/dr. [radians/s]

  Moonlet moonlet;

  ShearSystem() {

    particles = new ArrayList<Particle>();
    g = new ArrayList<Grid>();
  }

  /** Take a step using the Velocity Verlet (Leapfrog) ODE integration algorithm.
   * Additional Method to Check if particles have left simulation.
   */
  void update() {

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
  boolean particle_outBox(ShearParticle x) {
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
  boolean particle_inMoonlet(ShearParticle x) {
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
  void random_inject(float n) {
    //particles.add(new Moonlet());
    for (int i = 0; i < n; i++) {
      particles.add(new ShearParticle());
    }
  }

  /** Method to Initialise the simulation with a random set of starting particles at the edges (in y).
   */
  void random_start() {
    random_inject(n_particles);
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


  void initTable() {
    addParticlesFromTable(this, "shearoutput.csv");
  }
}

/**Class TiltSystem
 * @author Thomas Cann
 */
class TiltSystem extends System {

  float Max_Inclination=80; //Maximum Magnitude of Inclined Planes round x-axis[degrees]
  float Min_Inclination=1;  //Minimum Magnitude of Inclined Planes round x-axis[degrees]
  float Lambda= 8E-5;       //Exponential decay constant [milliseconds^-1] == 1/LAMBDA -> Mean Life Time[ milliseconds]
                            //Example Ranges for Lambda ==> 8E-5 decays in about 30seconds // 3E-5 decays in 90 seconds;
  float Inner = 1.1;        //Inner Radius for Particles[Planetary Radi] 
  float Outer = 4.9;        //Outer Radius for Particles[Planetary Radi] 

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
void addMoon(int i, ArrayList<Particle> m) {

  //Source: Nasa Saturn Factsheet

  switch(i) {
  case 0:
    // Pan Mass 5e15 [kg] Radius 1.7e4 [m] Orbital Radius 133.583e6 [m]
    m.add(new Moon(G*5e15, 1.7e4, 133.5832e6));
    break;
  case 1:
    // Daphnis Mass 1e14 [kg] Radius 4.3e3 [m] Orbital Radius 136.5e6 [m]
    m.add(new Moon(G*1e14, 4.3e3, 136.5e6));
    break;
  case 2:
    // Atlas Mass 7e15 [kg] Radius 2e4 [m] Orbital Radius 137.67e6 [m]
    m.add(new Moon(G*7e15, 2.4e4, 137.67e6));
    break;
  case 3:
    // Promethieus Mass 1.6e17 [kg] Radius 6.8e4 [m] Orbital Radius 139.353e6 [m]
    m.add(new Moon(G*1.6e17, 6.8e4, 139.353e6));
    break;
  case 4:
    // Pandora Mass 1.4e17 [kg] Radius 5.2e4 [m] Orbital Radius 141.7e6 [m]
    m.add(new Moon(G*1.4e17, 5.2e4, 141.7e6));
    break;
  case 5:
    // Epimetheus Mass 5.3e17 [kg] Radius 6.5e4 [m] Orbital Radius 151.422e6 [m]
    m.add(new Moon(G*5.3e17, 6.5e4, 151.422e6, color(0, 255, 0)));
    break;
  case 6:
    // Janus Mass 1.9e18 [kg] Radius 1.02e5 [m] Orbital Radius 151.472e6 [m]
    m.add(new Moon(G*1.9e18, 1.02e5, 151.472e6));
    break;
  case 7: 
    // Mimas Mass 3.7e19 [kg] Radius 2.08e5 [m] Obital Radius 185.52e6 [m]
    m.add(new Moon(G*3.7e19, 2.08e5, 185.52e6));
    break;
  case 8:
    // Enceladus Mass 1.08e20 [kg] Radius 2.57e5 [m] Obital Radius 238.02e6 [m]
    m.add(new Moon(G*1.08e20, 2.57e5, 238.02e6));
    break;
  case 9:
    // Tethys Mass 6.18e20 [kg] Radius 5.38e5 [m] Orbital Radius 294.66e6 [m]
    m.add(new Moon(G*6.18e20, 5.38e5, 294.66e6));
    break;
  case 10:
    // Calypso Mass 4e15 [kg] Radius 1.5e4 [m] Orbital Radius 294.66e6 [m]
    m.add(new Moon(G*4e15, 1.5e4, 294.66e6));
    break;
  case 11:
    // Telesto Mass 7e15 [kg] Radius 1.6e4 [m] Orbital Radius 294.66e6 [m]
    m.add(new Moon(G*7e15, 1.6e4, 294.66e6));
    break;
  case 12:
    // Dione Mass 1.1e21 [kg] Radius 5.63e5 [m] Orbital Radius 377.4e6 [m]
    m.add(new Moon(G*1.1e21, 5.63e5, 377.4e6));
    break;
  case 13:
    // Helele Mass 3e16 [kg] Radius 2.2e4 [m] Orbital Radius 377.4e6[m]
    m.add(new Moon(G*3e16, 2.2e4, 377.4e6));
    break;
  case 14:
    // Rhea Mass 2.31e21 [kg] Radius 7.65e5 [m] Orbital Radius 527.04e6 [m]
    m.add(new Moon(G*2.31e21, 7.65e5, 527.4e6));
    break;
  case 15:
    // Titan Mass 1.3455e23 [kg] Radius 2.575e6 [m] Orbital Radius 1221.83e6 [m]
    m.add(new Moon(G*1.34455e23, 2.57e6, 1221.83e6));
    break;
  case 16:
    // Hyperion Mass 5.6e18 [kg] Radius 1.8e5 [m] Orbital Radius 1481.1e6 [m]
    m.add(new Moon(G*5.6e18, 1.8e5, 1481.1e6));
    break;
  case 17:
    // Iapetus Mass 1.81e21 [kg] Radius 7.46e5 [m] Orbital Radius 3561.3e6 [m]
    m.add(new Moon(G*1.81e21, 7.46e5, 3561.3e6));
    break;
  case 18:
    // Pheobe Mass 8.3e18 [kg] Radius 1.09e5 [m] Orbital Radius 12944e6 [m] 
    m.add(new Moon(G*8.3e18, 1.09e5, 12994e6));
    break;
    // Inner smaller moons
  case 19:
    m.add(new Moon(G*3.7e18, 1.77e6, 1.373657091*System.Rp));    
    break;
  case 20:
    m.add(new Moon(G*1.5e20, 2.66e6, 2.180544711*System.Rp));
    break;
  case 21:
    m.add(new Moon(G*9.0e18, 9.90e5, 2.857321894*System.Rp));
    break;
  case 22:
    m.add(new Moon(G*3.7e19, 1.32e6, 3.226611418*System.Rp));
    break;
  case 23:
    m.add(new Moon(G*3.7e19, 4.08e6, 4.0165977*System.Rp));
    break;
    // Larger outer moons
  case 24:
    m.add(new Moon(G*2.31e21, 1.65e7, 8.75091259*System.Rp));
    break;
  case 25:
    m.add(new Moon( G*4.9e20, 6.85e7, 16.49*System.Rp));  
    break;
  case 26:
    m.add(new Moon( G*1.34455e23, 8.57e7, 20.27327*System.Rp));  
    break;
  case 27:
    m.add(new Moon( G*3.7e22, 2.08e8, 34.23*System.Rp));
    break;
  case 28:
    m.add(new Moon( G*1.81e21, 7.46e7, 49.09*System.Rp));
    break;
  }
}
