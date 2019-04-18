
import remixlab.bias.*;
import remixlab.bias.event.*;
import remixlab.dandelion.constraint.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.fpstiming.*;
import remixlab.proscene.*;
import remixlab.util.*;


PImage saturnTex;
PShape planet;

InteractiveFrame planetSaturn;
Scene scene;

Trackable lastParticle;
boolean inThirdPerson;
  

//--------------------------------------------------

void initScene() {

  scene = new Scene(this);
  scene.eyeFrame().setDamping(0.05); //0 is a little too rigid
 
  //create an object that can be part of the interactive scene and set its initial positoon
  planetSaturn = new InteractiveFrame(scene);
  planetSaturn.setPosition(new Vec(0, 0, 0));
  
  //not ready yet but will allow clicking on any particle or moon to get camera con trol from their perspective
  scene.mouseAgent().setPickingMode(MouseAgent.PickingMode.CLICK);
  
  //load json file with predon camera paths.... 
  scene.loadConfig();
  
  //trun off debug guides
  scene.setGridVisualHint(false);
  scene.setAxesVisualHint(false);
  
  //must set scene to be big so it redners proerply
  scene.setRadius(500); //how big is the scene - bigger means slower to load at startup
  
  scene.showAll();
  
  //todo all the particles and entire system need to be part of an Interactive Frame to enable them to be part of the individual camera control
  
}






// fps and other important info to the title bar

void titleText() {
  String txt_fps = String.format(getClass().getSimpleName()+ "   [size %d/%d]   [frame %d]   [fps %6.2f] [Time Elapsed in Seconds %d] [Simulation Time Elapsed in Hours %d]", width, height, frameCount, frameRate, int(millis()/1000.0), int(totalSimTime/3600.0) );
  surface.setTitle(txt_fps);
}
