/**Class RingSystem collection of Rings, Ringlets and Gaps for a planetary ring system. 
 *
 * @author Thomas Cann
 * @version 1.0
 */

int N_PARTICLES = 10000; 
float G = 6.67408E-8;       // Gravitational Constant 6.67408E-11[m^3 kg^-1 s^-2]
float GMp = 3.7931187e16;    // Gravitational parameter (Saturn)

// What are the minimum and maximum extents in r for initialisation
float R_MIN = 1;
float R_MAX = 5;
int RING_INDEX =3;
int MOON_INDEX =1;

final float Rp = 60268e3;          // Length scale (1 Saturn radius) [m]
final float SCALE = 100/Rp;        // Converts from [m] to [pixel] with planetary radius (in pixels) equal to the numerator. Size of a pixel represents approximately 600km.

class RingSystem {

  ArrayList<Particle> totalParticles;
  ArrayList<Ring> rings;
  ArrayList<Moon> moons;
  Grid g;
  float r_min, r_max;

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  RingSystem() {

    g = new Grid();
    r_min= R_MIN;
    r_max= R_MAX;
    totalParticles = new ArrayList<Particle>();
    rings = new ArrayList<Ring>();
    moons = new ArrayList<Moon>();
    initialise();



    //***********************************************
  }

  void initialise() {
    initialiseMoons();
    initialiseRings();
    totalParticles.clear();
    for (Ring r : rings) {
      for (RingParticle p : r.particles) {
        totalParticles.add(p);
      }
    }
    for (Moon m : moons) {
      totalParticles.add(m);
    }
  }

  void initialiseMoons() {
    //***********Initialise Moons*********************
    moons.clear();
    switch(MOON_INDEX) {
      case(1):
      // Adding Specific Moons ( e.g. Mima, Enceladus, Tethys, ... )
      //addMoon(5, moons);
      //addMoon(7, moons);
      //addMoon(9, moons);
      //addMoon(12, moons);
      //addMoon(14, moons);
      break;
      case(2):
      //Adding All Moons
      for (int i = 0; i < 18; i++) {
        addMoon(i, moons);
      }
    default:
    }
  }

  void initialiseRings() {
    //***********Initialise Rings********************* 
    rings.clear();
    switch(RING_INDEX) {
    case 1:
      //Generic Disc of Particles
      rings.add(new Ring(1.1, 2.9, N_PARTICLES));
      break;
    case 2:
      //Saturn Ring Data (Source: Nasa Saturn Factsheet) [in Saturn radii]
      // D Ring: Inner 1.110 Outer 1.236
      rings.add(new Ring(1.110, 1.236, N_PARTICLES/10));
      // C Ring: Inner 1.239 Outer 1.527
      rings.add(new Ring(1.239, 1.527, N_PARTICLES/10));
      // B Ring: Inner 1.527 Outer 1.951
      rings.add(new Ring(1.527, 1.951, N_PARTICLES/10));
      // A Ring: Inner 2.027 Outer 2.269
      rings.add(new Ring(2.027, 2.269, N_PARTICLES/2));
      // F Ring: Inner 2.320 Outer *
      rings.add(new Ring(2.320, 2.321, N_PARTICLES/10));
      // G Ring: Inner 2.754 Outer 2.874
      rings.add(new Ring(2.754, 2.874, N_PARTICLES/10));
      // E Ring: Inner 2.987 Outer 7.964
      //rings.add(new Ring(2.987, 7.964, 1000));

      //Gaps/Ringlet Data
      // Titan Ringlet 1.292
      // Maxwell Gap 1.452
      // Encke Gap 2.265
      // Keeler Gap 2.265

      break;

    case 3:
      rings.add(new Ring(1, 3, 0));
      Table table; 
      table = loadTable("input.csv");//"input.csv"
      //println(table.getRowCount()+" "+ table.getColumnCount());
      ArrayList<RingParticle> tempParticles = new ArrayList<RingParticle>();
      for (int i = 0; i < table.getRowCount(); i++) {
        for (int j = 0; j < table.getColumnCount(); j++) {

          for (int x=0; x<table.getInt(i, j); x++) {
            tempParticles.add(new RingParticle(r_min+g.dr*i, g.dr, radians(g.dtheta*j-180), radians(g.dtheta)));
          }
        }
      }
      rings.get(0).particles=tempParticles;
      break;
    case 4:
      rings.add(new Ring(1, 3, 0));
      rings.get(0).particles.add(new RingParticle(2, 0, 0, 0));
      break;
    case 5:
      //2 Discs of Particles
      rings.add(new Ring(1.1, 2.9, N_PARTICLES/2));
      rings.add(new Ring(4.5, 4.7, N_PARTICLES/2));
      break;
    default:
    }
  }


  /**
   *  Updates object for one time step of simulation taking into account the position of one moon.
   */
  void update() {

    g.update(this);
    for (Particle p : totalParticles) {
      p.set_getAcceleration(this);
    }
    for (Particle p : totalParticles) {
      p.updatePosition();
    }
    g.update(this);
    for (Particle p : totalParticles) {
      p.updateVelocity(p.getAcceleration(this));
    }
    //Output TABLE 
    //saveTable(g.gridToTable(g.grid), "output.csv");
  }

  /**
   *
   */
  void display() {
    push();
    translate(width/2, height/2);
    strokeWeight(2);
    stroke(255);
    for (Ring r : rings) {
      for (RingParticle p : r.particles) {

        point(SCALE*p.position.x, SCALE*p.position.y);
      }
    }
    strokeWeight(4);
    stroke(255, 0, 0);
    for (Moon m : moons) {
      point(SCALE*m.position.x, SCALE*m.position.y);
    }
    guidelines();

    //for (Particle p : totalParticles) {
    //  if (p instanceof RingParticle) {
    //    strokeWeight(2);
    //    stroke(255);
    //    point(SCALE*p.position.x, SCALE*p.position.y);
    //  } else if ( p instanceof Moon) {
    //    strokeWeight(4);
    //    stroke(255, 0, 0);
    //    point(SCALE*p.position.x, SCALE*p.position.y);
    //  }
    //}
    pop();

    
    g.display();
  }

  //guidelines round edge of rings and planet.
  void guidelines() {
    strokeWeight(1);
    stroke(255, 165, 0);
    noFill();
    circle(0, 0, 2*R_MAX*SCALE*Rp);
    circle(0, 0, 2*R_MIN*SCALE*Rp);
    fill(255, 165, 0);
    circle(0, 0, 2.0*SCALE*Rp);
   
  }

  /**
   *
   */
  void render(PGraphics x) {
    for (Ring r : rings) {
      //r.render(x);
    }
    for (Moon m : moons) {
      m.render(x);
    }
  }


  /**
   *
   */
  void addMoon(int i, ArrayList<Moon> m) {

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
    }
  }
}
