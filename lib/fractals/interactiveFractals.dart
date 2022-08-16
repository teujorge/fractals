import 'package:flame/extensions.dart';

import 'fractals.dart';

class InteractiveFractalPainter extends FractalPainter {
  InteractiveFractalPainter({super.mode});

  @override
  void makeDots() {
    newVertex = vertexChooser(numVertices);

    // ensure new vertex is != to old vertex
    if (mode == 1) {
      while (newVertex == lastVertex) {
        newVertex = vertexChooser(numVertices);
      }
      lastLastVertex = lastVertex;
      lastVertex = newVertex;
    }

    super.makeDots();
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (numVertices == 3) {
      paintVerticesTriangle();
    } else if (numVertices == 4) {
      paintVerticesSquare();
    } else if (numVertices == 5) {
      paintVerticesPentagon();
    }
    super.paint(canvas, size);
  }
}
