#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float time;

void main()
{
	float angle = 0.4*vertex.y*sin(time);
	mat3 matriuRotY = mat3(vec3(cos(angle),0,-sin(angle)),vec3(0,1,0),vec3(sin(angle),0,cos(angle)));
	vec3 vertexRotat = matriuRotY*vertex;
    frontColor = vec4(color,1.0);
    gl_Position = modelViewProjectionMatrix * vec4(vertexRotat, 1.0);
}
