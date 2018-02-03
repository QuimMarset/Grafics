#version 330 core


out vec4 fragColor;

in vec2 vtexCoord;

uniform float n = 8;

void main()
{
	float valorRGB;
	float coordtexelS = fract(vtexCoord.s)*n;
	float coordtexelT = fract(vtexCoord.t)*n;
	if (fract(coordtexelS) > 0.1 && fract(coordtexelT) > 0.1) discard;
	else fragColor = vec4(1,0,0,1);

}
