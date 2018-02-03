#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;

out vec3 normalEye;
out vec3 vertexEye;

void main()
{
	normalEye = normalMatrix * normal;
	vertexEye = vec3(modelViewMatrix * vec4(vertex,1));
	gl_Position = modelViewProjectionMatrix * vec4(vertex,1);
}
