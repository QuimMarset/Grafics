#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;


out vec4 frontColor;


uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrixInverse;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

uniform float n = 4;

void main()
{
    
    frontColor = vec4(normalize(normalMatrix * normal).z);
    
    vec3 lightPositionObj = vec3(modelViewMatrixInverse*lightPosition);
    float d = sqrt(pow(vertex.x - lightPositionObj.x,2) +
    	pow(vertex.y - lightPositionObj.y,2) + 
    	pow(vertex.z - lightPositionObj.z,2));

    float param1 = 1.0/pow(d,n);
    float w = clamp(param1,0,1);
    vec3 vertexN = (1- w)*vertex + w*lightPositionObj;
    gl_Position = modelViewProjectionMatrix * vec4(vertexN, 1.0);
}
