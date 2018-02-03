#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec3 vertexObj;
out vec3 normalObj;

uniform mat4 modelViewProjectionMatrix;

void main()
{
	vertexObj = vertex;
	normalObj = normal;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
