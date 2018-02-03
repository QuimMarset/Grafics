#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec4 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

out vec3 N;

void main()
{
    N = normalMatrix * normal;
    vtexCoord = projectionMatrix * modelViewMatrix * vec4(vertex,1);
    vtexCoord = vtexCoord * 0.5;
    vtexCoord = vtexCoord + vec4(0.5);
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
