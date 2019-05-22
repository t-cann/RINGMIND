Boolean Running= true;

void settings() {

  //fullScreen(P3D, 1);
  size (1000, 800, P3D);
  smooth(); //noSmooth();
}

void setup() {
  background(0);
  randomSeed(3);
  systemState = State.initState;  //which state shall we begin with 
  setupStates();    //instantiate the scenarios so they are avialble for the state system to handle
}

void draw() {

  //*************Simulation Update Frame******************

  updateCurrentState(millis());    //calls the render and anything specific to each scene state 

  //******************************************************
}

//--------------------------- INTERACTION KEYS -------------------------------------------------------------------

void keyPressed() {

  if (key==' ') {
    Running = !Running;
  }
  //NUMERICAL KEY
  if (key=='1') {
    //Proscene - Camera Route #1
  } else if (key=='2') {
    //Proscene - Camera Route #2
  } else if (key=='3') {
    //Proscene - Camera Route #3
  } else if (key=='4') {
    //introState
    systemState= State.introState;
    setupStates();
  } else if (key=='5') {
    //ringmindStableState
    systemState= State.ringmindState;
    setupStates();
  } else if (key=='%') {
    //Unstable Ringmind State
    systemState= State.ringmindUnstableState;
    setupStates();
  } else if (key=='6') {
    //connectedState
    systemState= State.connectedState;
    setupStates();
  } else if (key=='7') {
    //saturnState
    systemState= State.saturnState;
    setupStates();
  } else if (key=='8') {
    //shearState
    systemState= State.shearState;
    setupStates();
  } else if (key=='*') {
    //Toggle Moonlet
    if (s instanceof ShearSystem) {
      ShearSystem ss = (ShearSystem) s;
      ss.Moonlet = !ss.Moonlet;
    }
  } else if (key=='9') {
    //TiltSystem
    systemState= State.formingState;
    setupStates();
  } else if (key=='0') {
    systemState= State.ringboarderState;
    setupStates();
  } else if (key==')') {
    systemState= State.addAlienLettersState;
    setupStates();
  } else if (key=='-') {
    systemState= State.threadingState;
    setupStates();
  }


  //----------------------------TOP ROW QWERTYUIOP[]------------------------------------------------
  if (key=='q') {
    camera1();
  } else if (key=='Q') {
    //
  } else if (key=='w') {
    camera2();
  } else if (key=='W') {
    //
  } else if (key=='e') {
    camera3();
    //Proscene -
  } else if (key=='E') {
    //
  } else if (key=='r') {
    camera4();
    //Proscene - Show Camera Path
  } else if (key=='R') {
    //
  } else if (key=='t') {
    zoomedCamera();
  } else if (key=='T') {
    //
  } else if (key=='y') {
    camera6();
  } else if (key=='Y') {
    //
  } else if (key=='u') {
    closerCamera();
  } else if (key=='U') {
    //
  } else if (key=='i') {
    toptiltCamera();
  } else if (key=='I') {
    //
  } else if (key=='o') {
    camera9();
  } else if (key=='O') {
    //
  } else if (key=='p') {
    camera10();
  } else if (key=='P') {
    //
  } else if (key=='[') {
    initCamera();
  } else if (key==']') {
    scene.camera().interpolateToFitScene(); //if any screen frame translations ahve happened this will jump :-/ hmm. otherwise its a nice zoom to fit
  }

  //---------------------------SECOND ROW ASDFGHJKL--------------------------------------------

  if (key == 'a') {
    //Proscene - 3 Axis Markers
  } else if (key == 'A') {
    useAdditiveBlend = !useAdditiveBlend;
  } else if (key=='s') {
    useTrace = !useTrace;
    //Proscene - Fill Screen
  } else if (key=='S') {
    //Save Path to JSON
  } else if (key=='d') {
    traceAmount=190;
  } else if (key=='D') {
    //
  } else if (key=='f') {
    useFilters=!useFilters;
  } else if (key=='F') {
    //
  } else if (key=='g') {
    systemState= State.fadeup; //fade up all particles
    //Proscene - Grid Square
  } else if (key=='G') {
    //
  } else if (key=='h') {
    systemState= State.fadetoblack; //fadeout all particles from everything
  } else if (key=='H') {
    //
  } else if (key=='j') {
    //
  } else if (key=='J') {
    //
  } else if (key=='k') {
    //
  } else if (key=='k') {
    //
  } else if (key=='l') {
    //
  } else if (key=='L') {
    //
  }

  //---------------------------THIRD ROW ZXCVBNM--------------------------------------------

  if (key=='z') {
    //
  } else if (key=='Z') {
    //
  } else if (key=='x') {
    //
  } else if (key=='X') {
    //
  } else if (key=='c') {
    //oscRingDensity(Saturn);
    //oscRingRotationRate(Saturn);
  } else if (key=='C') {
    //
  } else if (key=='v') {
    saveFrame("./screenshots/ringmind_screen-###.jpg");
  } else if (key=='V') {
    //
  } else if (key=='b') {
    //
  } else if (key=='B') {
    //
  } else if (key=='n') {
    //
  } else if (key=='N') {
    //
  } else if (key=='m') {
    ////turn on this alogorithm to send tony the data
    //MoonAlignment = !MoonAlignment;
  } else if (key=='M') {
    //
  }
}

//-------------------------------
public void keyReleased() {
  //if you edit the camera pathways be sure to save them !!!!
  if (key=='S') {
    scene.saveConfig(); //outputs the camera path to a json file.
    println("camera pathways saved");
  }
}

//---------------------------- MOUSE -----------------------------------------------------------------------

public void mouseReleased() {
  //lets debug print all the camera stuff to help figure out what data we need for each scene
  println("****** camera debug info ******");
  println();
  println("camera orientation");
  Rotation r = scene.camera().frame().orientation();
  r.print();
  println();
  println("camera position");
  println(scene.camera().position());
  println();
  println("view direction");
  println(scene.camera().viewDirection());
  println();
}
