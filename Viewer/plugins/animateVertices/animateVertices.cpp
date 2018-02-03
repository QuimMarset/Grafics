#include "animateVertices.h"



void AnimateVertices::onPluginLoad() {

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("plugins/animateVertices/animateVertices.vert");

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceFile("plugins/animateVertices/animateVertices.frag");

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

	QTimer *timer = new QTimer(this);
	connect(timer, SIGNAL(timeout()), glwidget(), SLOT(update()));
	timer->start();
	elapsedTimer.start();
}

void AnimateVertices::preFrame() {

	program->bind();
	program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix());
	program->setUniformValue("normalMatrix", camera()->viewMatrix().normalMatrix());
	program->setUniformValue("time", float(elapsedTimer.elapsed()/1000.0f));

}


void AnimateVertices::postFrame() {

	program->release();
}