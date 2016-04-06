#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform vec2 resolution;
uniform sampler2D texture0;

#define DELTA .01

#define r resolution
#define c gl_FragCoord.xy

void main()
{
  vec2 uv = c/r;
  vec3 l = texture( texture0, vec2( uv.x-DELTA, 1.-uv.y ) ).xyz;
  vec3 r = texture( texture0, vec2( uv.x+DELTA, 1.-uv.y ) ).xyz;
  vec3 u = texture( texture0, vec2( uv.x, 1.-uv.y+DELTA ) ).xyz;
  vec3 d = texture( texture0, vec2( uv.x, 1.-uv.y-DELTA ) ).xyz;
  color = vec4( vec3( abs( l-r ) + abs( u-d ) ), 1. );
}
