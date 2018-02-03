#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;

uniform float speed = 0.5;
uniform float time;

const float PI = 3.141592;

void enviaTriangle () {

	for (int i = 0;i < 3;++i) {
		gl_Position = modelViewProjectionMatrix*gl_in[i].gl_Position;
		gfrontColor = vfrontColor[i];
		EmitVertex();
	}
	EndPrimitive();
}

void redueix(vec3 baricentre) {

	for (int i = 0;i < 3;++i) {
		float pes = abs(sin(2*PI*fract(time*speed)));
		vec3 novaPosicio = mix(gl_in[i].gl_Position.xyz,baricentre,pes);
		gl_Position = modelViewProjectionMatrix*vec4(novaPosicio,1);
		gfrontColor = vfrontColor[i];
		EmitVertex();
	}
	EndPrimitive();
}

void main( void )
{
	vec3 baricentre = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz)/3.0;
	int multiple = int(time*speed);
	if (multiple%2 == 0) {
		if (gl_PrimitiveIDIn%2 == 0) enviaTriangle();
		else redueix(baricentre);
	}
	else {
		if (gl_PrimitiveIDIn%2 != 0) enviaTriangle();
		else redueix(baricentre);
	}


}
