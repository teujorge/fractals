import 'package:flame/extensions.dart';

import 'fractals.dart';

class SquareFractalPainter extends FractalPainter {
  SquareFractalPainter(super.mode);

  @override
  void makeDots() {
    newVertex = vertexChooser(4);

    // ensure new vertex is != to old vertex
    if (mode == 0) {
      while (newVertex == lastVertex) {
        newVertex = vertexChooser(4);
      }
    }
    // if old vertex == old-old vertex,
    // ensure new vertex is != to old vertex
    else if (mode == 1) {
      if (lastLastVertex == lastVertex) {
        while (newVertex == lastVertex) {
          newVertex = vertexChooser(4);
        }
      }
    }
    // if old vertex == old-old vertex,
    // ensure new vertex does not neighboor old vertex
    else if (mode == 2) {
      if (lastVertex != null) {
        if (lastLastVertex == lastVertex) {
          while (newVertex!.dx == lastVertex!.dx ||
              newVertex!.dy == lastVertex!.dy) {
            newVertex = vertexChooser(4);
          }
        }
      }
    }

    lastLastVertex = lastVertex;
    lastVertex = newVertex;
    super.makeDots();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // init vertex dots
    if (vertices.isEmpty) {
      vertices.add(Offset(screenSize.width * 0.1, screenSize.height * 0.1));
      vertices.add(Offset(screenSize.width * 0.9, screenSize.height * 0.1));
      vertices.add(Offset(screenSize.width * 0.9, screenSize.height * 0.9));
      vertices.add(Offset(screenSize.width * 0.1, screenSize.height * 0.9));
    } else {
      vertices[0] = (Offset(screenSize.width * 0.1, screenSize.height * 0.1));
      vertices[1] = (Offset(screenSize.width * 0.9, screenSize.height * 0.1));
      vertices[2] = (Offset(screenSize.width * 0.9, screenSize.height * 0.9));
      vertices[3] = (Offset(screenSize.width * 0.1, screenSize.height * 0.9));
    }

    super.paint(canvas, size);
  }
}
