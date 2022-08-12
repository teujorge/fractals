import 'package:flame/extensions.dart';

import 'fractals.dart';
import '../components/dot.dart';

class PentagonFractal extends Fractals {
  PentagonFractal(super.context, super.mode) {
    // init vertex dots
    pointA = Dot(Vector2(screenSize.width * 0.25, screenSize.height * 0.1));
    pointB = Dot(Vector2(screenSize.width * 0.75, screenSize.height * 0.1));
    pointC = Dot(Vector2(screenSize.width * 0.9, screenSize.height * 0.5));
    pointD = Dot(Vector2(screenSize.width * 0.5, screenSize.height * 0.9));
    pointE = Dot(Vector2(screenSize.width * 0.1, screenSize.height * 0.5));
  }

  @override
  void makeDots() {
    // ensure new vertex is != to old vertex
    Dot newVertex = vertexChooser(5);
    while (newVertex == lastVertex) {
      newVertex = vertexChooser(5);
    }
    lastLastVertex = lastVertex;
    lastVertex = newVertex;

    pointX = SmallDot(pointX, newVertex);
    add(pointX);
  }

  @override
  void update(double dt) {
    super.update(dt);

    pointA.position = Vector2(screenSize.width * 0.25, screenSize.height * 0.1);
    pointB.position = Vector2(screenSize.width * 0.75, screenSize.height * 0.1);
    pointC.position = Vector2(screenSize.width * 0.9, screenSize.height * 0.5);
    pointD.position = Vector2(screenSize.width * 0.5, screenSize.height * 0.9);
    pointE.position = Vector2(screenSize.width * 0.1, screenSize.height * 0.5);
  }
}
