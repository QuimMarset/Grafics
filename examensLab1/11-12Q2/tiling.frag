#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D sampler;

void main()
{
    fragColor = texture(sampler,vtexCoord);
}
