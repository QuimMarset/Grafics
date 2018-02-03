#version 330 core

out vec4 fragColor;

in vec3 normalObj;
in vec3 vertexObj;

uniform bool rotate = true;
uniform float time;
uniform mat4 modelViewMatrixInverse;


// V, N, P, lightPos han d'estar al mateix espai de coordenades
// V és el vector unitari cap a l'observador
// N és la normal
// P és la posició 
// lightPos és la posició de la llum
// lightColor és el color de la llum
vec4 light(vec3 V, vec3 N, vec3 P, vec3 lightPos, vec3 lightColor)
{
	const float shininess = 100.0;
	const float Kd = 0.5;
	N = normalize(N);
	vec3 L = normalize(lightPos - P);
	vec3 R = reflect(-L, N);
	float NdotL = max(0.0, dot(N,L));
	float RdotV = max(0.0, dot(R,V));
	float spec =  pow( RdotV, shininess);
	return vec4(Kd*lightColor*NdotL + vec3(spec),0);
}


void main()
{

	vec3 posObs = vec3(modelViewMatrixInverse * vec4(0,0,0,1));
	vec3 V = normalize(posObs - vertexObj);

	vec3 posLlum1 = vec3(0,10,0);
	vec3 posLlum2 = vec3(0,-10,0);
	vec3 posLlum3 = vec3(10,0,0);
	vec3 posLlum4 = vec3(-10,0,0);

	vec3 colorLlum1 = vec3(0,1,0);
	vec3 colorLlum2 = vec3(1,1,0);
	vec3 colorLlum3 = vec3(0,0,1);
	vec3 colorLlum4 = vec3(1,0,0);

	if (rotate) {

		mat3 matriuRot = mat3(vec3(cos(time), sin(time), 0), vec3(-sin(time), cos(time), 0), vec3(0, 0, 1));
		posLlum1 = matriuRot * posLlum1;
		posLlum2 = matriuRot * posLlum2;
		posLlum3 = matriuRot * posLlum3;
		posLlum4 = matriuRot * posLlum4;	
	}

	posLlum1 = vec3(modelViewMatrixInverse * vec4(posLlum1,1));
	posLlum2 = vec3(modelViewMatrixInverse * vec4(posLlum2,1));
	posLlum3 = vec3(modelViewMatrixInverse * vec4(posLlum3,1));
	posLlum4 = vec3(modelViewMatrixInverse * vec4(posLlum4,1));		

    fragColor = light(V, normalObj, vertexObj, posLlum1, colorLlum1) + 
    	light(V, normalObj, vertexObj, posLlum2, colorLlum2) +
    	light(V, normalObj, vertexObj, posLlum3, colorLlum3) +
    	light(V, normalObj, vertexObj, posLlum4, colorLlum4);
}
