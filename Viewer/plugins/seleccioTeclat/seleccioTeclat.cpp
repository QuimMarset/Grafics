#include "seleccioTeclat.h"
#include "glwidget.h"



void SeleccioTeclat::keyPressEvent(QKeyEvent *event) {

	GLWidget &g = *glwidget();
	g.makeCurrent();

	if (event->key() >= Qt::Key_0 && event->key() <= Qt::Key_9) {
		int numTecla = event->key() - Qt::Key_0;
		if ((int)scene()->objects().size() < numTecla + 1) scene()->setSelectedObject(-1);
		else scene()->setSelectedObject(numTecla);
	}

	g.update();
}