#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;


uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;

uniform bool worldSpace = false;

out vec3 normalF;
out vec3 vertexF;

void main()
{
	if (worldSpace) {
		normalF = normal;
		vertexF = vertexF;
	}
	else {
		normalF = normalMatrix * normal;
		vertexF = vec3(modelViewMatrix * vec4(vertex,1));
	}
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
