#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec3 vertexF;
out vec3 normalF;

uniform mat4 modelViewProjectionMatrix;

void main()
{
	normalF = normal;
	vertexF = vertex;
    
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
