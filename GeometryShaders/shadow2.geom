#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

void emetVertex(vec3 posicio, vec4 color) {

	gl_Position = modelViewProjectionMatrix * vec4(posicio, 1);
	gfrontColor = color;
	EmitVertex();
}

void main( void )
{

	if (gl_PrimitiveIDIn == 0) {

		vec3 centreCapsa = (boundingBoxMax + boundingBoxMin) / 2.0;
		float R = distance(boundingBoxMax, boundingBoxMin) / 2.0;

		vec3 centreAux = vec3(centreCapsa.x, boundingBoxMin.y - 0.01, centreCapsa.z);
		vec4 color = vec4(0,1,1,1);

		emetVertex(centreAux + vec3(-R, 0, R), color);
		emetVertex(centreAux + vec3(R, 0, R), color);
		emetVertex(centreAux + vec3(-R, 0, -R), color);
		EndPrimitive();

		emetVertex(centreAux + vec3(-R, 0, -R), color);
		emetVertex(centreAux + vec3(R, 0, R), color);
		emetVertex(centreAux + vec3(R, 0, -R), color);
		EndPrimitive();

	}

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vec4(0,0,0,1);
		vec4 posicio = gl_in[i].gl_Position;
		posicio.y = boundingBoxMin.y;
		gl_Position = modelViewProjectionMatrix * posicio;;
		EmitVertex();
	}
    EndPrimitive();
}
