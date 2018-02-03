#ifndef _FRAMERATE_H
#define _FRAMERATE_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>
#include <QTimer>


class Framerate : public QObject, public BasicPlugin
{
     Q_OBJECT
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    void postFrame();

 public slots:
 	void actualitzaFPS();
 
 private:
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs; 
    GLuint VAO, VBOVertex;
    GLuint textureID;
    int contFrames;
    int fps;
    bool creat;
    void drawRect();
 };
 
 #endif
