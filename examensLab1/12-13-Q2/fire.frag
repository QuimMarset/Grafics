#version 330 core

out vec4 fragColor;

in vec2 vtexCoord;

uniform float slice = 0.10;
uniform sampler2D sampler0; 
uniform sampler2D sampler1; 
uniform sampler2D sampler2; 
uniform sampler2D sampler3; 
uniform float time;

void main()
{
	int multipleSlice = int(time/slice)%4;
	if (multipleSlice == 0)  fragColor = texture(sampler0,vtexCoord);
	else if (multipleSlice == 1)  fragColor = texture(sampler1,vtexCoord);
	else if (multipleSlice == 2)  fragColor = texture(sampler2,vtexCoord);
	else  fragColor = texture(sampler3,vtexCoord);
}
