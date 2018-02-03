#version 330 core


out vec4 fragColor;

in vec2 vtexCoord;

void main()
{

	float f = fract(vtexCoord.s);
	float a = 1.0/9;
	float texelS = f/a;
	if (mod(floor(texelS),2) == 0) fragColor = vec4(1,1,0,1);
	else fragColor = vec4(1,0,0,1);
}
