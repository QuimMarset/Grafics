#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;
uniform mat4 modelViewProjectionMatrix;


void emetVertex(vec4 posicio, vec4 color) {

	gl_Position = modelViewProjectionMatrix * posicio;
	gfrontColor = color;
	EmitVertex();
}

void main( void )
{

	if (gl_PrimitiveIDIn == 0) {

		float R = distance(boundingBoxMax, boundingBoxMin) / 2.0;
		vec3 centreCapsa = (boundingBoxMin + boundingBoxMax) / 2.0;
		vec4 centrePla = vec4(centreCapsa.x, boundingBoxMin.y - 0.01, centreCapsa.z, 1);
		vec4 colorPla = vec4(0,1,1,1);

		emetVertex(centrePla + vec4(-R, 0, R, 0), colorPla);
		emetVertex(centrePla + vec4(R, 0, R, 0), colorPla);
		emetVertex(centrePla + vec4(-R, 0, -R, 0), colorPla);
		EndPrimitive();

		emetVertex(centrePla + vec4(-R, 0, -R, 0), colorPla);
		emetVertex(centrePla + vec4(R, 0, R, 0), colorPla);
		emetVertex(centrePla + vec4(R ,0, -R, 0), colorPla);
		EndPrimitive();


	}

	for( int i = 0 ; i < 3 ; i++ ) {
		emetVertex(gl_in[i].gl_Position, vfrontColor[i]);
	}
    EndPrimitive();

    vec4 posicioProjec;
    for( int i = 0 ; i < 3 ; i++ )
	{
		posicioProjec = gl_in[i].gl_Position;
		posicioProjec.y = boundingBoxMin.y;
		emetVertex(posicioProjec, vec4(0,0,0,1));
	}
    EndPrimitive();
}
