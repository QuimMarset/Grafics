#version 330 core

out vec4 fragColor;

in vec2 vtexCoord;

uniform int nstripes = 19;
uniform vec2 origin = vec2(0.5,0.15);

void main()
{
	float longitudVector = length(vtexCoord - origin);
	int multipleNStripes = int(longitudVector*nstripes);
	if (multipleNStripes%2 == 0) fragColor = vec4(1,0,0,1);
    else fragColor = vec4(1,1,0,1);
}
