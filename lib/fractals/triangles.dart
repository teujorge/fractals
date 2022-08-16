import 'package:flame/extensions.dart';

import 'fractals.dart';

class TriangleFractalPainter extends FractalPainter {
  TriangleFractalPainter({super.mode});

  @override
  void makeDots() {
    newVertex = vertexChooser(3);
    super.makeDots();
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintVerticesTriangle();
    super.paint(canvas, size);
  }
}
