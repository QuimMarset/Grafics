#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float time;
uniform float speed;

void main()
{
	float angleRad = speed*time;
	mat3 matRotacio = mat3(vec3(cos(angleRad),0,-sin(angleRad)),vec3(0,1,0),vec3(sin(angleRad),0,cos(angleRad)));
	vec3 vertexMod = matRotacio*vertex;

    frontColor = vec4(color,1.0);
    gl_Position = modelViewProjectionMatrix * vec4(vertexMod, 1.0);
}
