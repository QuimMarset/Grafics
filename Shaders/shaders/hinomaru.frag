#version 330 core


out vec4 fragColor;

in vec2 vtexCoord;

void main()
{
    float radi = 0.2;
    vec2 vectorCentreCoordText = vec2(vtexCoord.s - 0.5,vtexCoord.t - 0.5);
    float valor = step(0.2,length(vectorCentreCoordText));
    fragColor = vec4(1,valor,valor,1);
}
