/** Enumerated Variable State - Values equaling Different Display States //<>//
 */
enum State {
  // State called at start of program in initialise everything. 
  initState, 

  /**
   *Main Initialisation States
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

    resonanceState, 

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
    s = new RingmindSystem(1, 0);  

    break;
  case introState:

    initCamera();
    s = new RingmindSystem(2, 2); 
    break;

  case ringmindState:

    useAdditiveBlend=true;
    closerCamera();
    s = new RingmindSystem(10, 4);


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
  
    addParticlesFromTable(s, "outputParticles.csv");
    break;

  case formingState:
  
    useAdditiveBlend=true;
    s = new TiltSystem();
    break;

  case shearState:
    useAdditiveBlend=true;
    zoomedCamera();
    s = new ShearSystem(false);
    s.simToRealTimeRatio = 2000.0/1.0;  
    break;
    
   case resonanceState:
   
   s = new ResonantSystem();
   break;

  default:
  }
}

/**Update State Method - separate update method for each state. 
 *depending on which scenario do different things and render differently etc
 *@param t 
 */
void updateCurrentState(int t) {

  if (Running) {
    if (s != null) {
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
