#version 330 core

out vec4 fragColor;

in vec3 P;
in vec3 N;

uniform sampler2D glossy;
uniform int r = 40;

const float W = 512;
const float H = 512;

vec4 sampleTexture(sampler2D sampler, vec2 st, int r)
{
	//vec4 colorTextura = texture2D(sampler, st);
	vec4 color = vec4(0,0,0,0);
	for (int i = -r;i <= r;++i) {
		for (int j = -r;j <= r;++j) {
			color += texture2D(sampler,st + vec2(i/W,j/H));
		}
	}
	float v = 1.0/pow(2*r + 1,2);
	return color*v;
}

vec4 sampleSphereMap(sampler2D sampler, vec3 R)
{
	float z = sqrt((R.z+1.0)/2.0);
	vec2 st = vec2((R.x/(2.0*z)+1.0)/2.0, (R.y/(2.0*z)+1.0)/2.0);
    st.y = -st.y;
	return sampleTexture(sampler, st, r);
}

void main()
{
	vec3 obs = vec3(0.0);
	vec3 I = normalize(P-obs);
	vec3 R = reflect(I, N);
	
	fragColor = sampleSphereMap(glossy, R);
}
