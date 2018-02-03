#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

out vec4 gfrontColor;

uniform mat4 projectionMatrix;

const float areamax = 0.0005;
const vec3 Yellow = vec3(1,1,0);
const vec3 Red = vec3(1,0,0);

void main( void )
{

	vec3 crossProduct = cross(gl_in[1].gl_Position.xyz - gl_in[0].gl_Position.xyz, gl_in[2].gl_Position.xyz - gl_in[0].gl_Position.xyz);
	float areParal = length(crossProduct);
	float areaTriangle = areParal / 2.0;
	float areaTriangleNorm = areaTriangle / areamax;

	vec3 colorGrad = mix(Red,Yellow, areaTriangleNorm);

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vec4(colorGrad, 1);
		gl_Position = projectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
}
