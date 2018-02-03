#version 330 core

out vec4 fragColor;

uniform sampler2D sampler;

in vec3 normalF;
in vec3 vertexF;

uniform bool wordlSpace = false;

uniform mat4 modelViewMatrixInverse;

vec4 sampleSphereMap(sampler2D sampler, vec3 R)
{
	float z = sqrt((R.z+1.0)/2.0);
	vec2 st = vec2((R.x/(2.0*z)+1.0)/2.0, (R.y/(2.0*z)+1.0)/2.0);
	//st.y = -st.y;
	return texture(sampler, st);
}


void main()
{
	vec3 N = normalize(normalF);
	vec3 posObs = vec3(0,0,0);
	vec3 vectorPObs;
	if (wordlSpace) {
		posObs = vec3(modelViewMatrixInverse * vec4(posObs,1));
		vectorPObs = normalize(posObs - vertexF);
	}
	else {
		vectorPObs = normalize(-vertexF);
	}
	vec3 R = normalize(-reflect(vectorPObs,N));
    fragColor = sampleSphereMap(sampler,R);
}
