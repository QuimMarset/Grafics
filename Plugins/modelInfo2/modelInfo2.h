#ifndef _MODELINFO2_H
#define _MODELINFO2_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>


class ModelInfo2 : public QObject, public BasicPlugin
{
     Q_OBJECT
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    void onObjectAdd();
    void postFrame();
 
 private:
 	int numVertex, numPoligons, numObjectes, percentatgeTriangles;
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs; 
    void calculaInfo();
    GLuint VAO, VBOVertex;
    GLuint textureID;
    bool creat;
    void drawRect();
 };
 
 #endif
