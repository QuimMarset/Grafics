#version 330 core

out vec4 fragColor;
in vec3 vertexObject;

uniform sampler2D spheremap;
uniform mat4 modelViewMatrixInverse;

vec4 sampleSphereMap(sampler2D sampler, vec3 V)
{
	float z = sqrt((V.z+1.0)/2.0);
	vec2 st = vec2((V.x/(2.0*z)+1.0)/2.0, (V.y/(2.0*z)+1.0)/2.0);
	return texture2D(sampler, st);
}

void main()
{
	vec3 posObs = vec3(modelViewMatrixInverse*vec4(0,0,0,1));
	vec3 V = normalize(posObs - vertexObject);
    fragColor = sampleSphereMap(spheremap, V);
}
