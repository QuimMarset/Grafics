#ifndef _AREA_H  
#define _AREA_H

#include "basicplugin.h"
//#include <iostream>

class Area : public QObject, public BasicPlugin
 {
 	 Q_OBJECT
	 Q_PLUGIN_METADATA(IID "BasicPlugin")
	 Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();

 };
 
 #endif
 
 
