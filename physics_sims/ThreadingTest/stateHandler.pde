/** Enumerated Variable State - Values equaling Different Display States
 */
enum State {
  // State called at start of program in initialise everything. 
  initState, 

  /**
   * Main Initialisation States
   */
    //
    introState, 
    //
    ringmindState, 
    //
    ringmindUnstableState, 
    //forming - particles not in plane, collapsing down to a ring.
    formingState, 
    //shear - 
    shearState, 
    //tuning - the ring sound, lets just focus on a ring
    tuningState, 
    //
    connectedState, 
    //
    threadingState, 
    //
    saturnState, 
    //
    ringboarderState, 
    //
    addAlienLettersState, 
    //outro - what is a ringmind lets return back to the beginning.
    outroState, 

  /**
   * Display States
   */
    fadetoblack, 
    fadeup, 
    nocamlock
};

State systemState;

/**Setup States Method - called to initialise the state. 
 */
void setupStates() {
  switch(systemState) {
  case initState:

    renderSetup();
    initScene();   //setup proscene camera and eye viewports etc
    createMaterials();       //extra materials we can apply to the rings

    //init with = rings 10,  moons 4, rendering normal =true (titl would be false);
    s = new ParticleSystem();  

    break;
  case introState:

    initCamera();
    s = new RingmindSystem(2, 2); 
    break;

  case ringmindState:

    useAdditiveBlend=true;
    closerCamera();
    s = new RingmindSystem(10, 4); //<>//


    break;

  case ringmindUnstableState:

    closerCamera();
    useAdditiveBlend=true;
    G=6.67408E-9;
    s = new RingmindSystem(11, 4);

    break;

  case connectedState:

    useAdditiveBlend=true;
    //Connecting=true; 
    //simToRealTimeRatio = 360.0/1.0; //slow it down
    zoomedCamera();
    s = new RingmindSystem(1, 2);
    break;

  case saturnState:

    s = new RingmindSystem(2, 4);

    break;

  case ringboarderState:

    //zoomedCamera();
    initCamera();
    s = new RingmindSystem(13, 0);


    break;
  case addAlienLettersState:
    if (s instanceof RingmindSystem) {
      //RingmindSystem rms = (RingmindSystem)s;
      addParticlesFromTable(s, "outputParticles.csv");
      // rms.rs.rings.get(1).setMaxRenderedParticle(rms.rs.rings.get(1).particles.size());
      //for (Ring r : rms.rs.rings) {
      //  r.material = RingMat5;
      //}
    }
    break;

  case formingState:
    useAdditiveBlend=true;
    s = new TiltSystem();
    break;

    //case orbitalState:

    //  drawMoons=false;
    //  Threading=true;
    //  toptiltCamera();
    //  G=6.67408E-13;
    //  Saturn = new RingSystem(1, 2, true);
    //  applyBasicMaterials();
    //  for (Ring r : Saturn.rings) {
    //    r.material = RingMat5;
    //  }
    //  for (Moon m : Saturn.moons) {
    //    m.radius = 1;
    //  }

    //  Saturn.moons.get(2).GM =4.529477495e13;
    //  Saturn.moons.get(0).GM =2.529477495e13;

    //  break;

  case shearState:
    useAdditiveBlend=true;
    zoomedCamera();
    s = new ShearSystem();
    s.simToRealTimeRatio = 2000.0/1.0;  
    break;
  }
}

/**Update State Method - separate update method for each state. 
 *depending on which scenario do different things and render differently etc
 *@param t 
 */
void updateCurrentState(int t) {

  if (Running) {
    if(s != null){
    s.update();
    }
  }

  if (useTrace) {
    scene.beginScreenDrawing();
    fill(0, traceAmount);
    rect(0, 0, width, height);
    scene.endScreenDrawing();
  } else {
    background(0);
  }

  // Display all of the objects to screen using the renderer.
  if (useAdditiveBlend) {
    blendMode(ADD);
  } else {
    blendMode(NORMAL);
  }
 
  renderOffScreenOnPGraphicsClean();
  switch(systemState) {
  case connectedState:
  renderer.renderComms(s, renderContext, 1);
    break;
  default:
   renderer.render(s, renderContext, 1);
    break;
  }

  if (useFilters) {
    applyFilters();
  }

  titleText();
}
