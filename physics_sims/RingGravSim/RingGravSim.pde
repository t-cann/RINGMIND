/**Class RingGravSim 
 * A gravitational simulation in a Cartesian coordinate system.
 * @author Thomas Cann
 * @author Sim Hinson
 * @version 1.0
 */

// What are the minimum and maximum extents in r for initialisation
float r_min = 1.5;
float r_max = 3;

final float G = 6.67408E-11; // Gravitational Constant[m^3 kg^-1 s^-2]
float Rp = 60268e3;          // Length scale (1 Saturn radius)
float scale = 150/Rp;        // 
float GMp = 3.7931187e16;    // Gravitational parameter (Saturn)
float h_stepsize;


// Basic parameters
float n_orboids = 10000;
//vis_freq = 50;        // how of ten is a frame drawn

//Dynamic Timestep variables
float simToRealTimeRatio =3600.0/1.0;  //1hour/second
//initialise for frame counting
float totalSimTime =0.0;


ArrayList<Orboid> orboids;
ArrayList<Moon> moons;

void setup() {
  size (1920, 1000, P2D);
  frameRate(30);
  noSmooth();
  randomSeed(0);
  
  orboids = new ArrayList<Orboid>();
  moons = new ArrayList<Moon>();

  // Adding Specific Moons ( e.g. Mima, Enceladus, Tethys, ... )
  
  addMoon(7, moons);
  addMoon(8, moons);
  addMoon(9, moons);
  addMoon(12, moons);
  addMoon(14, moons);

  //Adding All Moons
  
  //for (int i = 0; i < 18; i++) {
  //  addMoon(i,moons);
  //}

  for (int i = 0; i < n_orboids; i++) {
    orboids.add(new Orboid());
  }
}

void draw() {
  
  // calculate simulation time step for this frame
  h_stepsize= simToRealTimeRatio/frameRate;
  
  //*************Update and Render Frame******************
  
  guidelines();
  
  //float tempEtot = 0;
  for (Orboid x : orboids) {
    x.update(moons);
    //tempEtot+= x.Etot_orboid();
  }
  for (Moon m : moons) {
      m.update(moons);
  }
  //println(tempEtot+" ");

  fps();
  
  //******************************************************
  
  totalSimTime +=h_stepsize;

}

void fps(){
  push();
  fill(0);
  rect(0, height-20, width, 20);
  fill(255);
  text("Framerate: " + int(frameRate) + "     Time Elapsed[Seconds]: " + int(millis()/1000.0) + "     Simulation Time Elapsed[hours]: " + int(totalSimTime/3600.0) , 10, height-6);
  pop();
}

void guidelines(){
  push();
    translate(width/2, height/2);
  background(0);
  stroke(0, 255, 0);
  noFill();
  circle(0, 0, 2*r_max*scale*Rp);
  circle(0, 0, 2*r_min*scale*Rp);
  stroke(255, 165, 0);
  fill(255, 165, 0);
  circle(0, 0, 2.0*scale*Rp);
  pop();
}

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
    m.add(new Moon(G*5.3e17, 6.5e4, 151.422e6));
    break;
  case 6:
    // Janus Mass 1.9e18 [kg] Radius 1.02e5 [m] Orbital Radius 151.472e6 [m]
    m.add(new Moon(G*1.9e18, 1.02e5, 151.472e6));
    break;
  case 7: 
    // Mima Mass 3.7e19 [kg] Radius 2.08e5 [m] Obital Radius 185.52e6 [m]
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

//TO DELETE/ TIDY UP

//if (mousePressed) {
//  //orboids.add(new Orboid(mouseX, mouseY));
//  println(sqrt(sq(mouseX-width/2)+sq(mouseY-height/2)) + " ");
//}

// Check energy conservation
//pl.close();
//pl.Figure();
//pl.subplot(2, 1, 1);
//pl.plot(pow(v_orboid, 2));
//pl.subplot(2, 1, 2);
//pl.semilogy(pow(v_orboid, 2.0)*100/pow(v_orboid, 2));
//pl.show();
