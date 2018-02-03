#include "modelInfo2.h"
#include "glwidget.h"
#include <vector>
#include <QPainter>

void ModelInfo2::onPluginLoad() {

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("plugins/modelInfo2/modelInfo2.vert");

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceFile("plugins/modelInfo2/modelInfo2.frag");

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

	GLWidget &g = *glwidget();
	g.makeCurrent();

	calculaInfo();

	creat = false;

}

void ModelInfo2::calculaInfo() {

	const vector <Object>& objectes = scene()->objects();
	numVertex = 0;
	numPoligons = 0;
	percentatgeTriangles = 0;
	numObjectes = objectes.size();

	for (int i = 0;i < (int)objectes.size(); ++i) {
		numVertex += objectes[i].vertices().size();
		const vector <Face>& cares = objectes[i].faces();
		numPoligons += cares.size();
		for (int j = 0;j < (int)cares.size();++j) {
			if (cares[j].numVertices() == 3) ++percentatgeTriangles;
		}
	}
}


void ModelInfo2::onObjectAdd() {

	numObjectes = scene()->objects().size();
	Object& ultimAfegit = scene()->objects()[numObjectes-1];
	numVertex += ultimAfegit.vertices().size();
	const vector <Face>& cares = ultimAfegit.faces();
	numPoligons += cares.size();
	for (int i = 0;i < (int)cares.size();++i) {
		if (cares[i].numVertices() == 3) ++percentatgeTriangles;
	}
}


void ModelInfo2::drawRect() {

	GLWidget &g = *glwidget();

	if (!creat) {

		creat = true;

		float z = -0.99999;
		vector <float> coords = {
			-1,-1,z, 1,-1,z, -1,1,z, 1,1,z
		};

		g.glGenVertexArrays(1, &VAO);
		g.glBindVertexArray(VAO);
		g.glGenBuffers(1, &VBOVertex);
		g.glBindBuffer(GL_ARRAY_BUFFER, VBOVertex);
		g.glBufferData(GL_ARRAY_BUFFER, sizeof(float)*coords.size(), &coords[0], GL_STATIC_DRAW);
		g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
		g.glEnableVertexAttribArray(0);
		g.glBindVertexArray(0);
	}

	g.glBindVertexArray(VAO);
	g.glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	g.glBindVertexArray(0);
}

void ModelInfo2::postFrame() {

	GLWidget &g = *glwidget();
	g.makeCurrent();

	const int SIZE = 1024;
    // 1. Create image with text
    QImage image(SIZE,SIZE,QImage::Format_RGB32);
    image.fill(Qt::white);    
    QPainter painter;
    painter.begin(&image);
    QFont font;
    font.setPixelSize(30);
    painter.setFont(font);
    painter.setPen(QColor(50,50,50));
    int x = 15;
   	int y = 900;
    painter.drawText(x, y, QString("Número de vèrtex: ") += QString::number(numVertex));
    painter.drawText(x, y+30, QString("Número d'objectes: ") += QString::number(numObjectes));  
    painter.drawText(x, y+60, QString("Número de polígons: ") += QString::number(numPoligons));  
    painter.drawText(x, y+90, QString("Percentatge de triangles (%): ") += QString::number(100*percentatgeTriangles/numPoligons));   
    painter.end();

    // 2. Create texture
    const int textureUnit = 5;
    g.glActiveTexture(GL_TEXTURE0+textureUnit);
    QImage im0 = image.mirrored(false, true).convertToFormat(QImage::Format_RGBA8888, Qt::ColorOnly);
	g.glGenTextures( 1, &textureID);
	g.glBindTexture(GL_TEXTURE_2D, textureID);
	g.glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, im0.width(), im0.height(), 0, GL_RGBA, GL_UNSIGNED_BYTE, im0.bits());
	g.glGenerateMipmap(GL_TEXTURE_2D);
	g.glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR );
	g.glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
	g.glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
	g.glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );

	program->bind();
	program->setUniformValue("infoSampler",textureUnit);
	program->setUniformValue("width", float(glwidget()->width()));
	program->setUniformValue("height", float(glwidget()->height()));

	drawRect();

	program->release();
    g.glBindTexture(GL_TEXTURE_2D, 0);
    g.glDeleteTextures(1, &textureID);

}