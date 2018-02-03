
#include "modelInfo1.h"



void ModelInfo1::imprimeixInformacio() {

	const vector <Object>& objectes = scene()->objects();
	int numObjectes = objectes.size();

	int numVertex = 0;
	int numPoligons = 0;
	int percentatgeTriangles = 0;

	for (int i = 0;i < numObjectes;++i) {
		const vector <Face>& cares = objectes[i].faces();
		for (int j = 0;j < (int)cares.size();++j) {
			numVertex += cares[j].numVertices();
			if (cares[j].numVertices() == 3) percentatgeTriangles++;
			++numPoligons;
		}
	}
	percentatgeTriangles = 100*int(percentatgeTriangles/numPoligons);
	cout << "==============================================" << endl;
	cout << "Informació associada als objectes de l'escena:" << endl;
	cout << "Num objectes: " << numObjectes << endl;
	cout << "Num vèrtex: " << numVertex << endl;
	cout << "Num polígons: " << numPoligons << endl;
	cout << "Percentatge de triangles: " << percentatgeTriangles << endl;
	cout << "=============================================" << endl;
}

void ModelInfo1::onObjectAdd() {
	imprimeixInformacio();
}

void ModelInfo1::onPluginLoad() {
	imprimeixInformacio();
}