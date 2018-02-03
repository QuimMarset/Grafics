#version 330 core


out vec4 fragColor;

in float coordNDCX; //ve sumada 1 per tal que vagin de 0 a 2

uniform float time;

void main()
{
	if (coordNDCX <= time) fragColor = vec4(0,0,1,1);
	else discard;
}
