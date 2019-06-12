#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
uniform sampler2D sprite;
uniform sampler2D diffTex;

varying vec2 texCoord;
varying vec4 globalTexCoord;

varying vec4 vertColor;

void main() {
  vec2 proj_uv = (globalTexCoord.xy / globalTexCoord.w) * vec2(0.5) + vec2(0.5);
    //the below remoives the texture to get rid of the black circle but the fade no longer works
   
 // gl_FragColor.rgb = texture2D(diffTex, proj_uv).rgb * vertColor.rgb;
 // gl_FragColor.a = 1;
    
    gl_FragColor = texture2D(sprite, texCoord)*texture2D(diffTex, proj_uv) * vertColor;

}
