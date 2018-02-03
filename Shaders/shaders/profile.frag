#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 coordEye;
in vec3 normalF;

uniform float epsilon = 0.1;
uniform float light = 0.5;

void main()
{
	vec4 colorGrocFosc = vec4(0.7,0.6,0,1);
	vec3 V = normalize(-coordEye);
	vec3 normalNorm = normalize(normalF);
	float dotProduct = dot(V,normalNorm);
	if (abs(dotProduct) < epsilon) fragColor = colorGrocFosc;
	else fragColor = frontColor*light*normalNorm.z;
}
