#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform vec2 resolution;
uniform sampler2D texture0;

#define r resolution
#define c gl_FragCoord.xy

float gray( vec3 _i )
{
  return (_i.x+_i.y+_i.z)/3.;
}

void main()
{
  vec2 uv = floor( c/6. ) * 6./r + vec2( 3. )/r;
  vec2 pos = mod( c, 6. );
  vec4 tex = texture( texture0, vec2( uv.x, 1.-uv.y ) );
  color = vec4( clamp( vec3( gray( tex.xyz )*3. - length( pos-vec2(3.) )*1. ), 0., 1. )*tex.xyz, 1. );
}
