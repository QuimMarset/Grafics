#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;


out vec3 normalF;
out vec3 coordF;

uniform mat4 modelViewProjectionMatrix;

void main()
{
    normalF = normal;
    coordF = vertex;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
