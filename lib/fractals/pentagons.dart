import 'package:flame/extensions.dart';

import 'fractals.dart';

class PentagonFractalPainter extends FractalPainter {
  PentagonFractalPainter({super.mode});

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
    paintVerticesPentagon();
    super.paint(canvas, size);
  }
}
