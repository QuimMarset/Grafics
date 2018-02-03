#ifndef _DISINTEGRATE_H
#define _DISINTEGRATE_H

#include "basicplugin.h"
#include <QGLShader>
#include <QGLShaderProgram>
#include <QElapsedTimer>


class Disintegrate : public QObject, public BasicPlugin
{
     Q_OBJECT
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
     Q_INTERFACES(BasicPlugin)

public:
    void onPluginLoad();
    void preFrame();
    void postFrame();
    void keyPressEvent(QKeyEvent *event);
   
private:
    QGLShaderProgram* program;
    QGLShader *fs, *gs, *vs;
    QElapsedTimer timer;
};
 
 #endif
