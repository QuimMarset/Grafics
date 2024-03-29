#version 330 core

in vec3 gNormal;

out vec4 fragColor;

uniform mat3 normalMatrix;

void main()
{
	vec3 N = normalize(normalMatrix * gNormal);
    fragColor = vec4(N.z);
}
