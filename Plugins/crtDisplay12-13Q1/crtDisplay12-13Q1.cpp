#include "crtDisplay12-13Q1.h"
#include "glwidget.h"


void CrtDisplay::onPluginLoad() {

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("plugins/crtDisplay12-13Q1/crtDisplay.vert");

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs-> compileSourceFile("plugins/crtDisplay12-13Q1/crtDisplay.frag");

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

}

void CrtDisplay::preFrame() {

	program->bind();
	program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix());

}

void CrtDisplay::postFrame() {

	program->release();
}