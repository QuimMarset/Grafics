#version 330 core

out vec4 fragColor;

in vec2 vtexCoord;

void main()
{
	vec2 centre = vec2(0.5,0.5);
	float radi = 0.2;
	vec2 vectorCentreCoordTex = vtexCoord - centre;
	float llargada = length(vectorCentreCoordTex);
	float valor = llargada <= radi ? 0:1;
    fragColor = vec4(1,valor,valor,1);
}
