#ifndef _SELECCIOTECLAT_H
#define _SELECCIOTECLAT_H

#include "basicplugin.h"


class SeleccioTeclat : public QObject, public BasicPlugin
{
     Q_OBJECT
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
     Q_INTERFACES(BasicPlugin)

 public:
    void keyPressEvent(QKeyEvent *event);
    
 };
 
 #endif
