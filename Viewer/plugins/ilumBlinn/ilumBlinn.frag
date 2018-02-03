#version 330 core

in vec3 normalEye;
in vec3 vertexEye;
out vec4 fragColor;

uniform vec4 lightAmbient;
uniform vec4 lightSpecular;
uniform vec4 lightDiffuse;
uniform vec4 lightPosition;

uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

void main()
{
    vec3 N = normalize(normalEye);
    vec3 L = normalize(lightPosition.xyz - vertexEye);
    vec3 H = normalize(L + vec3(0,0,1));

    float NdotL = max(0.0, dot(N, L));
    float NdotH = max(0.0, dot(N, H));

    vec4 colorAmbient = matAmbient * lightAmbient;
    vec4 colorDiffuse = matDiffuse * lightDiffuse * NdotL;
    vec4 colorSpecular = vec4(0);
    if (NdotL > 0) colorSpecular = matSpecular * lightSpecular * pow(NdotH, matShininess);
    fragColor = colorAmbient + colorDiffuse + colorSpecular;
}
