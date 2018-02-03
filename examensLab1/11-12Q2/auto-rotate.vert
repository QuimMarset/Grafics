#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;

uniform float speed;
uniform float time;

void main()
{
    frontColor = vec4(color,1.0);
    float angle = speed*time;
    mat3 matriuRot = mat3(vec3(cos(angle),0,-sin(angle)),vec3(0,1,0),vec3(sin(angle),0,cos(angle)));
    vec3 vertexRot = matriuRot*vertex;
    gl_Position = modelViewProjectionMatrix * vec4(vertexRot, 1.0);
}
