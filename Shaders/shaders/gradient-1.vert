#version 330 core

layout (location = 0) in vec3 vertex;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

const vec4 red = vec4(1,0,0,1);
const vec4 yellow = vec4(1,1,0,1);
const vec4 green = vec4(0,1,0,1);
const vec4 cyan = vec4(0,1,1,1);
const vec4 blue = vec4(0,0,1,1);


void main()
{
	float divisioY = 4 * (vertex.y - boundingBoxMin.y) / (boundingBoxMax.y - boundingBoxMin.y);
	if (divisioY < 1) frontColor = mix(red, yellow, fract(divisioY));
	else if (divisioY < 2) frontColor = mix(yellow, green, fract(divisioY));
	else if (divisioY < 3) frontColor = mix(green, cyan, fract(divisioY));
	else if (divisioY < 4) frontColor = mix(cyan, blue, fract(divisioY));
	else frontColor = blue;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
