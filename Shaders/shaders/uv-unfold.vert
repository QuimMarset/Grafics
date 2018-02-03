#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;

uniform vec2 Min = vec2(-1,-1);
uniform vec2 Max = vec2(1,1);

void main()
{
    frontColor = vec4(color,1.0);

    vec2 coordTexProject = vec2(-1,-1) + (vec2(2,2)*(texCoord - Min) / (Max - Min));
    gl_Position = vec4(coordTexProject, 0, 1.0);
}
