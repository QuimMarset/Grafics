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
    vec3 normalNorm = normalize(normalF);
	vec3 L = normalize(lightPosition.xyz - vertexF);
	vec3 H = normalize(L + vec3(0.0,0.0,1.0));
    float escalarNL = max(0.0,dot(normalNorm,L));
    float escalarNH = max(0.0,dot(normalNorm,H));

    fragColor = (matAmbient*lightAmbient) + (matDiffuse*lightDiffuse*escalarNL);
	if (escalarNL > 0.0) fragColor += (matSpecular*lightSpecular*pow(escalarNH,matShininess));
}
