#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

out vec3 vertexF;
out vec3 normalF;

uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;

uniform bool world;

void main()
{
	if (world) {
		normalF = normal;
		vertexF = vertex;
	}
	else {
		normalF = inverse(transpose(mat3(viewMatrix))) * normal;
		vertexF = vec3(viewMatrix * vec4(vertex,1.0));
	}
    vtexCoord = texCoord;
    gl_Position = projectionMatrix*viewMatrix * vec4(vertex, 1.0);
}
