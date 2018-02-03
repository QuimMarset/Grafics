#include "glwidget.h"
#include "inverter.h"
 

void Inverter::onPluginLoad() {

	QString vsCode =
		"#version 330 core\n"
		"layout (location = 0) in vec3 vertex;"
		"layout (location = 2) in vec3 color;"
		"out vec4 frontColor;"
		"uniform mat4 modelViewProjectionMatrix;"
		"void main()"
		"{"
		"	frontColor = vec4(color,1.0);"
		"	gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);"
		"}";

	QString fsCode =
		"#version 330 core\n"
		"in vec4 frontColor;"
		"out vec4 fragColor;"
		"uniform int mouseX;"
		"uniform int mouseY;"
		"void main()"
		"{"
		"	float d = distance(vec2(mouseX, mouseY), gl_FragCoord.xy - vec2(0.5));"
		"	if (d > 100) {"
		"		fragColor = frontColor;"
		"	}"
		"	else {"
		"		fragColor = vec4(1.0) - frontColor;"
		"	}"
		"}";


	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	//vs->compileSourceFile("plugins/inverter/inverter.vert");
	vs->compileSourceCode(vsCode);

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	//fs->compileSourceFile("plugins/inverter/inverter.frag");
	fs->compileSourceCode(fsCode);

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

	QTimer *timer = new QTimer(this);
	connect(timer, SIGNAL(timeout()), glwidget(), SLOT(update()));
	timer->start();
}

void Inverter::preFrame() {

	GLWidget &g = *glwidget();
	g.makeCurrent();

	int posMouseX = g.mapFromGlobal(QCursor::pos()).x();
	int posMouseY = g.height() - g.mapFromGlobal(QCursor::pos()).y();

	program->bind();
	program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix());
	program->setUniformValue("mouseX", posMouseX);
	program->setUniformValue("mouseY", posMouseY);


}

void Inverter::postFrame() {

	program->release();
}

