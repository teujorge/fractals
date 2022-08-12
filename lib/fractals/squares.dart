import 'package:flame/extensions.dart';

import 'fractals.dart';
import '../components/dot.dart';

class SquareFractal extends Fractals {
  SquareFractal(super.context, super.mode) {
    // init vertex dots
    pointA = Dot(Vector2(screenSize.width * 0.1, screenSize.height * 0.1));
    pointB = Dot(Vector2(screenSize.width * 0.9, screenSize.height * 0.1));
    pointC = Dot(Vector2(screenSize.width * 0.9, screenSize.height * 0.9));
    pointD = Dot(Vector2(screenSize.width * 0.1, screenSize.height * 0.9));
  }

  @override
  void makeDots() {
    Dot newVertex = vertexChooser(4);

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
          while (newVertex.position.x == lastVertex!.position.x ||
              newVertex.position.y == lastVertex!.position.y) {
            newVertex = vertexChooser(4);
          }
        }
      }
    }

    lastLastVertex = lastVertex;
    lastVertex = newVertex;

    pointX = SmallDot(pointX, newVertex);
    add(pointX);
  }

  @override
  void update(double dt) {
    super.update(dt);
    pointA.position = Vector2(screenSize.width * 0.1, screenSize.height * 0.1);
    pointB.position = Vector2(screenSize.width * 0.9, screenSize.height * 0.1);
    pointC.position = Vector2(screenSize.width * 0.9, screenSize.height * 0.9);
    pointD.position = Vector2(screenSize.width * 0.1, screenSize.height * 0.9);
  }
}
