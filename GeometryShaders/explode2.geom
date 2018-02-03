#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 vNormal[];

out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;

uniform float time;
const float speed = 0.5;
const float angSpeed = 8.0; 

void main( void )
{

	vec3 promigNormals = (vNormal[0] + vNormal[1] + vNormal[2]) / 3.0;
	vec3 vectorTrans = promigNormals * speed * time;
	vec3 baricentre = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz) / 3.0;
	float angleRot = angSpeed * time;

	mat3 matRotacio = mat3(vec3(cos(angleRot), sin(angleRot), 0), vec3(-sin(angleRot), cos(angleRot), 0), vec3(0, 0, 1));

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		vec3 vertexMod = gl_in[i].gl_Position.xyz - baricentre;
		vertexMod = matRotacio * vertexMod;
		vertexMod = vertexMod + baricentre + vectorTrans;
		gl_Position = modelViewProjectionMatrix * vec4(vertexMod, 1);
		EmitVertex();
	}
    EndPrimitive();
}
