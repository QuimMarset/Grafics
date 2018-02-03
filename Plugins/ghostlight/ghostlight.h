#ifndef _GHOSTLIGHT_H  
#define _GHOSTLIGHT_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>

class GhostLight : public QObject, public BasicPlugin
 {
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

public:
    void preFrame();
    void postFrame();
    void onPluginLoad();
    void mouseMoveEvent(QMouseEvent *event);

private:
	QOpenGLShader *fs, *vs;
	QOpenGLShaderProgram *program;
	int mouseX, mouseY;
 };
 
 #endif
 
 
