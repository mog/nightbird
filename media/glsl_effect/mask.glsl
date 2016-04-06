#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform float time;
uniform vec2 resolution;

uniform sampler2D texture0;
uniform sampler2D texture1;

uniform vec3 param0;  //color
uniform float param1; //delta


#define t time
#define r resolution
#define c gl_FragCoord.xy

void main()
{
  vec2 uv = c/r;

    vec4 t0 = texture( texture0, vec2( uv.x, 1.-uv.y ) );
    vec4 t1 = texture( texture1, vec2( uv.x, 1.-uv.y ) );

    vec3 col = param0;//vec4(0.0, 0.0, 0.0, 0.0);
    float delta = param1;//.4;

    if( ((t0.x >= col.x - delta) && (t0.x <= col.x + delta)) &&
        ((t0.y >= col.y - delta) && (t0.y <= col.y + delta)) &&
        ((t0.z >= col.z - delta) && (t0.z <= col.z + delta))){

        color = t1;
    } else {
        color = t0;
    }
}
