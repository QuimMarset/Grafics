#version 330 core

in vec4 frontColor;
out vec4 fragColor;


uniform int n;

void main()
{
    fragColor = frontColor;
    float y = floor(gl_FragCoord.y);
    if (mod(y,n) != 0) discard;
}
