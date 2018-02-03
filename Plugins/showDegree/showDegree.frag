#version 330 core

out vec4 fragColor;
uniform float width;
uniform float height;

void main()
{
	vec2 texCoord = (gl_FragCoord.xy - vec2(0.5)) / vec2(width, height);
    fragColor = texture(colorMap, texCoord);
    if (all(equal(fragColor.rgb, vec3(1.0)))) discard;
}
