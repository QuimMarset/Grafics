#version 330 core

out vec4 fragColor;
in vec4 frontColor;

void main()
{
    fragColor = frontColor;
}
