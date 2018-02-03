#version 330 core

out vec4 fragColor;
in vec2 vtexCoord;
uniform sampler2D colorMap;
uniform float time;

void main()
{
	float coordT = vtexCoord.t;
	float coordS;
	float frac = fract(time);
	if (frac <= 0.5) {
		if (vtexCoord.s >= 0.5) coordS = vtexCoord.s;
		else coordS = 1 - vtexCoord.s;
	}
	else {
		if (vtexCoord.s <= 0.5) coordS = vtexCoord.s;
		else coordS = 1 - vtexCoord.s;
	}
    fragColor = texture(colorMap,vec2(coordS,coordT));
}
