#version 330 core

out vec4 fragColor;
in vec2 vtexCoord;
in vec3 vertexEye;

uniform sampler2D sampler;

void main()
{
	vec3 dx = dFdx(vertexEye);
	vec3 dy = dFdy(vertexEye);
	vec3 normalEye = normalize(cross(dx,dy));
    fragColor = texture(sampler,normalEye.xy)*normalEye.z;
}
