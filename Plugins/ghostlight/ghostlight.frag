#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform int mouseX;
uniform int mouseY;

void main()
{
    fragColor = frontColor;
	float dist = distance(gl_FragCoord.xy - vec2(0.5), vec2(mouseX, mouseY));
	if (dist > 100) {
		fragColor.a = 0.025;
	}
	else {
		fragColor.a = 0.25;
	}

}
