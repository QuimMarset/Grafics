#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform int mouseX;
uniform int mouseY;

void main()
{
	float d = distance(vec2(mouseX, mouseY), gl_FragCoord.xy - vec2(0.5));
	if (d > 100) {
		fragColor = frontColor;
	}
	else {
		fragColor = vec4(1.0) - frontColor;
	} 
}
