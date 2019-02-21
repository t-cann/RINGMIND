/**
 * ShearBoxSim
 * by Thomas Cann extends Chris Arridge work in python.
 *
 */

void setup () {
  size (1000, 500);
  ShearingBox s = new ShearingBox(width, height);
  
} 

void draw () {
  translate(width/2, height/2);
  background (255); 
  

  
  if (mousePressed) {
  //  orboids.add(new Orboid(mouseX,mouseY));
  } 
}
