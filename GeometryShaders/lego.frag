#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

in float textura;
in vec2 gtexCoord;
in vec3 gNormal;

uniform sampler2D lego;

const vec4 Red = vec4(1,0,0,1);
const vec4 Blue = vec4(0,0,1,1);
const vec4 Green = vec4(0,1,0,1);
const vec4 Cyan = vec4(0,1,1,1);
const vec4 Yellow = vec4(1,1,0,1);

void main()
{
	float distColorRed = distance(gfrontColor,Red);
	float distColorBlue = distance(gfrontColor,Blue);
	float distColorGreen = distance(gfrontColor,Green);
	float distColorCyan = distance(gfrontColor,Cyan);
	float distColorYellow = distance(gfrontColor,Yellow);

	vec4 color;

	if (distColorRed <= distColorBlue && distColorRed <= distColorGreen && distColorRed <= distColorCyan && distColorRed <= distColorYellow) 
		color = Red;
	else if (distColorBlue <= distColorRed && distColorBlue <= distColorGreen && distColorBlue <= distColorCyan && distColorBlue <= distColorYellow)
		color = Blue;
	else if (distColorGreen <= distColorRed && distColorGreen <= distColorBlue && distColorGreen <= distColorCyan && distColorGreen <= distColorYellow)
		color = Green;
	else if (distColorCyan <= distColorRed && distColorCyan <= distColorBlue && distColorCyan <= distColorGreen && distColorCyan <= distColorYellow)
		color = Cyan;
	else color = Yellow;

	vec3 N = normalize(gNormal);
	if (textura == 0) fragColor = color*N.z;
	else fragColor = texture(lego, gtexCoord)*color*N.z;
}
