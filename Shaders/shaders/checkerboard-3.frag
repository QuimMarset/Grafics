#version 330 core

out vec4 fragColor;

in vec2 vtexCoord;
uniform float n = 8;

void main()
{
	vec2 texCoord = fract(vtexCoord);
	float divHoritz = texCoord.s * n;
	float divVert = texCoord.t * n;
	if (fract(divHoritz) <= 0.1 || fract(divVert) <= 0.1) fragColor = vec4(0,0,0,1);
	else fragColor = vec4(0.8,0.8,0.8,1);

}
