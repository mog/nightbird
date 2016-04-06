#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform vec2 resolution;
uniform sampler2D texture0;
uniform float param0;

#define r resolution
#define c gl_FragCoord.xy

void main()
{
  vec2 uv = c/r;
  float res = max( ceil( param0*10. ), 1. );
  vec2 p = mod( vec2( uv.x*res, 1.-uv.y*res ), 1. );
  vec3 col = texture( texture0, p ).xyz;
  color = vec4( col, 1. );
}
