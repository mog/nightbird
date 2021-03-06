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

uniform float param1; //delta

#define t time
#define r resolution
#define c gl_FragCoord.xy

void main()
{
    vec2 uv = c/r;

    vec4 t0 = texture( texture0, vec2( uv.x, 1.-uv.y ) );
    vec4 t1 = texture( texture1, vec2( uv.x, 1.-uv.y ) );

    vec4 mask = texture( texture2, vec2( uv.x, 1.-uv.y ) );

    float delta = param1;//.4;

    if( ((mask.x >= col.x - delta) && (mask.x <= col.x + delta)) &&
        ((mask.y >= col.y - delta) && (mask.y <= col.y + delta)) &&
        ((mask.z >= col.z - delta) && (mask.z <= col.z + delta))){

        color = vec4(t1.x, t1.y, t1.z, mask.x);
    } else {
        color = vec4(t0.x, t0.y, t0.z, mask.x);
    }
}
