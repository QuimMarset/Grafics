#ifndef _ILUMBLINN_H
#define _ILUMBLINN_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>


class IlumBlinn : public QObject, public BasicPlugin
{
     Q_OBJECT
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    void preFrame();
    void postFrame();
 
 private:
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs; 
    Vector lightAmbient, lightSpecular, lightDiffuse;
    QVector4D lightPosition;
    Vector matAmbient, matDiffuse, matSpecular;
    float matShininess;
 };
 
 #endif
