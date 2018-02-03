#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 3) in vec2 texCoord;

out vec3 vertexEye;

uniform mat4 modelViewProjectionMatrix;
uniform float time;

void main()
{
	float angle = 0.1*time;
	mat3 matriuRot = mat3(vec3(cos(angle),0,-sin(angle)),vec3(0,1,0),vec3(sin(angle),0,cos(angle)));
	vec3 vertexRotat = matriuRot*vertex;
	vertexEye = vec3(modelViewProjectionMatrix*vec4(vertexRotat,1));
    gl_Position = modelViewProjectionMatrix * vec4(vertexRotat, 1.0);
}
