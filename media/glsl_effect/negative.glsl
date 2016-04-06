#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform float time;
uniform vec2 resolution;
uniform sampler2D texture0;

#define r resolution
#define c gl_FragCoord.xy

void main()
{
  vec2 uv = c/r;
  vec3 col = texture( texture0, vec2( uv.x, 1.-uv.y ) ).xyz;
  color = vec4( vec3( 1. ) - col, 1. );
}
