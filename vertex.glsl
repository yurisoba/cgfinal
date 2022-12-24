#version 410 core

layout(location = 0) in vec3 iv3vertex;
layout(location = 1) in vec3 iv3tex_coord;
layout(location = 2) in vec3 iv3normal;

uniform mat4 p;
uniform mat4 v;
uniform mat4 m;
uniform vec4 ov_color;

out vec2 texcoord;
out vec3 normal;
flat out vec4 ovc;
flat out vec3 L;

out vData
{
	vec3 N;
	vec3 H;
} vd;

void main()
{
	gl_Position = p * v * m * vec4(iv3vertex, 1);

	vec4 P = v * m * vec4(iv3vertex, 1);
	vec3 V = -P.xyz;
	vec4 l = p * v * vec4(-2.845, 2.028, -1.293, 1);
	L = l.xyz;
	vd.N = mat3(v * m) * iv3normal;
	vd.H = normalize(L + V);
	L = normalize(L);

	texcoord = iv3tex_coord.xy;
	normal = iv3normal;
	ovc = ov_color;
}
