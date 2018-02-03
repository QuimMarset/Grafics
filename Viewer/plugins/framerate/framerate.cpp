#include "framerate.h"
#include "glwidget.h"
#include <vector>
#include <QPainter>


void Framerate::onPluginLoad() {

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("plugins/framerate/framerate.vert");

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceFile("plugins/framerate/framerate.frag");

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

	contFrames = 0;
	fps = 0;
	creat = false;

	QTimer *timerFPS = new QTimer(this);
	connect(timerFPS, SIGNAL(timeout()), this, SLOT(actualitzaFPS()));
	timerFPS->start(1000.0f);

	QTimer *timerEscena = new QTimer(this);
	connect(timerEscena, SIGNAL(timeout()), glwidget(), SLOT(update()));
	timerEscena->start();

}

void Framerate::actualitzaFPS() {

	fps = contFrames;
	contFrames = 0;
}

void Framerate::drawRect() {

	GLWidget &g = *glwidget();
	g.makeCurrent();

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

void Framerate::postFrame() {

	GLWidget &g = *glwidget();

	++contFrames;

	const int SIZE = 1024;
    // 1. Create image with text
    QImage image(SIZE,SIZE,QImage::Format_RGB32);
    image.fill(Qt::white);    
    QPainter painter;
    painter.begin(&image);
    QFont font;
    font.setPixelSize(32);
    painter.setFont(font);
    painter.setPen(QColor(50,50,50));
    int x = 15;
    int y = 50;
    painter.drawText(x, y, QString("FPS: ") += QString::number(fps));    
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