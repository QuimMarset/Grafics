#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform float time;

void main()
{
    frontColor = vec4(color,1.0);

    float angle = max(vertex.y - 0.5,0)*sin(time);
    mat3 matriuRot = mat3(vec3(1,0,0),vec3(0,cos(angle),sin(angle)),vec3(0,-sin(angle),cos(angle)));
    vec3 vertexRotat = matriuRot*(vertex + vec3(0,-1,0));
    vertexRotat = vertexRotat + vec3(0,1,0);
    gl_Position = modelViewProjectionMatrix * vec4(vertexRotat, 1.0);
}
