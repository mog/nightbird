#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform float time;
uniform vec2 resolution;
uniform float param0;
uniform sampler2D texture0;
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform sampler2D texture3;

#define t time
#define r resolution
#define c gl_FragCoord.xy

void main()
{
  vec2 uv = c/r;
  float p = mod( param0, 4. );
  vec4 col = vec4( 0. );

  if( p < 1. )
  {
    col = texture( texture0, vec2( uv.x, 1.-uv.y ) );
  }
  else if( p < 2. )
  {
    col = texture( texture1, vec2( uv.x, 1.-uv.y ) );
  }
  else if( p < 3. )
  {
    col = texture( texture2, vec2( uv.x, 1.-uv.y ) );
  }
  else
  {
    col = texture( texture3, vec2( uv.x, 1.-uv.y ) );
  }

  color = col;
}
