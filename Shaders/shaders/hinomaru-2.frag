#version 330 core


out vec4 fragColor;

in vec2 vtexCoord;

uniform bool classic = false;

const float PI = 3.141592;

void main()
{
	vec2 vectorCentreCoordText = vec2(vtexCoord.s - 0.5,vtexCoord.t - 0.5);
	float llargada = length(vectorCentreCoordText);
	float valorStep = step(0.2,llargada);
	vec4 colorFrag = vec4(1,valorStep,valorStep,1);

	if (!classic) {
		float angleRad = atan(vectorCentreCoordText.s,vectorCentreCoordText.t);
		float anglePhi = PI/16;
		if (mod(angleRad/anglePhi + 0.5, 2) < 1) colorFrag = vec4(1,0,0,1);
	}

    fragColor = colorFrag;
}
