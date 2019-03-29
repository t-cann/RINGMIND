/**Class Renderer - renders frames for the simulation. 
 * @author Thomas Cann
 * buffer = new ArrayList<PGraphics>()
 * @version 1.0
 */
class Renderer {

  ArrayList<PGraphics> buffer;

  //Background Colour
  //Scale converts units --> pixels
  //Dimensions of Output Screen or Simulation Box?
  //Object Colours
  //Object sizes
  //

  Renderer() {
    buffer = new ArrayList<PGraphics>();

  }

  void render(RingSystem rs) {
    PGraphics currentFrame = createGraphics(width,height);
    currentFrame.beginDraw();
    currentFrame.clear();
    rs.render(currentFrame);
    //currentFrame.updatePixels();
    currentFrame.endDraw();

    buffer.add(currentFrame);
    while (buffer.size() >10) {
      if (buffer.size() >10) {
        buffer.remove(0);
      }
    }
  }
  
  //void output(){
  //buffer.add(recorder);
  //while(buffer.size() >10){
  //  if(buffer.size() >10){
  //buffer.remove(0);
  //  }
  //}
  //for(PGraphics i:buffer){
  //image(i,0,0);
  //}
  //}
}
