#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform bool eyespace = true;
uniform float time;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

void main()
{
    frontColor = vec4(color,1.0);

    float r = distance(boundingBoxMax,boundingBoxMin)/2.0;
    float amplitud;
    if (eyespace) amplitud = (modelViewMatrix*vec4(vertex,1)).y;
    else amplitud = vertex.y;
    amplitud = (r/10)*amplitud;
    float d = amplitud*sin(time); //freq = 1/2*PI -> s'anul·la
    vec3 vertexDesplacat = vertex + d*normal;

    gl_Position = modelViewProjectionMatrix * vec4(vertexDesplacat, 1.0);
}
