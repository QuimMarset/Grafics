#version 330 core

layout (location = 0) in vec3 vertex;

out vec3 vertexEye;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform float time;

void main()
{
	float angle = 0.1*time;
	mat3 matriuRotacio = mat3(vec3(cos(angle),0,-sin(angle)),vec3(0,1,0),vec3(sin(angle),0,cos(angle)));
	vec3 vertexRotatY = matriuRotacio*vertex;
	vertexEye = vec3(modelViewMatrix*vec4(vertexRotatY,1));
    gl_Position = modelViewProjectionMatrix * vec4(vertexRotatY, 1.0);
}
