#version 330 core

out vec4 fragColor;

in vec4 vtexCoord;
in vec3 normalEye;

uniform sampler2D sampler;

void main()
{
    fragColor = texture(sampler, vtexCoord.st / vtexCoord.q) * normalize(normalEye).z;
}
