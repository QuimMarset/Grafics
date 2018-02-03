#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D ex;

void main()
{
    fragColor = texture(ex,vtexCoord);
}
