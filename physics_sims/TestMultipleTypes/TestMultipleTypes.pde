

ArrayList<Particle> particles;

void setup () {
  frameRate(30);
  size (900, 900);

  particles = new ArrayList<Particle>();

  for (int i = 0; i < 10; i++) {
    particles.add(new Particle());
    particles.add(new RingParticle());
    particles.add(new Moon());
  }
} 

void draw () {

  background(0);
  for (Particle x : particles) {
    // Zero acceleration to start
    x.update(particles);
    x.display();
    //if(x.getClass()==particles.get(2).getClass()){
    //x.display();
    //}
  }
  
}
