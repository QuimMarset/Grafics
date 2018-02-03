#include "showDegree.h"
#include "glwidget.h"


void ShowDegree::onPluginLoad() {

	QString vsCode =
		"#version 330 core\n \
		layout (location = 0) in vec3 vertex; \
		void main() \
		{ \
		    gl_Position = vec4(vertex, 1.0); \
		}";

	QString fsCode =
		"#version 330 core\n \
		out vec4 fragColor; \
		uniform float width; \
		uniform float height; \
		uniform sampler2D colorMap; \
		void main() \
		{ \
			vec2 texCoord = (gl_FragCoord.xy - vec2(0.5)) / vec2(width, height); \
		    fragColor = texture(colorMap, texCoord); \
		    if (all(equal(fragColor.rgb, vec3(1.0)))) discard; \
		}";

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceCode(vsCode);

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceCode(fsCode);

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

	grauMig = 0;
	calculaGrauMig();

	creat = false;
}

void ShowDegree::calculaGrauMig() {

	Object  &objecte = scene()->objects()[0];
	int numVertex = objecte.vertices().size();
	const vector <Face>& cares = objecte.faces();

	for (int i = 0;i < (int)cares.size();++i) {

		grauMig += cares[i].numVertices();
	}

	grauMig = grauMig / numVertex;
}

void ShowDegree::drawRect() {

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


void ShowDegree::postFrame() {

	GLWidget &g = *glwidget();

	QImage image(g.width(), g.height(), QImage::Format_RGB32);
    image.fill(Qt::white);    
    QPainter painter;
    painter.begin(&image);
    QFont font;
    font.setPixelSize(15);
    painter.setFont(font);
    painter.setPen(QColor(50,50,50));
    painter.drawText(40, 40, QString::number(grauMig));
    painter.end();

    QImage im0 = image.mirrored(false, true).convertToFormat(QImage::Format_RGBA8888, Qt::ColorOnly);


	g.glActiveTexture(GL_TEXTURE0);
	g.glGenTextures(1, &textureID);
	g.glBindTexture(GL_TEXTURE_2D, textureID);
	g.glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, im0.width(), im0.height(), 0, GL_RGBA, GL_UNSIGNED_BYTE, im0.bits());
	g.glGenerateMipmap(GL_TEXTURE_2D);
	g.glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR );
	g.glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );

	program->bind();
	program->setUniformValue("colorMap", 0);
	program->setUniformValue("width", float(g.width()));
	program->setUniformValue("height", float(g.height()));

	drawRect();

	program->release();

}