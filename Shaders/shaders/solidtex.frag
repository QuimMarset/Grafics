#version 330 core

out vec4 fragColor;
in vec3 vertexF;

uniform vec3 origin = vec3(1,0,0);
uniform vec3 axis = vec3(0,1,0);
uniform float slice = 0.1;

const vec4 cyan = vec4(0,1,1,1);
const vec4 blue = vec4(0,0,1,1);

void main()
{
	float d = length(cross(axis,origin - vertexF))/ length(axis);
	int multipleSlice = int(d/slice);
	if (multipleSlice%2 == 0) fragColor = cyan;
	else fragColor = blue;
}
