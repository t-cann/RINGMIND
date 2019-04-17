//--------- center planet texture

void initSaturn() {
  saturnTex = loadImage("plutomap1k.jpg");
  sphereDetail(60);
  planet = createShape(SPHERE, 60);
  planet.setTexture(saturnTex);
  //refactor this properly to make a shape with all the correct settings.
  planet.setStroke(255);  
}

void drawSaturn() {
  //yackky matrix move this so its only once in creation
  noStroke();
  noFill();
  push();
  rotateX(radians(-90));
  shape(planet);
  pop();
}



void lighting(){
  //illumonate saturn
  pointLight(255, 255, 255, 500, 250, 900);
  //backlight just for ref
 // pointLight(255,  255,  255,  0,  0,  -150); 
}
