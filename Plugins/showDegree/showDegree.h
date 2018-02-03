#ifndef _SHOWDEGREE_H
#define _SHOWDEGREE_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>
#include <QPainter>


class ShowDegree : public QObject, public BasicPlugin
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
    float grauMig;
    void calculaGrauMig();
    void drawRect();
    bool creat;
    GLuint VAO, VBOVertex, textureID;
 };
 
 #endif
