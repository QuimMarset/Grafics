#ifndef _RESALTAOBJECTE_H
#define _RESALTAOBJECTE_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>


class ResaltaObjecte : public QObject, public BasicPlugin
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
    GLuint VAO, VBOVertex, VBOColors;
    void creaBuffers();
    int numVertex;
 };
 
 #endif
