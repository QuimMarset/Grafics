#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;

uniform float time;

void main()
{
    frontColor = vec4(color,1.0);
    
    float angleRad = 0.4*vertex.y*sin(time);
    mat3 matRotacio = mat3(vec3(cos(angleRad),0,-sin(angleRad)),vec3(0,1,0),vec3(sin(angleRad),0,cos(angleRad)));
    vec3 vertexRotat = matRotacio*vertex;

    gl_Position = modelViewProjectionMatrix * vec4(vertexRotat, 1.0);
}
