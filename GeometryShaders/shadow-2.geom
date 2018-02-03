#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

//in int gl_PrimitiveIDIn;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;
uniform mat4 modelViewProjectionMatrix;

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix*gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();

    for (int i = 0;i < 3;++i) {
    	gfrontColor = vec4(0,0,0,1);
    	vec4 posicio = gl_in[i].gl_Position;
    	posicio.y = boundingBoxMin.y;
    	gl_Position = modelViewProjectionMatrix*posicio;
    	EmitVertex();
    }
    EndPrimitive();

    if (gl_PrimitiveIDIn == 0) {

    	float R = distance(boundingBoxMax,boundingBoxMin)/2.0;
    	vec3 C = (boundingBoxMax + boundingBoxMin)/2.0;

    	gfrontColor = vec4(0,1,1,1);
		gl_Position = modelViewProjectionMatrix*vec4(C.x-R,boundingBoxMin.y-0.01,C.z-R,1);
		EmitVertex();
		gfrontColor = vec4(0,1,1,1);
		gl_Position = modelViewProjectionMatrix*vec4(C.x+R,boundingBoxMin.y-0.01,C.z-R,1);
		EmitVertex();
		gfrontColor = vec4(0,1,1,1);
		gl_Position = modelViewProjectionMatrix*vec4(C.x-R,boundingBoxMin.y-0.01,C.z+R,1);
		EmitVertex();
    	EndPrimitive();

    	gfrontColor = vec4(0,1,1,1);
		gl_Position = modelViewProjectionMatrix*vec4(C.x-R,boundingBoxMin.y-0.01,C.z+R,1);
		EmitVertex();
		gfrontColor = vec4(0,1,1,1);
		gl_Position = modelViewProjectionMatrix*vec4(C.x+R,boundingBoxMin.y-0.01,C.z-R,1);
		EmitVertex();
		gfrontColor = vec4(0,1,1,1);
		gl_Position = modelViewProjectionMatrix*vec4(C.x+R,boundingBoxMin.y-0.01,C.z+R,1);
		EmitVertex();
    	EndPrimitive();
    }
}
