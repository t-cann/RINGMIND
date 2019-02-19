// Flow Field Following

// Daniel Shiffman <http://www.shiffman.net>

// The Nature of Code, Spring 2009



// Via Reynolds: http://www.red3d.com/cwr/steer/FlowFollow.html



// Using this variable to decide whether to draw all the stuff



// Altered to change over time for Nature of Code 2011 Assignment

// by Antonius Wiriadjaja, http://antoni.us



boolean debug = false;



// keep count

float counter = 0;



PFont f;



// Flowfield object

FlowField flowfield;

// An ArrayList of boids

ArrayList boids;



void setup() {

  size(1080,1080);

  smooth();

  f = createFont("Georgia",12,true);

  // Make a new flow field with "resolution" of 16

  flowfield = new FlowField(16);

  boids = new ArrayList();

  // Make a whole bunch of boids with random maxspeed and maxforce values

  for (int i = 0; i < 120; i++) {

    boids.add(new Boid(new PVector(random(width),random(height)),random(2,5),random(0.1f,0.5f)));

  }

}



void draw() {

  background(255);

  // Display the flowfield in "debug" mode

  if (debug) flowfield.display();

  

  // changes the flowfield as counter goes up

//  flowfield.time(counter);

  counter+=0.01;



  // Tell all the boids to follow the flow field

  for (int i = 0; i < boids.size(); i++) {

    Boid b = (Boid) boids.get(i);

    b.follow(flowfield);

    b.run();

  }



  // Instructions

  textFont(f);

  fill(0);

  text("Hit space bar to toggle debugging lines.\nClick the mouse to generate a new path.",10,height-30);



}





 void keyPressed() {

  debug = !debug;

}



// Make a new flowfield

 void mousePressed() {

  flowfield.init();

}
