#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vColor[];
in vec3 vNormal[];
out vec4 gColor;

uniform float time;
uniform mat4 modelViewProjectionMatrix;

void main( void )
{

	int grup = (17 * gl_PrimitiveIDIn + 19) % 10;
	
	float move = pow((time - grup) / 4.0, 2);
	if (move > 1.0) move = 1.0;

	vec3 vertex0 = gl_in[0].gl_Position.xyz + normalize(vNormal[0])*move;
	vec3 vertex1 = gl_in[1].gl_Position.xyz + normalize(vNormal[1])*move;
	vec3 vertex2 = gl_in[2].gl_Position.xyz + normalize(vNormal[2])*move;

	vec3 baricentre = (vertex0 + vertex1 + vertex2) / 3.0;

	vec3 vertex0Prima = mix(vertex0, baricentre, move);
	vec3 vertex1Prima = mix(vertex1, baricentre, move);
	vec3 vertex2Prima = mix(vertex2, baricentre, move);

	gl_Position = modelViewProjectionMatrix * vec4(vertex0Prima,1);
	gColor = vColor[0];
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(vertex1Prima,1);
	gColor = vColor[1];
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(vertex2Prima,1);
	gColor = vColor[2];
	EmitVertex();						

    EndPrimitive();
}
