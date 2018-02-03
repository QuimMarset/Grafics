#version 330 core

out vec4 fragColor;
in vec2 vtexCoord;
uniform sampler2D map;
uniform float time;
uniform float a = 0.5;
const float PI = 3.14159;

void main()
{
	vec4 colorText = texture(map,vtexCoord);
	float m = max(max(colorText.r,colorText.g),colorText.b);
	float angle = 2*PI*time;
	mat2 matriuRot = mat2(vec2(cos(angle),sin(angle)),vec2(-sin(angle),cos(angle)));
	vec2 uRotat = matriuRot*vec2(m,m);
	vec2 offset = uRotat * (a/100.0);
    fragColor = texture(map,vtexCoord + offset);
}
