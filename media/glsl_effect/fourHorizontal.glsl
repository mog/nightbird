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
  if( uv.y < .25 )
  {
    tex = texture( texture3, vec2( uv.x, 1.-uv.y-.375 ) );
  }
  else if( uv.y < .5 )
  {
    tex = texture( texture2, vec2( uv.x, 1.-uv.y-.125 ) );
  }
  else if( uv.y < .75 )
  {
    tex = texture( texture1, vec2( uv.x, 1.-uv.y+.125 ) );
  }
  else
  {
    tex = texture( texture0, vec2( uv.x, 1.-uv.y+.375 ) );
  }

  color = tex;
}
