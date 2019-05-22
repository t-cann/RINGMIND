#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 resolution;

float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

void main( void ) {
	vec2 uv = gl_FragCoord.xy / resolution.xy;
    uv*=100;
    uv.x += time * 0.01;
    uv.y += time * 0.02;
	float nR = noise(uv+vec2(0.577));
    float nG = noise(uv+vec2(0.39));
	float nB = noise(uv+vec2(1.41));

	gl_FragColor = vec4(nR,nG,nB, 1.0);
}
