uniform mat4 projection;
uniform mat4 modelview;
uniform mat4 view;

attribute vec4 position;
attribute vec4 color;
attribute vec2 offset;

varying vec4 vertColor;
varying vec2 texCoord;
varying vec4 globalTexCoord;
uniform float weight;

void main() {
    vec4 pos = modelview * position;
    vec4 clip = projection * pos;

    vec4 vPos =   clip + projection * vec4(offset, 0, 0);
    gl_Position = vPos;

    vertColor = color;
    texCoord = (vec2(0.5) + offset / weight);
    globalTexCoord = projection*view*position;
}