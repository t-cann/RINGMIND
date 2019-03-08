// A package containing code for the Ringmind project
//.. module:: orboid_xy
//   :synopsis: Test code to try Boids in a Cartesian coordinate system.

//.. moduleauthor:: Chris Arridge <c.arridge@lancaster.ac.uk>

// What are the minimum and maximum extents in r for initialisation
float r_min = 1.2;
float r_max = 2.5;

// length scale (1 Saturn radius) and gravitational parameter (Saturn)
float Rp = 60268e3;
float GM = 3.7931187e16;
float h_stepsize = 1*60; // seconds
float scale = 100/Rp;

// Basic parameters
float n_orboids = 1000;
float n_moons = 1;
//vis_freq = 50;        // how of ten is a frame drawn

ArrayList<Orboid> orboids;
ArrayList<Moon> moons;

void setup() {
  size (1000, 700);
  orboids = new ArrayList<Orboid>();
  moons = new ArrayList<Moon>();

  for (int i = 0; i < n_orboids; i++) {
    orboids.add(new Orboid());
  }
  for (int i = 0; i < n_moons; i++) {
    moons.add(new Moon());
  }
}

void draw() {
  push();
  translate(width/2, height/2);
  background(0);
  stroke(0, 255, 0);
  fill(0);
  circle(0, 0, 5.0*scale*Rp);
  circle(0, 0, 2.4*scale*Rp);
  circle(0, 0, 2.0*scale*Rp);
  //float tempEtot = 0;
  for (Orboid x : orboids) {
    x.update();
    //tempEtot+= x.Etot_orboid();
  }
  for (Moon m : moons){
    m.update();
  }
  //println(tempEtot+" ");

  if (mousePressed) {
    orboids.add(new Orboid(mouseX, mouseY));
  }
  pop();

  fill(0);
  rect(0, height-20, width, 20);
  fill(255);
  text("Framerate: " + int(frameRate), 10, height-6);
}

void keyPressed() {
  if (key=='c') {
    orboids.clear();
  }
}

// Check energy conservation
//pl.close();
//pl.Figure();
//pl.subplot(2, 1, 1);
//pl.plot(pow(v_orboid, 2));
//pl.subplot(2, 1, 2);
//pl.semilogy(pow(v_orboid, 2.0)*100/pow(v_orboid, 2));
//pl.show();
