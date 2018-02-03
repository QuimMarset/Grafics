#version 330 core

in vec3 gNormal;
in vec3 gPos;

out vec4 fragColor;

uniform float d = 0.1;
uniform sampler2D grass_top;
uniform sampler2D grass_side1;

void main()
{
	vec2 texCoord;

	if (gNormal.z == 0) { //cara vertical
		texCoord = vec2(4*(gPos.x - gPos.y), 1.0 - gPos.z/d);
		fragColor = texture(grass_side1, texCoord);
		if (fragColor.a < 0.1) discard;
	}
	else {
		texCoord = 4*gPos.xy;
		fragColor = texture(grass_top, texCoord);
	}
}
