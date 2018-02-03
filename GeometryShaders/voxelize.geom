#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

out vec4 gfrontColor;
out vec3 gNormal;

uniform float step = 0.2;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;



void emetVertex(vec3 posicio, vec3 N) {

	gl_Position = modelViewProjectionMatrix*vec4(posicio,1);
	gfrontColor = vec4(0.9,0.9,0.9,1);
	gNormal = N;
	EmitVertex();
}


void main( void )
{
	
	vec3 baricentre = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz)/3.0;
	baricentre = baricentre/step;
	baricentre = round(baricentre);		
	vec3 centreCub = baricentre*step;
	float meitat = step/2.0;

	vec3 N = normalMatrix*vec3(0,0,1);
	emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z + meitat),N);
	emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z + meitat),N);
	emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z + meitat),N);
	emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z + meitat),N);
    EndPrimitive();

    N = normalMatrix*vec3(0,0,-1);
    emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z - meitat),N);
	emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z - meitat),N);
	emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z - meitat),N);
	emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z - meitat),N);
    EndPrimitive();

    N = normalMatrix*vec3(-1,0,0);
    emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z - meitat),N);
	emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z + meitat),N);
	emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z - meitat),N);
	emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z + meitat),N);
    EndPrimitive();

    N = normalMatrix*vec3(1,0,0);
    emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z + meitat),N);
	emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z - meitat),N);
	emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z + meitat),N);
	emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z - meitat),N);
    EndPrimitive();

    N = normalMatrix*vec3(0,-1,0);
    emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z - meitat),N);
	emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z - meitat),N);
	emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z + meitat),N);
	emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z + meitat),N);
    EndPrimitive();

    N = normalMatrix*vec3(0,1,0);
    emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z - meitat),N);
	emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z - meitat),N);
	emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z + meitat),N);
	emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z + meitat),N);
    EndPrimitive();
}
