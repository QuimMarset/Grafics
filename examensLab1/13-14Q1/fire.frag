#version 330 core

out vec4 fragColor;

in vec2 vtexCoord;

uniform float time;
uniform sampler2D explosion;

void main()
{
	int frame = int(time*30)%48;
	vec2 coordText = vec2(vtexCoord.s/8.0,vtexCoord.t/6.0);
	vec2 offset = vec2(1.0/8.0*(frame%8),1.0/6.0*(5-frame/8));
    fragColor = texture(explosion,coordText+offset);
    fragColor *= fragColor.a;
}
