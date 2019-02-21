/**
 * ShearBoxSim
 * by Thomas Cann extends Chris Arridge work in python.
 *
 */
float time= 0;

void setup () {
  size (1000, 500);
  ShearingBox s = new ShearingBox();
    
} 

void draw () {
  translate(width/2, height/2);
  background (255);
  println("Simulation Time: "+ time);
  

  
  if (mousePressed) {
  //  orboids.add(new Orboid(mouseX,mouseY));
  } 
  time += dt;
}
