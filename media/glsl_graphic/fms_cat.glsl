#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform float time;
uniform vec2 resolution;

#define t time
#define r resolution
#define c (gl_FragCoord.xy)

void main()
{
	vec2 uv = (2.*c-r)/r.y;
	float p = length(floor(uv*12.+.5));
	color = vec4(
		.5+.5*sin(p-t*12.),
		.5+.5*sin(p-t*12.+2.),
		.5+.5*sin(p-t*12.+4.),
		1.
	);
}
