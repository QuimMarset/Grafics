#version 330 core


out vec4 fragColor;

in vec2 vtexCoord;

uniform float n = 8;

void main()
{

	float fracS = fract(vtexCoord.s);
	float fracT = fract(vtexCoord.t);
	float d = 1.0/n;
	int texelS = int(fracS/d);
	int texelT = int(fracT/d);
	float valorRGB;
	if (texelS%2 == texelT%2) valorRGB = 0.8;
	else valorRGB = 0;
    fragColor = vec4(valorRGB,valorRGB,valorRGB,1);

}
