#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

void main()
{
	vec2 texCoord = fract(vtexCoord); //coord textura [0,1]
	int divHoritz = int(texCoord.s * 8.0);
	int divVert = int(texCoord.t * 8.0);
	if (divVert%2 != 0 && divHoritz%2 == 0 || divVert%2 == 0 && divHoritz%2 != 0) fragColor = vec4(0,0,0,1);
	else fragColor = vec4(0.8,0.8,0.8,1);
}
