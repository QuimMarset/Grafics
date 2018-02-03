#version 330 core

out vec4 fragColor;

uniform sampler2D colorMap; 
uniform float time;

in vec2 vtexCoord;

void main()
{
	vec2 centre = vec2(0.272,0.09);
	float radi = 0.065;
	vec2 dist = vec2(time,0);
	vec2 nouCentre = fract(centre + dist);
	float distCoordC = length(vtexCoord - centre);
	float distCoordNouC = length(vtexCoord - nouCentre);
	if (distCoordNouC < radi) fragColor = texture(colorMap,vtexCoord - dist);
	else if (distCoordC < radi) fragColor = texture(colorMap,vec2(vtexCoord.s + 0.5, vtexCoord.t));
	else fragColor = texture(colorMap,vtexCoord);
}
