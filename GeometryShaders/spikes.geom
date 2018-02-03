#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;

uniform float disp = 0.05;

void emetVertex(vec3 posicio, vec4 color) {

	gl_Position = modelViewProjectionMatrix * vec4(posicio, 1);
	gfrontColor = color;
	EmitVertex();
}

void main( void )
{

	vec3 baricentre = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz) / 3.0; 
	vec3 vectorTang1 = gl_in[1].gl_Position.xyz - gl_in[0].gl_Position.xyz;
	vec3 vectorTang2 = gl_in[2].gl_Position.xyz - gl_in[0].gl_Position.xyz;
	vec3 normalT = cross(vectorTang1, vectorTang2);
	normalT = normalize(normalT);

	baricentre = baricentre + normalT*disp;
	vec4 colorB = vec4(1,1,1,1);

	emetVertex(gl_in[0].gl_Position.xyz, vfrontColor[0]);
	emetVertex(gl_in[1].gl_Position.xyz, vfrontColor[1]);
	emetVertex(baricentre, colorB);
	EndPrimitive();

	emetVertex(gl_in[1].gl_Position.xyz, vfrontColor[1]);
	emetVertex(gl_in[2].gl_Position.xyz, vfrontColor[2]);
	emetVertex(baricentre, colorB);
	EndPrimitive();

	emetVertex(gl_in[2].gl_Position.xyz, vfrontColor[2]);
	emetVertex(gl_in[0].gl_Position.xyz, vfrontColor[0]);
	emetVertex(baricentre, colorB);
	EndPrimitive();
}
