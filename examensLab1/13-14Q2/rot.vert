#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 3) in vec2 texCoord;

out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float d;
attribute vec3 attrTangent;
attribute vec3 attrBitangent;
uniform float time;

const float PI = 3.14159;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    vtexCoord = texCoord;

    float fase = time > 0 ? 2*PI*(texCoord.s + texCoord.t):0;
    float despl = d*sin(2*PI*0.1*time + fase);
    vec3 puntDespl = vec3(0,0,0);

    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
