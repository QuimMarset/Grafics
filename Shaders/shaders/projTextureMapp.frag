#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec4 vtexCoord;
in vec3 N;

uniform sampler2D sampler;

void main()
{
    fragColor = texture(sampler, vtexCoord.st/vtexCoord.q) * normalize(N).z;
}
