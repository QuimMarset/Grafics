#include "resaltaObjecte.h"
#include "glwidget.h"
#include <vector>
#include <iostream>



void ResaltaObjecte::onPluginLoad() {

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("plugins/resaltaObjecte/resaltaObjecte.vert");

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceFile("plugins/resaltaObjecte/resaltaObjecte.frag");

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

	creaBuffers();
}

void ResaltaObjecte::creaBuffers() {

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

	vector <float> colors = {
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0,
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0,
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0,
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0,
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0,
		0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0
	};
	numVertex = coords.size()/3;

	g.glGenVertexArrays(1, &VAO);
	g.glBindVertexArray(VAO);

	g.glGenBuffers(1, &VBOVertex);
	g.glBindBuffer(GL_ARRAY_BUFFER, VBOVertex);
	g.glBufferData(GL_ARRAY_BUFFER, sizeof(float)*coords.size(), &coords[0], GL_STATIC_DRAW);
	g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
	g.glEnableVertexAttribArray(0);

	g.glGenBuffers(1, &VBOColors);
	g.glBindBuffer(GL_ARRAY_BUFFER, VBOColors);
	g.glBufferData(GL_ARRAY_BUFFER, sizeof(float)*colors.size(), &colors[0], GL_STATIC_DRAW);
	g.glVertexAttribPointer(2, 3, GL_FLOAT, GL_FALSE, 0, 0);
	g.glEnableVertexAttribArray(2);

	g.glBindVertexArray(0);


}

void ResaltaObjecte::postFrame() {

	GLWidget &g = *glwidget();

	program->bind();

	int seleccionat = scene()->selectedObject();
	//std::cout << seleccionat << endl;
	if (seleccionat != -1) {

		Object &objecteSeleccionat = scene()->objects()[seleccionat];
		program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix());
		program->setUniformValue("boundingBoxMin", objecteSeleccionat.boundingBox().min());
		program->setUniformValue("boundingBoxMax", objecteSeleccionat.boundingBox().max());

		g.glBindVertexArray(VAO);
		g.glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
		g.glDrawArrays(GL_TRIANGLES, 0, numVertex);
		g.glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
		g.glBindVertexArray(0);
	}

	program->release();

}