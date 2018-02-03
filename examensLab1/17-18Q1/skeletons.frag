#version 330 core

out vec4 fragColor;
in vec2 vtexCoord;
uniform sampler2D esquelet;

void main()
{
	vec4 color = texture(esquelet,vtexCoord);
	color = vec4(vec3(1,1,1) - color.xyz,color.a);
    fragColor = color;
}
