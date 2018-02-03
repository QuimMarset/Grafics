#include "area.h"


float calculaArea(Point p1, Point p2, Point p3) {

	Vector u = p2 - p1;
	Vector v = p3 - p1;

	Vector producteVect = QVector3D::crossProduct(u,v);
	float areaTriangle = producteVect.length() / 2.0;

	return areaTriangle;

}

void Area::onPluginLoad() {

	const vector <Object>& objectes = scene()->objects();

	float areaIessima;

	for (int i = 0;i < (int)objectes.size();++i) {

		areaIessima = 0;

		const vector <Face>& cares = objectes[i].faces();

		for (int j = 0;j < (int)cares.size();++j) {

			int index1 = cares[j].vertexIndex(0);
			int index2 = cares[j].vertexIndex(1);
			int index3 = cares[j].vertexIndex(2);

			Point p1 = objectes[i].vertices()[index1].coord();
			Point p2 = objectes[i].vertices()[index2].coord();
			Point p3 = objectes[i].vertices()[index3].coord();
			
			float area = calculaArea(p1, p2, p3);
			areaIessima += area;

		}

		cout << "Area: " << areaIessima << endl;

	}

}
