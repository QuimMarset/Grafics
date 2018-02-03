#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

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
    vec3 N = normalize(normalMatrix * normal);
    vec3 vertexEye = vec3(modelViewMatrix * vec4(vertex,1.0));
    vec3 L = normalize(lightPosition.xyz - vertexEye);
    vec3 H = normalize(vec3(0.0,0.0,1.0) + L);
    float escalarNL = max(0.0,dot(N,L));
    float escalarNH = max(0.0,dot(N,H));
    frontColor = (matAmbient * lightAmbient) + 
	(matDiffuse * lightDiffuse * escalarNL);
	if (escalarNL > 0) frontColor += (matSpecular * lightSpecular * pow(escalarNH,matShininess));
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}

