// A package containing code for the Ringmind project
//.. module:: orboid_xy
//   :synopsis: Test code to try Boids in a Cartesian coordinate system.

//.. moduleauthor:: Chris Arridge <c.arridge@lancaster.ac.uk>


// length scale (1 Saturn radius) and gravitational parameter (Saturn)
float Rp = 60268e3;
float GM = 3.7931187e16;
float h_stepsize = 10*60;   // seconds

// Basic parameters
float n_steps=10000;
float n_orboids = 1000;
//vis_freq = 50;        // how of ten is a frame drawn

ArrayList<Orboid> orboids;

void setup() {
  size (850, 650);
  orboids = new ArrayList<Orboid>();

  for (int i = 0; i < n_orboids; i++) {
    orboids.add(new Orboid());
  }
}

void draw() {
  translate(width/2, height/2);
  background(255);
}

// acceleration functions
ax_grav = lambda _x, _y, _GM: 
-_GM*_x/pow(sqrt(sq(_x) + sq(_y)), 3.0);
ay_grav = lambda _x, _y, _GM: 
-_GM*_y/pow(sqrt(sq(_x) + sq(_y)), 3.0);

// What are the minimum and maximum extents in r for initialisation
float r_min = 1.5;
float r_max = 3.0;


// Setup visualisation.
if vis_dest=='matplotlib':
fig = pl.Figure()
  elif vis_dest=='vis':
rend = vis.Renderer(2.0*r_max, 2.0*r_max, moonlet_radius=0.0, max_particle_radius=0.01, scale=100)
  rend.start_movie('orboid_rphi_test.gif', fps=20)


  for i in range(n_steps):
// leapfrog integration
x1_orboid = x_orboid + vx_orboid*h_stepsize + 0.5*ax_grav(x_orboid, y_orboid, GM)*h_stepsize*h_stepsize
  y1_orboid = y_orboid + vy_orboid*h_stepsize + 0.5*ay_grav(x_orboid, y_orboid, GM)*h_stepsize*h_stepsize
  vx_orboid = vx_orboid + 0.5*(ax_grav(x_orboid, y_orboid, GM)+ax_grav(x1_orboid, y1_orboid, GM))*h_stepsize
  vy_orboid = vy_orboid + 0.5*(ay_grav(x_orboid, y_orboid, GM)+ay_grav(x1_orboid, y1_orboid, GM))*h_stepsize
  x_orboid = x1_orboid
  y_orboid = y1_orboid
  v_orboid[i+1, :
] = sqrt(sq(vx_orboid[0:
10])+sq(vy_orboid[0:
10]))

  // Check energy conservation
  pl.close();
pl.Figure();
pl.subplot(2, 1, 1);
pl.plot(v_orboid**2);
pl.subplot(2, 1, 2);
pl.semilogy(v_orboid**2*100/v_orboid[0, :
]**2);
pl.show();
