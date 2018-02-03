#include "drawBounding.h"
#include "glwidget.h"
#include <vector>


void DrawBounding::onPluginLoad() {

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("plugins/drawBounding/drawBounding.vert");

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceFile("plugins/drawBounding/drawBounding.frag");

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

	creaBuffers();
}

void DrawBounding::creaBuffers() {

	GLWidget &g = *glwidget();
	g.makeCurrent();

	vector <float> coords = {
		1,0,0, 0,0,0, 1,1,0, 1,1,0, 0,0,0, 0,1,0,
		0,0,1, 1,0,1, 0,1,1, 0,1,1, 1,0,1, 1,1,1,
		0,0,0, 0,0,1, 0,1,0, 0,1,0, 0,0,1, 0,1,1,
		1,0,1, 1,0,0, 1,1,1, 1,1,1, 1,0,0, 1,1,0,
		0,0,0, 1,0,0, 0,0,1, 0,0,1, 1,0,0, 1,0,1, 
		1,1,0, 0,1,0, 1,1,1, 1,1,1, 0,1,0, 0,1,1
	};
	numVertex = coords.size()/3;

	g.glGenVertexArrays(1, &VAO);
	g.glBindVertexArray(VAO);

	g.glGenBuffers(1, &VBOVertex);
	g.glBindBuffer(GL_ARRAY_BUFFER, VBOVertex);
	g.glBufferData(GL_ARRAY_BUFFER, sizeof(float)*coords.size(), &coords[0], GL_STATIC_DRAW);
	g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
	g.glEnableVertexAttribArray(0);

	vector <float> color = {
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0,
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0,
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0,
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0,
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0,
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0
	};
	g.glGenBuffers(1, &VBOColor);
	g.glBindBuffer(GL_ARRAY_BUFFER, VBOColor);
	g.glBufferData(GL_ARRAY_BUFFER, sizeof(float)*color.size(), &color[0], GL_STATIC_DRAW);
	g.glVertexAttribPointer(2, 3, GL_FLOAT, GL_FALSE, 0, 0);
	g.glEnableVertexAttribArray(2);

	g.glBindVertexArray(0);

}

void DrawBounding::postFrame() {

	GLWidget &g = *glwidget();

	program->bind();
	program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix());

	g.glBindVertexArray(VAO);
	g.glPolygonMode(GL_FRONT_AND_BACK, GL_LINE); 
	const vector <Object>& objectes = scene()->objects();
	for (int i = 0;i < (int)objectes.size();++i) {
		program->setUniformValue("boundingBoxMin", objectes[i].boundingBox().min());
		program->setUniformValue("boundingBoxMax", objectes[i].boundingBox().max());
		g.glDrawArrays(GL_TRIANGLES, 0, numVertex);
	}

	g.glBindVertexArray(0);
	program->release();
}