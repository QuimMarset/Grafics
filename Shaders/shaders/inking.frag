#version 330 core


out vec4 fragColor;

in vec2 vtexCoord;

uniform int textureSize = 1024;
uniform int edgeSize = 2;
uniform float threshold = 0.2;

uniform sampler2D textura;


void main()
{
	vec2 left = vtexCoord + edgeSize * vec2(-1, 0) / textureSize;
	vec2 right = vtexCoord + edgeSize * vec2(1, 0) / textureSize;
	vec2 bottom = vtexCoord + edgeSize * vec2(0, -1) / textureSize;
	vec2 top = vtexCoord + edgeSize * vec2(0, 1) / textureSize;

	float Gx = length(texture(textura,left) - texture(textura,right));
	float Gy = length(texture(textura,top) - texture(textura,bottom));
	vec2 G = vec2(Gx,Gy);

	if (length(G) > threshold) fragColor = vec4(0,0,0,1);
	else fragColor = texture(textura,vtexCoord);

}
