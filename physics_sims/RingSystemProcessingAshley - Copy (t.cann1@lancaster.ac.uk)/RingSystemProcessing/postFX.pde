
// postfx
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

void setupFX(){
   fx = new PostFX(this); 
}

void runPostFX(){
  // add bloom filter
  fx.render()
    .sobel()
    .bloom(0.5, 20, 300)
    .compose();
}
