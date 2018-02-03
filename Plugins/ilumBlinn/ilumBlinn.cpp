#include "ilumBlinn.h"
#include "glwidget.h"



void IlumBlinn::onPluginLoad() {

	QString vsCode = 
		"#version 330 core\n \
		layout (location = 0) in vec3 vertex; \
		layout (location = 1) in vec3 normal; \
		out vec3 normalEye; \
		out vec3 vertexEye; \
		uniform mat4 modelViewProjectionMatrix; \
		uniform mat3 normalMatrix; \
		uniform mat4 modelViewMatrix; \
		void main() \
		{ \
		    normalEye = normalMatrix * normal; \
		    vertexEye = vec3(modelViewMatrix * vec4(vertex,1)); \
		    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0); \
		}";

	QString fsCode = 
		"#version 330 core\n \
		in vec3 normalEye; \
		in vec3 vertexEye; \
		out vec4 fragColor; \
		uniform vec4 lightAmbient; \
		uniform vec4 lightSpecular; \
		uniform vec4 lightDiffuse; \
		uniform vec4 lightPosition; \
		uniform vec4 matAmbient; \
		uniform vec4 matDiffuse; \
		uniform vec4 matSpecular; \
		uniform float matShininess; \
		void main() \
		{ \
		    vec3 N = normalize(normalEye); \
		    vec3 L = normalize(lightPosition.xyz - vertexEye); \
		    vec3 H = normalize(L + vec3(0,0,1)); \
		    float NdotL = max(0.0, dot(N, L)); \
		    float NdotH = max(0.0, dot(N, H)); \
		    vec4 colorAmbient = matAmbient * lightAmbient; \
		    vec4 colorDiffuse = matDiffuse * lightDiffuse * NdotL; \
		    vec4 colorSpecular = vec4(0); \
		    if (NdotL > 0) colorSpecular = matSpecular * lightSpecular * pow(NdotH, matShininess); \
		    fragColor = colorAmbient + colorDiffuse + colorSpecular; \
		}";

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceCode(vsCode);

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceCode(fsCode);

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();


	lightAmbient = Vector(0.1,0.1,0.1);
    lightDiffuse = Vector(1,1,1);
    lightSpecular = Vector(1,1,1);

    lightPosition = QVector4D(0,0,0,1);

    matAmbient = Vector(0.8, 0.8, 0.6);
    matDiffuse = Vector(0.8, 0.8, 0.6);
    matSpecular = Vector(1.0, 1.0, 1.0);
    matShininess = 64.0;

}

void IlumBlinn::preFrame() {

	program->bind();
	program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix());
	program->setUniformValue("modelViewMatrix", camera()->viewMatrix());
	program->setUniformValue("normalMatrix", camera()->viewMatrix().normalMatrix());
	program->setUniformValue("lightAmbient", QVector4D(lightAmbient,1));
	program->setUniformValue("lightDiffuse", QVector4D(lightDiffuse,1));
	program->setUniformValue("lightSpecular", QVector4D(lightSpecular,1));
	program->setUniformValue("lightPosition", lightPosition);
	program->setUniformValue("matAmbient", QVector4D(matAmbient,1));
	program->setUniformValue("matShininess", matShininess);
	program->setUniformValue("matSpecular", QVector4D(matSpecular,1));
	program->setUniformValue("matDiffuse", QVector4D(matDiffuse,1));

}

void IlumBlinn::postFrame() {

	program->release();
}