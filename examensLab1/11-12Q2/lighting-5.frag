#version 330 core

out vec4 fragColor;

uniform bool world = true;
uniform vec4 lightPosition;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrixInverse;

in vec3 vertexEye;
in vec3 normalEye;

uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;
uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;


vec4 light(vec3 N, vec3 V, vec3 L)
{
	N=normalize(N); V=normalize(V); L=normalize(L);
	vec3 R = normalize( 2.0*dot(N,L)*N-L );
	float NdotL = max( 0.0, dot( N,L ) );
	float RdotV = max( 0.0, dot( R,V ) );
	float Idiff = NdotL;
	float Ispec = 0;
	if (NdotL>0) Ispec=pow( RdotV, matShininess );
	return
	matAmbient * lightAmbient +
	matDiffuse * lightDiffuse * Idiff+
	matSpecular * lightSpecular * Ispec;
}
void main()
{
	vec3 vertex,normal,camera,llum;
	if (world) {
		vertex = vec3(modelViewMatrixInverse*vec4(vertexEye,1));
		normal = inverse(normalMatrix)*normalEye;
		camera = vec3(modelViewMatrixInverse*vec4(0,0,0,1));
		llum = vec3(modelViewMatrixInverse*lightPosition);
	}
	else {
		vertex = vertexEye;
		normal = normalEye;
		camera = vec3(0,0,0);
		llum = lightPosition.xyz;
	}
	vec3 V = camera - vertex;
	vec3 L = llum - vertex;
    fragColor = light(normal,V,L);
}
