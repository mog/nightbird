#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform float time;
uniform vec2 resolution;
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
  vec4 tex = vec4( 0. );
  if( uv.x < .25 )
  {
    tex = texture( texture0, vec2( uv.x+.375, 1.-uv.y ) );
  }
  else if( uv.x < .5 )
  {
    tex = texture( texture1, vec2( uv.x+.125, 1.-uv.y ) );
  }
  else if( uv.x < .75 )
  {
    tex = texture( texture2, vec2( uv.x-.125, 1.-uv.y ) );
  }
  else
  {
    tex = texture( texture3, vec2( uv.x-.375, 1.-uv.y ) );
  }

  color = tex;
}
