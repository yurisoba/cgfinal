#version 410 core

layout(location = 0) out vec4 fragColor;

flat in vec4 ovc;
flat in vec3 L;
in vec2 texcoord;

uniform sampler2D tex;

in vData
{
	vec3 N;
	vec3 H;
} vd;

uniform vec4 ka;
uniform vec4 kns;

uniform int feature;

void blinnphong()
{
    vec3 Kd = fragColor.xyz;
    vec3 N = normalize(vd.N);
    vec3 H = normalize(vd.H);

    vec3 Ia = vec3(0.1);
    vec3 Id = vec3(0.7);
    vec3 Is = vec3(0.2);

    vec3 ambient = ka.xyz * Ia;
    vec3 diffuse = max(dot(L, N), 0.0) * Kd * Id;
    vec3 specular = pow(max(dot(H, N), 0.0), kns.z) * kns.xyz * Is;

    fragColor = vec4(ambient + diffuse + specular, fragColor.a);
}

void main()
{
    vec4 texel = texture(tex, texcoord);
    if (texel.a < 0.3)
        discard;
    fragColor = vec4((texel.rgb * (1.0 - ovc.a)) + ovc.rgb, 1.0);

    if ((feature & (1 << 0)) != 0)
        blinnphong();
}
