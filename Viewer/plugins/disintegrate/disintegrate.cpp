#include "disintegrate.h"

void Disintegrate::onPluginLoad()
{

    vs = new QGLShader(QGLShader::Vertex, this);
    vs->compileSourceFile("plugins/disintegrate/disintegrate.vert");
    
    gs = new QGLShader(QGLShader::Geometry, this);
    gs->compileSourceFile("plugins/disintegrate/disintegrate.geom");

    fs = new QGLShader(QGLShader::Fragment, this);
    fs->compileSourceFile("plugins/disintegrate/disintegrate.frag");

    program = new QGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(gs);
    program->addShader(fs);
    program->link();
    
    timer.start();

    QTimer *autoupdate = new QTimer(this);
    connect(autoupdate, SIGNAL(timeout()), glwidget(), SLOT(update()));
    autoupdate->start();
}

void Disintegrate::keyPressEvent(QKeyEvent *event) {

    GLWidget &g = *glwidget();
    g.makeCurrent();

    if (event->key() == Qt::Key_R) {
        timer.start();
    }
    g.update();
}

void Disintegrate::preFrame() 
{
    // bind shader and define uniforms
    program->bind();
    program->setUniformValue("time", timer.elapsed() / 1000.0f);
    QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP); 
}

void Disintegrate::postFrame() 
{
    // unbind shader
    program->release();
}



