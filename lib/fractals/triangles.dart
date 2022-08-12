import 'package:flame/extensions.dart';

import 'fractals.dart';
import '../components/dot.dart';

class TriangleFractal extends Fractals {
  TriangleFractal(super.context, super.mode) {
    // init vertex dots
    pointA = Dot(Vector2(screenSize.width * 0.1, screenSize.height * 0.9));
    pointB = Dot(Vector2(screenSize.width * 0.5, screenSize.height * 0.1));
    pointC = Dot(Vector2(screenSize.width * 0.9, screenSize.height * 0.9));
  }

  @override
  void makeDots() {
    pointX = SmallDot(pointX, vertexChooser(3));
    add(pointX);
  }

  @override
  void update(double dt) {
    super.update(dt);
    pointA.position = Vector2(screenSize.width * 0.1, screenSize.height * 0.9);
    pointB.position = Vector2(screenSize.width * 0.5, screenSize.height * 0.1);
    pointC.position = Vector2(screenSize.width * 0.9, screenSize.height * 0.9);
  }
}
