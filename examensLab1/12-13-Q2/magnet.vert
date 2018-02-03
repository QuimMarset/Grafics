#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec4 frontColor;
out vec2 vtexCoord;

uniform float n = 8;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrixInverse;

uniform vec4 lightPosition; //sempre ve en eyeSpace

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    vec3 lightPositionObject = vec3(modelViewMatrixInverse*lightPosition);
    float d = distance(vertex,lightPositionObject.xyz);
    float w = clamp(1/pow(d,n),0,1);
    vec3 nouVertex = (1.0 - w)*vertex + lightPositionObject*w;
    frontColor = vec4(N.z);
    gl_Position = modelViewProjectionMatrix * vec4(nouVertex, 1.0);
}
