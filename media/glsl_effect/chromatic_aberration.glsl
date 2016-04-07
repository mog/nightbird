#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform vec2 resolution;
uniform sampler2D texture0;
uniform float param0;   // 0.04

#define PI 3.1415926

#define res resolution
#define col gl_FragCoord.xy

float gamma_to_linear(float value) {
	return pow(value, 2.2);
}

float linear_to_gamma(float value) {
	return pow(value, 1.0/2.2);
}

void main()
{
	vec4 tex_tmp;
	vec2 uv = col/res;
	vec2 uvtmp = vec2(0.0);
	tex_tmp = vec4(0.0);
	tex_tmp.a = 1.0;

	uvtmp = uv;
	uvtmp = uvtmp - vec2(0.5);
	uvtmp = uvtmp * vec2(1.00);
	uvtmp = uvtmp + vec2(0.5);
	tex_tmp.r += gamma_to_linear(texture( texture0, vec2(uvtmp.x, 1.0-uvtmp.y)).r) / 2.0;

	uvtmp = uv;
	uvtmp = uvtmp - vec2(0.5);
	uvtmp = uvtmp * vec2(1.00-(param0*(1.0/4.0)));
	uvtmp = uvtmp + vec2(0.5);
	tex_tmp.r += gamma_to_linear(texture( texture0, vec2(uvtmp.x, 1.0-uvtmp.y)).r) / 2.0;
	tex_tmp.g += gamma_to_linear(texture( texture0, vec2(uvtmp.x, 1.0-uvtmp.y)).g) / 3.0;

	uvtmp = uv;
	uvtmp = uvtmp - vec2(0.5);
	uvtmp = uvtmp * vec2(1.00-(param0/2.0));
	uvtmp = uvtmp + vec2(0.5);
	tex_tmp.g += gamma_to_linear(texture( texture0, vec2(uvtmp.x, 1.0-uvtmp.y)).g) / 3.0;

	uvtmp = uv;
	uvtmp = uvtmp - vec2(0.5);
	uvtmp = uvtmp * vec2(1.00-(param0*(3.0/4.0)));
	uvtmp = uvtmp + vec2(0.5);
	tex_tmp.g += gamma_to_linear(texture( texture0, vec2(uvtmp.x, 1.0-uvtmp.y)).g) / 3.0;
	tex_tmp.b += gamma_to_linear(texture( texture0, vec2(uvtmp.x, 1.0-uvtmp.y)).b) / 2.0;

	uvtmp = uv;
	uvtmp = uvtmp - vec2(0.5);
	uvtmp = uvtmp * vec2(1.0-param0);
	uvtmp = uvtmp + vec2(0.5);
	tex_tmp.b += gamma_to_linear(texture( texture0, vec2(uvtmp.x, 1.0-uvtmp.y)).b) / 2.0;

	color = vec4(linear_to_gamma(tex_tmp.r), linear_to_gamma(tex_tmp.g), linear_to_gamma(tex_tmp.b), 1.0);
}