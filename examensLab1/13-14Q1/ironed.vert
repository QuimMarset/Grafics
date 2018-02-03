#version 330 core

layout (location = 0) in vec3 vertex;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;

const float PI = 3.14159;
uniform float amplitude = 0.1;
uniform float time;

void main()
{
    frontColor = vec4(1,0,0,1);
    vec3 vertexMod = vertex;
    vertexMod.y = amplitude*sin(2*PI*vertexMod.x + 3*time);
    gl_Position = modelViewProjectionMatrix * vec4(vertexMod, 1.0);
}
