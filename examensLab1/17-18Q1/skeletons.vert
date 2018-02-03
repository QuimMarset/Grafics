#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;

uniform int tiles=3;
uniform float time;

void main()
{
    vec2 coordText = texCoord*tiles;
    int frame = int(time*30.0)%44;
    float offset =  (1.0/44)*frame;
    vtexCoord = vec2(coordText.s/44.0 + offset,coordText.t);
    gl_Position = vec4(vertex, 1.0);
}
