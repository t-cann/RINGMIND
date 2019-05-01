// new render class
// do not modify


class RenderContext {
  RenderContext() {
    mat = new Material();
  }
  PShader shader;
  Material mat;
  PApplet pgfx;
}

class Material {
  PImage diffTexture;
  PImage spriteTexture;
  float partWeight = 10;  //do not change or sprite texture wont show unles its 1
  color strokeColor = 255;
  float strokeWeight = 1;//0.3 //usually 1 so we can see our texture but if we turn off we can make a smaller particle point as liong as the weight above is bigger than 1
}

class RingSystemRenderer {
  boolean withMoon = true;

  int ringNumber = 1;
  void render(RingSystem rs, RenderContext ctx) {
    PGraphicsOpenGL pg = (PGraphicsOpenGL) ctx.pgfx.g;
    
    push();
    shader(ctx.shader, POINTS);

    //quick hack to show we can render each ring as and when
    ringNumber = min(ringNumber, rs.rings.size());
    for (int i = 0; i < ringNumber; i++) {
      Ring r = rs.rings.get(i);
      Material mat = r.material;
      if (mat == null) {
        mat = ctx.mat;
      }
      stroke(mat.strokeColor);
      strokeWeight(mat.strokeWeight);
      
      ctx.shader.set("weight", mat.partWeight);
      ctx.shader.set("sprite", mat.spriteTexture);
      ctx.shader.set("diffTex", mat.diffTexture);
      ctx.shader.set("view", pg.camera); //don't touch that :-)

      beginShape(POINTS);
      for (int ringI = 0; ringI < r.getMaxRenderedParticle(); ringI++) {
        RingParticle p = r.particles.get(ringI);
        
        PVector position1 = displayRotate(p);
        vertex(scale*position1.x, scale*position1.y, scale*position1.z);
      }
      endShape();
      
    }
    pop();

    if (withMoon) {
      ellipseMode(CENTER);
      push();
      for (Moon m : rs.moons) {
        pushMatrix();
        //translate(width/2, height/2);
        fill(m.c);
        stroke(m.c);
        translate(scale*m.position.x, scale*m.position.y, 2*m.radius*scale);
        sphere(1);
        //circle(scale*position.x, scale*position.y, 2*radius*scale);
        popMatrix();
      }
      pop();
    }
  }

PVector displayRotate(RingParticle p){
    PVector temp = p.position.copy();
    
    float angle = radians(p.inclination());
    float cosi = cos(angle);
    float sini = sin(angle);

    temp.y = cosi * p.position.y - sini * p.position.z;

    temp.z = cosi * p.position.z + sini * p.position.y;
    
    PVector temp1 = temp.copy();
    
    float cosa = cos(radians(p.rotation));
    float sina = sin(radians(p.rotation));
    
    temp.x = cosa * temp1.x - sina * temp1.y;

    temp.y = cosa * temp1.y + sina * temp1.x;
  

  return temp;
}
}
