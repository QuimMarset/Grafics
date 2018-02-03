#ifndef _INVERTER_H
#define _INVERTER_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>
#include <QTimer>


class Inverter : public QObject, public BasicPlugin
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
    QOpenGLShader *fs, *vs; 
 };
 
 #endif
