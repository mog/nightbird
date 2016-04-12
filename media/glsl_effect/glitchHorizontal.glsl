#version 300 es
#ifdef GL_ES
precision mediump float;
#endif

out vec4 color;
uniform vec2 resolution;
uniform float time;
uniform sampler2D texture0;
uniform float param0;

#define t mod(time,60.)
#define r resolution
#define c gl_FragCoord.xy

float noise( float _i )
{
	return fract( sin( _i*3287.5456 + 92.44 )*32.45344 );
}

void main()
{
	vec2 uv = c/r;
	float my = c.y*5.+t*10.;
	float mo = noise( floor( ( my+( 2.+sin( my*.1 ) )*noise( t )*20. )*.07 + noise( floor( my*1.1 ) ) ) );
	float amp = param0 * ( 1.+40.*pow( uv.y, 120. ) );
	vec3 p = vec3(
		fract( uv.x+( .4*sin( mo*182.43+floor(t*3.)/3.*.1 ) )*amp ),
		fract( uv.x+( .4*sin( mo*182.43+floor(t*3.)/3.*.1+.4 ) )*amp ),
		fract( uv.x+( .4*sin( mo*182.43+floor(t*3.)/3.*.1+.8 ) )*amp )
	);

	vec3 col = vec3(
		texture( texture0, vec2( p.x, 1.-uv.y ) ).x,
		texture( texture0, vec2( p.y, 1.-uv.y ) ).y,
		texture( texture0, vec2( p.z, 1.-uv.y ) ).z
	);
	color = vec4( col, 1. );
}
