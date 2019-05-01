# Ring-Table-Processing

[Processing](https://processing.org/) project for 

* (i) [Ring Table](#rs-processing) simulation ([examples](#all-examples))

## Dependencies

All dependencies of this project are native to Processing platform.

## Contact / License

Feel free to contact me by mail: canntj@gmail.com

---

<a name="rs-processing"></a>
## Ring System (RingTableProcessing.pde)
> Physics Simulation of Planetary Ring Systems including Moon, Ring and Ring Particle objects

Usage:

`Open the main .pde file (RingSystemProcessing.pde) and run it by the Processing IDE`
* Pressing <kbd>CTRL</kbd>+<kbd>R</kbd>; or
* Selecting menu <kbd>Sketch</kbd> and <kbd>Run</kbd>;

### Main concepts of Ring System (introduction and concepts)

Due to the large variety in size and time scales. 
The Motion of Objects are affected by a subset of objects:

Ring Particles are affected by the Moons positions.  
Moons are affected by the positions of other Moons.

Additionally a grid which collect information such as local particle density, average velocity - using this an estimation of collision and local gravity could be calculated.

### Classes of RingSystem implementation

* **RingParticle.pde**

> Class that represents the RingParticle entity.

A Ring Particle is a item with a position `(x, y, z)` and a velocity `(vx, vy, vz)`.

The attributes for RingParticle class are:
  
```processing
   PVector position;
   PVector velocity;
```

The methods for RingParticle class are:

```processing
  void display() {... }
  void render(PGraphics x) {... }
  void update(ArrayList<Moon> moons) {... }
```

* **Ring.pde**

> Class that represents the Ring entity.

The Ring class is in the process of implementation and will responsible for all radial subdivision and outputing radial structure properties.

The attributes for Ring class are:
  
```processing

  ArrayList<RingParticle> particles;
  float r_inner, r_outer;
  color c;
  
```

The methods for Ring class are:

```processing
  void update(ArrayList<Moon> m) {...}
  void display() {...}
  void render(PGraphics x) {...}
```

* **RingSystem.pde**

> Class that represents the Ring System entity.

The Ring System class is responsible for the integration of all entities (Rings, Ring Particles and Moons) in the ring system simulation.

The attributes for RingSystem class are:
  
```processing

  ArrayList<Ring> rings;
  ArrayList<Moon> moons;
  
```

The methods for Ring class are:

```processing
  void addMoon(int i, ArrayList<Moon> m) {...}
  void update() {...}
  void display() {...}
  void render(PGraphics x) {...}
```

* **RingTableProcessing.pde**

> Main class that is in charge of the main simulation loop (updating and displaying/rendering objects) and is dynamically in control of time step to make simulation smooth.

The attributes for RingTableProcessing class are:
 
```processing
  int n_particles = 10000;   
  float h_stepsize;

//Dynamic Timestep variables

  final float simToRealTimeRatio = 10*3600.0/1.0;   // 3600.0/1.0 --> 1hour/second
  final float maxTimeStep = 20* simToRealTimeRatio / 30;
  float totalSimTime =0.0;                       // Tracks length of time simulation has be running

  RingSystem Saturn;
```

The methods for RingSystemProcessing class are:

```processing

  void setup() { ... }
  void draw() { ... }
   
  void fps(){...}
  void guidelines() {...}
  
```
