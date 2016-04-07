#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform float time;
uniform vec2 resolution;
uniform sampler2D texture0;
uniform sampler2D texture1;

#define t time
#define res resolution
#define c gl_FragCoord.xy


void main()
{
	vec2 uv = c / res;

    vec4 tex = texture( texture0, vec2( uv.x, 1.0 - uv.y ) );
    vec4 gradient = texture( texture1, vec2( uv.x, 1.0 - uv.y ) );

	float _r = 0.299 * pow(tex.r, 2.0);
	float _g = 0.587 * pow(tex.g, 2.0);
	float _b = 0.114 * pow(tex.b, 2.0);
    float luminance = sqrt( _r + _g + _b );

    color = texture(texture1, vec2(luminance, 0.0));
}