//enum ParticleType {Ring, Moon, Tilt, Shearing, Moonlet};  Idea? //<>// //<>// //<>//

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
   *  Class Constuctor - General need passing all the values. 
   */
  Particle(float x1_, float x2_, float x3_, float v1_, float v2_, float v3_) {
    //default position
    this.position = new PVector(x1_, x2_, x3_);
    //default velocity
    this.velocity = new PVector(v1_, v2_, v3_);
    this.acceleration = new PVector();
  }

  /**
   *  Class Constuctor - General need passing all the values. 
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
    this(radius, random(1)*2.0*PI); //random(1)
  }

  /**
   *  Class Constuctor - Initialises an Particle object with zero position and velocity. 
   */
  Particle() {
    this(0, 0, 0, 0, 0, 0);
  }

  /**
   * Display Method - Renders this object to screen displaying its position and colour.
   */
  void display() {
  }


  /**Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
   * @param rs
   * @return acceleration on the particle PVector[m.s^-2,m.s^-2,m.s^-2]
   */
  PVector getAcceleration(System s) {
    PVector a_grav = new PVector();

    // acceleration due planet in centre of the ring. 
    a_grav = PVector.mult(position.copy().normalize(), -System.GMp/position.copy().magSq());

    //Acceleration from the Grid Object
    for (Grid x : s.g) {
      a_grav.add(x.gridAcceleration(this, s.dt));
    }
    return a_grav;
  }

  /** Calculates the acceleration on this particle (based on its current position) (Overrides value of acceleration stored by particle)
   * @param rs
   */
  void set_getAcceleration(System sb ) {
    acceleration = getAcceleration(s);
  }

  /** 
   *  Update Position of particle based of Velocity and Acceleration. 
   */
  Runnable updatePosition(float dt) {
    class UpdatePosition implements Runnable {
      float dt;
      UpdatePosition(float dt) {
        this.dt = dt;
      }

      public void run() {
        position.add(velocity.copy().mult(dt)).add(acceleration.copy().mult(0.5*sq(dt)));
      }
    }
    return new UpdatePosition(dt);
  }

  /**
   * Updates the velocity of this Particle (Based on Velocity Verlet) using 2 accelerations. 
   * @param a current acceleration of particle
   */
  Runnable updateVelocity(PVector a, float dt) {
    class UpdateVelocity implements Runnable {
      PVector a;
      float dt;
      UpdateVelocity(PVector a, float dt ) {
        this.dt =dt;
        this.a = a;
      }
      public void run() {
        velocity.add(PVector.add(acceleration.copy(), a).mult(0.5 *dt));
      }
    }
    return new UpdateVelocity( a, dt);
  }



  ///**
  // *  Updates object for one time step of simulation.
  // */
  //void update(float dt) {
  //  // acceleration functions

  //  PVector a_grav = PVector.mult(position.copy().normalize(), -System.GMp/position.copy().magSq());

  //  PVector tempPosition = PVector.add(position.copy(), velocity.copy().mult(dt)).add(a_grav.copy().mult(0.5*sq(dt)));

  //  PVector a_grav1 = PVector.mult(tempPosition.copy().normalize(), -System.GMp/tempPosition.copy().magSq());

  //  this.velocity.add(PVector.add(a_grav, a_grav1).mult(0.5 *dt));
  //  this.position = tempPosition;
  //}

  ///**
  // * Render Method - Renders this object to PGraphics Object. 
  // */
  //void render(PGraphics x) {
  //}
  abstract Particle clone();
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
    super((random(1)*(outer-inner) + inner)*System.Rp, random(1)*2.0*PI);
  }

  /**
   *  Class Constuctor - Initialises an RingParticle object with a random position in the ring with correct orbital velocity. 
   */
  RingParticle(float radius) {
    // Initialise ourRingParticle.
    super(radius, random(1)*2.0*PI);
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
  PVector getAcceleration(System s) {

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
  Particle clone() {
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
  color c ;
  final float moonSizeScale= 2;

  /**
   *  Class Constuctor - General Moon object with random angle. 
   */
  Moon(float Gm, float radius, float orb_radius, color c) {
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

    this(2.529477495e13, 400e3, 185.52e6);
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
  void display() {
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
  PVector getAcceleration(RingmindSystem s) {

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
  Particle clone() {
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
  boolean isAligned(Alignable other) {
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
  float timeToAlignment(Alignable other) {
    Moon otherMoon = (Moon)other;
    float dAngle = this.position.heading() - otherMoon.position.heading();
    float dOmega = kepler_omega(this)-kepler_omega(otherMoon);
    return dAngle/(dOmega*s.simToRealTimeRatio);
  }

  /** Method to calculate the Keplerian orbital angular frequency (using Kepler's 3rd law).
   *@param r Radial position (semi-major axis) to calculate the period [m].
   *@return The angular frequency [radians/s].
   */
  float kepler_omega(Moon m) {
    return sqrt(System.GMp/(pow(m.position.mag(), 3.0)));
  }


  /**Method to get the angle in degrees of the moon
   * @param m Moon Object.
   * @return [degrees].
   */
  float moonAngle(Moon m) {
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
  void addResonance(float Q) {
    r.add(new Resonance(Q, this));
  }
}

/**Class Resonance - Orbital Resonance / Limdblad Resonance information.  
 * @author Thomas Cann
 */
public class Resonance {

  float Q;
  float rGap;
  float Effect;
  float rMax;
  float bellMag = 1e5;
  float bellWidth = 0.001913069;

  Resonance(float Q, Moon m) {
    this.Q = Q;
    calcRGap(m);
    //calcEffect(m);
    calcRmax();
  }

  void calcRGap(Moon m) {
    rGap = (m.position.mag()*pow(Q, (-2.0/3.0)))/60268e3;
  }
  //void calcEffect(Moon m) {
  //  //Accleration at gap ( Gravitational force due to moon at ring gap --> moonmass/(rmoon -rgap)^2 multiplied by a constant
  //}

  float calcAccleration(float x) {

    // a proportional to GM pow(Q, ?) 
    return bellMag*exp( -sq(x) /(Q*bellWidth)) + 1;
  }

  void calcRmax() {
    // Bell Curve/ Effect curve gets to f(0)= 1 ---> f(RMax)=0.01
    rMax = rGap + sqrt((-bellWidth*log(0.01/bellMag))/Q);
  }
}

/**
 * Method to add specific ResonanceMoon object to an Arraylist.
 */
void addResonanceMoon(int i, ArrayList<ResonantMoon> m) {
  //Source: Nasa Saturn Factsheet

  switch(i) {
  case 1: 
    // Mimas Mass 3.7e19 [kg] Radius 2.08e5 [m] Obital Radius 185.52e6 [m]
    ResonantMoon moon =new ResonantMoon(G*3.7e19, 2.08e5, 185.52e6);
    moon.addResonance(2.0);
    m.add(moon);
    break;
  }
}


//---------------------------------------------------------------------------------------------------------------------------------------------------//

/** Class TiltParticle
 */
class TiltParticle extends RingParticle {

  float MAX_INCLINATION=80;
  float MIN_INCLINATION=1;
  float LAMBDA= 8E-5;  //float LAMBDA= 3E-5;

  float rotation;
  float inclination;
  float initialiseTime;
  float minInclination;

  /** Class Constuctor - Initialises an TiltParticle object with a random position in the ring with correct orbital velocity. 
   */
  TiltParticle(float r, float dr, float theta, float dtheta) {
    super(r, dr, theta, dtheta);
    rotation =random(360);
    inclination= randomGaussian()*MAX_INCLINATION;
    minInclination = randomGaussian()* MIN_INCLINATION;
    initialiseTime = millis();
  }
  /** Class Constuctor - Initialises an TiltParticle object with a random position in the ring with correct orbital velocity. 
   */
  TiltParticle(float inner, float outer) {
    super(inner, outer);
    rotation =random(360);
    inclination= randomGaussian()*MAX_INCLINATION;
    minInclination = randomGaussian()* MIN_INCLINATION;
    initialiseTime = millis();
  }

  /** Class Constuctor - Initialises a TiltParticle object with a random position in the ring with correct orbital velocity. 
   */
  TiltParticle(float radius) {
    super(radius);
    rotation =random(360);
    inclination= randomGaussian()*MAX_INCLINATION;
    minInclination = randomGaussian()* MIN_INCLINATION;
    initialiseTime = millis();
  }

  /** Method to exponential decrease inclination with after since initialisation.
   */
  float inclination() {
    return inclination* exp(-LAMBDA*(millis()-initialiseTime)) +minInclination ;
  }
}

//------------------------------------- SHEAR PARTICLE -------------------------------------------------------

class ShearParticle extends Particle {

  //position.x;    //Position of Particle along planet-point line relative to moonlet [m].
  //position.y;    //Position of Particle along along orbit relative to moonlet [m].

  final float SG = 6.67408e-11; //Shear Gravitational Constant
  //ShearParticle Initialisation Properties
  final float particle_rho = 900.0;  //Density of a ring particle [kg/m^3].
  final float particle_a = 0.01;     //Minimum size of a ring particle [m].
  final float particle_b = 10.0;     //Maximum size of a ring particle [m].
  final float particle_lambda = 5;   //Power law index for the size distribution [dimensionless].
  final float particle_D =1.0/( exp(-particle_lambda*particle_a) -exp(-particle_lambda*particle_b));
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
    position.x= (random(1)-0.5)*s.Lx;
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
    velocity.y = 1.5 * s.Omega0 * position.x;
    //
    this.radius = - log((particle_C-random(1.0))/particle_D)/particle_lambda;
    this.GM = SG* (4.0*PI/3.0)*pow(radius, 3.0)*particle_rho;
    m= PI*pow(radius, 3.0)*4.0/3.0;
  }

  ShearParticle() {
    //
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    //
    this.radius = - log((particle_C-random(1.0))/particle_D)/particle_lambda;
    this.GM = SG* (4.0*PI/3.0)*pow(radius, 3.0)*particle_rho;
    m= PI*pow(radius, 3.0)*4.0/3.0;
  }

  /**Calculates the acceleration on this particle (based on its current position) (Does not override value of acceleration of particle)
   * @param sb Shearing Box
   * @return accleration of this particles due to ShearingBox
   */
  PVector getAcceleration(ShearSystem s) {

    // acceleration due planet in centre of the ring. 
    PVector a_grav = new PVector();

    if (s.A1) {
      a_grav.x += 2.0*s.Omega0*s.S0*position.x;
    }
    if (s.A2) {
      a_grav.x += 2.0*s.Omega0*velocity.y;
    }
    if (s.Moonlet) {
      float moonlet_GMr3 = s.moonlet.GM/pow(position.mag(), 3.0);
      a_grav.x += -moonlet_GMr3*position.x;
      a_grav.y += -moonlet_GMr3*position.y;
    }

    if (s.Self_Grav) {
      for (Particle p : s.particles) {
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

  //TODO Check don't need these as should be imported from Particle.
  ///**
  // *
  // */
  //void set_getAcceleration(System s) {
  //  acceleration = getAcceleration(s);
  //}

  ///**
  // *
  // */
  //void updatePosition(float dt) {
  //  position.add(velocity.copy().mult(dt)).add(acceleration.copy().mult(0.5*sq(dt)));
  //}

  ///**
  // *    Updates the velocity of this Ring Particle (Based on Velocity Verlet) using 2 accelerations.  
  // */
  //void updateVelocity(PVector a, float dt) {
  //  this.velocity.add(PVector.add(acceleration.copy(), a).mult(0.5 *dt));
  //}

  /** Reset
   * @param s 
   */
  void Reset(ShearSystem s) {
    acceleration.x=0;
    acceleration.y=0;
    //
    position.x= (random(1)-0.5)*s.Lx;
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
    velocity.y = 1.5 * s.Omega0 * position.x;
    //
    this.radius = - log((particle_C-random(1))/particle_D)/particle_lambda;
    this.GM = SG* (4*PI/3)*pow(radius, 3)*particle_rho;
  }


  /**Clone Method - Return New Object with same properties.
   * @return particle object a deep copy of this. 
   */
  Particle clone() {
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
  float moonlet_r = 50.0;            //Radius of the moonlet [m].
  final float moonlet_density = 1000.0; //Density of the moonlet [kg/m]
  float moonlet_GM = SG*(4.0*PI/3.0)*pow(moonlet_r, 3.0)*moonlet_density; //Standard gravitational parameter.

  Moonlet() {
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    this.radius = moonlet_r ;
    this.GM = moonlet_GM;
    m= PI*pow(radius, 3.0)*4.0/3.0;
  }
}

//-----------------------------------------Particle I/O--------------------------------------------------------------

/** Method addParticlesFromTable
 * @param s
 * @param filename
 */
void addParticlesFromTable(System s, String filename) {
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
void importFromFileToGrid(System s, String filename) {

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
