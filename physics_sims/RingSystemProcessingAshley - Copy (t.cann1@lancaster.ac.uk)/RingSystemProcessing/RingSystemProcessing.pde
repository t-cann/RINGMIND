
/**Class RingSystemProcessing 
 * A gravitational simulation in a Cartesian coordinate system.
 *
 * @author Thomas Cann
 * @author Sim Hinson
 * @version 2.0
 */




// interaction design
// audio visual system 
// @ ashley james brown march.2019




////////////////
//            //
//            //
//  RINGMIND  //
//            //
//            //
////////////////


// render variables
boolean drawMoons;
int ringCnt = 10; // how many rings to render

// Basic parameters
int n_particles = 10000;   //currently irrelvant and not actually used due to proper data in class constructor
float h_stepsize;

//Dynamic Timestep variables
final float simToRealTimeRatio = 360.0/1.0;   // 3600.0/1.0 --> 1hour/second
final float maxTimeStep = 20* simToRealTimeRatio / 30;
float totalSimTime =0.0;                       // Tracks length of time simulation has be running

//Initialising 
RingSystem Saturn;

//Render System
RingSystemRenderer rsRenderer;
RenderContext rsRenderContext;
PGraphics pg;
PShader offscreenShader;

//---------------------------------------------------------------------------------------------------------------------------------------

void settings() {
  size (1900, 1000, P3D); //3840,2160 still runs 60fps just takeas few secodns to load
  smooth(); //noSmooth();
}


//----------------------------------------------------------------------------------------------------------------------------------------

// default overlay render using shader

void renderOffScreenOnPGraphics() {
  pg.beginDraw();
  pg.shader(offscreenShader);
  offscreenShader.set("resolution", float(pg.width), float(pg.height));
  offscreenShader.set("time", float(millis()));
  pg.rect(0, 0, pg.width, pg.height);
  pg.endDraw();
}


//a little keyhole example
void renderOffScreenOnPGraphics2() {
  pg.beginDraw();
  pg.background(0, 0, 0);
  //pg.stroke(255);
  //pg.fill(255);
  //pg.strokeWeight(100);
  //pg. line(0,0,pg.wdith,pg.height);

  pg.ellipse(mouseX, mouseY, 200, 200);
  pg.endDraw();
}

void renderOffScreenOnPGraphicsClean() {
  pg.beginDraw();
  pg.background(255, 255, 255); //no shader diffuse texture over the top
  pg.endDraw();
}



//--------------------------------------------------------------------------------------------------------------------------------------------

void setup() {
  // size (960, 540, P3D);

  setupOSC();

  randomSeed(3);
  Saturn = new RingSystem();

  // --------- renderer
  rsRenderer = new RingSystemRenderer();
  rsRenderer.withMoon = false;
  rsRenderContext = new RenderContext();
  rsRenderContext.pgfx = this;
  rsRenderContext.shader = loadShader("texfrag.glsl", "texvert.glsl");
  rsRenderContext.mat.spriteTexture = loadImage("rock.png");
  pg = createGraphics(1024, 1024, P3D);
  rsRenderContext.mat.diffTexture = pg;
  rsRenderContext.mat.strokeColor = 255;
  offscreenShader = loadShader("noise.glsl");

  background(0);

  //setup proscene camera and eye viewports etc
  initScene();
  
  //if we want a planet in the middle
  initSaturn();
  
  //if we want postfx - but they a bit slow and shiuld render in the shader really
  //setupFX();

  //which state shall we begin with
  systemState = State.introState; 

//----------- Materials per ring

  // first ring material to be different just as proof of concept
  Material RingMat =  new Material();
  RingMat.strokeColor = color(203, 162, 147);
  RingMat.spriteTexture = loadImage("partsmall.png");
  RingMat.diffTexture = pg;
  RingMat.strokeWeight = .9;


 // second ring material to be different just as proof of concept
  Material RingMat2 =  new Material();
  RingMat2.strokeColor = color(203, 62, 117);
  RingMat2.spriteTexture = loadImage("partsmall.png");
  RingMat2.diffTexture = pg;
  RingMat2.strokeWeight = .9;


  //apply the new material to each ring required 
  Saturn.rings.get(0).material = RingMat;
  //Saturn.rings.get(2).material = RingMat2;
  //Saturn.rings.get(5).material = RingMat;
  
  
  // osc sound engine init
  transmitAllRingsOSC();
}

//-----------------------------------------------------------------------------------------------------------------------------------------------

void draw() {

  //lighting();//only needed if rendering planet. all else is in teh shader
  background(0);
  
  
  // calculate simulation time step for this frame
  if (simToRealTimeRatio/frameRate < maxTimeStep) {
    h_stepsize= simToRealTimeRatio/frameRate;
  } else {
    h_stepsize= maxTimeStep;
    println("At Maximum Time Step");
  }

  //*************Update and Render Frame******************

  //Updates properties of all objects.

  //thread("update");
  Saturn.update();
  //blendMode(NORMAL);
  //drawSaturn();
  blendMode(ADD);

  // Display all of the objects to screen.

  // here we can now define exactly how many particles from each ring we render regardless how big the ring actually is. change as per scenario requires it
  for (Ring r : Saturn.rings) {
    r.setMaxRenderedParticle(10000);
  }

  //renderOffScreenOnPGraphics(); // this fills the diffuse texture
 // renderOffScreenOnPGraphics2(); // this ios the keyhole overlay
  renderOffScreenOnPGraphicsClean();
  rsRenderer.withMoon = drawMoons;
  rsRenderer.ringNumber = ringCnt;
  rsRenderContext.mat.diffTexture = pg;
  rsRenderer.render(Saturn, rsRenderContext);

  // debug frame output nice and quick
  titleText();

  // runPostFX(); //slow and not that great

  //******************************************************

  totalSimTime +=h_stepsize;
}

//Method to enable threading
void update() {
  Saturn.update();
}


// guidelines round edge of rings and planet.
void guidelines() {
  push();
  translate(width/2, height/2);
  stroke(255, 165, 0);
  noFill();
  circle(0, 0, 2*r_max*scale*Rp);
  circle(0, 0, 2*r_min*scale*Rp);
  stroke(255, 165, 0);
  fill(255, 165, 0);
  circle(0, 0, 2.0*scale*Rp);
  pop();
}


//--------------------------- INTERACTION KEYS ,need to be careful as some are bind to the proscene but we can voerwrite. todo add new bindings

public void keyPressed() {
  if (key == 'm') {
    // the moons slow down the entire system so maybe dont render them always or chang them to be also a texture like the particles.? 
    drawMoons = !drawMoons;
  } else if (key=='o'){
    transmitAllRingsOSC();
  }
}

public void keyReleased() {
  //if (key == '1') state = cam.getState();
  // if (key == '2') cam.setState(state, 10000);
  scene.saveConfig(); //outputs the camera path to a json file.
}
