#version 330 core

layout (location = 0) in vec3 vertex; 
layout (location = 2) in vec3 normal;
layout (location = 2) in vec3 color; 

out vec4 vColor;
out vec3 vNormal; 

void main() {

	vNormal = normal;
 	vColor = vec4(color,1.0); 
 	gl_Position = vec4(vertex,1.0); 

}