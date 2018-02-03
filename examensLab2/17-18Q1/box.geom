#version 330 core
        
layout(triangles) in;
layout(line_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

void emetVertexCaixa(vec3 posicio) {

	gl_Position = modelViewProjectionMatrix * vec4(posicio, 1);
	gfrontColor = vec4(0,0,0,1);
	EmitVertex();
}

void main( void )
{

	if (gl_PrimitiveIDIn == 0) {

		vec4 color = vec4(0,0,0,1);

		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMin.y, boundingBoxMax.z));
		emetVertexCaixa(vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMax.z));
		emetVertexCaixa(vec3(boundingBoxMax.x, boundingBoxMax.y, boundingBoxMax.z));
		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMax.z));
		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMin.y, boundingBoxMax.z));
		EndPrimitive();

		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMin.y, boundingBoxMin.z));
		emetVertexCaixa(vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMin.z));
		emetVertexCaixa(vec3(boundingBoxMax.x, boundingBoxMax.y, boundingBoxMin.z));
		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMin.z));
		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMin.y, boundingBoxMin.z));
		EndPrimitive();

		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMax.z));
		emetVertexCaixa(vec3(boundingBoxMax.x, boundingBoxMax.y, boundingBoxMax.z));
		emetVertexCaixa(vec3(boundingBoxMax.x, boundingBoxMax.y, boundingBoxMin.z));
		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMin.z));
		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMax.z));
		EndPrimitive();

		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMin.y, boundingBoxMax.z));
		emetVertexCaixa(vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMax.z));
		emetVertexCaixa(vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMin.z));
		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMin.y, boundingBoxMin.z));
		emetVertexCaixa(vec3(boundingBoxMin.x, boundingBoxMin.y, boundingBoxMax.z));
		EndPrimitive();

	}

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
}
