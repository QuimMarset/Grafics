#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

void main()
{
   
	vec3 red = vec3(1,0,0);
	vec3 yellow = vec3(1,1,0);
	vec3 green = vec3(0,1,0);
	vec3 cyan = vec3(0,1,1);
	vec3 blue = vec3(0,0,1);
	vec3 colorGradient;

	vec4 vertexPersp = modelViewProjectionMatrix*vec4(vertex,1);
	vertexPersp = vertexPersp/vertexPersp.w;

	float posicio = (vertexPersp.y + 1.0)/2.0;
	posicio = posicio*4;
	if (posicio < 1) colorGradient = mix(red,yellow,fract(posicio));
	else if (posicio < 2) colorGradient = mix(yellow,green,fract(posicio));
	else if (posicio < 3) colorGradient = mix(green,cyan,fract(posicio));
	else if (posicio < 4) colorGradient = mix(cyan,blue,fract(posicio));
	else if (posicio == 4) colorGradient = blue;

    frontColor = vec4(colorGradient,1); 
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
