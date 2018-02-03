#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec3 vNormal[];

uniform float d = 0.1;
uniform mat4 modelViewProjectionMatrix;

out vec3 gNormal;
out vec3 gPos;

void emetVertex(vec3 posicio, vec3 N) {

	gl_Position = modelViewProjectionMatrix * vec4(posicio,1);
	gPos = posicio;
	gNormal = N;
	EmitVertex();
}

vec3 calculaNormal(vec3 p1, vec3 p2, vec3 p3) {

	vec3 vectorTangent1 = p2 - p1;
	vec3 vectorTangent2 = p3 - p1;
	vec3 normal = cross(vectorTangent1, vectorTangent2);
	return normal;
}


void main( void )
{
	vec3 promigNorm = normalize(vNormal[0] + vNormal[1] + vNormal[2]);

	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 v1 = gl_in[1].gl_Position.xyz;
	vec3 v2 = gl_in[2].gl_Position.xyz;

	vec3 vDespl0 = v0 + d*promigNorm;
	vec3 vDespl1 = v1 + d*promigNorm;
	vec3 vDespl2 = v2 + d*promigNorm;

	vec3 normalCara;

	normalCara = promigNorm;
	emetVertex(vDespl0, normalCara);
	emetVertex(vDespl1, normalCara);
	emetVertex(vDespl2, normalCara);
	EndPrimitive();

	normalCara = calculaNormal(v0, v1, vDespl0);
	emetVertex(v0, normalCara);
	emetVertex(v1, normalCara);
	emetVertex(vDespl0, normalCara);
	emetVertex(vDespl1, normalCara);
	EndPrimitive();

	normalCara = calculaNormal(v1, v2, vDespl1);
	emetVertex(v1, normalCara);
	emetVertex(v2, normalCara);
	emetVertex(vDespl1, normalCara);
	emetVertex(vDespl2, normalCara);
	EndPrimitive();

	normalCara = calculaNormal(v2, v0, vDespl2);
	emetVertex(v2, normalCara);
	emetVertex(v0, normalCara);
	emetVertex(vDespl2, normalCara);
	emetVertex(vDespl0, normalCara);
	EndPrimitive();
}
