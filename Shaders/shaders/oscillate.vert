#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

uniform bool eyespace = true;
uniform float time;

void main()
{
    frontColor = vec4(color,1.0);
    float r = sqrt(pow(boundingBoxMax.x - boundingBoxMin.x,2) + pow(boundingBoxMax.y - boundingBoxMin.y,2) +
    	pow(boundingBoxMax.z - boundingBoxMin.z,2));
    r = r/2.0;
    float y = vertex.y;
    if (eyespace) y = vec3(modelViewMatrix*vec4(vertex,1.0)).y;
    float d = (r/10)*y;
    float distancia = d*sin(time);
    vec3 vertexMod = vertex + distancia*normal;
    gl_Position = modelViewProjectionMatrix * vec4(vertexMod, 1.0);
}
