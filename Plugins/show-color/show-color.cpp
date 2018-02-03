#include "show-color.h"
#include "glwidget.h" 
#include <QPainter>


void ShowColor::onPluginLoad() {

	GLWidget &g = *glwidget();
	g.makeCurrent();

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("plugins/show-color/show-color.vert");

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceFile("plugins/show-color/show-color.frag");

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

	QTimer *timer = new QTimer(this);
	connect(timer, SIGNAL(timeout()), glwidget(), SLOT(update()));
	timer->start();

	creat = false;

}

void ShowColor::drawRect() {

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

void ShowColor::postFrame() { 

	GLWidget &g = *glwidget();
	g.makeCurrent();

	int posMouseX = g.mapFromGlobal(QCursor::pos()).x();
	int posMouseY = g.height() - g.mapFromGlobal(QCursor::pos()).y();

	GLubyte color[3];
	glReadPixels(posMouseX, posMouseY, 1, 1, GL_RGB, GL_UNSIGNED_BYTE, color);
	//printf("PIXEL: %d - %d - %d\n",color[0], color[1], color[2]);

	QImage image(g.width(), g.height(), QImage::Format_RGB32);
    image.fill(Qt::white);    
    QPainter painter;
    painter.begin(&image);
    QFont font;
    font.setPixelSize(15);
    painter.setFont(font);
    painter.setPen(QColor(50,50,50));
    painter.drawText(40, 40, QString("Color RGB: ") += QString::number(color[0]) += QString(" ") += QString::number(color[1]) 
    	+= QString(" ") += QString::number(color[2]));
    painter.end();

    QImage im0 = image.mirrored(false, true).convertToFormat(QImage::Format_RGBA8888, Qt::ColorOnly);

    g.glActiveTexture(GL_TEXTURE0);
	g.glGenTextures( 1, &textureID);
	g.glBindTexture(GL_TEXTURE_2D, textureID);
	g.glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, im0.width(), im0.height(), 0, GL_RGBA, GL_UNSIGNED_BYTE, im0.bits());
	g.glGenerateMipmap(GL_TEXTURE_2D);
	g.glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR );
	g.glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );

    program->bind();
    program->setUniformValue("colorMap", 0);
    program->setUniformValue("width", float(g.width()));
    program->setUniformValue("height", float(g.height()));

    drawRect();

    program->release();
    g.glBindTexture(GL_TEXTURE_2D, 0);


}

