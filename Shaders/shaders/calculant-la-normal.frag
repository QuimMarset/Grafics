#version 330 core


out vec4 fragColor;
in vec4 frontColor;
in vec3 vertexEye;

uniform vec4 lightDiffuse;


void main()
{

	vec3 dx = dFdx(vertexEye);
	vec3 dy = dFdy(vertexEye);
	vec3 normal = normalize(cross(dx,dy));
    fragColor = frontColor*normal.z;
}
