  /**<h1>RingSim</h1> extends Chris Arridge work in python.
   * Through the implementation of simple boid like rules, a ring system is created.
   *<ul><li>Rule 1 - Damps out radial motion to artificially simulate collisions</li>
   *<li>Rule 2 - Applies acceleration to particles so they only orbit at keplerian speed.</li>
   *<li>Rule 3 - Artificially creates ring gaps based on given clearing properties </li>
   *<li>Rule 4- Random gaussian noise to simulate collisions</li>
   *<li>Rule 5- Creates a Shepherd Moon that forms a ring gap through orbital resonance.</li></ul>
   * @author Thomas Cann
   * @author Sim Hinson
   * @version 1.0
   */
  
  int n_orboids = 10000;
  
  ArrayList<Orboid> orboids;   //ArrayList for all "things"
  ArrayList<Orboid>[] grid;  //Grid of ArrayLists for intersection test
  int scl = 5;           // Size of each grid cell
  int annuli;         // Total annuli
  
  float time = 0 ;
  float h_stepsize = 0.1;
  
  // A boolean to track whether we are recording are not
  boolean recording = false;
  
  /** Sets the application size [pixels].
   *  Intialises an arraylist called orboids.
   *  Intialises n_orboids number of orboid objects. 
   *  Adds all Orboid objects orboids arraylist.
   */
  void setup () {
    size (900, 900);
    orboids = new ArrayList<Orboid>(); //Create the list
    annuli = int(sqrt(pow(width/2,2) + pow(height/2,2)))/scl;
    println(annuli);
    
    // Initialize grid as 2D array of empty ArrayLists
    grid = new ArrayList[annuli];
    for (int i = 0; i < annuli; i++) {
       grid[i] = new ArrayList<Orboid>();
    }
  
    for (int i = 0; i < n_orboids; i++) {
      orboids.add(new Orboid());
    }
  } 
  
  /** 
   *  Sets background colour.
   *  Calls and runs update method.
   *  When mouse is clicked, an orboid is created at that position.
   *  Calls and runs record_update method.
   */
  void draw () {
  
    background(0);
    

    push();
    translate(width/2, height/2);
    // Every time through draw clear all the lists
    for (int i = 0; i < annuli; i++) {
        grid[i].clear();
      
    }
    
    // Register every Thing object in the grid according to it's position
    for (Orboid t : orboids) {
      int r = int(t.returnR()) / scl; 
           
      grid[r].add(t);
      // as well as its 8 neighbors 
      
      //for (int n = -1; n <= 1; n++) {
      //  for (int m = -1; m <= 1; m++) {
      //    if (x+n >= 0 && x+n < cols && y+m >= 0 && y+m< rows) grid[x+n][y+m].add(t);
      //  }
      //}
    }
  
    
    
    // Run through the Grid
    for (int i = 0; i <annuli; i++) {
      //line(i*scl,0,i*scl,height);
      
        //line(0,j*scl,width,j*scl);
        
        // For every list in the grid
        ArrayList<Orboid> temp = grid[annuli-i-1];
         //Check every Thing     
        if(temp.size() !=0){
        //print(temp.size()+ " ");
        fill(temp.size()*1/3,temp.size()*1/3,0);
        arc(0, 0, (annuli-i)*2*scl,(annuli-i)*2*scl, radians(0), radians(360));
        }     
    }
    
    
    
    for(Orboid x : orboids){
      x.update();
      x.display();
    }
    
    theta_moon += vtheta_moon*h_stepsize;
  
    stroke(255);
    line(0, 0, 400 * cos(theta_moon), 400*sin(theta_moon));
    noFill();
    circle(0, 0, 300);
    circle(0, 0, 600);
    pop();
  
    time+= h_stepsize;
    //println(time+ " ");
  
    if (mousePressed) {
      orboids.add(new Orboid(mouseX, mouseY));
    } 
  
    record_update();
    
    
    fill(0);
    rect(0,height-20,width,20);
    fill(255);
    text("Framerate: " + int(frameRate),10,height-6);
    

  }
  
  /**
   *  If 'r' key is pressed, start or stop recording.
   */
  void keyPressed() {
  
    if (key == 'r' || key == 'R') {
      recording = !recording;
    }
  }
  
  /**
   *  If recoding output frames and show recording with text and red circle.
   */
  void record_update() {
    push();
    // If we are recording call saveFrame!
    // The number signs (#) indicate to Processing to 
    // number the files automatically
    if (recording) {
      saveFrame("output/frames####.png");
    }
  
    // Let's draw some stuff to tell us what is happening
    // It's important to note that none of this will show up in the
    // rendered files b/c it is drawn *after* saveFrame()
    textAlign(CENTER);
    fill(255);
    if (!recording) {
      text("Press r to start recording.", width/2, height-24);
    } else {
      text("Press r to stop recording.", width/2, height-24);
    }
  
    // A red dot for when we are recording
    stroke(255);
    if (recording) {
      fill(255, 0, 0);
    } else { 
      noFill();
    }
    ellipse(width/2, height-48, 16, 16);
    pop();
  }
