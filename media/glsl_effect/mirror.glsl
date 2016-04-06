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
  float p = mod( param0, 1. );
  if( p < .5 && .5 < uv.x ){ uv.x = 1.-uv.x; }
  if( .5 <= p && uv.x < .5 ){ uv.x = 1.-uv.x; }
  vec3 col = texture( texture0, vec2( uv.x, 1.-uv.y ) ).xyz;
  color = vec4( col, 1. );
}
