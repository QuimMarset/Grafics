#ifndef _ANIMATEVERTICES_H
#define _ANIMATEVERTICES_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>
#include <QTimer>
#include <QElapsedTimer>


class AnimateVertices : public QObject, public BasicPlugin
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
    QOpenGLShader *vs, *fs;
    QElapsedTimer elapsedTimer;
 };
 
 #endif
