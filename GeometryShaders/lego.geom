#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];

out vec4 gfrontColor;
out float textura;
out vec2 gtexCoord;
out vec3 gNormal;

uniform float step = 0.5;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

vec3 centreCub;
vec4 color;


void emetVertex(vec3 posicio, vec3 N, bool superior, vec2 coordTex) {

	gl_Position = modelViewProjectionMatrix*vec4(posicio,1);
	gfrontColor = color;
	gtexCoord = coordTex;
	gNormal = N;
	textura = superior ? 1:0;
	EmitVertex();
}


void main( void )
{
	vec3 baricentre = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz)/3.0;
	baricentre = baricentre/step;
	baricentre = round(baricentre);
	centreCub = baricentre*step;
	float meitat = step/2.0;

	color = (vfrontColor[0] + vfrontColor[1] + vfrontColor[2])/3.0;

    vec3 N = normalMatrix*vec3(0,0,1);
    emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z + meitat),N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z + meitat),N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z + meitat),N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z + meitat),N, false, vec2(0,0));
    EndPrimitive();

    N = normalMatrix*vec3(0,0,-1);
    emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z - meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z - meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z - meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z - meitat), N, false, vec2(0,0));
    EndPrimitive();

    N = normalMatrix*vec3(-1,0,0);
    emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z - meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z + meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z - meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z + meitat), N, false, vec2(0,0));
    EndPrimitive();

    N = normalMatrix*vec3(1,0,0);
    emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z + meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z - meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z + meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z - meitat), N, false, vec2(0,0));
    EndPrimitive();

    N = normalMatrix*vec3(0,-1,0);
    emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z - meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z - meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x - meitat, centreCub.y - meitat, centreCub.z + meitat), N, false, vec2(0,0));
    emetVertex(vec3(centreCub.x + meitat, centreCub.y - meitat, centreCub.z + meitat), N, false, vec2(0,0));
    EndPrimitive();

    N = normalMatrix*vec3(0,1,0);
    emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z - meitat), N, true, vec2(0,0));
    emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z - meitat), N, true, vec2(1,0));
    emetVertex(vec3(centreCub.x + meitat, centreCub.y + meitat, centreCub.z + meitat), N, true, vec2(0,1));
    emetVertex(vec3(centreCub.x - meitat, centreCub.y + meitat, centreCub.z + meitat), N, true, vec2(1,1));
    EndPrimitive();
}
