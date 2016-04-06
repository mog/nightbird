#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform float time;
uniform vec2 resolution;
uniform sampler2D texture0;

#define t time
#define r resolution
#define c gl_FragCoord.xy

float gray(vec3 _i)
{
    return (_i.x+_i.y+_i.z)/3.;
}

void main()
{
    vec2 uv = c/r;
    vec4 tex = texture( texture0, vec2( uv.x, 1.-uv.y ) );
    float g = gray( tex.xyz );
    float m = .95+.05*sin(uv.y*800.+t*30.);
    color = vec4( vec3( 0., 1., .3 )*(1.-gray( tex.xyz ))*m, 1. );
}
