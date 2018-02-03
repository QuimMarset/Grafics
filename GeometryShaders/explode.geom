#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec3 vNormal[];
in vec4 vfrontColor[];

out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;

uniform float time;
const float speed = 0.5;

void main( void )
{
	vec3 promigNormals = (vNormal[0] + vNormal[1] + vNormal[2]) / 3.0;
	vec3 vectorTrans = promigNormals * speed * time;
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * vec4(gl_in[i].gl_Position.xyz + vectorTrans, 1);
		EmitVertex();
	}
    EndPrimitive();
}
