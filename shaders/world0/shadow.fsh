#version 120

/*
BSL Shaders by Capt Tatsu
https://www.bitslablab.com
*/

#include "/global.glsl"

varying float mat;
varying vec2 texcoord;
varying vec4 color;

uniform int blockEntityId;

uniform sampler2D tex;

void main(){
	#if MC_VERSION >= 11300
	if (blockEntityId == 138) discard;
	if (mat == 2) discard;
	#endif

	vec4 albedo = texture2D(tex,texcoord.xy);
	albedo.rgb *= color.rgb * color.a;

	float premult = float(mat > 0.98 && mat < 1.02);
	float disable = float(mat > 1.98 && mat < 3.02);
	
	#ifdef ShadowColor
	//if ((checkalpha > 0.9 && albedo.a > 0.98) || checkalpha < 0.9) albedo.rgb *= 0.0;
	albedo.rgb = mix(vec3(1.0),albedo.rgb,pow(albedo.a,(1.0-albedo.a)*0.5)*1.05);
	albedo.rgb *= 1.0-pow(albedo.a,64.0);
	#else
	if ((premult > 0.5 && albedo.a < 0.98)) albedo.a *= 0.0;
	#endif
	if (disable > 0.5) albedo.a *= 0.0;
	
	gl_FragData[0] = albedo;
	
}