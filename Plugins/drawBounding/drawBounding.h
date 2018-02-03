#ifndef _DRAWBOUNDING_H
#define _DRAWBOUNDING_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>


class DrawBounding : public QObject, public BasicPlugin
{
     Q_OBJECT
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    void postFrame();
 
 private:
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs;
    GLuint VAO, VBOVertex, VBOColor;;
    void creaBuffers();
    int numVertex;
 };
 
 #endif
