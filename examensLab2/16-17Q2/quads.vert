#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec4 vfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    vfrontColor = vec4(N.z);
    vec4 vertexClip = modelViewProjectionMatrix * vec4(vertex,1);
    vec3 vertexNDC = vertexClip.xyz / vertexClip.w;
    gl_Position = vec4(vertexNDC, 1.0);
}
