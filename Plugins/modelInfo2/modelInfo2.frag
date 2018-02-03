#version 330 core

out vec4 fragColor;

uniform sampler2D infoSampler;
uniform float width;
uniform float height;

void main()
{
    vec2 texCoord = (gl_FragCoord.xy - vec2(0.5)) / vec2(width, height);
    fragColor = texture(infoSampler,texCoord);
    if (all(equal(fragColor.rgb,vec3(1.0)))) discard; //eliminar fragments que no es corresponen al text (color blanc)
}
