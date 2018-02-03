#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 2) in vec3 color;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

out vec4 frontColor;

void main()
{
	frontColor = vec4(color,1);
	vec3 vertexMod = vertex * (boundingBoxMax - boundingBoxMin);
	vertexMod += boundingBoxMin;
    gl_Position = modelViewProjectionMatrix * vec4(vertexMod, 1.0);
}
