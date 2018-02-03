#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D foot0;
uniform sampler2D foot1;
uniform sampler2D foot2;
uniform sampler2D foot3;

const float R = 80.0;

uniform int layer = 1;

uniform vec2 mousePosition;
uniform bool virtualMouse = false;
uniform float mouseX, mouseY; 

vec2 mouse()
{
	if (virtualMouse) return vec2(mouseX, mouseY);
	else return mousePosition;
}

void main()
{
	
	float dist = distance(gl_FragCoord.xy - vec2(0.5), mouse());

	vec4 colorC = texture(foot0, vtexCoord);

	if (dist >= R) {
		fragColor = colorC;
	}
	else {

		vec4 colorD;
		if (layer == 0) colorD = texture(foot0, vtexCoord);
		else if (layer == 1) colorD = texture(foot1, vtexCoord);
		else if (layer == 2) colorD = texture(foot2, vtexCoord);
		else colorD = texture(foot3, vtexCoord);

		fragColor = mix(colorD, colorC, dist/R);
	}



}
