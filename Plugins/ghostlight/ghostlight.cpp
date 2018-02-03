#include "ghostlight.h"
#include "glwidget.h"


void GhostLight::onPluginLoad() {

	QString vsCode =
		"#version 330 core\n \
		layout (location = 0) in vec3 vertex; \
		layout (location = 2) in vec3 color; \
		out vec4 frontColor; \
		uniform mat4 modelViewProjectionMatrix; \
		void main() \
		{ \
		    frontColor = vec4(color,1.0); \
		    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0); \
		}";

	QString fsCode =
		"#version 330 core\n \
		in vec4 frontColor; \
		out vec4 fragColor; \
		uniform int mouseX; \
		uniform int mouseY; \
		void main() \
		{ \
		    fragColor = frontColor; \
			float dist = distance(gl_FragCoord.xy - vec2(0.5), vec2(mouseX, mouseY)); \
			if (dist > 100) { \
				fragColor.a = 0.025; \
			} \
			else { \
				fragColor.a = 0.25; \
			} \
		}";

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceCode(vsCode);

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceCode(fsCode);

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

	GLWidget &g = *glwidget();
	g.makeCurrent();
	g.setMouseTracking(true);


}

void GhostLight::mouseMoveEvent(QMouseEvent *event) {

	GLWidget &g = *glwidget();

	mouseX = event->x();
	mouseY = g.height() - event->y();

	g.update();
}

void GhostLight::preFrame() 
{
    glDisable(GL_DEPTH_TEST);
    glBlendEquation(GL_FUNC_ADD);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);
    glEnable(GL_CULL_FACE);
    glEnable(GL_BLEND);

    program->bind();
    program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix());
    program->setUniformValue("mouseX", mouseX);
    program->setUniformValue("mouseY", mouseY);
}

void GhostLight::postFrame() 
{
    glEnable(GL_DEPTH_TEST);
    glDisable(GL_BLEND);

    program->release();
}

#if QT_VERSION < 0x050000
Q_EXPORT_PLUGIN2(alpha-blending, AlphaBlending)   // plugin name, plugin class
#endif

