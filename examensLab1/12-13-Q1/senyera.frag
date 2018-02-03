#version 330 core

out vec4 fragColor;

in vec2 vtexCoord;

void main()
{
	float fractS = fract(vtexCoord.s);
	float alpha = 1/9.0;
	if (int(fractS/alpha)%2 == 0) fragColor = vec4(1,1,0,1); 
    else fragColor = vec4(1,0,0,1);
}
