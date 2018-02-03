#version 330 core

in vec2 gTexCoord;
out vec4 fragColor;

uniform sampler2D sampler;

void main()
{
    fragColor = texture(sampler, gTexCoord);
    if (fragColor.a != 1.0) discard;
}
