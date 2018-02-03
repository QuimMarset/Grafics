  #version 330 core

layout (location = 0) in vec3 vertex;

out vec4 frontColor;

uniform float ymin = -2;
uniform float ymax = 2;

uniform float xmin = -6;
uniform float xmax = 6;

void main()
{
 
    float valorX = (xmax - xmin)*(vertex.x +1)/2.0;
    valorX += xmin;
    float funcio;
    if (vertex.z == -2) funcio = sin(valorX);
    else if (vertex.z == 0) {
    	float exponent = (valorX*valorX)/6.0;
    	funcio = 2.0*exp(-exponent);
    }
    else funcio = sin(2.0*valorX);

    float valorY = 2.0*(funcio - ymin)/(ymax - ymin);
    valorY += -1;
    if (vertex.z == -2) frontColor = vec4(1,0,0,1);
    else if (vertex.z == 0) frontColor = vec4(0,1,0,1);
    else frontColor = vec4(0,0,1,1);

    gl_Position = vec4(vertex.x,vertex.y + valorY,0,1);
}
