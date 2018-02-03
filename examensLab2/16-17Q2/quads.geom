#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		vec4 posicio = gl_in[i].gl_Position;
		posicio.x -= 0.5;
		posicio.y -= 0.5;
		gl_Position = posicio;
		EmitVertex();
	}
    EndPrimitive();

    for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		vec4 posicio = gl_in[i].gl_Position;
		posicio.x += 0.5;
		posicio.y -= 0.5;
		gl_Position = posicio;
		EmitVertex();
	}
    EndPrimitive();

    for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		vec4 posicio = gl_in[i].gl_Position;
		posicio.x -= 0.5;
		posicio.y += 0.5;
		gl_Position = posicio;
		EmitVertex();
	}
    EndPrimitive();

    for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		vec4 posicio = gl_in[i].gl_Position;
		posicio.x += 0.5;
		posicio.y += 0.5;
		gl_Position = posicio;
		EmitVertex();
	}
    EndPrimitive();
}
