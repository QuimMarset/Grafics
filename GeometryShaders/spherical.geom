#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

uniform float side = 0.1;
uniform mat4 projectionMatrix;

out vec2 gTexCoord;

void emetVertex(vec3 posicio, vec2 texCoord) {

	gTexCoord = texCoord;
	gl_Position = projectionMatrix * vec4(posicio,1);
	EmitVertex();
}

void main( void )
{
	vec3 centreQuad = gl_in[0].gl_Position.xyz;
	float meitat = side/2.0;

	emetVertex(centreQuad + vec3(-meitat, - meitat, 0), vec2(0,0));
	emetVertex(centreQuad + vec3(meitat, -meitat, 0), vec2(1,0));
	emetVertex(centreQuad + vec3(-meitat, meitat, 0), vec2(0,1));
	emetVertex(centreQuad + vec3(meitat, meitat, 0), vec2(1,1));
	EndPrimitive();
}
