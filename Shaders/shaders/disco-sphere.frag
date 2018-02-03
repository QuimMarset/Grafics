#version 330 core

out vec4 fragColor;
in vec3 vertexEye;

uniform sampler2D sampler;

void main()
{
	vec3 dx = dFdx(vertexEye);
	vec3 dy = dFdy(vertexEye);
	vec3 normal = normalize(cross(dx,dy));
    fragColor = texture(sampler,normal.xy)*normal.z;
}
