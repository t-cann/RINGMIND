/**
 * ShearBoxSim
 * by Thomas Cann extends Chris Arridge work in python.
 *
 */
float time= 0;
final float G = 6.67408e-11; //Gravitational Constant
ShearingBox s;
void setup () {
  size (1000, 500);
  s = new ShearingBox();
    
} 

void draw () { //<>//
  push();
  translate(width/2, height/2);
  background (255);
  println("Simulation Time: "+ time);
  
  s.display();
  s.update();
  
  if (mousePressed) {
  //  orboids.add(new Orboid(mouseX,mouseY));
  } 
  
  time += 2*dt;
  
  pop();
  
  fill(0);
  rect(0,height-20,width,20);
  fill(255);
  text("Framerate: " + int(frameRate),10,height-6);
}
