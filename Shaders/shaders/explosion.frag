#version 330 core

out vec4 fragColor;

in vec2 vTexCoord;

uniform float time;
uniform sampler2D explosion;

void main()
{
	int numFrame = int(time * 30.0) % 48;
	vec2 texCoord = vTexCoord * vec2(1/8.0, 1/6.0);
	texCoord.s += (numFrame % 8) * (1/8.0);
	texCoord.t += (5 - (numFrame/8)) * (1/6.0);
    fragColor = texture(explosion, texCoord);
    fragColor *= fragColor.a;
}
