#include "seleccioMouse.h"
#include "glwidget.h"



void SeleccioMouse::onPluginLoad() {

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("plugins/seleccioMouse/seleccioMouse.vert");

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceFile("plugins/seleccioMouse/seleccioMouse.frag");

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();
}

void encodeID(int index, GLubyte color[]) {

	color[0] = color[1] = color[2] = color[3] = index;
}

int decodeID(GLubyte color[]) {

	if (color[0] == 255) return -1;
	else return color[0];
}


void SeleccioMouse::mouseReleaseEvent(QMouseEvent *event) {

	GLWidget &g = *glwidget();
	g.makeCurrent();

	if (event->button() != Qt::LeftButton) return;
	if (event->modifiers() != Qt::ControlModifier) return;

	g.glClearColor(1,1,1,1);
	g.glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	program->bind();
	program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix());

	for (unsigned int i=0; i<scene()->objects().size(); ++i) {

		GLubyte color[4];
		encodeID(i,color);
		program->setUniformValue("color", QVector4D(color[0]/255.0, color[1]/255., color[2]/255., 1.0));
		drawPlugin()->drawObject(i);
	} 

	int x = event->x();
	int y = glwidget()->height() - event->y();
	GLubyte read[4];
	glReadPixels(x, y, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, read);

	int seleccionat = decodeID(read);
	scene()->setSelectedObject(seleccionat);

	program->release();

	g.update();

}
