#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform float speed = 0.2;
uniform float time;
uniform mat4 modelViewProjectionMatrix;

const float PI = 3.141592;

void emetTriangle() {

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
	EndPrimitive();
}

void emetVertex(vec3 posicio, vec4 color) {
		
	gfrontColor = color;
	gl_Position = modelViewProjectionMatrix * vec4(posicio, 1);
	EmitVertex();

}

void emetTriangleReduit(vec3 baricentre) {

	float pes = abs(sin(2*PI*fract(speed*time)));

	for (int i = 0;i < 3; ++i) {
		gfrontColor = vfrontColor[i];
		vec3 novaPos = mix(gl_in[i].gl_Position.xyz, baricentre, pes);
		gl_Position = modelViewProjectionMatrix * vec4(novaPos, 1);
		EmitVertex();
	}
	EndPrimitive();
}

void main( void )
{
	vec3 baricentre = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz) / 3.0;

	int multiple = int(time*speed);
	if (multiple%2 == 0) {
		if (gl_PrimitiveIDIn%2 == 0) emetTriangle();
		else emetTriangleReduit(baricentre);
	}
	else {
		if (gl_PrimitiveIDIn%2 != 0) emetTriangle();
		else emetTriangleReduit(baricentre);
	}
}
