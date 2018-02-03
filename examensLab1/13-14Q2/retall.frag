#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform float offset = 0;
uniform vec4 lightPosition;
uniform mat4 modelViewMatrixInverse;
in vec3 vertexF;

void main()
{
	vec3 normalPla = vec3(modelViewMatrixInverse*lightPosition);
	vec4 eqPla = vec4(normalPla,offset);
	float producte = dot(eqPla,vec4(vertexF,1));
	if (producte < 0) fragColor = frontColor;
	else discard;
}
