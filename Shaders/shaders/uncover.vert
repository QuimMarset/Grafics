#version 330 core

layout (location = 0) in vec3 vertex;


out float coordNDCX;

uniform mat4 modelViewProjectionMatrix;

void main()
{
	vec4 coordClipping = modelViewProjectionMatrix*vec4(vertex,1.0);
    coordNDCX = coordClipping.x/coordClipping.w + 1;
    gl_Position = coordClipping;
}
