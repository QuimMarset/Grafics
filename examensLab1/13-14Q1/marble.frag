#version 330 core

out vec4 fragColor;

in vec3 normalF;
in vec3 vertexF;

uniform sampler2D noise;

uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;

vec4 shading(vec3 N, vec3 Pos, vec4 diffuse) {
	vec3 lightPos = vec3(0.0,0.0,2.0);
	vec3 L = normalize( lightPos - Pos );
	vec3 V = normalize( -Pos);
	vec3 R = reflect(-L,N);
	float NdotL = max( 0.0, dot( N,L ) );
	float RdotV = max( 0.0, dot( R,V ) );
	float Ispec = pow( RdotV, 20.0 );
	return diffuse * NdotL + Ispec;
}


void main()
{
	vec4 white = vec4(1,1,1,1);
	vec4 redish = vec4(0.5,0.2,0.2,1);

	vec4 plaS = 0.3*vec4(0,1,-1,0);
	vec4 plaT = 0.3*vec4(-2,-1,1,0);
	vec2 coordText = vec2(dot(plaS,vec4(vertexF,1)),dot(plaT,vec4(vertexF,1)));

	float v = texture(noise,coordText).r; 
	vec4 colorDifos;
	if (v < 0.5) colorDifos = mix(white,redish,fract(2*v));
	else if (v < 1) colorDifos = mix(redish,white,fract(2*v));
	else colorDifos = white;

	vec3 vertexEye = vec3(modelViewMatrix*vec4(vertexF,1));
	vec3 normalEye = normalize(normalMatrix*normalF);
    fragColor = shading(normalEye,vertexEye,colorDifos);
}
