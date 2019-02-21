/**
 * ShearBoxSim
 * by Thomas Cann extends Chris Arridge work in python.
 *
 */
float time= 0;
ShearingBox s;
void setup () {
  size (1000, 500);
  s = new ShearingBox();
    
} 

void draw () { //<>//
  translate(width/2, height/2);
  background (255);
  println("Simulation Time: "+ time);
  
  s.display();
  s.update();
  
  if (mousePressed) {
  //  orboids.add(new Orboid(mouseX,mouseY));
  } 
  
  time += dt;
}
