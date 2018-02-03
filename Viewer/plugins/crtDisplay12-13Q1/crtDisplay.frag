#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform int n = 6;

void main()
{

	int linia = int(gl_FragCoord.y);
	if (linia%n != 0) discard;
    fragColor = frontColor;
}
