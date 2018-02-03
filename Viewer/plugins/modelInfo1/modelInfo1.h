
#ifndef _MODELINFO1_H
#define _MODELINFO1_H
#include "basicplugin.h"

using namespace std;

class ModelInfo1: public QObject, public BasicPlugin
{

	Q_OBJECT
	Q_PLUGIN_METADATA(IID "BasicPlugin")
	Q_INTERFACES(BasicPlugin)

	public:
	void onObjectAdd();
	void onPluginLoad();
	void imprimeixInformacio();

};

#endif