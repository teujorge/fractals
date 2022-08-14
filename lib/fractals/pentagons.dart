import 'package:flame/extensions.dart';

import 'fractals.dart';

class PentagonFractalPainter extends FractalPainter {
  PentagonFractalPainter(super.mode);

  @override
  void makeDots() {
    // ensure new vertex is != to old vertex
    newVertex = vertexChooser(5);
    while (newVertex == lastVertex) {
      newVertex = vertexChooser(5);
    }
    lastLastVertex = lastVertex;
    lastVertex = newVertex;

    super.makeDots();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // init vertex dots
    if (vertices.isEmpty) {
      vertices.add(Offset(screenSize.width * 0.25, screenSize.height * 0.1));
      vertices.add(Offset(screenSize.width * 0.75, screenSize.height * 0.1));
      vertices.add(Offset(screenSize.width * 0.9, screenSize.height * 0.5));
      vertices.add(Offset(screenSize.width * 0.5, screenSize.height * 0.9));
      vertices.add(Offset(screenSize.width * 0.1, screenSize.height * 0.5));
    } else {
      vertices[0] = (Offset(screenSize.width * 0.25, screenSize.height * 0.1));
      vertices[1] = (Offset(screenSize.width * 0.75, screenSize.height * 0.1));
      vertices[2] = (Offset(screenSize.width * 0.9, screenSize.height * 0.5));
      vertices[3] = (Offset(screenSize.width * 0.5, screenSize.height * 0.9));
      vertices[4] = (Offset(screenSize.width * 0.1, screenSize.height * 0.5));
    }

    super.paint(canvas, size);
  }
}
