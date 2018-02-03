#version 330 core

uniform sampler2D glossy;
uniform int r = 40;

in vec3 normalEye;
in vec3 vertexEye;

out vec4 fragColor;

const float W = 512;
const float H = 512;

vec4 sampleTexture(sampler2D sampler, vec2 st, int r)
{
	vec4 colorAcum = vec4(0);
	for (int i = -r;i <= r;++i) {
		for (int j = -r;j <= r;++j) {
			vec2 texCoord = st + vec2(i / W, j / H);
			colorAcum += texture(sampler, texCoord);
		}
	}
	colorAcum = colorAcum * (1.0 / pow(2*r + 1,2));
	return colorAcum;
}

vec4 sampleSphereMap(sampler2D sampler, vec3 R)
{
	float z = sqrt((R.z+1.0)/2.0);
	vec2 st = vec2((R.x/(2.0*z)+1.0)/2.0, (R.y/(2.0*z)+1.0)/2.0);
    //st.y = -st.y;
    return sampleTexture(sampler, st, min(40,r));
}

void main()
{
	vec3 N = normalize(normalEye);
	vec3 V = normalize(-vertexEye);
	vec3 R = normalize(-reflect(V, N));
	fragColor = sampleSphereMap(glossy, R);
}
