#version 330 core

in vec3 normalEye;
in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D window; 
uniform sampler2D interior1;  // observeu el digit 1 al final     
uniform sampler2D exterior2;  // observeu el digit 2 al final 

void main()
{
	vec3 N = normalize(normalEye);
    vec4 colorC = texture(window,vtexCoord);
    if (colorC.a == 1.0) fragColor = colorC;
    else if (colorC.a < 1.0) {
    	vec4 colorD = texture(interior1,vtexCoord + 0.5*N.xy);
    	if (colorD.a == 1.0) fragColor = colorD;
    	else fragColor = texture(exterior2,vtexCoord + 0.7*N.xy);
    }
}
