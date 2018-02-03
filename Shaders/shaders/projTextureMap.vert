#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec4 vtexCoord;
out vec3 normalEye;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
	normalEye = normalMatrix * normal;
    vtexCoord = modelViewProjectionMatrix * vec4(vertex,1);
    vtexCoord = vtexCoord * vec4(0.5);
    vtexCoord = vtexCoord + vec4(0.5);
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
