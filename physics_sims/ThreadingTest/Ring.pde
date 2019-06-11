/**Class Ring - collection of ring particles 
 * @author Thomas Cann
 * @author ashley james brown
 */
class Ring {
  
  //render variables
  private int maxRenderedParticle;
  Material material = null;
  //ring variables
  ArrayList<RingParticle> particles;
  float r_inner, r_outer, Omega0, density;
  color c;

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Ring( float Inner, float Outer, int n_particles) {

    this.r_inner = Inner;
    this.r_outer = Outer;

    particles = new ArrayList<RingParticle>();
    for (int i = 0; i < n_particles; i++) {
      particles.add(new RingParticle(Inner, Outer));
    }

    Omega0 = kepler_omega((Inner + Outer)/2.0);

    //set a default but overwritable by methods below for each ring and depends on state
    maxRenderedParticle = n_particles;

    this.density = density();
  }

  /**
   *  Method to add RingParticle to particles arraylist (increasing number ofrendered particles as well)
   */
  void addParticle(RingParticle rp) {
    particles.add(rp);
    maxRenderedParticle += 1;
  }

  /**
   *  Get Method - MaxRenderedParticle
   *  @return maxRenderedParticle (used in Render)
   */
  int getMaxRenderedParticle() {
    return maxRenderedParticle;
  }

  /**
   *  Set Method - MaxRenderedParticle
   *  @param newMax
   */
  void setMaxRenderedParticle(int newMax) {
    maxRenderedParticle = min(particles.size(), newMax);
  }

  /** Method to calculate the Keplerian orbital angular frequency (using Kepler's 3rd law).
   *@param r Radial position (semi-major axis) to calculate the period [m].
   *@return The angular frequency [radians/s].
   */
  float kepler_omega(float r) {
    return sqrt(1/(pow(r, 3.0)));
  }

  /** Method to calculate the density of particles in ring.
   *@return denstiy [N/A].
   */
  float density() {
    return particles.size() /(PI *(sq(r_outer) - sq(r_inner)));
  }
}
