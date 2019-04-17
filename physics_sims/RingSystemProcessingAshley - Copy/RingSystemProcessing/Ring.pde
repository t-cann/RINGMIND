/**Class Ring
 * @author Thomas Cann
 * @version 1.0
 */
class Ring {

  //render variables
  private int maxRenderedParticle;
  Material material = null;

  //
  ArrayList<RingParticle> particles;
  float r_inner, r_outer;
  color c;

  //id
  int ringID = 0;

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  Ring(int rnum, float Inner, float Outer, int n_particles) {
    this.ringID = rnum;
    particles = new ArrayList<RingParticle>();
    for (int i = 0; i < n_particles; i++) {
      particles.add(new RingParticle(Inner, Outer));
    }
    maxRenderedParticle = n_particles; //default but overwritable by methods below for each ring and depends on state
  }
  
   void update(RingSystem rs) {
    for (RingParticle p : particles) {
      //p.update(rs);
    }
    
   }
   
   //--- new render methods setter and getter

  int getMaxRenderedParticle() {
    return maxRenderedParticle;
  }

  void setMaxRenderedParticle(int newMax) {
     maxRenderedParticle = min(particles.size(),newMax);
  }
  
 
  
}
