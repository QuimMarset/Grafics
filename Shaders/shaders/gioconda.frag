#version 330 core

out vec4 fragColor;
in vec2 vtexCoord;

uniform float time; 
uniform sampler2D sampler;

void main()
{
    vec2 centreUll = vec2(0.393,0.652);
    vec2 centreBoca = vec2(0.45,0.48);
    float radi = 0.025;
    vec2 offsetUllBoca = vec2(0.057, -0.172);

    if (fract(time) <= 0.5) {
    	fragColor = texture(sampler,vtexCoord);
    }
    else {
    	vec2 vectorCentreUllCoordText = vec2(vtexCoord.s - centreUll.s, vtexCoord.t - centreUll.t);
    	if (length(vectorCentreUllCoordText) <= 0.025) {
    		vec2 coordTextBoca = vtexCoord + offsetUllBoca;
    		fragColor = texture(sampler,coordTextBoca);
    	}
    	else
    		fragColor = texture(sampler,vtexCoord);
    }
}
