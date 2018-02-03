#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;


void emetVertex(vec3 posicio, vec4 color) {

	gl_Position = vec4(posicio, 1);
	gfrontColor = color;
	EmitVertex();
}

void main( void )
{

	if (gl_PrimitiveIDIn == 0) {

		float z = 0.999;

		emetVertex(vec3(-1, 0, z), vec4(0, 1, 0, 1));
		emetVertex(vec3(0, 0, z), vec4(0, 1, 0, 1));
		emetVertex(vec3(-1, 1, z), vec4(0, 1, 0, 1));
		emetVertex(vec3(0, 1, z), vec4(0, 1, 0, 1));
		EndPrimitive();

		emetVertex(vec3(0, 0, z), vec4(1, 1, 0, 1));
		emetVertex(vec3(1, 0, z), vec4(1, 1, 0, 1));
		emetVertex(vec3(0, 1, z), vec4(1, 1, 0, 1));
		emetVertex(vec3(1, 1, z), vec4(1, 1, 0, 1));
		EndPrimitive();

		emetVertex(vec3(-1, -1, z), vec4(1, 0, 0, 1));
		emetVertex(vec3(0, -1, z), vec4(1, 0, 0, 1));
		emetVertex(vec3(-1, 0, z), vec4(1, 0, 0, 1));
		emetVertex(vec3(0, 0, z), vec4(1, 0, 0, 1));
		EndPrimitive();

		emetVertex(vec3(0, -1, z), vec4(0, 0, 1, 1));
		emetVertex(vec3(1, -1, z), vec4(0, 0, 1, 1));
		emetVertex(vec3(0, 0, z), vec4(0, 0, 1, 1));
		emetVertex(vec3(1, 0, z), vec4(0, 0, 1, 1));
		EndPrimitive();


	}

	vec3 posicio;

	for( int i = 0 ; i < 3 ; i++ )
	{
		posicio = gl_in[i].gl_Position.xyz;
		posicio.x -= 0.5;
		posicio.y -= 0.5;
		emetVertex(posicio, vfrontColor[i]);
	}
    EndPrimitive();

    for( int i = 0 ; i < 3 ; i++ )
	{
		posicio = gl_in[i].gl_Position.xyz;
		posicio.x += 0.5;
		posicio.y -= 0.5;
		emetVertex(posicio, vfrontColor[i]);
	}
    EndPrimitive();

    for( int i = 0 ; i < 3 ; i++ )
	{
		posicio = gl_in[i].gl_Position.xyz;
		posicio.x -= 0.5;
		posicio.y += 0.5;
		emetVertex(posicio, vfrontColor[i]);
	}
    EndPrimitive();

    for( int i = 0 ; i < 3 ; i++ )
	{
		posicio = gl_in[i].gl_Position.xyz;
		posicio.x += 0.5;
		posicio.y += 0.5;
		emetVertex(posicio, vfrontColor[i]);
	}
    EndPrimitive();
}
