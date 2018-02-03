#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 normalF;
in vec3 vertexF;

uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;
uniform vec4 lightPosition;

uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

uniform mat4 viewMatrixInverse;

uniform bool world;

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
	vec3 N = normalF;
	vec3 V;
	vec3 L;
	if (world) {
		vec4 lightPositionWorld = viewMatrixInverse*lightPosition;
		L = lightPositionWorld.xyz - vertexF;
		V = vec3(viewMatrixInverse*vec4(0,0,0,1.0)) - vertexF; 
	}
	else {
		L = lightPosition.xyz - vertexF;
		V = -vertexF;
	}
    fragColor = light(N,V,L);
}
