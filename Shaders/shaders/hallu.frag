#version 330 core

out vec4 fragColor;

in vec2 vtexCoord;

uniform sampler2D map;
uniform float time;
uniform float a = 0.5;

const float PI = 3.14592;

void main()
{
	vec4 colorTextura = texture(map,vtexCoord);
	float m = max(colorTextura.r,max(colorTextura.g,colorTextura.b));
	float angleRotacioRad = 2*PI*time;
	mat2 matriuRotacio = mat2(vec2(cos(angleRotacioRad),sin(angleRotacioRad)),vec2(-sin(angleRotacioRad),cos(angleRotacioRad)));
	vec2 uRotat = matriuRotacio*vec2(m,m);
	vec2 offset = (a/100.0)*uRotat;
    fragColor = texture(map,vtexCoord+offset);
}
