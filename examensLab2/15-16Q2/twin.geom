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
		vec3 novaPos = gl_in[i].gl_Position.xyz;
		novaPos.x += 0.5;
		gl_Position = vec4(novaPos, 1);
		EmitVertex();
	}
    EndPrimitive();

    for (int i = 0;i < 3; ++i) {

    	gfrontColor = vfrontColor[i];
    	vec3 novaPos = gl_in[i].gl_Position.xyz;
		novaPos.x -= 0.5;
    	gl_Position = vec4(novaPos, 1);
    	EmitVertex();
    }
    EndPrimitive();
}
