#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

in vec3 vNormal[];

uniform float time;
const float speed = 0.5;
const float angSpeed = 8.0; 

uniform mat4 modelViewProjectionMatrix;

void main( void )
{
	vec3 n = (vNormal[0] + vNormal[1] + vNormal[2])/3.0;

	mat3 matRot = mat3(vec3(cos(angSpeed*time),sin(angSpeed*time),0),vec3(-sin(angSpeed*time),cos(angSpeed*time),0),vec3(0,0,1));

	vec3 baricentre = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz)/3.0;

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		vec3 posicio = matRot*(gl_in[i].gl_Position.xyz - baricentre);
		posicio = posicio + baricentre + speed*time*n;
		gl_Position = modelViewProjectionMatrix*vec4(posicio,1);
		EmitVertex();
	}

    EndPrimitive();
}
