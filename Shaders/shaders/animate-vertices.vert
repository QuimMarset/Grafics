#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;


uniform float amplitude=0.1;
uniform float freq = 1;
uniform float time;
const float PI = 3.14159;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(N.z);
    float distT = amplitude*sin(2*PI*freq*time);
    vec3 vertexDespl = vertex + normal*distT;

    gl_Position = modelViewProjectionMatrix * vec4(vertexDespl, 1.0);
}
