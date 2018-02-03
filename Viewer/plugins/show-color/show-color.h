#ifndef _SHOWCOLOR_H
#define _SHOWCOLOR_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>

class ShowColor : public QObject, public BasicPlugin
{
     Q_OBJECT
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    void postFrame();
    
 private:
 	QOpenGLShader *vs, *fs;
 	QOpenGLShaderProgram *program;
 	GLuint textureID, VAO, VBOVertex;
 	bool creat;
 	void drawRect();

 };
 
 #endif
