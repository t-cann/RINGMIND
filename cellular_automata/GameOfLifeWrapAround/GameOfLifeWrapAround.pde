// A basic implementation of John Conway's Game of Life CA
// how could this be improved to use object oriented programming?
// think of it as similar to our particle system, with a "cell" class
// to describe each individual cell and a "cellular automata" class
// to describe a collection of cells

// Cells wrap around

GOL gol;

void setup() {
  size(500, 500);
  gol = new GOL();
}

void draw() {
  background(255);

  gol.generate();
  gol.display();
  
  push();
  fill(0);
  rect(0,height-20,width,20);
  fill(255);
  text("Framerate: " + int(frameRate),10,height-6);
  pop();
}

// reset board when mouse is pressed
void mousePressed() {
  gol.init();
}
