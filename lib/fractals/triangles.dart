import 'package:flame/extensions.dart';

import 'fractals.dart';

class TriangleFractalPainter extends FractalPainter {
  TriangleFractalPainter(super.mode);

  @override
  void makeDots() {
    newVertex = vertexChooser(3);
    super.makeDots();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // init vertices
    if (vertices.isEmpty) {
      vertices.add(Offset(screenSize.width * 0.1, screenSize.height * 0.9));
      vertices.add(Offset(screenSize.width * 0.5, screenSize.height * 0.1));
      vertices.add(Offset(screenSize.width * 0.9, screenSize.height * 0.9));
    } else {
      vertices[0] = (Offset(screenSize.width * 0.1, screenSize.height * 0.9));
      vertices[1] = (Offset(screenSize.width * 0.5, screenSize.height * 0.1));
      vertices[2] = (Offset(screenSize.width * 0.9, screenSize.height * 0.9));
    }
    super.paint(canvas, size);
  }
}
