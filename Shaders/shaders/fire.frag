#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

uniform float slice = 0.1;

uniform float time;

uniform sampler2D sampler0;
uniform sampler2D sampler1;
uniform sampler2D sampler2;
uniform sampler2D sampler3;

void main()
{

	int numText = int(mod(time/slice,4));
	if (numText == 0) fragColor = texture(sampler0,vtexCoord);
	else if (numText == 1) fragColor = texture(sampler1,vtexCoord);
	else if (numText == 2) fragColor = texture(sampler2,vtexCoord);
	else fragColor = texture(sampler3,vtexCoord);
    
}
