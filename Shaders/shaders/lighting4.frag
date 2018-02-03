#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 normalF;
in vec3 vertexF;

uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;
uniform vec4 lightPosition;

uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

void main()
{
	vec3 N = normalize(normalF);
	vec3 L = normalize(lightPosition.xyz - vertexF);
	vec3 R = normalize(-reflect(L,N));
	vec3 V = normalize(-vertexF);
	float escalarNL = max(0.0,dot(N,L));
	float escalarRV = max(0.0,dot(R,V));
    fragColor = (lightAmbient*matAmbient) + (lightDiffuse*matDiffuse*escalarNL);
	if (escalarNL > 0.0) fragColor += (matSpecular*lightSpecular*pow(escalarRV,matShininess));
}
