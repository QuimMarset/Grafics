#version 330 core

out vec4 fragColor;

in vec2 vtexCoord;

uniform sampler2D colorMap;

void main()
{
	vec2 Q = (vtexCoord * 2.0) - 1;
	float r = length(Q);
	float rPrima = r + 0.22*pow(r,3) + 0.24*pow(r,5);
	vec2 QPrima = rPrima * normalize(Q);
	vec2 texCoord = (QPrima + 1) / 2.0;
	if (texCoord.s >= 0.0 && texCoord.s <= 1.0 && texCoord.t >= 0.0 && texCoord.t <= 1.0) {
		fragColor = texture(colorMap,texCoord);
	}
	else {
		fragColor = vec4(0,0,0,1);
	}
}
